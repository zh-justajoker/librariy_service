<%--
  Created by IntelliJ IDEA.
  User: 张航
  Date: 2021/4/17
  Time: 10:26
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
        #swiper_table td  {
            vertical-align: middle;
            text-align: center;
        }
        #swiper_table th  {
            vertical-align: middle;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="modal fade" id="swiperUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">轮播图修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">轮播图ID</label>
                            <div class="col-sm-10">
                                <input type="text" name="sid" class="form-control" id="sid_update_static" readonly="readonly">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">轮播图片</label>
                            <div class="col-sm-10">
                                <input name="file" type="file" onchange="swiperUpdate(this)" id="simg_update_input" formenctype="multipart/form-data">
                                <img height="80px" style="margin-top: 20px" src="" alt="" id="update_simg" >
                                <input type="text" name="swUrl" style="visibility: hidden" id="updateimgStr" autocomplete="off" readonly="readonly">
                                <span class="help-block"></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="swiper_update_btn">更新</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>轮播图管理</h1>
            </div>
        </div>
        <br>
        <br><br>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="swiper_table">
                    <thead>
                    <tr>
                        <th>轮播图ID</th>
                        <th>轮播图片</th>
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
                url:"${APP_PATH}/swiper/getlist",
                data:"pn="+pn,
                type:"GET",
                success:function(result){
                    console.log(result);
                    //1、解析并显示用户数据
                    build_swiper_table(result);
                    //2、解析并显示分页信息
                    build_page_info(result);
                }
            });
        }

        function build_swiper_table(result){
            //清空table表格
            $("#swiper_table tbody").empty();
            var swipers = result.extend.swiperInfo.list;
            $.each(swipers,function(index,item){
                var sid = $("<td></td>").append(item.sid);
                var imgUrl =  $("<img height='150'/>").attr('src',item.swUrl);
                var swUrl = $("<td></td>").append(imgUrl);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("修改");
                //为编辑按钮添加一个自定义的属性，来表示当前用户id
                editBtn.attr("edit-id",item.sid);
                var btnTd = $("<td></td>").append(editBtn);
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>")
                    .append(sid)
                    .append(swUrl)
                    .append(btnTd)
                    .appendTo("#swiper_table tbody");
            });
        }
        //解析显示分页信息
        function build_page_info(result){
            $("#page_info_area").empty();
            $("#page_info_area").append("共"+ result.extend.swiperInfo.total+"条记录");
        }

        $(document).on("click",".edit_btn",function(){

            getUser($(this).attr("edit-id"));
            //3、把用户的id传递给模态框的更新按钮
            $("#swiper_update_btn").attr("edit-id",$(this).attr("edit-id"));
            $("#swiperUpdateModal").modal({
                backdrop:"static"
            });
        });
        function swiperUpdate(obj) {
            //判断图片格式
            var fileName=obj.value;
            var suffixIndex=fileName.lastIndexOf(".");
            var suffix=fileName.substring(suffixIndex+1).toUpperCase();
            if(suffix!="BMP"&&suffix!="JPG"&&suffix!="JPEG"&&suffix!="PNG"&&suffix!="GIF"){
                alert("请上传图片（格式BMP、JPG、JPEG、PNG、GIF等）!");
                return;
            }

            var formData = new FormData();
            formData.append('file', $('#simg_update_input')[0].files[0]);  //添加图片信息的参数
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
                    $('#update_simg').attr("src", imgPath);
                    $('#updateimgStr').val(imgPath);
                }
            });

        }
        function getUser(id){
            $.ajax({
                url:"${APP_PATH}/swiper/getbyId/"+id,
                type:"GET",
                success:function(result){
                    console.log(result);
                    var swiperData = result.extend.swiperbyid;
                    $("#sid_update_static").val(swiperData.sid);
                    $('#update_simg').attr("src", swiperData.swUrl);
                    $('#updateimgStr').val(swiperData.swUrl);
                }
            });
        }

        $("#swiper_update_btn").click(function(){
            //2、发送ajax请求保存更新的用户数据
            console.log($("#swiperUpdateModal form").serialize());
            $.ajax({
                url:"${APP_PATH}/swiper/upSwiper/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#swiperUpdateModal form").serialize(),
                success:function(result){
                    //1、关闭对话框
                    $("#swiperUpdateModal").modal("hide");
                    $('#update_simg').attr("src", '');
                    to_page(1);
                }
            });
        });
    </script>
</body>
</html>
