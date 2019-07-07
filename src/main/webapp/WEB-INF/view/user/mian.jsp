<%--
  Created by IntelliJ IDEA.
  User: lyq
  Date: 2019/7/1
  Time: 10:07
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
            $('#tree').tree({//动态tree
                url:'/tree/trees',
                onClick: function(node){
                    addtabs(node.text,node.url) // 在用户点击的时候提示
                }
            });

        })

        function addtabs(tit,url) {//选项卡,点击树新增页面
            var b =$('#addpage').tabs('exists',tit);
            if (!b) {
                $('#addpage').tabs('add',{
                    title:tit,
                    content:'<iframe style="width:100%;height:100%;position:relative;" src="'+url+'" frameborder="0" scrolling="true" ></iframe>',
                    closable:true,
                    fit:true,
                    tools:[{
                        iconCls:'icon-mini-refresh',
                        handler:function(){
                            alert('refresh');
                        }
                    }]
                });
            }else {
                $('#addpage').tabs('select',tit);
            }
        }
    </script>
</head>

<body class="easyui-layout">
        <div data-options="region:'north',title:'主标题',split:true" style="height:100px;">
            <h1 align="center"> shiro到springboot整合阶段一</h1>
        </div>
        <div data-options="region:'south',title:'大概介绍',split:true" style="height:100px;"></div>
        <div data-options="region:'east',iconCls:'icon-reload',title:'广告区',split:true" style="width:100px;"></div>
        <div data-options="region:'west',title:'动态tree',split:true" style="width:100px;">
            <ul id="tree"></ul>
        </div>
        <div data-options="region:'center',title:'显示页面'" style="padding:5px;background:#eee;">
            <div id="addpage" class="easyui-tabs" fit="true">
                <div title="欢迎页面" data-options="closable:true" style="overflow:auto;padding:20px;display:none;" id="huanying">
                </div>
             </div>
        </div>
</body>

</html>
