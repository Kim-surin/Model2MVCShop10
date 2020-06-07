package com.model2.mvc.service.review.impl;

import com.model2.mvc.service.review.ReviewDao;
import com.model2.mvc.service.review.ReviewService;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Review;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	@Qualifier("reviewDaoImpl")
	private ReviewDao reviewDao;

	public ReviewServiceImpl() {
		System.out.println(this.getClass());
	}

	public void addReview(Review review) throws Exception {
		reviewDao.addReview(review);
	}
	
	public List<Review> getReview(int prodNo) throws SQLException{
		return reviewDao.getReview(prodNo);
	}
	
	public int countReviewNum(int prodNo)  throws SQLException{
		return reviewDao.countReviewNum(prodNo);
	}

}
