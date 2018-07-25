package com.yidu.motor.base.dao;

import java.util.List;
import java.util.Map;

import com.yidu.motor.base.domain.Pickstandard;
public interface PickstandardDao {
	/**
	 * 带条件的分页查询,如果条件为空,就是查询所有线路,并做分页
	 * @param map 查询条件映射
	 * @return 线路集合
	 */
	List<Pickstandard> basePickstandardpageQuery(Map<String,Object> map);
	/**
	 * 查询所有线路的总计数量
	 * @param map 查询条件映射
	 * @return 查询到的总记录数
	 */
	int findAllBasePickstandardCount(Map<String,Object> map);
	/**
	 * 添加线路
	 * @param Pickstandard 线路对象
	 * @return 添加成功返回1否则返回0
	 */
	int addBasePickstandard(Pickstandard Pickstandard);
	/**
	 * 修改线路信息
	 * @param Pickstandard 线路对象
	 * @return 修改成功返回1否则返回0
	 */
	int updateBasePickstandard(Pickstandard Pickstandard);
	/**
	 * 删除线路(逻辑删除)
	 * @param pickstandardid 线路Id
	 * @return 删除成功返回1否则返回0
	 */
	int deleteBasePickstandard(String pickstandardid);
	/**
	 * 批量冻结用户
	 * @return
	 */
	int updateUseableById(String pickstandardid);
	/**
	 * 批量解冻用户
	 * @return
	 */
	int updateUseableToYes(String pickstandardid);
}
