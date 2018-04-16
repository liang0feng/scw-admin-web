package com.atguigu.scw.web.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.atguigu.scw.common.bean.TPermission;
import com.atguigu.scw.common.bean.TRole;
import com.atguigu.scw.common.bean.TUser;
import com.atguigu.scw.common.service.PermissionService;
import com.atguigu.scw.common.service.RoleService;
import com.atguigu.scw.common.service.UserService;
import com.atguigu.scw.common.util.MyAppConstant;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理和用户有关的所有请求
 * 
 * @author lfy
 *
 */
@RequestMapping("/user")
@Controller("myUserController")
public class UserController {

	@Autowired
	UserService userService;
	@Autowired
	PermissionService permissionService;
	@Autowired
	RoleService roleService;

	@RequestMapping("/login")
	public String userLogin(TUser user, Model model, HttpSession session) {
		// 登陆完成用户放在session中
		TUser loginUser = userService.login(user);
		if (loginUser == null) {
			// 登陆失败
			model.addAttribute("msg", "用户名密码错误");
			return "login";
		}
		// 使用常量保存后来公共使用的属性等; loginUser是一个魔法值
		session.setAttribute(MyAppConstant.LOGIN_USER, loginUser);
		// 将当前用户能操作的所有菜单查询出来；

		// 成功来后台管理页面，失败来登陆
		// 查出当前用户所有的菜单
		List<TPermission> permissions = permissionService.getUserPermissions(loginUser.getId());

		// 将菜单查出以后放在session中
		session.setAttribute(MyAppConstant.USER_MENUS, permissions);
		return "redirect:/main.html";
	}

	// SpringMVC确定自定义类型的参数的值，最终都会放在隐含模型（请求域中）
	// 默认使用的key tUser
	// 版本的差异；4.3.11；Model和RedirectAttributes只能用一个；也要注意顺序问题
	@RequestMapping("/regist")
	public String userRegist(TUser user, RedirectAttributes ra, Model model) {

		// 1、用户注册
		try {
			System.out.println("提交来的用户信息：" + user);
			boolean flag = userService.regist(user);
		} catch (Exception e) {
			// 违反唯一约束就报错了

			// 要在页面提示，回显；
			model.addAttribute("msg", "用户名已经被占用");
			return "reg";
		}

		// 成功来后台管理页面，失败来登陆
		ra.addFlashAttribute("msg", "注册成功可以登陆了");
		// 给隐含模型中放的数据
		// 如果是转发默认是放在request域中
		// 如果是重定向默认放在请求参数后面 ${}
		// 重定向携带数据；把数据放在session中；只要取出就立马从session中移除；
		// RedirectAttributes就是Model，方法上Model和Ra只写一个
		return "redirect:/login.html";
	}

	/**
	 * 用户权限管理页面
	 */

	// 查询的时候需要带条件，
	// 查出符合条件的所有 用户，分页展示
	@RequestMapping("/list.html")
	public String listHtml(Model model, 
			@RequestParam(value = "pn", required = false, defaultValue = "1") Integer pn,
			@RequestParam(value="condition",required=false,defaultValue="") String condition,
			HttpSession session) {
		
		// 使用PageHelper分页插件
		// pn为当前页码
		// page_size:每页显示条数
		PageHelper.startPage(pn, MyAppConstant.PAGE_SIZE);
		// 需紧跟startPage后才能对结果进行分页
		List<TUser> list = userService.queryUserByCondition(condition);

		// 将查询结果封装进pageInfo
		//pageInfo包含所有分页信息
		PageInfo<TUser> pageInfo = new PageInfo<>(list, MyAppConstant.PAGE_NAV);

		//将分页信息放入request请求域中:
		model.addAttribute("pageInfo",pageInfo);
		//保存查询条件到请求域中
		session.setAttribute("condition", condition);
		//model中的数据：
			//转发时：model的数据会刷到request请求域 中
			//重定向时，model中的数据会放在url地址后，作为 重定向的携带的请求参数:可以解决路径中有中文的问题
		//注意：HttpSesion、Model、RedirectAttribute三个区别
		return "authority -manager/user-list";
	}
	
