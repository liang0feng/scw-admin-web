package com.atguigu.scw.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.atguigu.scw.common.util.MyAppConstant;

//登陆权限检查拦截器
public class LoginInterceptor implements HandlerInterceptor {

	// 目标方法执行之前拦截
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		System.out.println("用户登录拦截器!");
		// 做登陆检查，检查用户当前是否登陆
		Object object = request.getSession().getAttribute(
				MyAppConstant.LOGIN_USER);
		if (object != null) {
			//已登陆，放行
			return true;
		}

		request.setAttribute("msg", "还未登陆，没有权限！");
		//不放行，返回登陆页面提示登陆
		request.getRequestDispatcher("/login.html").forward(request, response);
		return false;
	}

	// 目标方法运行以后
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	// 页面渲染以后
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
