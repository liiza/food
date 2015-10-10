package com.example.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.CollectionTable;

/*
 * A recipe model.
 */
@Entity
public class Recipe {

	// The recipe id, which is the primary key of the recipe. Generated value. 
    @Id
    @GeneratedValue
    private Integer id;

    // Recipe name.
    private String name;
    
    // The image attached to recipe.
    private String imageUrl;

    /*
     * Ingredients attached to recipe.
     */
    @ElementCollection
    @CollectionTable(name ="ingredients")
    private List<Ingredient> ingredients = new ArrayList<Ingredient>();; 
    
    /*
     * Steps attached to recipe.
     */
    @ElementCollection
    @CollectionTable(name="steps")
    private List<String> steps = new ArrayList<String>();
    
    public List<String> getSteps() {
		return steps;
	}

	public void setSteps(List<String> steps) {
		this.steps = steps;
	}

	public Integer getId() {
        return id;
    }

    public List<Ingredient> getIngredients() {
		return ingredients;
	}

	public void setIngredients(List<Ingredient> ingredients) {
		this.ingredients = ingredients;
	}

	public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl ;
    }

}
