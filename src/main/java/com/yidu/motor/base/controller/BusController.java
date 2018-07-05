package com.yidu.motor.base.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.yidu.motor.base.domain.Bus;
import com.yidu.motor.base.service.BusService;
@Controller
@RequestMapping("/bus")
public class BusController {
	/**
	 * 将busService依赖注入
	 */
	@Autowired
	private BusService busService;
	/**
	 * Controller的set方法
	 * @param busService 班车设置的service层
	 */
	public void setBusService(BusService busService) {
		this.busService = busService;
	}
	/**
	 * 查询所有班车，并做出分页
	 * @param pageSize 页码
	 * @param pageNumber 页面大小
	 * @param carrier 承运商
	 * @param driver 司机
	 * @return 班车集合
	 * @throws Exception 异常
	 */
	@RequestMapping(value="/findAllPageQuery")
	@ResponseBody
	public  Map<String,Object> pageQueryBus(Integer pageSize,Integer pageNumber,
			String carrier,String driver) throws Exception{
		//调用业务逻辑层分页方法
		List<Bus> busList = busService.busPageQuery(pageSize, pageNumber,carrier,driver);
		//获取总记录数
		int total = busService.findAllBaseBusCount(carrier,driver);
		//获取total，rows数利用map封装，便于json格式输出
		Map<String,Object> map = new HashMap<String, Object>();
		//为Map映射赋值
		map.put("total",total);
		//为Map映射赋值
		map.put("rows", busList);
		//返回Map映射结果
		return map;
		
	}
	
	/**
	 * 添加班车
	 * @param bus 班车对象
	 * @return 成功返回true，否则返回false
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/add",method= {RequestMethod.POST})
	public String add(Bus bus)throws Exception{
		//将随机生成Id赋值给班车Id
		bus.setBusid(IDGenerator.getID());
		//获取系统时间赋值给操作时间
		bus.setOperateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		//调用业务层添加班车的方法
		boolean result = busService.addBaseBus(bus);
		//判断添加是否成功
		if(result){
			   return "true";
		   }else{
			   return "false";
		   }
	}
	
	/**
	 * 修改班车信息
	 * @param bus 班车对象
	 * @return 成功返回true，否则返回false
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/update",method= {RequestMethod.POST})
	public String update(Bus bus)throws Exception{
		//调用业务逻辑的修改方法
		boolean result = busService.updateBaseBus(bus);
		//判断是否成功
		if(result){
			return "true";
		}else{
			return "false";
		}
		
	}
	
	/**
	 * 删除(逻辑删除)
	 * @param busIds 班车Id
	 * @return 成功返回success，否则返回error
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/delete",method= {RequestMethod.POST})
	public String delete(@RequestParam(value="busIds[]")String[] busIds)throws Exception{
		boolean result = false;
		//利用增强的for循环获取班车Id
		for(String busId:busIds) {
			//调用业务逻辑层的删除方法
			result = busService.deleteBaseBus(busId);
		}
		//判断删除是否成功
		if(result) {
			return "success"; 
		}else {
			return "error";
		}
	}
	
}
