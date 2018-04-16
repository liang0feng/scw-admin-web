package com.atguigu.scw.web.controllerTest;

import static org.junit.Assert.*;

import java.util.List;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.scw.web.controller.ProcessController;

@ContextConfiguration(locations= {
		"classpath:spring-beans.xml",
		"classpath:spring-mybatis.xml",
		"classpath:spring-tx.xml",
		"classpath:spring-activiti.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
public class ProcessControllerTest {

	@Autowired
	RepositoryService repositoryService;
	
	@Test
	public void test() {
		List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery()
				.list();
		
		System.out.println(list);
	}

}
