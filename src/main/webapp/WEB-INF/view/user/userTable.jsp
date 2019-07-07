<%--
  Created by IntelliJ IDEA.
  User: lyq
  Date: 2019/7/1
  Time: 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/jquery.min.js"></script>
    <script  src="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/jquery.easyui.min.js "></script>
    <link rel="stylesheet" href="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/themes/default/easyui.css">
    <link rel="stylesheet" href="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/themes/icon.css">
    <script  src="/webjars/github-com-novaeye-jquery-easyui-bower/1.5.0.1/locale/easyui-lang-zh_TW.js"></script>
    <script>
        $(function () {//页面加载函数
            $('#dg').datagrid({
                url:'/user/users',
                fitColumns:true,
                columns:[[
                    {field:'ck',align:'center',width:50,checkbox:true},
                    {field:'userId',title:'用户编号',width:100},
                    {field:'userName',title:'用户姓名',width:100},
                    {field:'roles',title:'角色名称',width:100,
                        formatter:function (value,row,index) {
                             var  roles=row.roles;
                             var str='';
                             for (var i= 0;i<roles.length;i++){
                                str+=","+roles[i].roleName;
                             }
                             str = str.substring(1);
                                return str;

                        }

                    }
                ]],
                toolbar: [{
                    iconCls: 'icon-add',
                    text: "增加",
                    handler: function(){ shwoDialog('addDialog','增加用户');}
                },'-',{
                    iconCls: 'icon-cancel',
                    text: "删除",
                    handler: function(){ deletePage();}
                },'-',{
                    iconCls: 'icon-edit',
                    text: "修改",
                    handler: function(){updatePage();}
                },'-',{
                    iconCls: 'icon-add',
                    text: "赋角色",
                    handler: function(){addRolePage();}
                }
                ]

            });
        })
        function shwoDialog(id,tit){//弹框
            $("#"+id).dialog({
                title: tit,
                width: 600,
                height: 400,
                closed: false,
                cache: false,
                modal: true
            });
        }
        function submitForm(){
            $.messager.progress();	// 显示进度条
            $('#addform').form('submit', {
                url: "/user/user",
                onSubmit: function(){
                    var isValid = $(this).form('validate');
                    if (!isValid){
                        $.messager.progress('close');
                    }
                    return isValid;
                },
                success: function(data){
                    console.log(data)
                    if(data == 'success'){
                        $('#addDialog').dialog("close");
                        $('#dg').datagrid('reload');
                        $('#addform').form("reset");
                    }
                    $.messager.progress('close');
                }
            });
        }
        function updatePage(){//修改弹框
            shwoDialog('updateDialog','修改角色');
            var user = $('#dg').datagrid('getSelected');//获取第一个选择的数据
            if (user == null){
                return;
            }
            $('#updateform').form('load','/user/user/'+user.userId);
        }
        function updateForm() {//修改提交
            $.messager.progress();	// 显示进度条
            $('#updateform').form('submit', {
                url: "/user/user",
                onSubmit: function(){
                    var isValid = $(this).form('validate');
                    if (!isValid){
                        $.messager.progress('close');
                    }
                    return isValid;
                },
                success: function(data){
                    if(data == "success"){
                        $.messager.alert('提示','修改成功');
                    }else{
                        $.messager.alert('提示','修改失败');
                    }
                    $.messager.progress('close');
                    $('#updateDialog').dialog("close");
                    $('#dg').datagrid('reload');
                    $('#updateform').form('reset');
                }
            });
        }
        function deletePage() {
            var users = $('#dg').datagrid('getSelections');
            var arr ={};
            for ( i=0;i<users.length;i++){
                arr[i] = users[i].userId;
            }
            if (arr.length==0){
                return;
            }
            $.messager.confirm('确认','确定要删除吗？',function(r){
                if (r){
                    $.ajax({
                        url:"/user/user",
                        type:"delete",
                        data:{
                            "arr":arr
                        },
                        success:function(data){
                            if(data == "success"){
                                $.messager.alert('提示','删除成功');
                            }else{
                                $.messager.alert('提示',"删除失败")
                            }
                            $('#dg').datagrid('reload');
                        }
                    })
                }
            });
        }
        function addRolePage(){//修改弹框
            shwoDialog('addRoleDialog','赋予角色');
            var user = $('#dg').datagrid('getSelected');//获取第一个选择的数据
            if (user == null){
                return;
            }
            $("#userId").val(user.userId);
            $.ajax({
                url:"/user/roles/"+user.userId,//得到role的全部数据，和role的id
                type:"get",
                datatype:"json",
                async:false,
                success:function(data){
                    $("#selectUserRole").empty();
                    var roles =  data.roles;
                    var roleIds = data.roleIds;
                    for(var i = 0; i < roles.length; i++) {
                        var id = roles[i].roleId;//获得role的id值
                        var name = roles[i].roleName;//获得role的名称
                        var che='';
                        if (roleIds.indexOf(id)>-1){
                            che='  checked   ';
                        }
                        var opt = '<input type="checkbox" value="'+id+'" name="roleName'+'['+i+']'+'" '+che+ '>'+name;
                        $("#selectUserRole").append(opt);

                    }},
                    error:function () {
                        alert("错误")
                    }
            })

        }
        function addUserRoleForm() {//修改提交
            var arr={};
            $.messager.progress();	// 显示进度条
            $('#addRoleform').form('submit', {
                url: "/user/addUserRole",
                onSubmit: function(){
                    var isValid = $(this).form('validate');
                    if (!isValid){

                    }
                    return isValid;
                },
                success: function(data){
                    if(data == "success"){
                        $.messager.alert('提示','修改成功');
                    }else{
                        $.messager.alert('提示','修改失败');
                    }
                    $.messager.progress('close');
                    $('#addRoleDialog').dialog("close");
                    $('#dg').datagrid('reload');
                    $('#updateform').form('reset');
                }
            });
        }
    </script>
</head>
<body>
<table id="dg" ></table>
<div id="addDialog" style="display: none;">
    <form id="addform" method="post">
        <table cellpadding="5">

            <tr>
                <td>用户姓名：</td>
                <td>
                    <input class="easyui-textbox" type="text" name="userName" data-options="required:true" ></input></td>
                </td>
            </tr>
            <tr>
                <td>用户密码：</td>
                <td>
                    <input class="easyui-textbox" type="password" name="userPswd" data-options="required:true" ></input></td>
                </td>
            </tr>

        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="submitForm()">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>
</div><%--增加弹框--%>
<div id="updateDialog" style="display: none;">
    <form id="updateform" method="post">
        <input type="hidden" name="_method" value="put" >
        <input type="hidden" name="userId" >
        <table cellpadding="5">
            <tr>
                <td>用户姓名：</td>
                <td><input class="easyui-textbox" type="text" name="userName" ></input></td>
            </tr>
            <tr>
                <td>用户密码：</td>
                <td>
                    <input class="easyui-textbox" type="password" name="userPswd" data-options="required:true" ></input></td>
                </td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a class="easyui-linkbutton"  style="width: 80px" onclick="updateForm()">提交</a>
        <a  class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>

</div><%--修改弹框--%>
<div id="addRoleDialog" style="display: none;">
    <form id="addRoleform" method="post">
        <input type="hidden" name="userId" id="userId" >

        <table cellpadding="5">
            <tr>
                <td>用户角色：</td>
                <td>
                     <div id="selectUserRole"></div>
                </td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="addUserRoleForm()">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>
</div><%--赋角色--%>
</body>
</html>
