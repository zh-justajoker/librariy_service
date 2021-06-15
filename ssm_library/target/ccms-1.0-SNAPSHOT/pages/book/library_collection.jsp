<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/2/9
  Time: 10:08
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
        #books_table td  {
            vertical-align: middle;
            text-align: center;
        }
        #books_table th  {
            vertical-align: middle;
            text-align: center;
        }
    </style>
</head>
<body>
<!-- 图书修改的模态框 -->
<div class="modal fade" id="bookUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">书籍修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">条形码</label>
                        <div class="col-sm-10">
                            <input type="text" name="btxm" class="form-control" id="btxm_update_static" readonly="readonly">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">ISBN</label>
                        <div class="col-sm-10">
                            <input type="text" name="isbn" class="form-control" id="isbn_update_input" >
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">书名</label>
                        <div class="col-sm-10">
                            <input type="text" name="bname" class="form-control" id="bname_update_input" >
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">作者</label>
                        <div class="col-sm-10">
                            <input type="text" name="author" class="form-control" id="author_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">分类</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="bclass">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="state" id="state1_update_input" value=0 checked="checked"> 在馆
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="state" id="state2_update_input" value=1> 已借出
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">书籍图片</label>
                        <div class="col-sm-10">
                            <input name="file" type="file" onchange="imageUpdate(this)" id="bimg_update_input" formenctype="multipart/form-data">
                            <img height="80px" width="60px" style="margin-top: 20px" src="" alt="" id="update_bimg" >
                            <input type="text" name="bookImg" style="visibility: hidden" id="updateimgStr" autocomplete="off" readonly="readonly">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="book_update_btn">更新</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 图书添加的模态框 -->
