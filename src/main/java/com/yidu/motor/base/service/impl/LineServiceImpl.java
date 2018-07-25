package com.yidu.motor.base.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yidu.motor.base.dao.LineDao;
import com.yidu.motor.base.domain.Dispatcher;
import com.yidu.motor.base.domain.Line;
import com.yidu.motor.base.service.LineService;
@Service
public class LineServiceImpl implements LineService {
	@Autowired
	private LineDao lineDao;
	/**
	 * lineDao接口的set方法
	 * @param lineDao 线路设置的lineDao接口
	 */
	public void setLineDao(LineDao lineDao) {
		this.lineDao = lineDao;
	}
	
	/**
	 * 带条件的分页查询,如果条件为空,就是查询所有线路,并做分页
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
	public List<Line> linePageQuery(Integer pageSize,Integer pageNumber,
			String linename,String linetype,String linestart,String lineend,String direction,String useable) {
		//定义一个map集合
		Map<String,Object> map = new HashMap<String,Object>();
		//将页码值放入map集合
		map.put("pageSize", pageSize);
		//将页面大小值放入map集合
		map.put("pageNumber", (pageNumber-1)*pageSize);
		//将线路名称值放入map集合
		map.put("linename", linename);
		//将线路类型值放入map集合
		map.put("linetype", linetype);
		//将开始站点值放入map集合
		map.put("linestart", linestart);
		//将结束站点放入map集合
		map.put("lineend", lineend);
		//将方向放入map集合
		map.put("direction", direction);
		//将状态放入map集合
		map.put("useable", useable);
		//调用mapper中的查询所有线路的方法
		return lineDao.baseLinepageQuery(map);
	}
	
	/**
	 * 查询总记录数
	 * @param carrier 承运商
	 * @param driver 司机
	 * @return 返回所有总记录数
	 */
	public int findAllBaselineCount(String linename,String linetype,String linestart,String lineend,String direction,String useable) {
		//定义一个map集合
		Map<String,Object> map = new HashMap<String,Object>();
		//将线路名称值放入map集合
		map.put("linename", linename);
		//将线路类型值放入map集合
		map.put("linetype", linetype);
		//将开始站点值放入map集合
		map.put("linestart", linestart);
		//将结束站点放入map集合
		map.put("lineend", lineend);
		//将方向放入map集合
		map.put("direction", direction);
		//将状态放入map集合
		map.put("useable", useable);
		//调用mapper中的查询总记录数的方法
		return lineDao.findAllBaseLineCount(map);
	}
	
	/**
	 * 添加线路
	 * @param line 线路对象
	 * @return 添加成功返回true否则返回false
	 */
	public boolean addBaseline(Line line) {
		//判断添加线路对象是否==1
		if(lineDao.addBaseLine(line) == 1){
			return true;
		}else {
			return false;
		}
		
	}
	
	/**
	 * 修改线路信息
	 * @param line 线路对象
	 * @return 修改成功返回true否则返回false
	 */
	public boolean updateBaseline(Line line) {
		//判断修改线路对象是否==1
		if(lineDao.updateBaseLine(line) == 1) {
			return true;
		}else {
			return false;
		}
		
		
	}
	
	/**
	 * 删除线路(逻辑删除)
	 * @param lineId 线路Id
	 * @return 删除成功返回true否则返回false
	 */
	public boolean deleteBaseline(String[] lineids) {
		//判断删除线路对象是否==1
		if(lineDao.deleteBaseLine(lineids) >0) {
			return true;
		}else {
			return false;
		}
	}
	/**
	 * 冻结线路状态
	 * @param lineids 线路id集合
	 * @return 冻结成功返回true 失败返回false
	 */
	public boolean updateUseableById(String[] lineids) {
		//判断冻结线路状态是否成功
		if(lineDao.updateUseableById(lineids)>0){
			return true;
		}else{
			return false;
		}
	}

	public boolean updateUseableToYes(String[] lineids) {
		//判断冻结线路状态是否成功
		if(lineDao.updateUseableToYes(lineids)>0){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 查询线路类型
	 */
	public List<Dispatcher> findLineTypeAndId() {

		return lineDao.findLineTypeAndId();
	}
}
