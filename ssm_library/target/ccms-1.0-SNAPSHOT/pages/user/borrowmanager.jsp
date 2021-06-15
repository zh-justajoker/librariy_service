<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/2/12
  Time: 16:06
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
            <h1>借阅记录管理</h1>
        </div>
    </div>
    <br>
    <div class="row">
        <%--    ------------查找框--------------   --%>
        <div class="col-lg-4">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="输入学号或书名" id="search_borrow"autocomplete="off">
                <span class="input-group-btn">
                        <button class="btn btn-primary glyphicon glyphicon-search" type="button" id="search_btn">搜索</button>
                    </span>
            </div>
        </div>
    </div>
    <br><br>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="borrows_table">
                <thead>
                <tr>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>图书条形码</th>
                    <th>书名</th>
                    <th>操作时间</th>
                    <th>状态</th>
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
            url:"${APP_PATH}/borrow/getlist",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                //1、解析并显示用户数据
                build_borrows_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_borrows_table(result){
        //清空table表格
        $("#borrows_table tbody").empty();
        var borrows = result.extend.borrowInfo.list;
        $.each(borrows,function(index,item){
            var time = item.btime;
            var bid = $("<td style='display: none'></td>").append(item.bid);
            var uno = $("<td></td>").append(item.uno);
            var uname = $("<td></td>").append(item.uname);
            var btxm = $("<td></td>").append(item.btxm);
            var bname = $("<td></td>").append(item.bname);
            var btime = $("<td></td>").append(parseTime(time));
            var state = $("<td></td>").append(item.state==0?"已预约":(item.state==1?"借阅中":"已归还"));
            // 借出按钮
            var borBtn = $("<button class='bor_btn'></button>").addClass("btn btn-success").append("确认借出");
            borBtn.attr("edit-id",item.uno);
            // 归还按钮
            var confirBtn = $("<button class='confir_btn'></button>").addClass("btn btn-info").append("确认归还");
            confirBtn.attr("edit-id",item.uno);
            // 删除按钮
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的用户id
            delBtn.attr("del-id",item.uno);

            var btnTd;
            switch (item.state) {
                case 0:
                    btnTd = $("<td></td>").append(borBtn);
                    break;
                case 1:
                    btnTd = $("<td></td>").append(confirBtn);
                    break;
                case 2:
                    btnTd = $("<td></td>").append(delBtn);
                    break;
            }
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(bid)
                .append(uno)
                .append(uname)
                .append(btxm)
                .append(bname)
                .append(btime)
                .append(state)
                .append(btnTd)
                .appendTo("#borrows_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.borrowInfo.pageNum+"页，共"+
            result.extend.borrowInfo.pages+"页，共"+
            result.extend.borrowInfo.total+"条记录");
        totalRecord = result.extend.borrowInfo.total;
        currentPage = result.extend.borrowInfo.pageNum;
    }
    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result){
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.borrowInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.borrowInfo.pageNum -1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.borrowInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.extend.borrowInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.borrowInfo.pages);
            });
        }
        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.borrowInfo.navigatepageNums,function(index,item){

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.borrowInfo.pageNum == item){
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

    //确认借出
    $(document).on("click",".bor_btn",function(){
        var bid = $(this).parents("tr").find("td:eq(0)").text();
        var uname = $(this).parents("tr").find("td:eq(1)").text();
        var btxm = $(this).parents("tr").find("td:eq(2)").text();
        var bname = $(this).parents("tr").find("td:eq(3)").text();
        if(confirm("确认【"+uname+"】借出【"+bname+"】吗？")){
            //确认，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/borrow/upBorrow1/"+bid,
                type:"PUT",
                success:function(result){
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });
    //确认归还
    $(document).on("click",".confir_btn",function(){
        var bid = $(this).parents("tr").find("td:eq(0)").text();
        var uname = $(this).parents("tr").find("td:eq(1)").text();
        var btxm = $(this).parents("tr").find("td:eq(2)").text();
        var bname = $(this).parents("tr").find("td:eq(3)").text();
        if(confirm("确认【"+uname+"】已归还【"+bname+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/borrow/upBorrow2/"+bid,
                type:"PUT",
                success:function(result){
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    //单个删除
    $(document).on("click",".delete_btn",function(){
        //1、弹出是否确认删除对话框
        var bid = $(this).parents("tr").find("td:eq(0)").text();
        var uname = $(this).parents("tr").find("td:eq(1)").text();
        var btxm = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除【"+uname+"】的本次借阅记录吗？")){
            //确认，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/borrow/deleteOne/"+bid,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });
    //为搜索按钮绑定单击事件
    $("#search_btn").click(function () {
        //清空tbody，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#borrows_table tbody").empty();
        //将搜索框中的内容保存到searchContent中
        var searchContent = $("#search_borrow").val();
        console.log(searchContent);
        $("#page_nav_area").empty();
        //如果输入框中的内容为空的话，用to_page回到原本显示的界面。
        if(searchContent == ""){
            to_page(1);
        }else{
            //如果不为空的话，发送ajax请求
            $.ajax({
                url:"${APP_PATH}/borrow/borrowSearch",
                type:"GET",
                data:"content=" + searchContent,
                success:function (res) {
                    //显示搜索到的用户
                    search_borrows_table(res);
                    //显示搜索页面的分页信息
                    build_search_page_info(res);
                }
            });
        }
    })
    // 解析并显示查询到的用户数据
    function search_borrows_table(res) {
        //清空table表格，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#borrows_table tbody").empty();
        //将查找出来的用户数据保存在borrowSearched中
        var borrowSearched = res.extend.pageInfo.list;
        if(borrowSearched.length == 0){
            $("<h4 style='color: red'></h4>").append("很抱歉没找到！！！")
                .appendTo("#borrows_table tbody");//将tr添加到tbody标签中
        }else {
            //遍历所有查询到的用户
            $.each(borrowSearched,function(index,item){
                var time = item.btime;
                var uno = $("<td></td>").append(item.uno);
                var uname = $("<td></td>").append(item.uname);
                var btxm = $("<td></td>").append(item.btxm);
                var bname = $("<td></td>").append(item.bname);
                var btime = $("<td></td>").append(parseTime(time));
                var state = $("<td></td>").append(item.state==0?"已预约":(item.state==1?"借阅中":"已归还"));
                // 借出按钮
                var borBtn = $("<button class='bor_btn'></button>").addClass("btn btn-success").append("确认借出");
                borBtn.attr("edit-id",item.uno);
                // 归还按钮
                var confirBtn = $("<button class='confir_btn'></button>").addClass("btn btn-info").append("确认归还");
                confirBtn.attr("edit-id",item.uno);
                // 删除按钮
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的用户id
                delBtn.attr("del-id",item.uno);
                // var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                var btnTd;
                switch (item.state) {
                    case 0:
                        btnTd = $("<td></td>").append(borBtn);
                        break;
                    case 1:
                        btnTd = $("<td></td>").append(confirBtn);
                        break;
                    case 2:
                        btnTd = $("<td></td>").append(delBtn);
                        break;
                }
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>").append(uno)
                    .append(uname)
                    .append(btxm)
                    .append(bname)
                    .append(btime)
                    .append(state)
                    .append(btnTd)
                    .appendTo("#borrows_table tbody");
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
