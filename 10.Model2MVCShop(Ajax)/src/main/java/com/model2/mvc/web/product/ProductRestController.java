package com.model2.mvc.web.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.review.ReviewService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;

	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Map getProduct(@PathVariable int prodNo, HttpServletResponse response, HttpServletRequest request) throws Exception { 
	
		System.out.println("/product/json/getProduct : GET");
		
		Product product = productService.getProduct(prodNo);
		List<Review> review = reviewService.getReview(prodNo);

		Cookie cookie = null;
		Cookie[] cookies = request.getCookies();
		String history = "";

		if (cookies != null || cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				if ((cookies[i].getName()).equals("history")) {
					history += (cookies[i].getValue()).trim();
					history += ",";
					break;
				}
			}
		}

		history = history.trim();
		history += Integer.toString(prodNo);

		cookie = new Cookie("history", history);
		response.addCookie(cookie);
		
		Map<String, Object> map = new HashMap();
		map.put("product", product);
		map.put("review", review);
		
		return map;
	}
	
	@RequestMapping(value="json/addProduct", method=RequestMethod.POST)
	public void addProduct(@RequestBody Product product) throws Exception { 
	
		System.out.println("/product/json/addProduct : POST");
	
		System.out.println(product);
		
		productService.addProduct(product);
		
	}
	
	@RequestMapping(value="json/updateProduct", method=RequestMethod.POST)
	public void updateProduct(@RequestBody Product product) throws Exception{		
		
		System.out.println("/product/json/updateProduct : POST");
		
		System.out.println(product);
		
		productService.updateProduct(product);
		
	}
	
	@RequestMapping(value="json/listProduct", method=RequestMethod.POST)
	public Map listProduct(@RequestBody Search search) throws Exception{
	
		System.out.println("/product/json/listProduct : POST");
		System.out.println(search);
		if (search.getSearchCondition()==null) {
			search.setSearchCondition("0");
		}
		Map<String, Object> map = productService.getProductList(search);
		//Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, search.getPageSize());
		
	return map;
	}
	
	
	
	
}
