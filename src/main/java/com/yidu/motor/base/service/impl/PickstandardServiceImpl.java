package com.yidu.motor.base.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yidu.motor.base.dao.PickstandardDao;
import com.yidu.motor.base.domain.Dispatcher;
import com.yidu.motor.base.domain.Pickstandard;
import com.yidu.motor.base.service.PickstandardService;
@Service
public class PickstandardServiceImpl implements PickstandardService {
	@Autowired
	private PickstandardDao pickstandardDao;
	/**
	 * pickstandardDao接口的set方法
	 * @param pickstandardDao 线路设置的pickstandardDao接口
	 */
	public void setPickstandardDao(PickstandardDao pickstandardDao) {
		this.pickstandardDao = pickstandardDao;
	}
	
	/**
	 * 带条件的分页查询,如果条件为空,就是查询所有线路,并做分页
	 * @param pageSize 页码
	 * @param pageNumber 页面大小
	 * @param pickstandardname 线路名称
	 * @param pickstandardtype线路类型
	 * @param pickstandardstart开始站点
	 * @param pickstandardend 结束站点
	 * @param direction 方向
	 * @param useable 状态
	 * @return 返回线路集合
	 */
	public List<Pickstandard> pickstandardPageQuery(Integer pageSize, Integer pageNumber, String pickstandardname,
			String minweight, String maxweight, String useable){		
		//定义一个map集合
		Map<String,Object> map = new HashMap<String,Object>();
		//将页码值放入map集合
		map.put("pageSize", pageSize);
		//将页面大小值放入map集合
		map.put("pageNumber", (pageNumber-1)*pageSize);
		//将线路名称值放入map集合
		map.put("pickstandardname", pickstandardname);
		//将线路类型值放入map集合
		map.put("minweight", minweight);
		//将开始站点值放入map集合
		map.put("maxweight", maxweight);
		//将状态放入map集合
		map.put("useable", useable);
		//调用mapper中的查询所有线路的方法
		return pickstandardDao.basePickstandardpageQuery(map);
	}
	
	/**
	 * 查询总记录数
	 * @param carrier 承运商
	 * @param driver 司机
	 * @return 返回所有总记录数
	 */
	public int findAllBasepickstandardCount(String pickstandardname, String minweight, String maxweight, String useable) {
		//定义一个map集合
		Map<String,Object> map = new HashMap<String,Object>();
		//将线路名称值放入map集合
		map.put("pickstandardname", pickstandardname);
		//将线路类型值放入map集合
		map.put("minweight", minweight);
		//将开始站点值放入map集合
		map.put("maxweight", maxweight);
		//将状态放入map集合
		map.put("useable", useable);
		//调用mapper中的查询总记录数的方法
		return pickstandardDao.findAllBasePickstandardCount(map);
	}
	
	/**
	 * 添加线路
	 * @param pickstandard 线路对象
	 * @return 添加成功返回true否则返回false
	 */
	public boolean addBasepickstandard(Pickstandard pickstandard) {
		//判断添加线路对象是否==1
		if(pickstandardDao.addBasePickstandard(pickstandard) == 1){
			return true;
		}else {
			return false;
		}
		
	}
	
	/**
	 * 修改线路信息
	 * @param pickstandard 线路对象
	 * @return 修改成功返回true否则返回false
	 */
	public boolean updateBasepickstandard(Pickstandard pickstandard) {
		//判断修改线路对象是否==1
		if(pickstandardDao.updateBasePickstandard(pickstandard) == 1) {
			return true;
		}else {
			return false;
		}
		
		
	}
	
	/**
	 * 删除线路(逻辑删除)
	 * @param pickstandardId 线路Id
	 * @return 删除成功返回true否则返回false
	 */
	public boolean deleteBasepickstandard(String pickstandardid) {
		//判断删除线路对象是否==1
		if(pickstandardDao.deleteBasePickstandard(pickstandardid) == 1) {
			return true;
		}else {
			return false;
		}
	}
	/**
	 * 冻结线路状态
	 * @param pickstandardids 线路id集合
	 * @return 冻结成功返回true 失败返回false
	 */
	public boolean updateUseableById(String pickstandardid) {
		//判断冻结线路状态是否成功
		if(pickstandardDao.updateUseableById(pickstandardid)==1){
			return true;
		}else{
			return false;
		}
	}

	public boolean updateUseableToYes(String pickstandardid) {
		//判断冻结线路状态是否成功
		if(pickstandardDao.updateUseableToYes(pickstandardid)==1){
			return true;
		}else{
			return false;
		}
	}
}
