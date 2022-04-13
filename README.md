Unit 8: Group Milestone - README
===
# iEats

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)

## Overview
### Description
Suggests new recipes for users to make based off their tastes. Users can also favorite their favorite recipes and even make their own recipes. App can be used to track all of a users favorite recipes on top of just suggesting.

### App Evaluation
- **Category:** Food
- **Mobile:** This app would be primarily developed for mobile. Functionality will be limited to mobile devices, however it could work on computers.
- **Story:** Analyzes users taste, and suggest recipes they might like to make. The user can then favorite their preferred recipes to not lose track of them.
- **Market:** Any individual that is interested in making their own food and trying new recipes.
- **Habit:** This app could be used as often or unoften as the user wanted depending on whether they are looking for a recipe to make in the moment or to make at a later time.
- **Scope:** First we would start with people that are already into cooking, then we could broaden our scope to people that are wanting to get into cooking. 

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* - [x] User login page design.
* - [ ] User login page logic.
* - [X] Regoster page design
* - [ ] Register page logic
* - [X] Create and Setup Database
* - [x] Suggested recipe page after log in design.
* - [ ] Suggested recipe page after log in logic.
* - [ ] User can favorite recipes.
* - [ ] Suggested recipes are tailored to a user's taste and will not repeat.
* - [ ] Recipe pages for each recipe.
* - [x] Page for favorited recipes design.
* - [ ] Logic for page for favorited recipes.
* - [ ] User can create their own recipe design.
* - [ ] User can create their own recipe logic.

**Optional Nice-to-have Stories**

* Profile page
* Page of most favorited recipes
* User created recipes can become available to other users
* Random recipe suggestion button
* Add comments/review recipe
* Star ranking for recipes
* Search for recipes

### 2. Screen Archetypes

* Login 
* Register - User signs up or logs into their account
   * Upon register users will be asked for their taste to be properly suggested recipes they'll like.
* Suggestion Screen - Displays the recipe page for suggested recipe
   * Will have a navigation bar to access other screens.
* Recipe Screen 
   * Displays all the information for a given recipe.
* Recipes Screen.
   * Will display a picture and name of all recipes in a column the user can scroll through. They can click on a specific recipe to go to its respective screen
* Favorite Recipes Screen
   * Will display all recipes favorited by a user.
* Create a Recipe Screen
   * Will display a form a user can fill in to create their own recipe. Recipes created by users will be automatically favorited, unfavortied recipes will be deleted.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Recipe selection
* Create Recipe

Optional:
* User created recipes
* Random recipe

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available
* Recipe Suggestion -> Navigation bar can go to all other recipes, favorites, or create a recipe
* All recipes -> Display specific recipe. 
* Favorites -> Display specific recipe
* Create a recipe -> After form is filled in goes to favorites

## Wireframes
<img src="/iEats Wireframe.jpg" width=800><br>

## Schema 
### Models
#### Recipe

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the recipe (default field) |
   | title         | String   | Title of recipe |
   | image         | File     | image of recipe |
   | description   | String   | description of recipe |
   | ingredients   | String   | ingredients for recipe |
   | directions    | String   | directions for recipe |
   | category      | String   | category of dish |
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user (default field) |
   | username      | String   | username for user |
   | password      | String   | password for user |
   | prefrences    | String   | list of user prefrences |
   | favorites     | Pointer to Recipe   | favorited recipes |
   
### Networking
#### List of network requests by screen
   - Home Feed Screen
      - (Read/GET) Query suggested recipes
         ```swift
         let query = PFQuery(className:"Recipe")
         query.whereKey("category", equalTo: currentUser.prefrences)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let recipes = recipes {
               print("Successfully retrieved \(recipes.count) recipes.")
           // TODO: Do something with recipes...
            }
         }
         ```
   - All Recipes Screen
     - (Read/GET) Query all recipes
         ```swift
         let query = PFQuery(className:"Recipe")
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let recipes = recipes {
               print("Successfully retrieved \(recipes.count) recipes.")
           // TODO: Do something with recipes...
            }
         }
         ```
  - Specific Recipe Screen
      - (Read/GET) Query specific recipes
         ```swift
         let query = PFQuery(className:"Recipe")
         query.whereKey("id", equalTo: currentRecipe.id)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let recipe = recipe {
               print("Successfully retrieved \(recipe.count) recipe.")
           // TODO: Do something with recipe...
            }
         }
         ```
      
   - Create Recipe Screen
      - (Create/POST) Create a new recipe
   - Favorties Screen
      - (Read/GET) Query logged in user object
      - (Read/GET) Query for recipes that are favorited by user
      - (Delete) Delete user created recipe

## Progress (via Gifs)
### Sprint 1
<img src="Week1.gif">
