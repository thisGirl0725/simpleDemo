<%--
  Created by IntelliJ IDEA.
  User: lyq
  Date: 2019/7/2
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/webjars/layui/2.4.5/css/layui.css">
    <script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
    <script src="/webjars/layui/2.4.5/layui.js"></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">by1902bylee</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">

                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    李亚琦
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="/user/logout">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 静态tree  -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item ">
                    <a class="" href="javascript:;">用户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:tabAdd('用户列表','/user/toUserTable2','yhlb');">用户表</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item ">
                    <a class="" href="javascript:;">角色管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:tabAdd('角色列表','/role/roleTablePage','jslb');">角色表</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item ">
                    <a class="" href="javascript:;">权限管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:tabAdd('权限列表','/permission/permissionTable','qxlb');">权限表</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <%--选项卡主题--%>
        <div class="layui-tab" lay-filter="myTabs" lay-allowclose="true">
            <ul class="layui-tab-title">
                <li class="layui-this" lay-id="11">欢迎页面</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">内容主体区域</div>
            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script>
    //JavaScript代码区域
    var element;
    var active;
    // use(["模块1","模块2"],function(){ layui.模块  })
    layui.use('element', function(){
        element = layui.element;
        //触发事件
        active = {
            tabAdd: function(title,url,id){
                //新增一个Tab项
                element.tabAdd('myTabs', {
                    title: title //用于演示
                    , content: '<iframe style="width:100%;height:100%;position:relative;" src="'+url+'" frameborder="0" scrolling="true" ></iframe>'
                    ,id:id
                })
            }
            ,tabDelete: function(othis){
                //删除指定Tab项
                element.tabDelete('demo', '44'); //删除：“商品管理”
                othis.addClass('layui-btn-disabled');
            }
            ,tabChange: function(id){
                //切换到指定Tab项
                element.tabChange('myTabs', id); //切换到：用户管理
            }
        };
    });
    //增加选项卡
    function tabAdd(title,url,id){
        //如果没有选项卡
        if($(".layui-tab-title li[lay-id]").length <= 0){
            //新增一个Tab项
            active.tabAdd(title,url,id);
        }else{
            //判断是否重复
            var flag = false;//没有重复
            $(".layui-tab-title li[lay-id]").each(function(json){
                if($(this).attr("lay-id") == id){
                    flag = true;
                }
            })
            if(flag == false){
                active.tabAdd(title,url,id);
            }
        }
        //切换到指定Tab项
        active.tabChange(id);
    }
</script>

</body>
</html>
