package com.yidu.motor.base.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yidu.motor.base.dao.BusDao;
import com.yidu.motor.base.domain.Bus;
import com.yidu.motor.base.service.BusService;
@Service
public class BusServiceImpl implements BusService {
	@Autowired
	private BusDao busDao;
	public List<Bus> getAllBus() {
		return busDao.queryAllBus();
	}

}
