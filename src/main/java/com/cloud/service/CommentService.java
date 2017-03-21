package com.cloud.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloud.controller.bo.StatBO;
import com.cloud.dao.CommentDAO;
import com.cloud.entity.Comment;

@Service("commentService")
public class CommentService extends BaseService<Comment, Integer>{
	@Autowired
	private CommentDAO commentDAO;

	public List<Comment> getListToContentId(int page, int pageSize,
			int contentId) {
		return commentDAO.getListToContentId(page,pageSize,contentId);
	}

	public int getListCountToUserId(int userId) {
		return commentDAO.getListCountToUserId(userId);
	}
	
	public List<StatBO> getCountToUserIdAndCreateTime(int userId,Map<String,Long> betweens){
		return commentDAO.getCountToUserIdAndCreateTime(userId, betweens);
	}
	
	
}
