package com.model2.mvc.service.review;

import java.sql.SQLException;
import java.util.List;

import com.model2.mvc.service.domain.Review;

public interface ReviewDao {

	public void addReview(Review review) throws SQLException;
	
	public List<Review> getReview(int prodNo) throws SQLException;
	
	public int countReviewNum(int prodNo)  throws SQLException;
}