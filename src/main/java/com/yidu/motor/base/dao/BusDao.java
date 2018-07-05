package com.yidu.motor.base.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.yidu.motor.base.domain.Bus;

public interface BusDao {
	@Select("select * from t_bus")
	List<Bus> queryAllBus();
}
