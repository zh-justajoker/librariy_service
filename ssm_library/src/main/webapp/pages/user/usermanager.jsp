<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/2/9
  Time: 15:57
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
<!-- 用户修改的模态框 -->
<div class="modal fade" id="userUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学号</label>
                        <div class="col-sm-10">
                            <input type="text" name="uno" class="form-control" id="uno_update_static" readonly="readonly">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="uname" class="form-control" id="uname_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-10">
                            <input type="number" name="age" class="form-control" id="age_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex1_update_input" value=0 checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex2_update_input" value=1> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">院系</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="user_update_btn">更新</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 用户添加的模态框 -->
<div class="modal fade" id="userAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">用户添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学号</label>
                        <div class="col-sm-10">
                            <input type="text" name="uno" class="form-control" id="uno_add_input" placeholder="输入学号" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="uname" class="form-control" id="uname_add_input" placeholder="输入姓名" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="text" name="upwd" class="form-control" id="upwd_add_input" placeholder="输入密码" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">年龄</label>
                        <div class="col-sm-10">
                            <input type="number" name="age" class="form-control" id="age_add_input" placeholder="输入年龄" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex1_add_input" value=0 checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="sex2_add_input" value=1> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">院系</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="user_save_btn">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>用户管理</h1>
        </div>
    </div>
    <br>
    <div class="row">
        <%--    ------------查找框--------------   --%>
        <div class="col-lg-4">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="输入学号或姓名" id="search_user"autocomplete="off">
                <span class="input-group-btn">
                        <button class="btn btn-primary glyphicon glyphicon-search" type="button" id="search_btn">搜索</button>
                    </span>
            </div>
        </div>
        <div class="col-md-4" style="margin-left: 250px;">
            <button class="btn btn-primary" id="user_add_modal_btn">新增</button> &nbsp; &nbsp;
            <button class="btn btn-danger" id="user_delete_all_btn">删除</button>
        </div>
    </div>
    <br><br>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="users_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>密码</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>系部</th>
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
    var totalRecord,currentPage;
    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function(){
        //去首页
        to_page(1);
    });

    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/user/getlist",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                //1、解析并显示用户数据
                build_users_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_users_table(result){
        //清空table表格
        $("#users_table tbody").empty();
        var users = result.extend.userInfo.list;
        $.each(users,function(index,item){
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var uno = $("<td></td>").append(item.uno);
            var uname = $("<td></td>").append(item.uname);
            var upwd = $("<td></td>").append(item.upwd);
            var age = $("<td></td>").append(item.age);
            var sex = $("<td></td>").append(item.sex==0?"男":"女");
            var dept = $("<td></td>").append(item.dname);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前用户id
            editBtn.attr("edit-id",item.uno);
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的用户id
            delBtn.attr("del-id",item.uno);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //var delBtn =
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(uno)
                .append(uname)
                .append(upwd)
                .append(age)
                .append(sex)
                .append(dept)
                .append(btnTd)
                .appendTo("#users_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.userInfo.pageNum+"页，共"+
            result.extend.userInfo.pages+"页，共"+
            result.extend.userInfo.total+"条记录");
        totalRecord = result.extend.userInfo.total;
        currentPage = result.extend.userInfo.pageNum;
    }
    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result){
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.userInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.userInfo.pageNum -1);
            });
        }



        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.userInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.extend.userInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.userInfo.pages);
            });
        }



        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.userInfo.navigatepageNums,function(index,item){

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.userInfo.pageNum == item){
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

    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框。
    $("#user_add_modal_btn").click(function(){
        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#userAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#userAddModal select");
        //弹出模态框
        $("#userAddModal").modal({
            backdrop:"static"
        });
    });

    //查出所有的院系信息并显示在下拉列表中
    function getDepts(ele){
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}//user/depts",
            type:"GET",
            success:function(result){
                $.each(result.extend.depts,function(){
                    var optionEle = $("<option></option>").append(this.dname).attr("value",this.id);
                    optionEle.appendTo(ele);
                });
            }
        });

    }

    //校验表单数据
    function validate_add_form(){
        //1、拿到要校验的数据，使用正则表达式
        var uno = $("#uno_add_input").val();
        var reguno = /^[0-9]{6,16}$/;
        if(!reguno.test(uno)){
            show_validate_msg("#uno_add_input", "error", "学号为6-16位数字");
            return false;
        }else{
            show_validate_msg("#uno_add_input", "success", "");
        };
        return true;
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

    //校验学号是否可用
    $("#uno_add_input").change(function(){
        //发送ajax请求校验学号是否可用
        var uno = this.value;
        $.ajax({
            url:"${APP_PATH}/user/checkuser",
            data:"uno="+uno,
            type:"POST",
            success:function(result){
                console.log(result);
                if(result.code==100){
                    show_validate_msg("#uno_add_input","success","学号可用");
                    $("#user_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#uno_add_input","error",result.extend.va_msg);
                    $("#user_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //点击保存，保存用户。
    $("#user_save_btn").click(function(){
        if(!validate_add_form()){
            return false;
        };
        //1、判断之前的ajax学号校验是否成功。如果成功。
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //2、发送ajax请求保存用户
        $.ajax({
            url:"${APP_PATH}/user/addUser",
            type:"POST",
            data:$("#userAddModal form").serialize(),
            success:function(result){
                if(result.code == 100){
                    //用户保存成功；
                    //1、关闭模态框
                    $("#userAddModal").modal('hide');
                    to_page(totalRecord);
                }else{
                    //显示失败信息
                    if(undefined != result.extend.errorFields.uno){
                        //显示用户名字的错误信息
                        show_validate_msg("#uno_add_input", "error", result.extend.errorFields.uno);
                    }
                }
            }
        });
    });


    $(document).on("click",".edit_btn",function(){

        //1、查出部门信息，并显示部门列表
        getDepts("#userUpdateModal select");
        //2、查出用户信息，显示用户信息
        getUser($(this).attr("edit-id"));

        //3、把用户的id传递给模态框的更新按钮
        $("#user_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#userUpdateModal").modal({
            backdrop:"static"
        });
    });

    function getUser(id){
        $.ajax({
            url:"${APP_PATH}/user/getbyId/"+id,
            type:"GET",
            success:function(result){
                console.log(result);
                var userData = result.extend.userbyid;
                $("#uno_update_static").val(userData.uno);
                $("#uname_update_input").val(userData.uname);
                $("#upwd_update_input").val(userData.upwd);
                $("#age_update_input").val(userData.age);
                $("#userUpdateModal input[name=sex]").val([userData.sex]);
                $("#userUpdateModal select").val([userData.deptId]);
            }
        });
    }

    //点击更新，更新用户信息
    $("#user_update_btn").click(function(){
        //2、发送ajax请求保存更新的用户数据
        $.ajax({
            url:"${APP_PATH}/user/upUser/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#userUpdateModal form").serialize(),
            success:function(result){
                //1、关闭对话框
                $("#userUpdateModal").modal("hide");
                //回到当前页面
                to_page(currentPage);
            }
        });
    });

    //单个删除
    $(document).on("click",".delete_btn",function(){
        //1、弹出是否确认删除对话框
        var uname = $(this).parents("tr").find("td:eq(2)").text();
        var uno = $(this).attr("del-id");
        //alert($(this).parents("tr").find("td:eq(1)").text());
        if(confirm("确认删除【"+uname+"】吗？")){
            //确认，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/user/deleteOne/"+uno,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    //完成全选/全不选功能
    $("#check_all").click(function(){
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function(){
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#user_delete_all_btn").click(function(){
        //
        var uname = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function(){
            //this
            uname += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装用户id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        uname = uname.substring(0, uname.length-1);
        //去除删除的id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length-1);
        if(confirm("确认删除【"+uname+"】吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/user/deleteMore/"+del_idstr,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });

    //为搜索按钮绑定单击事件
    $("#search_btn").click(function () {
        //清空tbody，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#users_table tbody").empty();
        //将搜索框中的内容保存到searchContent中
        var searchContent = $("#search_user").val();
        console.log(searchContent);
        $("#page_nav_area").empty();
        //如果输入框中的内容为空的话，用to_page回到原本显示的界面。
        if(searchContent == ""){
            to_page(1);
        }else{
            //如果不为空的话，发送ajax请求
            $.ajax({
                url:"${APP_PATH}/user/userSearch",
                type:"GET",
                data:"content=" + searchContent,
                success:function (res) {
                    //显示搜索到的用户
                    search_users_table(res);
                    //显示搜索页面的分页信息
                    build_search_page_info(res);
                }
            });
        }
    })
    // 解析并显示查询到的用户数据
    function search_users_table(res) {
        //清空table表格，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#users_table tbody").empty();
        //将查找出来的用户数据保存在userSearched中
        var userSearched = res.extend.pageInfo.list;
        if(userSearched.length == 0){
            $("<h4 style='color: red'></h4>").append("很抱歉没找到！！！")
                .appendTo("#users_table tbody");//将tr添加到tbody标签中
        }else {
            //遍历所有查询到的用户
            $.each(userSearched,function(index,item){
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var uno = $("<td></td>").append(item.uno);
                var uname = $("<td></td>").append(item.uname);
                var upwd = $("<td></td>").append(item.upwd);
                var age = $("<td></td>").append(item.age);
                var sex = $("<td></td>").append(item.sex==0?"男":"女");
                var dept = $("<td></td>").append(item.dname);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为编辑按钮添加一个自定义的属性，来表示当前用户id
                editBtn.attr("edit-id",item.uno);
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的用户id
                delBtn.attr("del-id",item.uno);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //var delBtn =
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                    .append(uno)
                    .append(uname)
                    .append(upwd)
                    .append(age)
                    .append(sex)
                    .append(dept)
                    .append(btnTd)
                    .appendTo("#users_table tbody");
            });
        }
    }
    // 解析并显示搜索页面的分页信息
    function build_search_page_info(res) {
        //清空分页文字信息，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#page_info_area").empty();
        //显示共几条记录
        $("#page_info_area").append("已查询到" + res.extend.pageInfo.total +"条记录。");
    }
</script>
</body>
</html>
