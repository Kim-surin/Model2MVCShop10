package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.review.ReviewService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;

	private static final String UPLOAD_PATH = "C:\\Users\\user\\git\\repository\\Model2MVCShop10\\10.Model2MVCShop(Ajax)\\WebContent\\images\\uploadFiles";

	public ProductController() {
		System.out.println(this.getClass());
	}

	// ==> classpath:config/common.properties , classpath:config/commonservice.xml
	// 참조 할것
	// ==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	@RequestMapping(value="addProduct")
	public String addProduct(@ModelAttribute("prodct") Product product, Model model, @RequestParam("fileUpload") MultipartFile[] fileUpload) throws Exception {
		
		System.out.println("addProduct");

		//UUID uuid = UUID.randomUUID();
		
		String manySaveName = "";
		
		 for(MultipartFile f : fileUpload){
			 String originalFileName = f.getOriginalFilename();
			 String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			 //String savedFileName =  UUID.randomUUID()+"_"+originalFileName;
			 
			 manySaveName+=originalFileName+"/";

			    // 저장할 File 객체를 생성(껍데기 파일)
			    File saveFile = new File(UPLOAD_PATH,originalFileName); // 저장할 폴더 이름, 저장할 파일 이름

			    try {
			    	f.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
			    } catch (IOException e) {
			        e.printStackTrace();
			        return null;
			    }
		    }
		
	    
		
		 String manuDate = "";
			String[] manuDateSplit = product.getManuDate().split("-");
			
			for(int i=0; i<manuDateSplit.length; i++) {
				manuDate += manuDateSplit[i];
			}
			
			product.setFileName(manySaveName);
			product.setProTranCode("1");
			product.setManuDate(manuDate);
			productService.addProduct(product);
			
			model.addAttribute("product", product);
		
		return "forward:/product/addProduct.jsp";
	}

	@RequestMapping(value="getProduct")
	public String getProduct(@RequestParam("prod_no") int prodNo, HttpServletResponse response, HttpServletRequest request,
			Model model) throws Exception {

		System.out.println("getProduct");
		// Business Logic
		Product product = productService.getProductByPurchase(prodNo);

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

		model.addAttribute("product", product);

		if (request.getParameter("menu") != null) {
			if (request.getParameter("menu").equals("manage")) {
				return "forward:/product/updateProductView.jsp";
			} else {
				request.setAttribute("menu", "search");
				List<Review> list = reviewService.getReview(prodNo);
				model.addAttribute("list", list);
				return "forward:/product/getProduct.jsp";
			}
		} else {
			request.setAttribute("menu", "manage");
			return "forward:/product/getProduct.jsp";
		}
	}

	@RequestMapping(value="listProduct")
	public String listProduct(@ModelAttribute("search") Search search, HttpServletRequest request, Model model) throws Exception {

		System.out.println("listProduct");

		String menu = (String) request.getParameter("menu");
		if (menu == null) {
			menu = (String) request.getAttribute("menu");
		}

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchPrice1(request.getParameter("searchPrice1"));
		search.setSearchPrice2(request.getParameter("searchPrice2"));
		
		System.out.println(search);

		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
		model.addAttribute("listProduct", map.get("list"));
		model.addAttribute("search", search);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("menu", menu);

		if (request.getAttribute("isAmount") != null) {
			request.setAttribute("isAmount", request.getAttribute("isAmount"));
		}
		
		return "forward:/product/listProduct.jsp";
	}

	@RequestMapping(value="updateProduct")
	public String updateProduct(@ModelAttribute("product") Product product, Model model, HttpSession session, HttpServletRequest request, @RequestParam("fileUpload") MultipartFile[] fileUpload) throws Exception {
		
		String manySaveName = "";
		
		 for(MultipartFile f : fileUpload){
			 String originalFileName = f.getOriginalFilename();
			 String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
			 //String savedFileName =  UUID.randomUUID()+"_"+originalFileName;
			 
			 manySaveName+=originalFileName+"/";

			    // 저장할 File 객체를 생성(껍데기 파일)
			    File saveFile = new File(UPLOAD_PATH,originalFileName); // 저장할 폴더 이름, 저장할 파일 이름

			    try {
			    	f.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
			    } catch (IOException e) {
			        e.printStackTrace();
			        return null;
			    }
		    }
		
		String manuDate = "";
		String[] manuDateSplit = request.getParameter("manuDate").split("-");
		
		for(int i=0; i<manuDateSplit.length; i++) {
			manuDate += manuDateSplit[i];
		}
		
		product.setManuDate(manuDate);
		product.setFileName(manySaveName);
		int prodNo = product.getProdNo();
		
		productService.updateProduct(product);

		return "forward:/product/getProduct?prod_no=" + prodNo;
	}
	
	
}