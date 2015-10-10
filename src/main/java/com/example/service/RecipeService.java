package com.example.service;


import java.util.List;

import com.example.model.Recipe;
/*
 * The recipeservice interface
 */
public interface RecipeService {
    /*
     * Add new recipe to service.
     */
    public void addRecipe(Recipe recipe);
    /*
     * List all recipes in the service.
     */
    public List<Recipe> listRecipes();
    /*
     * Remove recipe by given id.
     */
    public void removeRecipe(Integer id);
    /*
     * Get recipe by given id.
     */
    public Recipe getRecipe(Integer id);
    /*
     * List all recipes that match to given query.
     */
    public List<Recipe> search(String word);
}
