package com.yidu.motor.base.test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.yidu.motor.base.dao.BusDao;
import com.yidu.motor.base.domain.Bus;
import com.yidu.motor.base.service.BusService;

public class BusTest {
	@Autowired
	BusService busService;
	ApplicationContext ctx=new ClassPathXmlApplicationContext("classpath:config/spring/spring-base.xml");
	BusDao busDao=ctx.getBean(BusDao.class);
	@Test
	public void testqueryAllBus(){
		List<Bus> busList=busDao.queryAllBus();
		for (Bus bus : busList) {
			System.out.println(bus.getBusnumber());
		}
	}
	@Test
	public void test(){
		List<Bus> busList =busService.getAllBus();
		for (Bus bus : busList) {
			System.out.println(bus.getBusnumber());
		}

	}
}
