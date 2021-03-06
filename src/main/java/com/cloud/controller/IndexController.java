package com.cloud.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cloud.entity.Department;
import com.cloud.entity.Project;
import com.cloud.entity.Theme;
import com.cloud.entity.User;
import com.cloud.service.ContentService;
import com.cloud.service.DepartmentService;
import com.cloud.service.ProjectService;
import com.cloud.service.SysLogService;
import com.cloud.service.ThemeService;
/**
 * 主页
 * @author hack
 *
 */
@Controller  
@RequestMapping("/") 
public class IndexController {
	 private static final Logger LOGGER = Logger.getLogger(IndexController.class);
	 
	 @Autowired
	 private ProjectService projectService;
	 @Autowired
	 private DepartmentService departmentService;
	 @Autowired
	 private ContentService contentService;
	 @Autowired
	 private ThemeService themeService;
	 @Autowired
	 private SysLogService sysLogService;
	 
	 @RequestMapping("/")
	 public String root(HttpServletRequest request,Model model){
		 HttpSession session = request.getSession();
		 User user = (User) session.getAttribute("user");
		 if(user == null){
			 return "login";
		 }else{
			 return index(request,model);
		 }
	 }
	 
	 
	 @RequestMapping("/index")
	 public String index(HttpServletRequest request,Model model){
		 HttpSession session = request.getSession();
		 User user = (User) session.getAttribute("user");
		 String themeId = request.getParameter("themeId");
		 Integer _indexCount = (Integer) session.getAttribute("indexCount");
		 int indexCount = 0;
		 if(_indexCount == null){
			 indexCount = 0;
			 session.setAttribute("indexCount", indexCount);
		 }else{
			 indexCount += 1;
			 session.setAttribute("indexCount", indexCount);
		 }
		 
		 if(user == null){
			 return "login";
		 }else{
			 //TODO 登录验证成功
			 List<Project> projects = projectService.findAll();
			 List<Department> depts = departmentService.findAll();
			 List<Theme> themes = themeService.findAll();
			 model.addAttribute("projects",projects);
			 model.addAttribute("depts",depts);
			 model.addAttribute("themes",themes);
			 model.addAttribute("themeId",themeId);
			 
			 int msgCount = sysLogService.getCountToUserIdAndIsRead(user.getId());
			 model.addAttribute("msgCount",msgCount);
			 
			 return "index";
		 }
	 }
	 
	 @RequestMapping("/logout")
	 public String logout(HttpServletRequest request,Model model){
		 request.getSession().invalidate();
		 return "login";
	 }
	 
	 @RequestMapping("/login")
	 public String login(HttpServletRequest request,Model model){
		 return "login";
	 }
	 
}
