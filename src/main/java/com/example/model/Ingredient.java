package com.example.model;

import javax.persistence.Embeddable;
/*
 * An ingredient model.
 */
@Embeddable
public class Ingredient {
	// The ingredient name.
	private String name;
	// The ingredient amount.
	private int amount;
	// The metric of the ingredient.
	private String metric;

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getMetric() {
		return metric;
	}
	public void setMetric(String metric) {
		this.metric = metric;
	}
	

}
