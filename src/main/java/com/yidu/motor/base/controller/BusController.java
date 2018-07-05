package com.yidu.motor.base.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yidu.motor.base.domain.Bus;
import com.yidu.motor.base.service.BusService;
@Controller
@RequestMapping("/bus")
public class BusController {
	@Autowired
	private BusService busService;
	@ResponseBody
	@RequestMapping("/queryAll")
	public PageInfo getAllBus(@RequestParam(value="pn",defaultValue="1") Integer pn){
		// 在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Bus> busList=busService.getAllBus();
		PageInfo page=new PageInfo(busList, 5);
		return page;
	}
}
