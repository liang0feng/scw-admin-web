package com.atguigu.scw.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.scw.common.bean.TTag;
import com.atguigu.scw.common.service.ProjectTagService;

@RequestMapping("/serviceManager")
@Controller
public class ServiceManagerContoller {
	
	@Autowired
	ProjectTagService projectTagService;

	/**
	 * 去tagList页面
	 * @return
	 */
	@RequestMapping("/tagList.html")
	public String listTagPage() {
		//查出所有标签
		
		return "service-manager/tag";
	}
	
	@ResponseBody
	@RequestMapping("/getAllTag")
	public List<TTag> listPage() {
		//查出所有标签
		return projectTagService.getAllTag();
		
	}
}
