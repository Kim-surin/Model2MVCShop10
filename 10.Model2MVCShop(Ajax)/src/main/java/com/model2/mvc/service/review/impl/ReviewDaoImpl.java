package com.model2.mvc.service.review.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;

@Repository("reviewDaoImpl")
public class ReviewDaoImpl implements ReviewDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public ReviewDaoImpl() {
	}

	public void addReview(Review review) throws SQLException {
		sqlSession.insert("ReviewMapper.addReview", review);
	}
	
	public List<Review> getReview(int prodNo) throws SQLException{
		return sqlSession.selectList("ReviewMapper.getReviewList", prodNo);
	}
	
	public int countReviewNum(int prodNo)  throws SQLException{
		return sqlSession.selectOne("ReviewMapper.countReviewNum", prodNo);
	}
}