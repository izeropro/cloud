package com.cloud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.dao.ContentDAO;
import com.cloud.entity.Calendar;
import com.cloud.entity.Content;
import com.cloud.entity.Permission;
import com.cloud.service.ContentService;
import com.cloud.util.BeanUtil;

@Service("contentService") 
public class ContentServiceImpl implements ContentService{
	@Autowired  
	private ContentDAO contentDAO;

	public Content load(Integer id) {
		return contentDAO.load(id);
	}

	public Content get(Integer id) {
		return contentDAO.get(id);
	}

	public List<Content> findAll() {
		return contentDAO.finaAll();
	}

	public void persist(Content entity) {
		contentDAO.persist(entity);		
	}

	public Integer save(Content entity) {
		return (Integer) contentDAO.save(entity);
	}

	public void update(Content entity) {
		Content old = contentDAO.get(entity.getId());
		try {
			BeanUtil.copyProperties(entity, old);
			contentDAO.update(old);	
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	public void delete(Integer id) {
		//修改状态为删除
		Content c = contentDAO.get(id);
		c.setStatus("N");
		update(c);
	}

	public void flush() {
		contentDAO.flush();		
	}

	public List<Content> getList(int page, int pageSize, String[] columns,
			Object[] objs) {
		return contentDAO.getList(page,pageSize, columns, objs);
	}

	public int getListCount(String[] columns, Object[] objs) {
		return contentDAO.getListCount(columns, objs);
	}

	public List<Content> getListToDeptId(int page, int pageSize, int deptId) {
		return contentDAO.getListToDeptId(page, pageSize, deptId);
	}

	public int getListCountToDeptId(int deptId) {
		return contentDAO.getListCountToDeptId(deptId);
	}

	public int getListCountToUserId(int userId) {
		return contentDAO.getListCountToUserId(userId);
	}

	public List<Content> getListToUserId(int page, int pageSize, int userId) {
		return contentDAO.getListToUserId(page, pageSize, userId);
	}

	public List<Content> getListToProjectId(int page, int pageSize,
			int projectId) {
		return contentDAO.getListToProjectId(page, pageSize, projectId);
	}

	public int getListCountToProjectId(int projectId) {
		return contentDAO.getListCountToProjectId(projectId);
	}
	
	
	
	
}
