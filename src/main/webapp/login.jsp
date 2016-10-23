<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("UTF-8");
String htmlData = request.getParameter("content.content") != null ? request.getParameter("content.content") : "";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>-碎片云-</title>
    <link rel="stylesheet" type="text/css" href="css/login.css">
    <script type="text/javascript" src="js/jquery-1.8.2.min.js" ></script>
    <script type="text/javascript" src="js/login.js" ></script>
    
  </head>
  
  <body>
  	<div class="top">
  		<div class="banner">
  			<div class="logo">
  				<img alt="" src="images/logo.png" width="200">
  			</div>
  			<div class="reg">
  				第一次使用碎片云平台?<a href="#">立即注册</a>
  			</div>
  			<div class="clear"></div>
  		</div>
  	</div>
  	<div class="center">
  		<div class="main">
  			<div class="login" id="tab">
  				<div class="tabList">
  					<ul>
  						<li class="cur">邮箱登陆</li>
  						<li>二维码登录</li>
  					</ul>
  				</div>
  				<div class="tabCon">
  					<div class="cur">
  						<label class="error hidden">&nbsp;请输入正确的邮箱和密码</label>
  						<p></p>
  						<input id="username" class="text-input" name="username" type="text"  maxlength="30" autofocus/>
  						<input id="password" class="text-input" name="password" type="password" maxlength="18" />
  						<span style="float: right;margin:20px 0;"><a style="color:#6e6e6e;" href="#">忘记密码?</a></span>
  						<button id="login" >登录</button>
  					</div>
  					<div>
  					此处放置二维码
  					</div>
  				</div>
  			</div>
  			<div class="adv">
  				<div class="adv-image">
  					<img alt="" src="images/adv.png" />
  				</div>
  				<div class="version"></div>
  			</div>
  			<div class="clear"></div>
  		</div>
  	</div>
  	<div class="read">
  		<div class="read-main">
  			<div class="download-phone">
	  			<div style="margin: 20px 0;">点击下载移动客户端:</div>
	  			<div>
	  				<a class="phone" href="#">Android版</a>
	  				<a class="phone" href="#">iPhone版</a>
	  			</div>
  			</div>
  			<div class="clear"></div>
  		</div>
  	</div>
  	<div class="bottom">
  		<div style="background: url('images/hr.png') repeat-x;height: 2px;"></div>
  		<div class="bottom-center" align="center">
  			碎片云信息管理系统  v1.0.0 - Copyright 2015-2026
  		</div>
  	</div>
  	
  </body>
</html>
