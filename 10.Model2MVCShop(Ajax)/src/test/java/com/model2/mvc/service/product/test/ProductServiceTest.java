package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Test
	public void testAddProduct() throws Exception {
		
		Product product = new Product();
		product.setProdName("testProductName");
		product.setProdDetail("testDetail");
		product.setManuDate("20200101");
		product.setPrice(10000);
		product.setAmount(1);
		product.setFileName("testFileName");
		
		productService.addProduct(product);
		
		product = productService.getProduct(10044);
		
		//==> API Ȯ��
		Assert.assertEquals("testProductName", product.getProdName());
		Assert.assertEquals("testDetail", product.getProdDetail());
		Assert.assertEquals("20200101", product.getManuDate());
		Assert.assertEquals(10000, product.getPrice());
		Assert.assertEquals(1, product.getAmount());
		Assert.assertEquals("testFileName", product.getFileName());
	}
	
	//@Test
	public void testGetUser() throws Exception {
		
		Product product = new Product();
		
		product = productService.getProduct(10044);

		//==> console Ȯ��
		System.out.println("GET ���� GET > "+product);
		
		//==> API Ȯ��
		Assert.assertEquals("testProductName", product.getProdName());
		Assert.assertEquals("testDetail", product.getProdDetail());
		Assert.assertEquals("20200101", product.getManuDate());
		Assert.assertEquals(10000, product.getPrice());
		Assert.assertEquals(1, product.getAmount());
		Assert.assertEquals("testFileName", product.getFileName());
	}
	
	//@Test
	 public void testUpdateUser() throws Exception{
		 
		Product product = productService.getProduct(10043);
		Assert.assertNotNull(product);
		System.out.println("UPDATE ���� GET > "+product);
		
		Assert.assertEquals("testProductName", product.getProdName());
		Assert.assertEquals("testDetail", product.getProdDetail());
		Assert.assertEquals("20200101", product.getManuDate());
		Assert.assertEquals(10000, product.getPrice());
		
		product.setProdName("changetestProductName");
		product.setProdDetail("changetestDetail");
		product.setManuDate("30200101");
		product.setPrice(20000);
		
		productService.updateProduct(product);
		
		product = productService.getProduct(10043);
		Assert.assertNotNull(product);	//null�� �ƴϸ� �ʷϻ���
		
		//==> console Ȯ��
		System.out.println("UPDATE ���� GET > "+product);
			
		//==> API Ȯ��
		Assert.assertEquals("changetestProductName", product.getProdName());
		Assert.assertEquals("changetestDetail", product.getProdDetail());
		Assert.assertEquals("30200101", product.getManuDate());
		Assert.assertEquals(20000, product.getPrice());
	 }
	
	 //@Test
	 public void testGetUserListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("t");
	 	map = productService.getProductList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
}