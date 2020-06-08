package com.model2.mvc.service.domain;

import java.sql.Date;

public class Review {
	private int revNo;		// PRIMARY KEY SEQUECE			
	private int prodNo	;		
	private String buyer;						
	private Date revDate;		// ¸®ºä µî·Ï ³¯Â¥
	private int star;				// ÆòÁ¡
	private String reviewSentence;	//¸®ºä
	private String reviewImage;
	
	public Review() {
		
	}

	public int getRevNo() {
		return revNo;
	}

	public int getProdNo() {
		return prodNo;
	}

	public String getBuyer() {
		return buyer;
	}
	
	public Date getRevDate() {
		return revDate;
	}

	public int getStar() {
		return star;
	}

	public String getReviewImage() {
		return reviewImage;
	}

	public void setReviewImage(String reviewImage) {
		this.reviewImage = reviewImage;
	}

	public String getReviewSentence() {
		return reviewSentence;
	}

	public void setRevNo(int revNo) {
		this.revNo = revNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}

	public void setRevDate(Date revDate) {
		this.revDate = revDate;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public void setReviewSentence(String reviewSentence) {
		this.reviewSentence = reviewSentence;
	}

	@Override
	public String toString() {
		return "Review [revNo=" + revNo + ", prodNo=" + prodNo + ", buyerId=" + buyer+ ",  revDate=" + revDate + ", star=" + star + ", review=" + reviewSentence + "]";
	}

	
	
}
