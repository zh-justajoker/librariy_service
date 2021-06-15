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
    <style type="text/css">
        #feedback_table td  {
            vertical-align: center;
            text-align: center;
        }
        #feedback_table th  {
            vertical-align: center;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="modal fade" id="feedReplyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">回复反馈</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">输入回复</label>
                            <div class="col-sm-10">
                                <textarea name="reply" id="replyContent" placeholder="输入回复的内容" class="form-control" cols="30" rows="6"></textarea>
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="reply_submit_btn">提交</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>反馈管理</h1>
            </div>
        </div>
        <br>
        <br><br>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="feedback_table">
                    <thead>
                    <tr>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>反馈内容</th>
                        <th>时间</th>
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
                url:"${APP_PATH}/feedback/getlist",
                data:"pn="+pn,
                type:"GET",
                success:function(result){
                    //1、解析并显示用户数据
                    build_feedback_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                    //3、解析显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        function build_feedback_table(result){
            //清空table表格
            $("#feedback_table tbody").empty();
            var feedbacks = result.extend.feedbackInfo.list;
            $.each(feedbacks,function(index,item){
                var time = item.ftime;
                var fid = $("<td style='display: none'></td>").append(item.fid);
                var uno = $("<td></td>").append(item.uno);
                var uname = $("<td></td>").append(item.uname);
                var content = $("<td width='450px' style='text-align: start'></td>").append(item.content);
                var ftime = $("<td></td>").append(parseTime(time));
                var state = $("<td></td>").append(item.state==0?"未回复":"已回复");
                // 借出按钮
                var replyBtn = $("<button></button>").addClass("btn btn-success btn-sm edit_btn").append("回复");
                replyBtn.attr("edit-id",item.fid);
                // 删除按钮
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的用户id
                delBtn.attr("del-id",item.fid);

                var btnTd;
                switch (item.state) {
                    case 0:
                        btnTd = $("<td></td>").append(replyBtn);
                        break;
                    case 1:
                        btnTd = $("<td></td>").append(delBtn);
                        break;
                }
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>").append(fid)
                    .append(uno)
                    .append(uname)
                    .append(content)
                    .append(ftime)
                    .append(state)
                    .append(btnTd)
                    .appendTo("#feedback_table tbody");
            });
        }
        //解析显示分页信息
        function build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.feedbackInfo.pageNum+"页，共"+
                result.extend.feedbackInfo.pages+"页，共"+
                result.extend.feedbackInfo.total+"条记录");
            totalRecord = result.extend.feedbackInfo.total;
            currentPage = result.extend.feedbackInfo.pageNum;
        }
        //解析显示分页条，点击分页要能去下一页....
        function build_page_nav(result){
            //page_nav_area
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(result.extend.feedbackInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加点击翻页的事件
                firstPageLi.click(function(){
                    to_page(1);
                });
                prePageLi.click(function(){
                    to_page(result.extend.feedbackInfo.pageNum -1);
                });
            }
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.extend.feedbackInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function(){
                    to_page(result.extend.feedbackInfo.pageNum +1);
                });
                lastPageLi.click(function(){
                    to_page(result.extend.feedbackInfo.pages);
                });
            }
            //添加首页和前一页 的提示
            ul.append(firstPageLi).append(prePageLi);
            //1,2，3遍历给ul中添加页码提示
            $.each(result.extend.feedbackInfo.navigatepageNums,function(index,item){

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.extend.feedbackInfo.pageNum == item){
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

        $(document).on("click",".edit_btn",function(){
            $("#reply_submit_btn").attr("edit-id",$(this).attr("edit-id"));
            $("#feedReplyModal").modal({
                backdrop:"static"
            });
        });

        //点击提交，回复反馈
        $("#reply_submit_btn").click(function(){
            var reply = $("#replyContent").val();
            $.ajax({
                url:"${APP_PATH}/feedback/replyFeed/"+$(this).attr("edit-id"),
                type:"PUT",
                data:"reply="+reply,
                success:function(result){
                    //1、关闭对话框
                    $("#feedReplyModal").modal("hide");
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        });


        //单个删除
        $(document).on("click",".delete_btn",function(){
            var fid = $(this).parents("tr").find("td:eq(0)").text();
            var uname = $(this).parents("tr").find("td:eq(2)").text();
            if(confirm("确认删除【"+uname+"】的本次的反馈吗？")){
                //确认，发送ajax请求删除即可
                $.ajax({
                    url:"${APP_PATH}/feedback/deleteOne/"+fid,
                    type:"DELETE",
                    success:function(result){
                        alert(result.msg);
                        //回到本页
                        to_page(currentPage);
                    }
                });
            }
        });

    </script>
</body>
</html>
