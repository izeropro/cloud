<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="/master-tag" prefix="fms" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/date-tag" prefix="date" %>
<fms:ContentPage masterPageId="frontMaster">
	<fms:Content contentPlaceHolderId="title">
		${title}
	</fms:Content>
	<fms:Content contentPlaceHolderId="source">
		<!-- 导入外部css/js -->
		<link rel="stylesheet" href="${contextPath}/js/dropkick/css/dropkick.css" />
		<script src="${contextPath}/js/dropkick/js/jquery.dropkick-2.1.9.min.js"></script>
		<!-- 日历插件 -->
		<link href='${contextPath}/js/fullcalendar/fullcalendar.min.css' rel='stylesheet' />
		<link href='${contextPath}/js/fullcalendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
		
		<script src='${contextPath}/js/fullcalendar/lib/moment.min.js'></script>
		<script src='${contextPath}/js/fullcalendar/fullcalendar.min.js'></script>
		<script src='${contextPath}/js/fullcalendar/jquery.fancybox-1.3.4.pack.js' ></script>
		
	</fms:Content>
	<fms:Content contentPlaceHolderId="main">
		<!-- main content -->
		<div class="main" style="overflow:hidden;">
			<div style="position:relative">
				<div class="cmenu" >
					<div class="cmenuleft">
						<a href="${contextPath}/my/contents">我的记录</a>
						<a class="cur">我的日历</a>
						<a href="${contextPath}/my/msg">我的消息</a>
					</div>
					<div class="cmenuright">
						<a href="${contextPath}/my/me">资料</a>
						<a href="${contextPath}/my/stats">统计</a>
						<a href="#">访客</a>
              		</div>
              		<div class="clear"></div>
				</div>	
				<div class="space_h_40"></div>
				<div>
					<!-- main div -->
					<div style="padding:15px 0 10px 0;margin-bottom:10px;border-bottom: 1px solid #ccc;">
						<select name="data_source" class="dropkick" id="data_source">
							<c:forEach items="${users}" var="u">
								<c:if test="${u.id==user.id}">
									<option value="${u.id}" selected="selected">${u.username}</option>
								</c:if>
								<c:if test="${u.id!=user.id}">
									<option value="${u.id}">${u.username}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div id='calendar'></div>
				</div>
				<div class="space_h_30 clear"></div>
			</div>
		</div>
		<!-- 新增事件模态对话框 -->
		<div class="modal fade" id="add_event" tabindex="-1" role="dialog" aria-labelledby="add_event" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                		<h4 class="modal-title" > ★ 创建事件 <small> >>请输入事件详细信息 </small></h4>
					</div>
					<div class="modal-body">
						<form action="${contextPath}/calendar/save.json" method="post" id="add_form">
							<div class="form-group">
								<span class="control-label">开始时间：</span>
								<input type="text" name="start" class="input-text" placeholder=""  />
							</div>
							<div class="form-group">
								<span class="control-label">结束时间：</span>
								<input type="text" name="end" readonly="readonly" class="input-text" placeholder=""  />
							</div>
							<div class="form-group">
								<span class="control-label">日程标题：</span>
								<input type="text" name="title"  class="input-text" placeholder="日程标题"  />
							</div>
							<div class="form-group">
								<span class="control-label">日程详情：</span>
								<textarea class="form-control" rows="6" style="width:341px;margin-top: 10px;resize: none;" name="content"></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                		<button type="button" class="btn btn-primary" onclick="add_event()">创建事件+</button>
					</div>
					
				</div>
			</div>
		</div>
		<!-- 查看事件模态对话框 -->
		<div class="modal fade" id="select_event" tabindex="-1" role="dialog" aria-labelledby="add_event" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                		<h4 class="modal-title" > ★ 查看事件 <small> >>事件详情 </small></h4>
					</div>
					<div class="modal-body" id="select_div">
						<div class="form-group">
							<input type="hidden" name="id" value="" />
							<span class="control-label">开始时间：</span>
							<span class="control-label" name="start"></span>
						</div>
						<div class="form-group">
							<span class="control-label">结束时间：</span>
							<span class="control-label" name="end"></span>
						</div>
						<div class="form-group">
							<span class="control-label">日程标题：</span>
							<span class="control-label" name="title"></span>
						</div>
						<div class="form-group">
							<span class="control-label">日程详情：</span>
							<span class="control-label" name="content"></span>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="del_event" onclick="del_calendar()">删除事件</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
		
		
		<script type="text/javascript">
			$(document).ready(function() {
			   $('#data_source').dropkick();
			   var userid = $("#data_source").val();
			   $("#calendar").fullCalendar({
				   header:{
					   left:'prev,next today',
					   center:'title',
					   right:'month,agendaWeek,agendaDay,listMonth'
				   },
				   navLinks:true, // can click day/week names to navigate views
				   businessHours: true, // display business hours
				   eventSources:[{
						events:function(start, end,timezone,callback){
					   		var userid = $("#data_source").val();
					   		$.ajax({
								url:"${contextPath}/calendar/list.json",
								data:{userid:userid},
								success:function(data){
									//var datas = eval("("+data+")").bolist;
								 	var datas = data.bolist;
									callback(datas);
								}
							});
				       	},
				       	color: '#d6eeff',   // an option!
			            textColor: 'black' // an option!
				   }],
				   dayClick:function(date, allDay, jsEvent, view){
						//开始时间
						var selDate =$.fullCalendar.formatDate(date,"YYYY-MM-DD");//格式化日期
						$("#add_form input[name='start']").val(selDate+" 08:01");
						$("#add_form input[name='end']").val(selDate+" 23:01");
						
						$("input[name='start']").datetimepicker();
						$("input[name='end']").datetimepicker();
						
				   		$("#add_event").modal("show");
				   },
				   eventClick:function(calEvent,jsEvent,view){
						var id = calEvent.id;
						$.ajax({
							url:"${contextPath}/calendar/get.json",
							data:{id:id},
							success:function(data){
								//data =  eval("("+data+")");
								var c = data.calendar;
								var start = new Date(c.startTime).Format("yyyy-MM-dd HH:mm:ss");
						     	var end = new Date(c.endTime).Format("yyyy-MM-dd HH:mm:ss");
						     	$("#select_div input[name='id']").val(c.id);
								$("#select_div span[name='start']").html(start);
								$("#select_div span[name='end']").html(end);
								$("#select_div span[name='title']").html(c.title);
								$("#select_div span[name='content']").html(c.content);
								$("#select_event").modal("show");
							}
						});
						
				   }
			   });
			   
			   $("#data_source").change(function(){
				   var val = $(this).val();
				   var userid = '${user.id}';
				   if(val != userid){
					   $("#del_event").hide();
				   }else{
					   $("#del_event").show();
				   }
				   $('#calendar').fullCalendar('refetchEvents'); //重新获取所有事件数据 
			   });
			   
			});
			
			function add_event(){
				var userid = $("#data_source").val();
				var form = $("#add_form");
				var action = form.attr("action");
				var alldata = form.serialize();
				alldata += "&userid="+userid;
				var start = form.find("input[name='start']").val();
				var end = form.find("input[name='end']").val();
				var title = form.find("input[name='title']").val().trim();
				var content = form.find("textarea[name='content']").val().trim();
				var regEx = new RegExp("\\-","gi");
				start = start.replace(regEx,"/");
				end = end.replace(regEx,"/");
				start = new Date(start+":00").getTime();
				end = new Date(start+":00").getTime();
				var now = new Date().getTime();
				if(start <= end){
					$.alert({title:'提示信息',content:"开始时间必须大于结束时间！",type:'red'});
					return;
				}
				if(start < now){
					$.alert({title:'提示信息',content:"开始时间必须大于当前时间！",type:'red'});
					return;
				}
				if(end < now){
					$.alert({title:'提示信息',content:"结束时间必须大于当前时间！",type:'red'});
					return;
				}
				if(title == ''){
					$.alert({title:'提示信息',content:"请输入日程标题！",type:'red'});
					return;
				}
				if(content == ''){
					$.alert({title:'提示信息',content:"请输入日程内容！",type:'red'});
					return;
				}
				
				$.ajax({
					url:action,
					data:alldata,
					type:"POST",
					success:function(data){
						//var vdata = eval("("+data+")");
						var vdata = data;
          			   	$.alert({title:'提示信息',content:vdata.message,type:'blue'});
          			  	$("#add_event").modal("hide");
          			   	document.getElementById("add_form").reset();
          			  	$('#calendar').fullCalendar('refetchEvents');
					}
				});
			}
			
			function del_calendar(){
				var id = $("#select_div input[name='id']").val();
				$.confirm({
					title:'提示信息',
					content:'确认删除吗？删除后无法恢复！！！',
					buttons:{
						confirm:function(){
							$.ajax({
								url:'${contextPath}/calendar/delete.json',
								data:{id:id},
								success:function(data){
									$.alert({title:'提示信息',content:data.message,type:'red'});
									$("#select_event").modal("hide");
									$('#calendar').fullCalendar('refetchEvents');
								}
							});
						},
						cancel:function(){
							//取消
						}
					}
				});
			}
				   
		</script>
		
		
	</fms:Content>
</fms:ContentPage>