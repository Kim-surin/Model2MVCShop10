package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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


//==> 회원관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//setter Method 구현 않음
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="addPurchaseView")
	public String addPurchaseView(@RequestParam("prod_no")int prodNo, Model model, HttpServletRequest request) throws Exception {

		System.out.println("/addPurchaseView");

		Product product = productService.getProduct(prodNo);

		model.addAttribute("product", product);

		HttpSession session=request.getSession(true);	
		User user = (User)session.getAttribute("user");
		
		model.addAttribute("user", user);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping(value="addPurchase")
	public String addPurchase(HttpServletRequest request, @RequestParam("prod_no") int prodNo, Model model) throws Exception {

		System.out.println("/addPurchase");
		//Business Logic
		HttpSession session=request.getSession(true);	
		User user = (User)session.getAttribute("user");
		model.addAttribute(user);
		
		Product product = null;
		product = productService.getProduct(prodNo);
		product.setAmount(product.getAmount()-1);
		
		if(product.getAmount() < 0) {
			return "forward:/listProduct?isAmount=false"; }
		product.setOrderCount(product.getOrderCount()+1);
		productService.updateProduct(product);
		product = productService.getProduct(prodNo);
		
		Purchase purchase = new Purchase();
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setPaymentOption((request.getParameter("paymentOption")).trim());
		purchase.setReceiverName(request.getParameter("receiverName")); 
		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
		purchase.setDlvyAddr(request.getParameter("receiverAddr"));
		purchase.setDlvyRequest(request.getParameter("receiverRequest"));
		purchase.setDlvyDate(request.getParameter("receiverDate"));
		purchase.setTranCode("1"); 
		purchase.setRevStatusCode(false);
		
		purchaseService.addPurchase(purchase);
		purchaseService.updateTranCode(purchaseService.getPurchase2(prodNo));
		purchase = purchaseService.getPurchase2(prodNo);
		
		
		model.addAttribute(purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping(value="deliveryProductView")
	public String deliveryProductView( @RequestParam("prod_no") int prodNo , Model model ) throws Exception {
		
		System.out.println("deliveryProductView");
		
		//Business Logic
		Map<String, Object> mapDelivery = purchaseService.getDeliveryList(prodNo);
		Product product = productService.getProduct(prodNo);	
		
		// Model 과 View 연결
		model.addAttribute("listDelivery", mapDelivery.get("list"));
		model.addAttribute("product", product);
		
		return "forward:/purchase/deliveryProdct.jsp";
	}
	
	@RequestMapping(value="deliveryProduct")
	public String deliveryProduct(@RequestParam("prodNo") int prodNo , @RequestParam("tranNo") int tranNo, Model model ) throws Exception{

		System.out.println("/deliveryProduct");
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchaseService.updateTranCode(purchase);
		purchase = purchaseService.getPurchase(tranNo);
		
		Product product = productService.getProduct(prodNo);
		product.setOrderCount(product.getOrderCount()-1);
		productService.updateProduct(product);
		
		return "forward:/product/listProduct?menu=manage";
	}
	
	@RequestMapping(value="getPurchase")
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model , HttpSession session) throws Exception{

		System.out.println("getPurchase");
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute(purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	@RequestMapping(value="listPurchase")
	public String listPurchase(@ModelAttribute("search") Search search, HttpServletRequest request, Model model) throws Exception{
		
		System.out.println("listPurchase");
		
		HttpSession session=request.getSession(true);	
		User user = (User)session.getAttribute("user");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println(search);
		
		Map<String, Object> map =purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	
	@RequestMapping(value="reviewPurchaseView")
	public String reviewPurchaseView(@RequestParam("tran_no") int tranNo, @RequestParam("userId") String userId, Model model) throws Exception{
		
		System.out.println("/reviewPurchaseView");
		//Business Logic
		
		model.addAttribute("userId", userId);
		model.addAttribute("purchase", purchaseService.getPurchase(tranNo));
		
		return "forward:/purchase/reviewPurchase.jsp";
	}
	
	@RequestMapping(value="reviewPurchase")
	public String reviewPurchase(HttpServletRequest request, @RequestParam("tranNo") int tranNo, @RequestParam("star") int star , @RequestParam("review") String reviewSentence) throws Exception{
		
		System.out.println("/reviewPurchase");
		
		//Business Logic
		HttpSession session=request.getSession(true);	
		User user = (User)session.getAttribute("user");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		Review review = new Review();
		review.setProdNo(purchase.getPurchaseProd().getProdNo());
		review.setBuyer(user.getUserId());
		review.setReviewSentence(reviewSentence);
		review.setStar(star);
		
		reviewService.addReview(review);
		purchaseService.updateRevStatusCode(purchase);
		
		Product product = new Product();
		product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		int countReview= reviewService.countReviewNum(purchase.getPurchaseProd().getProdNo());
		product.setStar((product.getStar()+star)/countReview);		
		productService.updateProduct(product);		
		
		return "forward:/purchase/listPurchase";
	}
	
	@RequestMapping(value="updatePurchase")
	public String updatePurchase( @RequestParam("tranNo") int tranNo, HttpServletRequest request, Model model) throws Exception{
		
		System.out.println("updatePurchase");
		
		String manuDate = "";
		String[] manuDateSplit = request.getParameter("dlvyDate").split("-");
		
		for(int i=0; i<manuDateSplit.length; i++) {
			manuDate += manuDateSplit[i];
		}
		
		Purchase purchase = purchaseService.getPurchase(tranNo);		
		
		purchase.setBuyer(userService.getUser(request.getParameter("buyerId")));
		purchase.setPaymentOption(request.getParameter("paymentOption"));
		purchase.setReceiverName(request.getParameter("receiverName"));
		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
		purchase.setDlvyAddr(request.getParameter("receiverAddr"));
		purchase.setDlvyRequest(request.getParameter("receiverRequest"));
		purchase.setDlvyDate(manuDate);
		
		purchaseService.updatePurcahse(purchase);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping(value="updatePurchaseView")
	public String updatePurchaseView( @RequestParam("tranNo") int tranNo, Model model) throws Exception{
		
		System.out.println("updatePurchaseView");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);		
			
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping(value="updateTranCode")
	public String updateTranCode( @RequestParam("tranNo") int tranNo, Model model) throws Exception{
		
		System.out.println("updateTranCode");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);		
		purchaseService.updateTranCode(purchase);
		purchase = purchaseService.getPurchase(tranNo);		
			
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/listPurchase";
	}
	
	@RequestMapping(value="updateTranCodeByProd")
	public String updateTranCodeByProd( @RequestParam("tran_no") int tranNo, Model model) throws Exception{
		
		System.out.println("updateTranCodeByProd");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);		
		purchaseService.updateTranCode(purchase);
		purchase = purchaseService.getPurchase(tranNo);		
			
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/listPurchase";
	}
}