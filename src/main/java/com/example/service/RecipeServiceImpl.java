package com.example.service;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;




import com.example.model.Recipe;



import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import javax.persistence.criteria.CriteriaQuery;

import java.util.List;

/*
 * The recipeservice implementation.
 */
@Service
public class RecipeServiceImpl implements RecipeService {

	
    @PersistenceContext
    EntityManager em;
        
    /*
     * Add new recipe to service with Entity manager.
     * @see com.example.service.RecipeService#addRecipe(com.example.model.Recipe)
     */
    @Transactional
    public void addRecipe(Recipe recipe) {
        em.persist(recipe);
    }

    /*
     * List all recipes in the service.
     * @see com.example.service.RecipeService#listRecipes()
     */
    @Transactional
    public List<Recipe> listRecipes() {
        CriteriaQuery<Recipe> c = em.getCriteriaBuilder().createQuery(Recipe.class);
        c.from(Recipe.class);
        return em.createQuery(c).getResultList();
    }

    /*
     * Remove the recipe by given id.
     * @see com.example.service.RecipeService#removeRecipe(java.lang.Integer)
     */
    @Transactional
    public void removeRecipe(Integer id) {
        Recipe recipe = em.find(Recipe.class, id);
        if (null != recipe) {
            em.remove(recipe);
        }
    }
 
    /*
     * Get the recipe by given id.
     * @see com.example.service.RecipeService#getRecipe(java.lang.Integer)
     */
    @Transactional
    public Recipe getRecipe(Integer id) {
        Recipe recipe = em.find(Recipe.class, id);
        // Force loading the ingredients and steps attached to this recipe.
        recipe.getIngredients().size();
        recipe.getSteps().size();
        return recipe;
    }
    
    /*
     * Search all recipes which name matches to the given query.
     * @see com.example.service.RecipeService#search(java.lang.String)
     */
    @Transactional
    public List<Recipe> search(String word) {
    	// Convert string parameter to lower case to match with all entities.

    	String wordLowerCase = word.toLowerCase();
        
		TypedQuery<Recipe> query = em.createQuery("FROM Recipe as recipe WHERE LOWER(recipe.name) LIKE :searchQuery", Recipe.class);
        query.setParameter("searchQuery", "%"+wordLowerCase+"%");
        List<Recipe> recipes = query.getResultList();

        return recipes;
    }
    
}
