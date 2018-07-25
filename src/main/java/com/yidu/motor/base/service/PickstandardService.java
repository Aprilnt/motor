package com.yidu.motor.base.service;

import java.util.List;

import com.yidu.motor.base.domain.Pickstandard;

public interface PickstandardService {

	List<Pickstandard> pickstandardPageQuery(Integer pageSize, Integer pageNumber, String pickstandardname,
			String minweight, String maxweight, String useable);

	int findAllBasepickstandardCount(String pickstandardname, String minweight, String maxweight, String useable);

	boolean addBasepickstandard(Pickstandard pickstandard);

	boolean updateBasepickstandard(Pickstandard pickstandard);

	boolean deleteBasepickstandard(String pickstandardid);

	boolean updateUseableById(String pickstandardid);

	boolean updateUseableToYes(String pickstandardid);

}
