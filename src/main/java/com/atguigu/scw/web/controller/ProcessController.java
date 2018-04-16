package com.atguigu.scw.web.controller;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.druid.sql.dialect.mysql.visitor.MySqlASTVisitorAdapter;
import com.atguigu.scw.api.bean.ApiReturn;
import com.atguigu.scw.common.bean.TUser;
import com.atguigu.scw.common.util.MyAppConstant;
import com.atguigu.scw.web.ProcessDefintionBean;

@ResponseBody // 所有请求都是返回Json数据
@RequestMapping("/process")
@Controller
public class ProcessController {
//
	@Autowired // 流程引擎的仓库组件服务
	RepositoryService repositoryService;


	/**
	 * 上传并布署流程
	 * @param file 上传的流程文件
	 * @param session 
	 * @return:
	 * @throws IOException
	 */
	@PostMapping("/uploadAndDeploy")
	public ApiReturn uploadAndDeployProcess(
			@RequestParam(value = "file", required = false, defaultValue = "") MultipartFile file,
			HttpSession session) throws IOException {
		
		//将上传的file流程布署
		repositoryService.createDeployment()
			.addInputStream(file.getOriginalFilename(), file.getInputStream())
			.tenantId(((TUser)session.getAttribute(MyAppConstant.LOGIN_USER)).getLoginacct())
			.deploy();
		System.out.println("djkfadksljfl");
		return ApiReturn.success("OK");
	}
	
	@GetMapping("/procs")
	public ApiReturn processes(){
		//1、数据库查询的所有流程定义
		List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().list();
		
		List<ProcessDefintionBean> result = new ArrayList<>();
		for (ProcessDefinition processDefinition : list) {
			ProcessDefintionBean bean = new ProcessDefintionBean();
			//属性的对拷；processDefinition===bean
			BeanUtils.copyProperties(processDefinition, bean);
			result.add(bean);
		}
		//返回所有流程
		return ApiReturn.success(result);
	}
	
	
	@GetMapping("/img")
	public void img(@RequestParam("pdId")String pdId,HttpServletResponse response) throws IOException{
		//图片内容
		InputStream inputStream = repositoryService.getProcessDiagram(pdId);
		
		ServletOutputStream outputStream = response.getOutputStream();
		
		IOUtils.copy(inputStream, outputStream);
		outputStream.close();
		inputStream.close();
		
	}

}

