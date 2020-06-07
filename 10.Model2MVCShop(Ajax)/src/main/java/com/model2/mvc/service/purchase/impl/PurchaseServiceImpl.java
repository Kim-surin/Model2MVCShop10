package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{
	
	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	public PurchaseServiceImpl() {
		System.out.println("\n"+this.getClass()+"\n");
	}
	
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}

	public void addPurchase(Purchase purchase) throws Exception {
		purchaseDao.addPurchase(purchase);
	}

	public Purchase getPurchase(int tranNo) throws Exception {
		return  purchaseDao.findPurchaseByTranNo(tranNo);
	}

	public Purchase getPurchase2(int ProdNo) throws Exception {
		return purchaseDao.findPurchaseByProdNo(ProdNo);
	}

	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
		List<Purchase> list = purchaseDao.getPurchaseList(search, buyerId);
		int totalCount = purchaseDao.getTotalCountByPurchaseList(buyerId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		return map;
	}

	public HashMap<String, Object> getSaleList(Search search) throws Exception {
		
		return null;
	}

	public void updatePurcahse(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);
	}

	public void updateTranCode(Purchase purchase) throws Exception {
		purchaseDao.updateTranCode(purchase);
	}
	
	public Map<String, Object> getDeliveryList(int prodNo) throws Exception {
		List<Purchase> list = purchaseDao.getDeliveryList(prodNo);
		int totalCount = purchaseDao.getTotalCountByDeliveryList(prodNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		return map;
	}
	
	public void updateRevStatusCode(Purchase purchase) throws Exception{
		purchaseDao.updateRevStatusCode(purchase);
	}

}
