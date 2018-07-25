package com.yidu.motor.base.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.yidu.motor.base.domain.Dispatcher;
import com.yidu.motor.base.domain.Line;
@Service
public interface LineService {
	/**
	 * 带条件的分页查询，如果条件为空，就是查询所有线路，并做分页
	 * @param pageSize 页码
	 * @param pageNumber 页面大小
	 * @param linename 线路名称
	 * @param linetype线路类型
	 * @param linestart开始站点
	 * @param lineend 结束站点
	 * @param direction 方向
	 * @param useable 状态
	 * @return 返回线路集合
	 */
	List<Line> linePageQuery(Integer pageSize, Integer pageNumber, String linename, String linetype,String linestart,String lineend,String direction,String useable);
	
	/**
	 * 查询所有总记录数
	 * @param carrier 承运商
	 * @param driver 司机
	 * @return 返回所有总记录数
	 */
	int findAllBaselineCount(String linename,String linetype,String linestart,String lineend,String direction,String useable);
	
	/**
	 * 添加线路
	 * @param line 线路对象
	 * @return 添加成功返回true否则返回false
	 */
	boolean addBaseline(Line line);
	
	/**
	 * 修改线路信息
	 * @param line 线路对象
	 * @return 修改成功返回true否则返回false
	 */
	boolean updateBaseline(Line line);
	
	/**
	 * 删除线路
	 * @param lineId 线路Id
	 * @return 删除成功返回true否则返回false
	 */
	boolean deleteBaseline(String[] lineids);
	/**
	 * 冻结线路状态
	 * @param lineids 线路id集合
	 * @return 冻结成功返回true 失败返回false
	 */
	boolean updateUseableById(String[] lineids);
	/**
	 * 解冻线路状态
	 * @param lineids 线路id集合
	 * @return 解冻成功返回true 失败返回false
	 */
	boolean updateUseableToYes(String[] lineids);
	/**查询所有的线路类型
	 * 
	 * @return 线路类型集合
	 */
	List<Dispatcher> findLineTypeAndId();
	
}
