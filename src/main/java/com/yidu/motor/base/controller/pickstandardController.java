package com.yidu.motor.base.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yidu.motor.util.IDGenerator;
import com.yidu.motor.base.domain.Pickstandard;
import com.yidu.motor.base.service.PickstandardService;
@Controller
@RequestMapping("/pickstandard")
public class pickstandardController {
	/**
	 * 将pickstandardService依赖注入
	 */
	@Autowired
	private PickstandardService pickstandardService;
	/**
	 * Controller的set方法
	 * @param pickstandardService 线路设置的service层
	 */
	public void setPickstandardService(PickstandardService pickstandardService) {
		this.pickstandardService = pickstandardService;
	}
	/**
	 * 查询所有线路，并做出分页
	 * @param pageSize 页码
	 * @param pageNumber 页面大小
	 * @param carrier 承运商
	 * @param driver 司机
	 * @return 线路集合
	 * @throws Exception 异常
	 */
	@RequestMapping(value="/findAllPageQuery")
	@ResponseBody
	public  Map<String,Object> pageQueryPickstandard(Integer pageSize,Integer pageNumber,
			String pickstandardname,String minweight,String maxweight,String useable) throws Exception{
		//调用业务逻辑层分页方法
		List<Pickstandard> pickstandardList = pickstandardService.pickstandardPageQuery(pageSize, pageNumber,pickstandardname,minweight,maxweight,useable);
		//获取总记录数
		int total = pickstandardService.findAllBasepickstandardCount(pickstandardname,minweight,maxweight,useable);
		//获取total，rows数利用map封装，便于json格式输出
		Map<String,Object> map = new HashMap<String, Object>();
		//为Map映射赋值
		map.put("total",total);
		//为Map映射赋值
		map.put("rows", pickstandardList);
		//返回Map映射结果
		return map;
		
	}
	
	/**
	 * 添加线路
	 * @param pickstandard 线路对象
	 * @return 成功返回true，否则返回false
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/add",method= {RequestMethod.POST})
	public String add(Pickstandard pickstandard)throws Exception{
		//将随机生成Id赋值给线路Id
		pickstandard.setPickstandardid(IDGenerator.getID());
		//调用业务层添加线路的方法
		boolean result = pickstandardService.addBasepickstandard(pickstandard);
		//判断添加是否成功
		if(result){
			   return "true";
		   }else{
			   return "false";
		   }
	}
	
	/**
	 * 修改线路信息
	 * @param pickstandard 线路对象
	 * @return 成功返回true，否则返回false
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/update",method= {RequestMethod.POST})
	public String update(Pickstandard pickstandard)throws Exception{
		//调用业务逻辑的修改方法
		boolean result = pickstandardService.updateBasepickstandard(pickstandard);
		//判断是否成功
		if(result){
			return "true";
		}else{
			return "false";
		}
		
	}
	
	/**
	 * 删除(逻辑删除)
	 * @param pickstandardIds 线路Id
	 * @return 成功返回success，否则返回error
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/delete",method= {RequestMethod.POST})
	public String delete(@RequestParam(value="pickstandardids[]")String[] pickstandardids)throws Exception{
		boolean result = false;
		//利用增强的for循环获取线路Id
		for(String pickstandardid:pickstandardids) {
			//调用业务逻辑层的删除方法
			result = pickstandardService.deleteBasepickstandard(pickstandardid);
		}
		//判断删除是否成功
		if(result) {
			return "success"; 
		}else {
			return "error";
		}
	}
	/**
	 * 批量冻结线路状态
	 * @param pickstandardids 线路id结合
	 * @return 成功返回success，否则返回error
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/updateUseable",method= {RequestMethod.POST})
	public String updateUseableById(@RequestParam(value="pickstandardids[]") String[] pickstandardids) throws Exception{
		boolean result = false;
		//调用业务逻辑层的冻结方法
		for(String pickstandardid:pickstandardids) {
			//调用业务逻辑层的冻结方法
			result = pickstandardService.updateUseableById(pickstandardid);
		}

		//判断删除是否成功
		if(result) {
			return "success"; 
		}else {
			return "error";
		}
	}
	/**
	 * 批量解冻线路状态
	 * @param pickstandardids 线路id结合
	 * @return 成功返回success，否则返回error
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/updateUseableToYes")
	public String updateUseableToYes(@RequestParam(value="pickstandardids[]") String[] pickstandardids){
		 boolean result=false;
		//调用业务逻辑层的解冻方法
		 for (String pickstandardid : pickstandardids) {
			result=pickstandardService.updateUseableToYes(pickstandardid);
		}
		//判断解冻是否成功
		if(result) {
			return "success"; 
		}else {
			return "error";
		}
	}
}
