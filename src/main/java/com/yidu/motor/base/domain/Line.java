package com.yidu.motor.base.domain;

public class Line {
    private String lineid;

    private String linename;

    private String linetypeid;

    private String linetype;

    private String linestart;

    private String lineend;

    private String direction;

    private String description;

    private String useable;

    private String remark1;

    private String remark2;

    private String remark3;

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

    public String getLinestart() {
        return linestart;
    }

    public void setLinestart(String linestart) {
        this.linestart = linestart == null ? null : linestart.trim();
    }

    public String getLineend() {
        return lineend;
    }

    public void setLineend(String lineend) {
        this.lineend = lineend == null ? null : lineend.trim();
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction == null ? null : direction.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getUseable() {
        return useable;
    }

    public void setUseable(String useable) {
        this.useable = useable == null ? null : useable.trim();
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