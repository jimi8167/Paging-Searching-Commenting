package com.pgm.bbs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.pgm.bbs.dto.RepleVO;
import com.pgm.bbs.service.RepleService;

@RequestMapping("/reply")
@RestController//string과 같은 직접 값을 넣어주는 거임 .-> json같은 곳에 담아서 보냄
//@Controller : 데이터 보낼떄  model을 통해서 보냄
public class RepleController {
	@Inject
	private RepleService service;
	
	/*
	 * @PostMapping("insert.do") public ResponseEntity<String>
	 * insert(@ModelAttribute("reple") RepleVO reple ) { ResponseEntity<String>
	 * entity=null; try { service.register(reple); entity=new
	 * ResponseEntity<String>("success", HttpStatus.OK); } catch (Exception e) { //
	 * TODO: handle exception entity=new ResponseEntity<String>(e.getMessage(),
	 * HttpStatus.BAD_REQUEST); } return entity;
	 * 
	 * 
	 * }
	 */
	@PostMapping("/insert.do")
	public @ResponseBody ResponseEntity<String> insert(@RequestBody RepleVO reple ) {
		System.out.println(reple);
		/* ResponseEntity<String> entity=null; */
		
		try {
			service.register(reple);
			System.out.println("성공???");
			return new ResponseEntity<String>("success", HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("실패???");
			return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			
		}
		
		
	}
	
	
	@GetMapping("list.do")
	public List<RepleVO> listJson(@RequestParam ("bno") int bno){
		List<RepleVO> list=service.getList(bno);
		return list;
		
	}
	
	@DeleteMapping("delete.do")
	public ResponseEntity<String> delete(@RequestParam ("rno") int rno){
		ResponseEntity<String> entity=null;
		try {
			service.remove(rno);
			entity=new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			entity=new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
		
		
		
	}
	
	

}
