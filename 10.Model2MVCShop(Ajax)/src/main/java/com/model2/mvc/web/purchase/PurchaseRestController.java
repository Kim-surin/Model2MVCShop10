package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.review.ReviewService;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

@Autowired
@Qualifier("purchaseServiceImpl")
private PurchaseService purchaseService;

@Autowired
@Qualifier("userServiceImpl")
private UserService userService;

@Autowired
@Qualifier("productServiceImpl")
private ProductService productService;

@Autowired
@Qualifier("reviewServiceImpl")
private ReviewService reviewService;

public PurchaseRestController() {
	System.out.println(this.getClass());
}
	

@RequestMapping(value="json/getPurchase/{tranNo}", method=RequestMethod.GET)
public Purchase getPurchase(@PathVariable("tranNo") int tranNo) throws Exception{

	System.out.println("/purchase/json/getPurchase : GET");
	
	Purchase purchase = purchaseService.getPurchase(tranNo);
	
	return purchase;
}

@RequestMapping(value="json/addPurchase", method=RequestMethod.POST)
public void addPurchase(@RequestBody Purchase purchase) throws Exception{

	System.out.println("/purchase/json/addPurchase : POST");
	System.out.println(purchase);
	
	purchaseService.addPurchase(purchase);	
}

@RequestMapping(value="json/deliveryProductView/{prodNo}", method=RequestMethod.GET)
public Map deliveryProductView(@PathVariable("prodNo") int prodNo ) throws Exception {
	
	System.out.println("/purchase/json/deliveryProductView : GET");
	
	//Business Logic
	Map<String, Object> mapDelivery = purchaseService.getDeliveryList(prodNo);
	//Product product = productService.getProduct(prodNo);	
	System.out.println(mapDelivery);
	// Model °ú View ¿¬°á
	return mapDelivery;
}

@RequestMapping(value="json/deliveryProduct/{prodNo}/{tranNo}", method=RequestMethod.GET)
public void deliveryProduct(@PathVariable("prodNo") int prodNo , @PathVariable("tranNo") int tranNo) throws Exception{

	System.out.println("/purchase/json/deliveryProduct : GET");
	
	//Business Logic
	Purchase purchase = purchaseService.getPurchase(tranNo);
	purchaseService.updateTranCode(purchase);
	purchase = purchaseService.getPurchase(tranNo);
	
	Product product = productService.getProduct(prodNo);
	product.setOrderCount(product.getOrderCount()-1);
	productService.updateProduct(product);
	
}

@RequestMapping(value="json/listPurchase", method=RequestMethod.POST)
public Map listPurchase(@RequestBody Search search) throws Exception{
	
	System.out.println("/purchase/json/listPurchase : POST");
	
	User user = new User();
	user.setUserId("user21");
	
	if(search.getCurrentPage() == 0 ){
		search.setCurrentPage(1);
	}
	
	System.out.println(search);
	
	Map<String, Object> map = purchaseService.getPurchaseList(search, user.getUserId());

	
	return map;
}

@RequestMapping(value="json/reviewPurchase/{tranNo}", method=RequestMethod.POST)
public void reviewPurchase(@PathVariable int tranNo, @RequestBody Review review) throws Exception{
	
	System.out.println("/purchase/json/reviewPurchase :GET");
	
	Purchase purchase = purchaseService.getPurchase(tranNo);
	
	review.setProdNo(purchase.getPurchaseProd().getProdNo());
	
	reviewService.addReview(review);
	purchaseService.updateRevStatusCode(purchase);
	
	Product product = new Product();
	product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
	int countReview = reviewService.countReviewNum(purchase.getPurchaseProd().getProdNo());
	product.setStar((product.getStar()+review.getStar())/countReview);		
	productService.updateProduct(product);		
	
}

@RequestMapping(value="json/updatePurchase", method=RequestMethod.POST)
public void updatePurchase(@RequestBody Purchase purchase) throws Exception{
	
	System.out.println("/purchase/json/updatePurchase : POST");
	
	//Purchase purchase = purchaseService.getPurchase(tranNo);		
	
	
	purchaseService.updatePurcahse(purchase);
	
}

@RequestMapping(value="json/updateTranCode/{tranNo}", method=RequestMethod.GET)
public Purchase updateTranCode( @PathVariable("tranNo") int tranNo) throws Exception{
	
	System.out.println("/purchase/json/updateTranCode : GET");
	
	Purchase purchase = purchaseService.getPurchase(tranNo);	
	
	System.out.println(purchase);
	
	purchaseService.updateTranCode(purchase);
	purchase = purchaseService.getPurchase(tranNo);		
	
	System.out.println("aa"+purchase);
		
	return purchase;
}

@RequestMapping(value="json/updateTranCodeByProd/{tranNo}")
public Purchase updateTranCodeByProd( @RequestParam("tranNo") int tranNo, Model model) throws Exception{
	
	System.out.println("/purchase/json/updateTranCodeByProd : GET");
	
	Purchase purchase = purchaseService.getPurchase(tranNo);		
	purchaseService.updateTranCode(purchase);
	purchase = purchaseService.getPurchase(tranNo);	
	
	return purchase;
}


	
}
