package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	//@	Test
	public void testAddPurchase() throws Exception{
		Purchase purchase = new Purchase();
		Product product = new Product();
		User user = new User();
		
		product.setProdNo(10005);
		user.setUserId("user22");
		
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setPaymentOption("1");
		purchase.setReceiverName("이수한");
		purchase.setReceiverPhone("1111");
		purchase.setDlvyAddr("서울시");
		purchase.setDlvyRequest("집 앞에");
		purchase.setTranCode("1");
		purchase.setDlvyDate("20200101");
		
		purchaseService.addPurchase(purchase);
		purchase = purchaseService.getPurchase(10000);
		//System.out.println("\n"+purchase+"\n");

	}
	
	//@Test
	public void testGetPurchaseByProdNo() throws Exception {
		Purchase purchase = new Purchase();
		
		purchase = purchaseService.getPurchase(10005);
		//System.out.println("\n"+purchase+"\n");
	}
	
	//@Test
	public void testGetPurchaseByTranNo() throws Exception {
		Purchase purchase = new Purchase();
		
		purchase = purchaseService.getPurchase2(10003);
		//System.out.println("\n"+purchase+"\n");
	}
	
	@Test
	public void testGetPurchaseList() throws Exception{
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);	
		String buyerId = "user22";
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		List<Object> list = (List<Object>) map.get("list");
		Integer totalCount = (Integer) map.get("totalCount");
		
		System.out.println(list);
		System.out.println(totalCount);
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception{
		Purchase purchase = new Purchase();
		User user = new User();
		
		user.setUserId("user22");

		purchase.setBuyer(user);
		purchase.setPaymentOption("1");
		purchase.setReceiverName("이수한");
		purchase.setReceiverPhone("1111");
		purchase.setDlvyAddr("서울시");
		purchase.setDlvyRequest("집 앞에");
		purchase.setTranCode("1");
		purchase.setDlvyDate("20200101");
		purchase.setTranNo(10001);
		
		purchaseService.updatePurcahse(purchase);	
	}
	
	//@Test
	public void testUpdateTranCode() throws Exception {
		Purchase purchase = new Purchase();
		
		purchase.setTranNo(10001);
		purchase.setTranCode("1");
		
		purchaseService.updateTranCode(purchase);	
	}
	
	//@Test
	public void testGetDeliveryList() throws Exception {
		Map<String, Object> map = purchaseService.getDeliveryList(10003);
		List<Object> list = (List<Object>) map.get("list");
		Integer totalCount = (Integer) map.get("totalCount");
		
		System.out.println(list);
		System.out.println(totalCount);
	}
}
