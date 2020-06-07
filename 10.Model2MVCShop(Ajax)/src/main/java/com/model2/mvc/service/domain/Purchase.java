package com.model2.mvc.service.domain;

import java.sql.Date;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;


public class Purchase {
	
	private int tranNo;
	private User buyer;
	private String dlvyAddr;
	private String dlvyDate;
	private String dlvyRequest;
	private Date orderDate;
	private String paymentOption;
	private Product purchaseProd;
	private String receiverName;
	private String receiverPhone;
	private String tranCode;
	private boolean revStatusCode;	//0�̸� No Review 1�̸� Review

	
	public Purchase(){
	}
	
	public User getBuyer() {
		return buyer;
	}
	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}
	public String getDlvyAddr() {
		return dlvyAddr;
	}
	public void setDlvyAddr(String divyAddr) {
		this.dlvyAddr = divyAddr;
	}
	public String getDlvyDate() {
		return dlvyDate;
	}
	public void setDlvyDate(String divyDate) {
		this.dlvyDate = divyDate;
	}
	public String getDlvyRequest() {
		return dlvyRequest;
	}
	public void setDlvyRequest(String divyRequest) {
		this.dlvyRequest = divyRequest;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getPaymentOption() {
		return paymentOption;
	}
	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption;
	}
	public Product getPurchaseProd() {
		return purchaseProd;
	}
	public void setPurchaseProd(Product purchaseProd) {
		this.purchaseProd = purchaseProd;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getReceiverPhone() {
		return receiverPhone;
	}
	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}
	public String getTranCode() {
		return tranCode;
	}
	public void setTranCode(String tranCode) {
		this.tranCode = tranCode;
	}
	public int getTranNo() {
		return tranNo;
	}
	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}
	
	public boolean getRevStatusCode() {
		return revStatusCode;
	}

	public void setRevStatusCode(boolean revStatusCode) {
		this.revStatusCode = revStatusCode;
	}

	@Override
	public String toString() {
		return "Purchase [tranNo=" + tranNo + ", buyer=" + buyer + ", divyAddr=" + dlvyAddr + ", dlvyDate=" + dlvyDate
				+ ", dlvyRequest=" + dlvyRequest + ", orderDate=" + orderDate + ", paymentOption=" + paymentOption
				+ ", purchaseProd=" + purchaseProd + ", receiverName=" + receiverName + ", receiverPhone="
				+ receiverPhone + ", tranCode=" + tranCode + ", revStatusCode=" + revStatusCode + "]";
	}


}