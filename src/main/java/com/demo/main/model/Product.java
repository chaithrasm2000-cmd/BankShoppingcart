package com.demo.main.model;

import jakarta.persistence.*;

@Entity
public class Product {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "prod_id")
    private Long prodId;   // auto-generated numeric ID

    private String prodName;
    private String prodType;
    private String prodInfo;

    private Double prodPrice;
    private Integer prodQuantity;

    // Instead of storing binary, store image URL/path
    private String prodImageUrl;

    private boolean available = true; // default to true

    // ✅ Link to seller
    @ManyToOne
    @JoinColumn(name = "seller_id")
    private user seller;

    public Product() {
        super();
    }

    public Product(Long prodId, String prodName, String prodType, String prodInfo,
                   Double prodPrice, Integer prodQuantity, String prodImageUrl) {
        this.prodId = prodId;
        this.prodName = prodName;
        this.prodType = prodType;
        this.prodInfo = prodInfo;
        this.prodPrice = prodPrice;
        this.prodQuantity = prodQuantity;
        this.prodImageUrl = prodImageUrl;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public Long getProdId() {
        return prodId;
    }

    public void setProdId(Long prodId) {
        this.prodId = prodId;
    }

    public String getProdName() {
        return prodName;
    }

    public void setProdName(String prodName) {
        this.prodName = prodName;
    }

    public String getProdType() {
        return prodType;
    }

    public void setProdType(String prodType) {
        this.prodType = prodType;
    }

    public String getProdInfo() {
        return prodInfo;
    }

    public void setProdInfo(String prodInfo) {
        this.prodInfo = prodInfo;
    }

    public Double getProdPrice() {
        return prodPrice;
    }

    public void setProdPrice(Double prodPrice) {
        this.prodPrice = prodPrice;
    }

    public Integer getProdQuantity() {
        return prodQuantity;
    }

    public void setProdQuantity(Integer prodQuantity) {
        this.prodQuantity = prodQuantity;
    }

    public String getProdImageUrl() {
        return prodImageUrl;
    }

    public void setProdImageUrl(String prodImageUrl) {
        this.prodImageUrl = prodImageUrl;
    }

    public user getSeller() {
        return seller;
    }

    public void setSeller(user seller) {
        this.seller = seller;
    }
    @Column(length = 500)
    private String rejectionReason;

	public String getRejectionReason() {
		return rejectionReason;
	}

	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}

}
