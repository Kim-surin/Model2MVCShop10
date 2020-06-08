package com.model2.mvc.service.purchase;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	public Purchase findPurchaseByTranNo(int tranNo) throws Exception;

	public Purchase findPurchaseByProdNo(int prodNo) throws Exception;
	
	public Purchase findPurchaseByUUID(String uuid) throws Exception;

	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception;
	
	public List<Purchase> getSaleList(Search search);

	public void addPurchase(Purchase purchase) throws Exception;

	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	public List<Purchase> getDeliveryList(int prodNo) throws Exception;
	
	public int getTotalCountByPurchaseList(String buyerId) throws Exception;
	
	public int getTotalCountByDeliveryList(int prodNo) throws Exception;
	
	public void updateRevStatusCode(Purchase purchase) throws Exception;

	//public String makeCurrentPageSql(String sql, Search search);
}
