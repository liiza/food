package com.example.controller;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.model.Ingredient;
import com.example.model.Recipe;
import com.example.service.RecipeService;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;



import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;


/*
 * The controller.
 */
@Controller
public class RecipeController {
	private static final String AWS_ACCESS_KEY_ID = "AWS_ACCESS_KEY_ID";
	private static final String AWS_SECRET_ACCESS_KEY = "AWS_SECRET_ACCESS_KEY";
	private static final String S3BUCKET = "S3BUCKET";

	@Autowired
	private RecipeService recipeService;

	/*
	 * Redirect empty query to front page
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String list() {
		return "redirect:/recipes/";
	}

	/*
	 * Show the front page of all recipes.
	 */
	@RequestMapping("/")
	public String listRecipes(Map<String, Object> map) {
		map.put("recipeList", recipeService.listRecipes());
		return "recipes";
	}

	/*
	 * Show the front page with all recipes with match to given query.
	 */
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(
			@RequestParam(value = "name", required = false) String name,
			Map<String, Object> map) {
		map.put("recipeList", recipeService.search(name));
		return "recipes";
	}

	/*
	 * Show the recipe by given id.
	 */
	@RequestMapping("/get/{recipeId}")
	public String getRecipe(@PathVariable("recipeId") Integer recipeId,
			Map<String, Object> map) {

		map.put("recipe", recipeService.getRecipe(recipeId));
		return "recipe";
	}

	/*
	 * Add new recipe to service.
	 */
	@RequestMapping(value = "/add", method = { RequestMethod.POST })
	public String addRecipe(@ModelAttribute("recipe") Recipe recipe,
			BindingResult result) {
		recipeService.addRecipe(recipe);
		return "redirect:/recipes/addpage";
	}

	/*
	 * Shot the page to add recipe. Use spring-framework forms to enter the
	 * data.
	 */
	@RequestMapping(value = "/addpage", method = { RequestMethod.GET })
	public String addRecipe(Map<String, Object> map) {
		map.put("recipe", new Recipe());
		return "AddRecipe";
	}
	
	/**
	 * Sign the request to be send to the aws -server to upload the image.
	 * 
	 * 
	 * @param type The file type of the image.
	 * @param name The name of the image.
	 * @return The signed request and the public url for the image.
	 */
	@RequestMapping(value = "/signS3", method = RequestMethod.POST)
	@ResponseBody
	public SignedRequest signRequest(
			@RequestParam(value = "type", required = false) String type,
			@RequestParam(value = "name", required = false) String name) {
		
		// Import environment variables
		Map<String, String> env_variables = System.getenv();
		String aws_access_key_id = env_variables.get(AWS_ACCESS_KEY_ID);
		String aws_secret_access_key = env_variables.get(AWS_SECRET_ACCESS_KEY);
		String bucket_name = env_variables.get(S3BUCKET);

		// Set the expiration date in seconds.
		long current_time = System.currentTimeMillis();
		System.out.println("current time in millis: "
				+ Long.toString(current_time));
		long expires = current_time / 1000 + 1000;
		
		// Set the image public to read.
		String azm_headers = "x-amz-acl:public-read";
		// The put request to be sent the server.
		String put_request = "PUT\n\n" + type + "\n" + Long.toString(expires)
				+ "\n" + azm_headers + "\n/" + bucket_name + "/" + name;
		
		/*
		System.out.println(put_request);
		for (byte b : put_request.getBytes(Charset.forName("UTF-8"))) {
			System.out.printf("%02X ", b);
		}*/
		
		String signature = "";
		try {
			// Use aws secret key to sign the request
			// Get an hmac_sha1 key from the raw key bytes
			String key = aws_secret_access_key;
			byte[] keyBytes = key.getBytes();
			SecretKeySpec signingKey = new SecretKeySpec(keyBytes, "HmacSHA1");

			// Get an hmac_sha1 Mac instance and initialize with the signing key
			Mac mac = Mac.getInstance("HmacSHA1");
			mac.init(signingKey);

			// Compute the hmac on input data bytes
			byte[] rawHmac = mac.doFinal(put_request.getBytes());

			// Change to base64 encoding.
			signature = StringUtils.newStringUtf8(Base64.encodeBase64(rawHmac));
			// Encode query parameter
			signature = URLEncoder.encode(signature, "UTF-8");

		} catch (InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// Concate the public url. The one where the picture will be available after loading.
		String url = "https://" + bucket_name + ".s3.amazonaws.com/" + name;

		// Concate the url that contains the data and the signature.
		String signed_request = url + "?AWSAccessKeyId=" + aws_access_key_id
				+ "&Expires=" + Long.toString(expires) + "&Signature="
				+ signature;

		return new SignedRequest(signed_request, url);

	}
	
	/**
	 * The class for signed request.
	 * Contains the signed request and url.
	 * @author Liisa
	 *
	 */
	private class SignedRequest {
		private String signed_request;
		private String url;

		public SignedRequest(String signed_request, String url) {
			this.setSigned_request(signed_request);
			this.setUrl(url);
		}

		public String getSigned_request() {
			return signed_request;
		}

		public void setSigned_request(String signed_request) {
			this.signed_request = signed_request;
		}

		public String getUrl() {
			return url;
		}

		public void setUrl(String url) {
			this.url = url;
		}
	}
}