<div class="modal fade" id="bookAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">图书添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">条形码</label>
                        <div class="col-sm-10">
                            <input type="text" name="btxm" class="form-control" id="btxm_add_input" placeholder="输入条形码" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">ISBN</label>
                        <div class="col-sm-10">
                            <input type="text" name="isbn" class="form-control" id="isbn_add_input" placeholder="输入ISBN" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">书名</label>
                        <div class="col-sm-10">
                            <input type="text" name="bname" class="form-control" id="bname_add_input" placeholder="输入书名" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">作者</label>
                        <div class="col-sm-10">
                            <input type="text" name="author" class="form-control" id="author_add_input" placeholder="输入作者" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">分类</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="bclass">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">状态</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="state" id="state1_add_input" value=0 checked="checked"> 在馆
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="state" id="state2_add_input" value=1> 已借出
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">书籍图片</label>
                        <div class="col-sm-10">
                            <input name="file" type="file" onchange="imageUpload(this)" id="bimg_add_input" formenctype="multipart/form-data">
                            <img height="80px" width="60px" style="margin-top: 20px" src="" alt="" id="add_bimg" >
                            <input type="text" name="bookImg" style="visibility: hidden" id="addimgStr" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">图书简介</label>
                        <div class="col-sm-10">
                            <textarea name="bookintro" id="bookintro_add_input" placeholder="输入简介" class="form-control" cols="30" rows="5"></textarea>
                            <span class="help-block"></span>
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
            <h1>馆藏图书</h1>
        </div>
    </div>
    <br>
    <div class="row">
        <%--    ------------查找框--------------   --%>
        <div class="col-lg-4">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="输入ISBN或书名" id="search_book"autocomplete="off">
                <span class="input-group-btn">
                        <button class="btn btn-primary glyphicon glyphicon-search" type="button" id="search_btn">搜索</button>
                    </span>
            </div>
        </div>
        <div class="col-md-4" style="margin-left: 250px;">
            <button class="btn btn-primary" id="book_add_modal_btn">新增</button> &nbsp; &nbsp;
            <button class="btn btn-danger" id="book_delete_all_btn">删除</button>&nbsp; &nbsp;
            <button class="btn btn-success" id="book_recommend_btn">一键推荐</button>
        </div>
    </div>
    <br><br>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="books_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>图书条形码</th>
                    <th>ISBN</th>
                    <th>书名</th>
                    <th>作者</th>
                    <th>封面</th>
                    <th>分类</th>
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
            url:"${APP_PATH}/book/getlist",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                console.log(result);
                //1、解析并显示用户数据
                build_books_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_books_table(result){
        //清空table表格
        $("#books_table tbody").empty();
        var books = result.extend.bookInfo.list;
        $.each(books,function(index,item){
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var btxm = $("<td></td>").append(item.btxm);
            var isbn = $("<td></td>").append(item.isbn);
            var bname = $("<td></td>").append(item.bname);
            var author = $("<td></td>").append(item.author);
            var imgUrl =  $("<img height='95'width='70'/>").attr('src',item.bookImg);
            var bookImg = $("<td></td>").append(imgUrl);
            var className = $("<td></td>").append(item.className);
            var state = $("<td></td>").append(item.state==0?"在馆":item.state==1?"已借出":"已预约");
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前用户id
            editBtn.attr("edit-id",item.btxm);
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的用户id
            delBtn.attr("del-id",item.btxm);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(btxm)
                .append(isbn)
                .append(bname)
                .append(author)
                .append(bookImg)
                .append(className)
                .append(state)
                .append(btnTd)
                .appendTo("#books_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.bookInfo.pageNum+"页，共"+
            result.extend.bookInfo.pages+"页，共"+
            result.extend.bookInfo.total+"条记录");
        totalRecord = result.extend.bookInfo.total;
        currentPage = result.extend.bookInfo.pageNum;
    }
    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result){
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.bookInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.bookInfo.pageNum -1);
            });
        }



        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.bookInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.extend.bookInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.bookInfo.pages);
            });
        }



        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.bookInfo.navigatepageNums,function(index,item){

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.bookInfo.pageNum == item){
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
    $("#book_add_modal_btn").click(function(){
        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#bookAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#bookAddModal select");
        //弹出模态框
        $("#bookAddModal").modal({
            backdrop:"static"
        });
    });

    function imageUpload(obj) {
        //判断图片格式
        var fileName=obj.value;
        var suffixIndex=fileName.lastIndexOf(".");
        var suffix=fileName.substring(suffixIndex+1).toUpperCase();
        if(suffix!="BMP"&&suffix!="JPG"&&suffix!="JPEG"&&suffix!="PNG"&&suffix!="GIF"){
            alert("请上传图片（格式BMP、JPG、JPEG、PNG、GIF等）!");
            return;
        }

        var formData = new FormData();
        formData.append('file', $('#bimg_add_input')[0].files[0]);  //添加图片信息的参数
        $.ajax({
            type: "POST",
            url: "${APP_PATH}//book/upload",
            data:formData,
            cache: false, //上传文件不需要缓存
            processData: false,// 告诉jQuery不要去处理发送的数据
            contentType: false,// 告诉jQuery不要去设置Content-Type请求头
            encType:"multipart/form-data",
            success: function(res) {
                var imgPath = res.extend['imgPath'];
                $('#add_bimg').attr("src", imgPath);
                $('#addimgStr').val(imgPath);
            }
        });

    }
    function imageUpdate(obj) {
        //判断图片格式
        var fileName=obj.value;
        var suffixIndex=fileName.lastIndexOf(".");
        var suffix=fileName.substring(suffixIndex+1).toUpperCase();
        if(suffix!="BMP"&&suffix!="JPG"&&suffix!="JPEG"&&suffix!="PNG"&&suffix!="GIF"){
            alert("请上传图片（格式BMP、JPG、JPEG、PNG、GIF等）!");
            return;
        }

        var formData = new FormData();
        formData.append('file', $('#bimg_update_input')[0].files[0]);  //添加图片信息的参数
        $.ajax({
            type: "POST",
            url: "${APP_PATH}//book/upload",
            data:formData,
            cache: false, //上传文件不需要缓存
            processData: false,// 告诉jQuery不要去处理发送的数据
            contentType: false,// 告诉jQuery不要去设置Content-Type请求头
            encType:"multipart/form-data",
            success: function(res) {
                var imgPath = res.extend['imgPath'];
                $('#update_bimg').attr("src", imgPath);
                $('#updateimgStr').val(imgPath);
            }
        });

    }

    //查出所有的院系信息并显示在下拉列表中
    function getDepts(ele){
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}//book/bookClass",
            type:"GET",
            success:function(result){
                $.each(result.extend.bookClass,function(){
                    var optionEle = $("<option></option>").append(this.className).attr("value",this.classId);
                    optionEle.appendTo(ele);
                });
            }
        });

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

    //校验条形码是否可用
    $("#btxm_add_input").change(function(){
        //发送ajax请求校验条形码是否可用
        var btxm = this.value;
        $.ajax({
            url:"${APP_PATH}/book/checkBook",
            data:"btxm="+btxm,
            type:"POST",
            success:function(result){
                console.log(result);
                if(result.code==100){
                    show_validate_msg("#btxm_add_input","success","条形码可用");
                    $("#user_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#btxm_add_input","error",result.extend.va_msg);
                    $("#user_save_btn").attr("ajax-va","error");
                }
            }
        });
    });

    //点击保存，保存图书。
    $("#user_save_btn").click(function(){
        $.ajax({
            url:"${APP_PATH}/book/addBook",
            type:"POST",
            data:$("#bookAddModal form").serialize(),
            success:function(result){
                if(result.code == 100){
                    $("#bookAddModal").modal('hide');
                    $('#add_bimg').attr("src", '');
                    to_page(totalRecord);
                }else{
                    if(undefined != result.extend.errorFields.uno){
                        show_validate_msg("#btxm_add_input", "error", result.extend.errorFields.btxm);
                    }
                }
            }
        });
    });


    $(document).on("click",".edit_btn",function(){
        getDepts("#bookUpdateModal select");
        getUser($(this).attr("edit-id"));
        $("#book_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#bookUpdateModal").modal({
            backdrop:"static"
        });
    });

    function getUser(id){
        $.ajax({
            url:"${APP_PATH}/book/getbyId/"+id,
            type:"GET",
            success:function(result){
                console.log(result);
                var bookData = result.extend.bookbyid;
                $("#btxm_update_static").val(bookData.btxm);
                $("#isbn_update_input").val(bookData.isbn);
                $("#bname_update_input").val(bookData.bname);
                $("#author_update_input").val(bookData.author);
                $('#update_bimg').attr("src", bookData.bookImg);
                $('#updateimgStr').val(bookData.bookImg);
                $("#bookUpdateModal input[name=state]").val([bookData.state]);
                $("#bookUpdateModal select").val([bookData.bclass]);
            }
        });
    }

    //点击更新，更新用户信息
    $("#book_update_btn").click(function(){
        //2、发送ajax请求保存更新的用户数据
        console.log($("#bookUpdateModal form").serialize());
        $.ajax({
            url:"${APP_PATH}/book/upBook/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#bookUpdateModal form").serialize(),
            success:function(result){
                //1、关闭对话框
                $("#bookUpdateModal").modal("hide");
                $('#update_bimg').attr("src", '');
                //回到当前页面
                to_page(currentPage);
            }
        });
    });

    //单个删除
    $(document).on("click",".delete_btn",function(){
        //1、弹出是否确认删除对话框
        var bname = $(this).parents("tr").find("td:eq(2)").text();
        var btxm = $(this).attr("del-id");
        if(confirm("确认删除【"+bname+"】吗？")){
            //确认，发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/book/deleteOne/"+btxm,
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
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function(){
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#book_delete_all_btn").click(function(){
        //
        var bname = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function(){
            //this
            bname += $(this).parents("tr").find("td:eq(3)").text()+",";
            //组装用户id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        bname = bname.substring(0, bname.length-1);
        //去除删除的id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length-1);
        if(confirm("确认删除【"+bname+"】吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/book/deleteMore/"+del_idstr,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
    //一键推荐
    $("#book_recommend_btn").click(function(){
        var bname = "";
        var add_idstr = "";
        $.each($(".check_item:checked"),function(){
            //this
            bname += $(this).parents("tr").find("td:eq(3)").text()+",";
            //组装用户id字符串
            add_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        bname = bname.substring(0, bname.length-1);
        add_idstr = add_idstr.substring(0, add_idstr.length-1);
        if(confirm("确认推荐【"+bname+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/sysReco/addSysreco/"+add_idstr,
                type:"POST",
                success:function(result){
                    if (result.extend.overstep == null){
                        alert(result.msg);
                    }
                    else {
                        alert(result.extend.overstep);
                    }
                    to_page(currentPage);
                }
            });
        }
    });

    //为搜索按钮绑定单击事件
    $("#search_btn").click(function () {
        //清空tbody，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#books_table tbody").empty();
        //将搜索框中的内容保存到searchContent中
        var searchContent = $("#search_book").val();
        console.log(searchContent);
        $("#page_nav_area").empty();
        //如果输入框中的内容为空的话，用to_page回到原本显示的界面。
        if(searchContent == ""){
            to_page(1);
        }else{
            //如果不为空的话，发送ajax请求
            $.ajax({
                url:"${APP_PATH}/book/bookSearch",
                type:"GET",
                data:"content=" + searchContent,
                success:function (res) {
                    //显示搜索到的用户
                    search_books_table(res);
                    //显示搜索页面的分页信息
                    build_search_page_info(res);
                }
            });
        }
    })
    // 解析并显示查询到的用户数据
    function search_books_table(res) {
        //清空table表格，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#books_table tbody").empty();
        //将查找出来的用户数据保存在bookSearched中
        var bookSearched = res.extend.pageInfo.list;
        if(bookSearched.length == 0){
            $("<h4 style='color: red'></h4>").append("很抱歉没找到！！！")
                .appendTo("#books_table tbody");//将tr添加到tbody标签中
        }else {
            //遍历所有查询到的用户
            $.each(bookSearched,function(index,item){
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var btxm = $("<td></td>").append(item.btxm);
                var isbn = $("<td></td>").append(item.isbn);
                var bname = $("<td></td>").append(item.bname);
                var author = $("<td></td>").append(item.author);
                var imgUrl =  $("<img height='95'width='70'/>").attr('src',item.bookImg);
                var bookImg = $("<td></td>").append(imgUrl);
                var className = $("<td></td>").append(item.className);
                var state = $("<td></td>").append(item.state==0?"在馆":item.state==1?"已借出":"已预约");
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为编辑按钮添加一个自定义的属性，来表示当前用户id
                editBtn.attr("edit-id",item.btxm);
                var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的用户id
                delBtn.attr("del-id",item.btxm);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                    .append(btxm)
                    .append(isbn)
                    .append(bname)
                    .append(author)
                    .append(bookImg)
                    .append(className)
                    .append(state)
                    .append(btnTd)
                    .appendTo("#books_table tbody");
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
