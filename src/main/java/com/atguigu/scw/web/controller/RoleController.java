package com.atguigu.scw.web.controller;

import java.sql.RowIdLifetime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.atguigu.scw.common.bean.TPermission;
import com.atguigu.scw.common.bean.TRole;
import com.atguigu.scw.common.exception.RoleIdExistException;
import com.atguigu.scw.common.service.PermissionService;
import com.atguigu.scw.common.service.RolePermissionService;
import com.atguigu.scw.common.service.RoleService;
import com.atguigu.scw.common.util.MyAppConstant;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@RequestMapping("/role")
@Controller
public class RoleController {
	
	@Autowired
	RoleService roleService;
	@Autowired
	PermissionService permissionService;
	@Autowired
	RolePermissionService rolePermissionService;

	@RequestMapping("/list.html")
	public String listAllPermissions(@RequestParam(value="pn",required=false,defaultValue="1")Integer pn,
			Model model,String condition,HttpSession session) {
		
		PageHelper.startPage(pn, MyAppConstant.PAGE_SIZE);
		
		System.out.println("condition："+condition);
		
		List<TRole> allRole = roleService.getAllRole(condition);
		PageInfo<TRole> pageInfo = new PageInfo<>(allRole, MyAppConstant.PAGE_NAV);
		
		model.addAttribute("pageInfo", pageInfo);
		session.setAttribute("condition",condition);
		
		return "authority -manager/role-list";
	}
	
	//根据roleId查询，role拥有的PerimssionId
	@ResponseBody
	@GetMapping("/getPermissionByRoleId")
	public List<TPermission> getPermissionByRoleId(Integer id) {
		
		return rolePermissionService.getRolePermission(id);
	}
	
	//根据角色id，修改角色权限
	@ResponseBody
	@RequestMapping("/updatePermission")
	public List<TPermission> updateRolePermission(Integer roleId,String permissionIds){
		List<Integer> pIdList = new ArrayList<>();
		System.out.println("roleId:" + roleId);
		System.out.println("permissionId:" + permissionIds);
		System.out.println("进入updataPermission");
		String[] split = permissionIds.split(",");
		for (String string : split) {
			try {
				Integer pid = Integer.parseInt(string);
				pIdList.add(pid);
			} catch (NumberFormatException e) {
				//pidString格式转换异常
			}
		}
		if (pIdList.size() != 0) {
			//修改
			rolePermissionService.updatePermission(roleId,pIdList);
		}
		//查询修改后，并返回
		return rolePermissionService.getRolePermission(roleId);
	}
	
	//新增角色
	@PostMapping("/add")
	public String addRole(String roleName,Model model) {
		roleService.addRole(roleName);
		model.addAttribute("pn", 100);
		return "redirect:/role/list.html";
	}
	
	// 删除角色
	@RequestMapping("/delete")
	public String deleteRole(Integer rid, Model model,Integer pn) {
		try {
			roleService.deleteRole(rid);
		} catch (RoleIdExistException e) {
//			ra.addAttribute("msg", e.getMessage());
		}
		model.addAttribute("pn", pn);
		return "redirect:/role/list.html";
	}

}
