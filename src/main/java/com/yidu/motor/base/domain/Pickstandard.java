package com.yidu.motor.base.domain;

import java.math.BigDecimal;

public class Pickstandard {
    private String pickstandardid;

    private String pickstandardname;

    private BigDecimal minweight;

    private BigDecimal maxweight;

    private String useable;

    private String description;

    private String remark1;

    private String remark2;

    private String remark3;

    public String getPickstandardid() {
        return pickstandardid;
    }

    public void setPickstandardid(String pickstandardid) {
        this.pickstandardid = pickstandardid == null ? null : pickstandardid.trim();
    }

    public String getPickstandardname() {
        return pickstandardname;
    }

    public void setPickstandardname(String pickstandardname) {
        this.pickstandardname = pickstandardname == null ? null : pickstandardname.trim();
    }

    public BigDecimal getMinweight() {
        return minweight;
    }

    public void setMinweight(BigDecimal minweight) {
        this.minweight = minweight;
    }

    public BigDecimal getMaxweight() {
        return maxweight;
    }

    public void setMaxweight(BigDecimal maxweight) {
        this.maxweight = maxweight;
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
}