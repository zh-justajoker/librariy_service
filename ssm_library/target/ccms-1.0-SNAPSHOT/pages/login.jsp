<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/2/6
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>许院图书馆</title>
    <meta name="keywords" content="登录">
    <meta name="description" content="登录">
    <link href="commons/hplus/css/bootstrap.min.css" rel="stylesheet">
    <link href="commons/hplus/css/style.min.css" rel="stylesheet">
    <script src="commons/hplus/js/jquery.min.js"></script>
    <script src="commons/js/CommonValue.js"></script>

    <style type="text/css">
        body.signin{
            padding: 0;
            margin: 0;
            background: url("<%=basePath%>commons/images/login-bg-autumn.jpg") no-repeat center fixed;
            background-size: 100% 100%;

        }
        .signinPanal{
            width: 750px;
            margin: 10% auto 0;
            height: 340px;
            position: relative;
        }
        .signup_footer{
            position: absolute;
            border-top: solid 1px rgba(255,255,255,.3);
            top: 100%;
            width: 750px;
            padding-top: 15px;
            margin-top: 100px;
        }
        .signin .uname{
            background: #fff url("<%=basePath%>commons/images/user.png") no-repeat 95% center;
        }
        .signin .pword{
            background: #fff url("<%=basePath%>commons/images/locked.png") no-repeat 95% center;
        }
    </style>
    <script type="text/javascript">
        if (window.top!=window.self){
            window.top.location = window.location;
        }
        $(function (){
            $("#username").focus(function (){
                $("#div_msg").html("");
            });
            $("#pwd").focus(function (){
                $("#div_msg").html("");
            });

            var rtnCode = GetQueryString("rtnCode");
            console.log(rtnCode);
            if (rtnCode != null && rtnCode == '500'){
                $("#div_msg").html("用户名或密码错误！");
            }
            else {
                $("#div_msg").html("");
            }
            $("loginForm").validate({
                rules:{
                    username:{
                        required:true
                    },
                    pwd:{
                        required: true
                    }
                },
                message:{
                    username: {
                        required:"请输入用户名"
                    },
                    pwd:{
                        required:"请输入密码"
                    }
                },
                submitHandler:function (form){
                    form.submit();
                }
            });
        });
    </script>
</head>
<body class="signin">
    <div class="signinPanal">
        <div style="position: absolute;width: 306px;height: 313px;top: 0;right: 0;background: rgba(255,255,255,.8);border: 1px solid rgba(255,255,255,.3)">
            <form id="loginForm" method="post" action="<%=basePath%>/root/login" autocomplete="off">
                <p class="m-t-md" id="title" style="color: #00B83F;font-size: 17px; position: absolute;width: 237px;height: 26px;z-index: 1;top: 8%;left: 13%">管理员登录</p>
                <div style="position: absolute;width: 237px;height: 26px;z-index: 1;top: 28%;left: 13%;">
                    <input type="text" class="form-control uname" placeholder="用户名" name="rname" id="username" style="color: #030303;">
                </div>
                <div style="position: absolute;width: 237px;height: 26px;z-index: 2;top: 49%;left: 13%;">
                    <input type="password" class="form-control pword m-b" placeholder="密码" name="rpwd" id="pwd" style="color: #030303;">
                </div>
                <div style="position:absolute;width: 185px;height: 26px;z-index: 2;top: 65%;left: 13%;">
                    <b><div id="div_msg" style="color: red;"></div></b>
                </div>
                <div style="position:absolute;width: 237px;height: 40px;z-index: 3;top: 75%;left: 13%;">
                    <button type="submit" class="btn btn-primary btn-block">登录</button>
                </div>
            </form>
        </div>
        <div class="signup_footer">
            <div class="pull-left" style="color:whitesmoke">
                @ 2021 by Zhanghang.
            </div>
        </div>
    </div>
</body>
</html>
