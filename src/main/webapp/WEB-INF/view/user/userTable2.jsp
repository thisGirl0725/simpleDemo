<%--
  Created by IntelliJ IDEA.
  User: lyq
  Date: 2019/7/2
  Time: 21:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>标题</title>
    <link rel="stylesheet" href="/webjars/layui/2.4.5/css/layui.css">
    <script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
    <script src="/webjars/layui/2.4.5/layui.js"></script>

    <script type="text/html" id="userToolBar">
        <a class="layui-btn layui-btn-xs" lay-event="giveRole">赋角色</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <script type="text/html" id="ToolBar">
        <a class="layui-btn layui-btn-xs" lay-event="edit">增加</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">修改</a>
    </script>
    <script>
        layui.use(['table','layer','form','jquery'], function() {
            var form = layui.form;
            var table=layui.table;
            var $ = layui.jquery;
            var lay = layui.layer;
            //第一个实例
            table.render({
                elem: '#userTable'//对应table载体的id
                ,height: 'full-60'
                ,url: '/user/users2' //加载json数据
                ,page: true //开启分页
                ,toolbar: '#ToolBar'
                ,cols: [[ //表头
                    {type: 'checkbox', fixed: 'left'}//复选框
                    ,{field: 'userId', title: '用户编码',}
                    ,{field: 'userName', title: '用户名'}
                    ,{field: 'roles', title: '用户角色' ,
                        templet: function(d){
                            var roles = d.roles;
                            var  str = '';
                            for (var i = 0; i < roles.length; i++) {
                                str += ','+roles[i].roleName;
                            }
                            str = str.substring(1);
                            return str;
                        }
                    }
                    ,{fixed: 'right', title:'操作', toolbar: '#userToolBar', width:150}
                ]]
            });
            table.on('tool(userTableFilter)',function(obj){
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象

                if(layEvent === 'del'){//说明是删除操作\
                    layer.confirm('真的删除行么', function(index){
                        $.post("/user/user/"+data.userId,{"_method":"delete"},function(data){
                            if(data.success){
                                obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                            }else{
                                layer.msg('删除失败！');
                            }
                        },"json");
                        layer.close(index);
                        //向服务端发送删除指令
                    });
                } else if(layEvent === 'giveRole'){//说明是赋角色操作\
                        var userId=data.userId;
                        $("#userId").val(userId);

                        active.showRoleByUserId(userId);

                        lay.open({
                            type:1,
                            title:"赋角色",
                            content:$("#giveRole"),
                            area:['500px','300px'],
                            icon:0
                        })

                }
            })

                var active = {
                    "showRoleByUserId": function (userId) {
                        $.get("/user/roles", {'userId': userId}, function (data) {
                            var roles = data.roles;
                            var roleIds = data.roleIds;
                            $("#rolesId").empty();//清除当前元素中的对象
                            for (var i = 0; i < roles.length; i++) {
                                var che = '';
                                if (roleIds.indexOf(roles[i].roleId) > -1) {//有重复的内容，则应该被选中
                                    che = 'checked';
                                }
                                $("#rolesId").append('<input type="checkbox" ' + che + ' name="roleName[' + i + ']" value="' + roles[i].roleId + '" title="' + roles[i].roleName + '"><br>');
                            }
                            form.render();
                        }, 'json');

                    }
                }


                 //对表格顶部工具栏的监听 toolbar
                 table.on('toolbar(userTableFilter)', function(obj){
                     var checkStatus = table.checkStatus(obj.config.id);
                     switch(obj.event){
                         case 'add':
                             layer.msg('添加');
                             break;

                     };
                 });
                //监听提交
                form.on('submit(giveRoleSubmit)', function(data){
                    console.log(data.field);//角色ids
                    $.post("/user/addUserRole2",data.field,function(data){
                        if(data.success){
                            table.reload("userTable", {page:{curr:1}});//从第一页加载
                        }else{
                            layer.msg('失败！');
                        }
                        layer.closeAll();
                    },"json")

                    return false;//防止表单自动提交
                });


            })

    </script>
</head>
<body>
<table id="userTable" lay-filter="userTableFilter"></table>
<div style="display: none;" id="giveRole">
    <form class="layui-form" action="">
        <input type="hidden" name="userId" id="userId">
        <div class="layui-form-item">
            <label class="layui-form-label">角色：</label>

            <div class="layui-input-block" id="rolesId">
            </div>
            </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="giveRoleSubmit">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>

</body>
</html>
