package com.yidu.motor.base.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yidu.motor.base.dao.BusDao;
import com.yidu.motor.base.domain.Bus;
import com.yidu.motor.base.domain.Dispatcher;
import com.yidu.motor.base.domain.Line;
import com.yidu.motor.base.service.BusService;

@Service
public class BusServiceImpl implements BusService {
	@Autowired
	private BusDao busDao;

	/**
	 * busDao接口的set方法
	 * 
	 * @param busDao
	 *            班车设置的busDao接口
	 */
	public void setBusDao(BusDao busDao) {
		this.busDao = busDao;
	}

	/**
	 * 带条件的分页查询,如果条件为空,就是查询所有班车,并做分页
	 * 
	 * @param pageSize
	 *            页码
	 * @param pageNumber
	 *            页面大小
	 * @param carrier
	 *            承运商
	 * @param driver
	 *            司机
	 * @return 返回班车集合
	 */
	public List<Bus> busPageQuery(Integer pageSize, Integer pageNumber, String carrier, String driver, String busnumber,
			String driverphone, String linetype, String linename, String useable) {
		// 定义一个map集合
		Map<String, Object> map = new HashMap<String, Object>();
		// 将页码值放入map集合
		map.put("pageSize", pageSize);
		// 将页面大小值放入map集合
		map.put("pageNumber", (pageNumber - 1) * pageSize);
		// 将承运商值放入map集合
		map.put("carrier", carrier);
		// 将司机值放入map集合
		map.put("driver", driver);
		// 将车牌号值放入map集合
		map.put("busnumber", busnumber);
		// 将司机电话放入map集合
		map.put("driverphone", driverphone);
		// 将线路类型放入map集合
		map.put("linetype", linetype);
		// 将线路名放入map集合
		map.put("linename", linename);
		// 将是否可用放入map集合
		map.put("useable", useable);
		// 调用mapper中的查询所有班车的方法
		return busDao.baseBuspageQuery(map);
	}

	/**
	 * 查询总记录数
	 * 
	 * @param carrier
	 *            承运商
	 * @param driver
	 *            司机
	 * @return 返回所有总记录数
	 */
	public int findAllBaseBusCount(String carrier, String driver, String driverphone, String busnumber, String linetype,
			String linename, String useable) {
		// 定义一个map集合
		Map<String, Object> map = new HashMap<String, Object>();
		// 将承运商值放入map集合
		map.put("carrier", carrier);
		// 将司机值放入map集合
		map.put("driver", driver);
		// 将车牌号值放入map集合
		map.put("busnumber", busnumber);
		// 将司机电话放入map集合
		map.put("driverphone", driverphone);
		// 将线路类型放入map集合
		map.put("linetype", linetype);
		// 将线路名放入map集合
		map.put("linename", linename);
		// 将是否可用放入map集合
		map.put("useable", useable);
		// 调用mapper中的查询总记录数的方法
		return busDao.findAllBaseBusCount(map);
	}

	/**
	 * 添加班车
	 * 
	 * @param bus
	 *            班车对象
	 * @return 添加成功返回true否则返回false
	 */
	public boolean addBaseBus(Bus bus) {
		// 判断添加班车对象是否==1
		if (busDao.addBaseBus(bus) == 1) {
			return true;
		} else {
			return false;
		}

	}

	/**
	 * 修改班车信息
	 * 
	 * @param bus
	 *            班车对象
	 * @return 修改成功返回true否则返回false
	 */
	public boolean updateBaseBus(Bus bus) {
		// 判断修改班车对象是否==1
		if (busDao.updateBaseBus(bus) == 1) {
			return true;
		} else {
			return false;
		}

	}

	/**
	 * 删除班车(逻辑删除)
	 * 
	 * @param busId
	 *            班车Id
	 * @return 删除成功返回true否则返回false
	 */
	public boolean deleteBaseBus(String busid) {
		// 判断删除班车对象是否==1
		if (busDao.deleteBaseBus(busid) == 1) {
			return true;
		} else {
			return false;
		}

	}

	/**
	 * 查询所有线路类型和Id
	 * 
	 * @return 线路类型和Id的集合
	 */
	public List<Line> findLineNameAndId() {
		return busDao.findLineNameAndId();
	}

	/**
	 * 冻结班车状态
	 * 
	 * @param busids
	 *            班车id集合
	 * @return 冻结成功返回true 失败返回false
	 */
	public boolean updateUseableById(String busid) {
		// 判断冻结班车状态是否成功
		if (busDao.updateUseableById(busid) == 1) {
			return true;
		} else {
			return false;
		}
	}

	public boolean updateUseableToYes(String busid) {
		// 判断冻结班车状态是否成功
		if (busDao.updateUseableToYes(busid) == 1) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 查询所有司机和Id
	 * 
	 * @return 司机和Id的集合
	 */
	public List<Dispatcher> findDriverNameAndId() {
		return busDao.findDriverNameAndId();
	}
}
