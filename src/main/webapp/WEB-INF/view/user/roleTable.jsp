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
                url:'/role/roles',
                fitColumns:true,
                columns:[[
                    {field:'ck',align:'center',width:50,checkbox:true},
                    {field:'roleId',title:'角色编号',width:100},
                    {field:'roleName',title:'角色名字',width:100},
                ]],
                toolbar: [{
                    iconCls: 'icon-add',
                    text: "增加",
                    handler: function(){ shwoDialog('addDialog','增加角色');}
                },'-',{
                    iconCls: 'icon-cancel',
                    text: "删除",
                    handler: function(){ deletePage();}
                },'-',{
                    iconCls: 'icon-edit',
                    text: "修改",
                    handler: function(){updatePage();}
                }]

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
                url: "/role/role",
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
            var role = $('#dg').datagrid('getSelected');//获取第一个选择的数据
            if (role == null){
                return;
            }
            $('#updateform').form('load','/role/role/'+role.roleId);
        }
        function updateForm() {//修改提交
            $.messager.progress();	// 显示进度条
            $('#updateform').form('submit', {
                url: "/role/role",
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
            var roles = $('#dg').datagrid('getSelections');
            var arr ={};
            for ( i=0;i<roles.length;i++){
                arr[i] = roles[i].roleId;
            }
            if (arr.length==0){
                return;
            }
            $.messager.confirm('确认','确定要删除吗？',function(r){
                if (r){
                    $.ajax({
                        url:"/role/role",
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
    </script>
</head>
<body>
<table id="dg" ></table>
<div id="addDialog" style="display: none;">
    <form id="addform" method="post">
        <table cellpadding="5">

            <tr>
                <td>角色名字：</td>
                <td>
                    <input class="easyui-textbox" type="text" name="roleName" data-options="required:true" ></input></td>
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
        <input type="hidden" name="roleId" >
        <table cellpadding="5">
            <tr>
                <td>用户角色：</td>
                <td><input class="easyui-textbox" type="text" name="roleName" ></input></td>
            </tr>
        </table>
    </form>
    <div style="text-align:center;padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="updateForm()">提交</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  style="width: 80px" onclick="clearForm()">重置</a>
    </div>

</div><%--修改弹框--%>
</body>
</html>
