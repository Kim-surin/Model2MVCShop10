package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession;
	
	public PurchaseDaoImpl() {
		System.out.println("\n"+this.getClass()+"\n");
	}
	
	public void setSqlsession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public void addPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("addPurchase", purchase);
	}

	public Purchase findPurchaseByTranNo(int tranNo) throws Exception {
		Purchase purchase = sqlSession.selectOne("getPurchaseBytranNo", tranNo);
		purchase.setBuyer((User)sqlSession.selectOne("UserMapper.getUser", purchase.getBuyer().getUserId()));
		purchase.setPurchaseProd((Product)sqlSession.selectOne("ProductMapper.getProductByPurchase", purchase.getPurchaseProd().getProdNo()));
		return purchase;		 
	}
	
	public Purchase findPurchaseByProdNo(int prodNo) throws Exception {
		Purchase purchase = sqlSession.selectOne("getPurchaseByprodNo", prodNo);
		purchase.setBuyer((User)sqlSession.selectOne("UserMapper.getUser", purchase.getBuyer().getUserId()));
		purchase.setPurchaseProd((Product)sqlSession.selectOne("ProductMapper.getProduct", purchase.getPurchaseProd().getProdNo()));
		return purchase;

	}

	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId", buyerId);
		
		List<Purchase> list = sqlSession.selectList("getPurchaseList", map);
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setBuyer((User)sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()));
			list.get(i).setPurchaseProd((Product)sqlSession.selectOne("ProductMapper.getProductByPurchase", list.get(i).getPurchaseProd().getProdNo()));
		}
		
		return list;
	}

	public List<Purchase> getSaleList(Search searchVO) {
		return null;
	}

	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("updatePurchase", purchase);
	}

	public void updateTranCode(Purchase purchase) throws Exception {
		sqlSession.update("updateTranCode", purchase);
	}

	public List<Purchase> getDeliveryList(int prodNo) throws Exception {
		return sqlSession.selectList("getDeliveryList", prodNo);
	}

	public int getTotalCountByPurchaseList(String buyerId) throws Exception {
		return sqlSession.selectOne("getTotalCountByPurchaseList", buyerId);
	}
	
	public int getTotalCountByDeliveryList(int prodNo) throws Exception {
		return sqlSession.selectOne("getTotalCountByDeliveryList", prodNo);
	}
	
	public void updateRevStatusCode(Purchase purchase) throws Exception{
		sqlSession.update("updateRevStatusCode", purchase);
	}
	public Purchase findPurchaseByUUID(String uuid) throws Exception{
		return sqlSession.selectOne("getPurchaseByUUID", uuid);
	}
	
}
