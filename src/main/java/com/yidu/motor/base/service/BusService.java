package com.yidu.motor.base.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.yidu.motor.base.domain.Bus;
@Service
public interface BusService {
	List<Bus> getAllBus();
}
