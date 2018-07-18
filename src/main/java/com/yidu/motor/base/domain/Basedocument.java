package com.yidu.motor.base.domain;

public class Basedocument {
    private String basedocumentid;

    private String basedocumentno;

    private String basedocumentname;

    private String scale;

    private String description;

    private String remark1;

    private String remark2;

    private String remark3;

    public String getBasedocumentid() {
        return basedocumentid;
    }

    public void setBasedocumentid(String basedocumentid) {
        this.basedocumentid = basedocumentid == null ? null : basedocumentid.trim();
    }

    public String getBasedocumentno() {
        return basedocumentno;
    }

    public void setBasedocumentno(String basedocumentno) {
        this.basedocumentno = basedocumentno == null ? null : basedocumentno.trim();
    }

    public String getBasedocumentname() {
        return basedocumentname;
    }

    public void setBasedocumentname(String basedocumentname) {
        this.basedocumentname = basedocumentname == null ? null : basedocumentname.trim();
    }

    public String getScale() {
        return scale;
    }

    public void setScale(String scale) {
        this.scale = scale == null ? null : scale.trim();
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