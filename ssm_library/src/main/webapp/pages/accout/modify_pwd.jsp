<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/4/17
  Time: 10:22
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
    <style type="text/css">
        .d1{
            margin:0 auto;
            width: 400px;
        }
        .d2{
            width: 400px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>密码修改</h1>
            </div>
        </div>
        <br>
        <div class="d1">
            <form>
                <div class="form-group">
                    <label for="oldPwd">旧密码：</label>
                    <input type="password" class="form-control" id="oldPwd" placeholder="旧密码">
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label for="newPwd">新密码：</label>
                    <input type="password" class="form-control" id="newPwd" placeholder="新密码">
                    <span class="help-block"></span>
                </div>
                <div class="form-group">
                    <label for="repeatPwd">确认密码：</label>
                    <input type="password" class="form-control" id="repeatPwd" placeholder="再次输入新密码">
                    <span class="help-block"></span>
                </div>
                <div class="d2">
                    <button type="submit" class="btn btn-primary" style="width: 200px" id="determine">确定</button>
                </div>
            </form>
        </div>
    </div>
    <script type="text/javascript">
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
        //校验条形码是否可用
        $("#oldPwd").change(function(){
            //发送ajax请求校验条形码是否可用
            var rpwd = this.value;
            $.ajax({
                url:"${APP_PATH}/root/checkPwd",
                data:"rpwd="+rpwd,
                type:"POST",
                success:function(result){
                    console.log(result);
                    if(result.code==100){
                        show_validate_msg("#oldPwd","success","旧密码正确");
                        $("#determine").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#oldPwd","error",result.extend.va_msg);
                        $("#determine").attr("ajax-va","error");
                    }
                }
            });
        });
        //校验两次输入密码是否一样
        $("#repeatPwd").change(function(){
            //发送ajax请求校验条形码是否可用
            var repeatpwd = this.value;
            var newpwd =  $('#newPwd').val();
            if (newpwd == repeatpwd){
                show_validate_msg("#repeatPwd","success","两次输入密码一致");
                $("#determine").attr("ajax-va","success");
            }
            else{
                show_validate_msg("#repeatPwd","error","两次输入密码不一致");
                $("#determine").attr("ajax-va","error");
            }
        });
        //点击保存，保存图书。
        $("#determine").click(function(){
            //2、发送ajax请求保存图书
            var repeatpwd = $('#repeatPwd').val();
            var newpwd =  $('#newPwd').val();
            if(newpwd == repeatpwd){
                $.ajax({
                    url:"${APP_PATH}/root/uprpwd",
                    type:"POST",
                    data:"rpwd="+newpwd,
                    success:function(result){
                        if(result.code == 100){
                            alert('密码修改成功,请重新登录！！！');
                            window.location.href="${APP_PATH}/pages/login.jsp";
                        }else{
                            alert('密码修改失败！！！');
                        }
                    }
                });
            }

        });
    </script>
</body>
</html>
