<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/2/12
  Time: 15:46
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
<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>系统荐书列表</h1>
        </div>
    </div>
    <br>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="books_table">
                <thead>
                <tr>
                    <th>图书条形码</th>
                    <th>ISBN</th>
                    <th>书名</th>
                    <th>作者</th>
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
            url:"${APP_PATH}/sysReco/getlist",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                console.log(result);
                //1、解析并显示用户数据
                build_books_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
            }
        });
    }

    function build_books_table(result){
        //清空table表格
        $("#books_table tbody").empty();
        var books = result.extend.bookInfo.list;
        $.each(books,function(index,item){
            //var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var btxm = $("<td></td>").append(item.btxm);
            var isbn = $("<td></td>").append(item.isbn);
            var bname = $("<td></td>").append(item.bname);
            var author = $("<td></td>").append(item.author);
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的用户id
            delBtn.attr("del-id",item.btxm);
            var btnTd = $("<td></td>").append(delBtn);
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>")
                .append(btxm)
                .append(isbn)
                .append(bname)
                .append(author)
                .append(btnTd)
                .appendTo("#books_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("共"+ result.extend.bookInfo.total+"条记录");
    }

    //单个删除
    $(document).on("click",".delete_btn",function(){
        //1、弹出是否确认删除对话框
        var bname = $(this).parents("tr").find("td:eq(2)").text();
        var btxm = $(this).attr("del-id");
        if(confirm("确认删除【"+bname+"】吗？")){
            //确认，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/sysReco/deleteOne/"+btxm,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到本页
                    to_page(1);
                }
            });
        }
    });
</script>
</body>
</html>
