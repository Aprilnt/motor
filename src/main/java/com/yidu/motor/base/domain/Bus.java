package com.yidu.motor.base.domain;

import java.math.BigDecimal;

public class Bus {
    private String busid;

    private String linetypeid;

    private String linetype;

    private String lineid;

    private String linename;

    private String busnumber;

    private String carrier;

    private String bustypeid;

    private String bustype;

    private String driver;

    private String driverphone;

    private BigDecimal ton;

    private String useable;

    private String description;
    
	private String operateTime;

    private String remark1;

    private String remark2;

    private String remark3;

    public String getBusid() {
        return busid;
    }

    public void setBusid(String busid) {
        this.busid = busid == null ? null : busid.trim();
    }

    public String getLinetypeid() {
        return linetypeid;
    }

    public void setLinetypeid(String linetypeid) {
        this.linetypeid = linetypeid == null ? null : linetypeid.trim();
    }

    public String getLinetype() {
        return linetype;
    }

    public void setLinetype(String linetype) {
        this.linetype = linetype == null ? null : linetype.trim();
    }

    public String getLineid() {
        return lineid;
    }

    public void setLineid(String lineid) {
        this.lineid = lineid == null ? null : lineid.trim();
    }

    public String getLinename() {
        return linename;
    }

    public void setLinename(String linename) {
        this.linename = linename == null ? null : linename.trim();
    }

    public String getBusnumber() {
        return busnumber;
    }

    public void setBusnumber(String busnumber) {
        this.busnumber = busnumber == null ? null : busnumber.trim();
    }

    public String getCarrier() {
        return carrier;
    }

    public void setCarrier(String carrier) {
        this.carrier = carrier == null ? null : carrier.trim();
    }

    public String getBustypeid() {
        return bustypeid;
    }

    public void setBustypeid(String bustypeid) {
        this.bustypeid = bustypeid == null ? null : bustypeid.trim();
    }

    public String getBustype() {
        return bustype;
    }

    public void setBustype(String bustype) {
        this.bustype = bustype == null ? null : bustype.trim();
    }

    public String getDriver() {
        return driver;
    }

    public void setDriver(String driver) {
        this.driver = driver == null ? null : driver.trim();
    }

    public String getDriverphone() {
        return driverphone;
    }

    public void setDriverphone(String driverphone) {
        this.driverphone = driverphone == null ? null : driverphone.trim();
    }

    public BigDecimal getTon() {
        return ton;
    }

    public void setTon(BigDecimal ton) {
        this.ton = ton;
    }

    public String getUseable() {
        return useable;
    }

    public void setUseable(String useable) {
        this.useable = useable == null ? null : useable.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getRemark1() {
        return remark1;
    }

    public void setRemark1(String remark1) {
        this.remark1 = remark1 == null ? null : remark1.trim();
    }

    public String getRemark2() {
        return remark2;
    }

    public void setRemark2(String remark2) {
        this.remark2 = remark2 == null ? null : remark2.trim();
    }

    public String getRemark3() {
        return remark3;
    }

    public void setRemark3(String remark3) {
        this.remark3 = remark3 == null ? null : remark3.trim();
    }

	public String getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(String operateTime) {
		this.operateTime = operateTime;
	}

}