	//修改用户前，先查出要修改的用户，用于回显
	@RequestMapping("/edit.html")
	public String toUserEidtPage(@RequestParam Integer id,Model model) {
		//根据要修改用户的id，查出用户
		TUser user = userService.getUserById(id);
		
		//将查出的用户保存到model中，用于页面回显
		model.addAttribute("user", user);
		//转发到用户修改页面
		return "authority -manager/user-edit";
	}

	//修改并重定向回list。html页面
	@PutMapping("/edit")
	public String updateUser(TUser user,Model model,RedirectAttributes ra,
			@RequestParam(value="pn",required=false,defaultValue="1") 
			Integer pn,HttpSession session) {
		
		try {
				userService.updateUser(user);
			
			//确保回到之前的页码：携带条件和页码
			ra.addAttribute("condition", session.getAttribute("condition"));
			ra.addAttribute("pn", pn);
		} catch (Exception e) {
			//修改失败，用户名存在
			//将修改失败的用户信息保存到model中，用于回显
			ra.addAttribute("msg", "修改失败，用户已存在！");
			ra.addAttribute("user", user);
			System.out.println("修改失败");
			return "authority -manager/user-edit";
		}
		//重定向，参数放在请求域中
		ra.addFlashAttribute("msg", "修改成功！");
		//修改成功，重定向到user-list页面
		return "redirect:/user/list.html";
	}
	
	//删除用户
	@DeleteMapping("/delete")
	public String deleteUser(@RequestParam("ids") String ids,RedirectAttributes msgRa) {
		List<Integer> u_ids = new ArrayList<>();
		
		if (!StringUtils.isEmpty(ids)) {
			String[] split = ids.split(",");
			for (String string : split) {
				try {
					u_ids.add(Integer.parseInt(string));
				} catch (NumberFormatException e) {
					//忽略转换失败
				}
			}
			userService.deleteUser(u_ids);
		}
		
		//保存删除操作提示信息
		msgRa.addFlashAttribute("msg", "成功删除【"+u_ids.size()+"】个用户！");
		//重定向到用户列表
		return "redirect:/user/list.html";
	}
	
	//添加用户
	@PostMapping("/add")
	public String addUser(TUser user,RedirectAttributes ra) {
		
		try {
			userService.addUser(user);
		} catch (Exception e) {
			//添加失败,保存回显信息
			ra.addFlashAttribute("msg", "添加失败，用户名已存在！");
			return "redirect:/user/list.html";
		}
		
		//添加成功
		ra.addFlashAttribute("msg", "添加成功！");
		//重定向携带请求参数:当总页数小于100时显示最后一面
		ra.addAttribute("pn", 100);
		//重定向到用户列表
		return "redirect:/user/list.html";
	}
	
	//查询某个用户的角色
		@RequestMapping("/assign.html")
		public String assign(Integer id,Model model) {
			//查询已分配的角色
			List<TRole> assingedRoles = userService.getAssignedRole(id);
			//查询未分配的角色
			List<TRole> unassingedRoles = userService.getUnassignedRole(id);
			
			
			
			model.addAttribute("assingedRoles", assingedRoles);
			model.addAttribute("unassingedRoles", unassingedRoles);
			
			return "authority -manager/user-assignRole";
		}
	
	@RequestMapping("/addRoles")
	public String addRole(Integer userId,String selectedId,Model model) {
		List<Integer> rids = new ArrayList<>();
		String[] split = selectedId.split(",");
		for (String string : split) {
			try {
				int rid = Integer.parseInt(string);
				rids.add(rid);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (rids.size()!=0) {
			userService.addRoles(userId,rids);
		}
		//重定向回到角色分配页面
		model.addAttribute("id", userId);
		return "redirect:/user/assign.html";
	}
	
	/**
	 * 
	 * @param userId 用户id
	 * @param selectedId ：用户要删除的角色
	 * @param model	：null
	 * @return
	 */
	@RequestMapping("/removeRoles")
	public String removeRole(Integer userId,String selectedId,Model model) {
		List<Integer> rids = new ArrayList<>();
		String[] split = selectedId.split(",");
		for (String string : split) {
			try {
				int rid = Integer.parseInt(string);
				rids.add(rid);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (rids.size()!=0) {
			userService.removeRoles(userId,rids);
		}
		
		//重定向回到角色分配页面
		model.addAttribute("id", userId);
		return "redirect:/user/assign.html";
	}
}
