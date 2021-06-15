<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/4/17
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script src="../../commons/hplus/js/jquery.min.js?v=2.1.4"></script>
    <link href="../../commons/hplus/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="../../commons/hplus/js/bootstrap.min.js?v=3.3.5"></script>
</head>
<body>
    <div class="modal fade" id="bookClassAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">图书分类添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">分类ID</label>
                            <div class="col-sm-10">
                                <input type="number" name="classId" class="form-control" id="classId_add_input" placeholder="输入分类ID" autocomplete="off">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">分类名</label>
                            <div class="col-sm-10">
                                <input type="text" name="className" class="form-control" id="className_add_input" placeholder="输入分类名" autocomplete="off">
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="bookClass_save_btn">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>图书分类管理</h1>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
                <button class="btn btn-primary" id="bookClass_add_modal_btn">新增分类</button> &nbsp; &nbsp;
            </div>
        </div>
        <br><br>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="bookClass_table">
                    <thead>
                    <tr>
                        <th>分类ID</th>
                        <th>分类名</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>

        <!-- 显示分页信息 -->
        <div class="row">
            <div class="col-md-6" id="page_info_area"></div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
        $(function(){
            //去首页
            to_page(1);
        });

        function to_page(pn){
            $.ajax({
                url:"${APP_PATH}/bookClass/getlist",
                data:"pn="+pn,
                type:"GET",
                success:function(result){
                    console.log(result);
                    //1、解析并显示用户数据
                    build_bookClass_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                }
            });
        }

        function build_bookClass_table(result){
            //清空table表格
            $("#bookClass_table tbody").empty();
            var books = result.extend.bookClassInfo.list;
            $.each(books,function(index,item){
                var classId = $("<td></td>").append(item.classId);
                var className = $("<td></td>").append(item.className);
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的用户id
                delBtn.attr("del-id",item.classId);
                var btnTd = $("<td></td>").append(delBtn);
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>")
                    .append(classId)
                    .append(className)
                    .append(btnTd)
                    .appendTo("#bookClass_table tbody");
            });
        }
        //解析显示分页信息
        function build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("共"+ result.extend.bookClassInfo.total+"条记录");
        }
        //点击新增按钮弹出模态框。
        $("#bookClass_add_modal_btn").click(function(){
            //清除表单数据（表单完整重置（表单的数据，表单的样式））
            reset_form("#bookClassAddModal form");
            //弹出模态框
            $("#bookClassAddModal").modal({
                backdrop:"static"
            });
        });
        //清空表单样式及内容
        function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        //显示校验结果的提示信息
        function show_validate_msg(ele,status,msg){
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }
        //校验ID是否可用
        $("#classId_add_input").change(function(){
            //发送ajax请求校验条形码是否可用
            var classId = this.value;
            $.ajax({
                url:"${APP_PATH}/bookClass/checkClassId",
                data:"classId="+classId,
                type:"POST",
                success:function(result){
                    console.log(result);
                    if(result.code==100){
                        show_validate_msg("#classId_add_input","success","分类ID可用");
                        $("#bookClass_save_btn").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#classId_add_input","error",result.extend.va_msg);
                        $("#bookClass_save_btn").attr("ajax-va","error");
                    }
                }
            });
        });
        //点击保存，保存图书。
        $("#bookClass_save_btn").click(function(){
            //2、发送ajax请求保存图书
            $.ajax({
                url:"${APP_PATH}/bookClass/addBookClass",
                type:"POST",
                data:$("#bookClassAddModal form").serialize(),
                success:function(result){
                    if(result.code == 100){
                        //1、关闭模态框
                        $("#bookClassAddModal").modal('hide');
                        to_page(1);
                    }else{
                        //显示失败信息
                        if(undefined != result.extend.errorFields.uno){
                            //显示用户名字的错误信息
                            show_validate_msg("#classId_add_input", "error", result.extend.errorFields.uno);
                        }
                    }
                }
            });
        });

        //单个删除
        $(document).on("click",".delete_btn",function(){
            //1、弹出是否确认删除对话框
            var className = $(this).parents("tr").find("td:eq(1)").text();
            var classId = $(this).attr("del-id");
            if(confirm("确认删除【"+className+"】吗？")){
                //确认，发送ajax请求删除即可
                $.ajax({
                    url:"${APP_PATH}/bookClass/deleteOne/"+classId,
                    type:"DELETE",
                    success:function(result){
                        if(result.code==100){
                            alert(result.msg);
                            to_page(1);
                        }else{
                            alert('有该分类的图书，不可删除！！！');
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>
