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
import com.yidu.motor.base.domain.Dispatcher;
import com.yidu.motor.base.domain.Line;
import com.yidu.motor.base.service.LineService;
@Controller
@RequestMapping("/line")
public class LineController {
	/**
	 * 将lineService依赖注入
	 */
	@Autowired
	private LineService lineService;
	/**
	 * Controller的set方法
	 * @param lineService 线路设置的service层
	 */
	public void setLineService(LineService lineService) {
		this.lineService = lineService;
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
	public  Map<String,Object> pageQueryLine(Integer pageSize,Integer pageNumber,
			String linename,String linetype,String linestart,String lineend,String direction,String useable) throws Exception{
		//调用业务逻辑层分页方法
		List<Line> lineList = lineService.linePageQuery(pageSize, pageNumber,linename,linetype,linestart,lineend,direction,useable);
		//获取总记录数
		int total = lineService.findAllBaselineCount(linename,linetype,linestart,lineend,direction,useable);
		//获取total，rows数利用map封装，便于json格式输出
		Map<String,Object> map = new HashMap<String, Object>();
		//为Map映射赋值
		map.put("total",total);
		//为Map映射赋值
		map.put("rows", lineList);
		//返回Map映射结果
		return map;
		
	}
	
	/**
	 * 添加线路
	 * @param line 线路对象
	 * @return 成功返回true，否则返回false
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/add",method= {RequestMethod.POST})
	public String add(Line line)throws Exception{
		//将随机生成Id赋值给线路Id
		line.setLineid(IDGenerator.getID());
		//调用业务层添加线路的方法
		boolean result = lineService.addBaseline(line);
		//判断添加是否成功
		if(result){
			   return "true";
		   }else{
			   return "false";
		   }
	}
	
	/**
	 * 修改线路信息
	 * @param line 线路对象
	 * @return 成功返回true，否则返回false
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/update",method= {RequestMethod.POST})
	public String update(Line line)throws Exception{
		//调用业务逻辑的修改方法
		boolean result = lineService.updateBaseline(line);
		//判断是否成功
		if(result){
			return "true";
		}else{
			return "false";
		}
		
	}
	
	/**
	 * 删除(逻辑删除)
	 * @param lineIds 线路Id
	 * @return 成功返回success，否则返回error
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/delete",method= {RequestMethod.POST})
	public String delete(@RequestParam(value="lineids[]")String[] lineids)throws Exception{
		boolean result = false;
		//利用增强的for循环获取线路Id
		for(String lineid:lineids) {
			//调用业务逻辑层的删除方法
			result = lineService.deleteBaseline(lineid);
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
	 * @param lineids 线路id结合
	 * @return 成功返回success，否则返回error
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/updateUseable",method= {RequestMethod.POST})
	public String updateUseableById(@RequestParam(value="lineids[]") String[] lineids) throws Exception{
		boolean result = false;
		//调用业务逻辑层的冻结方法
		for(String lineid:lineids) {
			//调用业务逻辑层的冻结方法
			result = lineService.updateUseableById(lineid);
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
	 * @param lineids 线路id结合
	 * @return 成功返回success，否则返回error
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/updateUseableToYes")
	public String updateUseableToYes(@RequestParam(value="lineids[]") String[] lineids){
		 boolean result=false;
		//调用业务逻辑层的解冻方法
		 for (String lineid : lineids) {
			result=lineService.updateUseableToYes(lineid);
		}
		//判断解冻是否成功
		if(result) {
			return "success"; 
		}else {
			return "error";
		}
	}
	/**
	 * 查询所有线路类型和Id
	 * @return 返回业务层的查询方法
	 * @throws Exception 异常
	 */
	@ResponseBody
	@RequestMapping(value="/findLineTypeAndId")
	public List<Dispatcher> findLineTypeAndId(){
		//调用业务逻辑层的查询所有司机名和Id的方法
		return lineService.findLineTypeAndId();
	}
}
