<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/4/17
  Time: 10:24
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
    <style>
        #notice_table td  {
            vertical-align: center;
            text-align: center;
        }
        #notice_table th  {
            vertical-align: center;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="modal fade" id="noticeAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加微公告</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">题目</label>
                            <div class="col-sm-10">
                                <input type="text" name="header" class="form-control" id="header_add_input" placeholder="输入微公告题目" autocomplete="off">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10">
                                <textarea name="content" id="content_add_input" placeholder="输入微公告内容" class="form-control" cols="30" rows="8"></textarea>
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="notice_save_btn">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>微公告管理</h1>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4">
                <button class="btn btn-primary" id="notice_add_modal_btn">新增微公告</button> &nbsp; &nbsp;
            </div>
        </div>
        <br><br>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="notice_table">
                    <thead>
                    <tr>
                        <th>标题</th>
                        <th>内容</th>
                        <th>发布时间</th>
                        <th>阅读量</th>
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
            <!--分页文字信息  -->
            <div class="col-md-6" id="page_info_area"></div>
            <!-- 分页条信息 -->
            <div class="col-md-6" id="page_nav_area">
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
                url:"${APP_PATH}/notice/getlist",
                data:"pn="+pn,
                type:"GET",
                success:function(result){
                    console.log(result);
                    //1、解析并显示用户数据
                    build_notice_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                    //3、解析显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        function build_notice_table(result){
            //清空table表格
            $("#notice_table tbody").empty();
            var depts = result.extend.noticeInfo.list;
            $.each(depts,function(index,item){
                var time = item.ntime;
                var nid = $("<td style='display: none'></td>").append(item.nid);
                var header = $("<td></td>").append(item.header);
                var content = $("<td width='450px' style='text-align: start'></td>").append(item.content);
                var ncount = $("<td></td>").append(item.ncount);
                var ntime = $("<td></td>").append(parseTime(time));
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的用户id
                delBtn.attr("del-id",item.nid);
                var btnTd = $("<td></td>").append(delBtn);
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>")
                    .append(nid)
                    .append(header)
                    .append(content)
                    .append(ntime)
                    .append(ncount)
                    .append(btnTd)
                    .appendTo("#notice_table tbody");
            });
        }
        //解析显示分页信息
        function build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("共"+ result.extend.noticeInfo.total+"条记录");
        }
        //解析显示分页条，点击分页要能去下一页....
        function build_page_nav(result){
            //page_nav_area
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(result.extend.noticeInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加点击翻页的事件
                firstPageLi.click(function(){
                    to_page(1);
                });
                prePageLi.click(function(){
                    to_page(result.extend.noticeInfo.pageNum -1);
                });
            }
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.extend.noticeInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    to_page(result.extend.noticeInfo.pageNum +1);
                });
                lastPageLi.click(function(){
                    to_page(result.extend.noticeInfo.pages);
                });
            }
            //添加首页和前一页 的提示
            ul.append(firstPageLi).append(prePageLi);
            //1,2，3遍历给ul中添加页码提示
            $.each(result.extend.noticeInfo.navigatepageNums,function(index,item){
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.extend.noticeInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function(){
                    to_page(item);
                });
                ul.append(numLi);
            });
            //添加下一页和末页 的提示
            ul.append(nextPageLi).append(lastPageLi);

            //把ul加入到nav
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }
        //时间戳转换
        function parseTime(timestamp){
            var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
            var Y = date.getFullYear() + '-';
            var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
            var D = (date.getDate() < 10 ? '0'+date.getDate() : date.getDate()) + ' ';
            var h = (date.getHours() < 10 ? '0'+date.getHours() : date.getHours()) + ':';
            var m = (date.getMinutes() < 10 ? '0'+date.getMinutes() : date.getMinutes()) + ':';
            var s = (date.getSeconds() < 10 ? '0'+date.getSeconds() : date.getSeconds());

            let strDate = Y+M+D+h+m+s;
            return strDate;
        }

        //点击新增按钮弹出模态框。
        $("#notice_add_modal_btn").click(function(){
            //清除表单数据（表单完整重置（表单的数据，表单的样式））
            reset_form("#noticeAddModal form");
            //弹出模态框
            $("#noticeAddModal").modal({
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

        $("#notice_save_btn").click(function(){
            $.ajax({
                url:"${APP_PATH}/notice/addNotice",
                type:"POST",
                data:$("#noticeAddModal form").serialize(),
                success:function(result){
                    if(result.code == 100){
                        //1、关闭模态框
                        $("#noticeAddModal").modal('hide');
                        to_page(1);
                    }else{
                        //显示失败信息
                        if(undefined != result.extend.errorFields.uno){
                            //显示用户名字的错误信息
                            show_validate_msg("#header_add_input", "error", result.extend.errorFields.uno);
                        }
                    }
                }
            });
        });

        //单个删除
        $(document).on("click",".delete_btn",function(){
            //1、弹出是否确认删除对话框
            var header = $(this).parents("tr").find("td:eq(1)").text();
            var id = $(this).attr("del-id");
            if(confirm("确认删除【"+header+"】吗？")){
                //确认，发送ajax请求删除即可
                $.ajax({
                    url:"${APP_PATH}/notice/deleteOne/"+id,
                    type:"DELETE",
                    success:function(result){
                        if(result.code==100){
                            alert(result.msg);
                            to_page(1);
                        }else{
                            alert('删除失败!!');
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>
