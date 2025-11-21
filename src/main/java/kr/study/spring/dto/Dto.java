package kr.study.spring.dto;

import java.sql.Timestamp;

public class Dto {
	
	private String userId;
	private String password;
	private String email;
	private String name;
	private String residentNumber;
	private String address;
	private String detailAddress;
	private Timestamp birth;
	private String interest;
	private String introduce;
	
	public Dto() {}
	public Dto(String userId, String password, String email, String name, String residentNumber, 
			String address, String detailAddress, Timestamp birth, String interest, String introduce) {
		this.userId = userId;
		this.password = password;
		this.email = email;
		this.name = name;
		this.residentNumber = residentNumber;
		this.address = address;
		this.detailAddress = detailAddress;
		this.birth = birth;
		this.interest = interest;
		this.introduce = introduce;
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getResidentNumber() {
		return residentNumber;
	}
	public void setResidentNumber(String residentNumber) {
		this.residentNumber = residentNumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public Timestamp getBirth() {
		return birth;
	}
	public void setBirth(Timestamp birth) {
		this.birth = birth;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	
	

}
