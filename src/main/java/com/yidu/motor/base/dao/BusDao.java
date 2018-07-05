package com.yidu.motor.base.dao;

import java.util.List;
import java.util.Map;
import com.yidu.motor.base.domain.Bus;
public interface BusDao {
	/**
	 * 带条件的分页查询,如果条件为空,就是查询所有班车,并做分页
	 * @param map 查询条件映射
	 * @return 班车集合
	 */
	List<Bus> baseBuspageQuery(Map<String,Object> map);
	/**
	 * 查询所有班车的总计数量
	 * @param map 查询条件映射
	 * @return 查询到的总记录数
	 */
	int findAllBaseBusCount(Map<String,Object> map);
	/**
	 * 添加班车
	 * @param bus 班车对象
	 * @return 添加成功返回1否则返回0
	 */
	int addBaseBus(Bus bus);
	/**
	 * 修改班车信息
	 * @param bus 班车对象
	 * @return 修改成功返回1否则返回0
	 */
	int updateBaseBus(Bus bus);
	/**
	 * 删除班车(逻辑删除)
	 * @param busId 班车Id
	 * @return 删除成功返回1否则返回0
	 */
	int deleteBaseBus(String busId);
}