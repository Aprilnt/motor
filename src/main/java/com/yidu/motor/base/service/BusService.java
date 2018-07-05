package com.yidu.motor.base.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.yidu.motor.base.domain.Bus;
@Service
public interface BusService {
	/**
	 * 带条件的分页查询，如果条件为空，就是查询所有班车，并做分页
	 * @param pageSize 页码
	 * @param pageNumber 页面大小
	 * @param carrier 承运商
	 * @param driver 司机
	 * @return 返回班车集合
	 */
	List<Bus> busPageQuery(Integer pageSize, Integer pageNumber, String carrier, String driver);
	
	/**
	 * 查询所有总记录数
	 * @param carrier 承运商
	 * @param driver 司机
	 * @return 返回所有总记录数
	 */
	int findAllBaseBusCount(String carrier,String driver);
	
	/**
	 * 添加班车
	 * @param bus 班车对象
	 * @return 添加成功返回true否则返回false
	 */
	boolean addBaseBus(Bus bus);
	
	/**
	 * 修改班车信息
	 * @param bus 班车对象
	 * @return 修改成功返回true否则返回false
	 */
	boolean updateBaseBus(Bus bus);
	
	/**
	 * 删除班车
	 * @param busId 班车Id
	 * @return 删除成功返回true否则返回false
	 */
	boolean deleteBaseBus(String busId);
	
}