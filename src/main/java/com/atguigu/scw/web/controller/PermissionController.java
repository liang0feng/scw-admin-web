package com.atguigu.scw.web.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.scw.common.bean.TPermission;
import com.atguigu.scw.common.bean.TUser;
import com.atguigu.scw.common.service.PermissionService;

@RequestMapping("/permission")
@Controller
public class PermissionController {

	@Autowired
	PermissionService permissionService;

	// 获取所有菜单的json数据
	@ResponseBody
	@RequestMapping("/getAllPermission")
	public List<TPermission> getAllPermissions1() {

		return permissionService.getAllPermissions();
	}

	// 去到Permissionlist页面
	@RequestMapping("/list.html")
	public String getAllPermissions() {

		return "authority -manager/permission-list";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addPermission(TPermission permission) {
		System.out.println("添加：" + permission);
		permissionService.addPermission(permission);
		return "redirect:/permission/list.html";
	}

	@RequestMapping(value = "/update", method = RequestMethod.PUT)
	public String updataPermission(TPermission permission) {
		System.out.println("修改：" + permission);
		permissionService.updataPermission(permission);
		return "redirect:/permission/list.html";
	}

	@RequestMapping("/delete/{id}")
	public String deletePermission(@PathVariable("id") Integer id) {
		System.out.println("删除");
		permissionService.deletePermission(id);
		return "redirect:/permission/list.html";
	}
}
