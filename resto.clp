; Create templates
(deftemplate Recipe
   (slot name)
   (slot cuisine)
   (slot difficulty)
   (slot ingredients)
   (slot instructions)
)

(deftemplate User
   (slot name)
   (slot cuisine-preference)
   (slot difficulty-preference)
   (slot ingredient-preference)
)

(deftemplate Drink
    (slot name)
    (slot cuisine)
)

(deftemplate Dessert
    (slot name)
    (slot cuisine)
)

(deftemplate AddOn
    (slot name)
    (slot cuisine)
)

; Create Rules

(defrule GetUserPreferences
    (not (User (name ?name)))
    =>
    ; inputs for user
    (printout t "insert your name !")
    (bind ?name (read))
    (printout t "Welcome, " ?name ". Let's find you a recipe!" crlf)
    (printout t "What cuisine do you prefer? ")
    (bind ?cuisine-pref (read))
    (printout t "How difficult should the recipe be? (Easy, Intermediate, Difficult) ")
    (bind ?difficulty-pref (read))
    (printout t "Do you have any specific ingredient preferences? ")
    (bind ?ingredient-pref (read))
    ; create new user fact
    (assert (User 
        (name ?name)
        (difficulty-preference ?difficulty-pref)
        (cuisine-preference ?cuisine-pref)
        (ingredient-preference ?ingredient-pref)
    ))
)

(defrule RecommendRecipe
    (User 
        (name ?name)
        (cuisine-preference ?cuisine-pref)
        (difficulty-preference ?difficulty-pref)
        (ingredient-preference ?ingredient-pref)
    )
    (Recipe 
        (name ?recipe)
        (cuisine ?cuisine)
        (difficulty ?difficulty)
        (ingredients ?ingredients)
    )
    (test (eq ?cuisine ?cuisine-pref))
    (test (eq ?difficulty ?difficulty-pref))
    (test (str-compare ?ingredients ?ingredient-pref))
    =>
    (printout t "Based on your preferences, we recommend: " ?recipe crlf)
    (printout t "Ingredients: " ?ingredients crlf)
    (printout t "Enjoy your meal!" crlf)
    ;(retract (User (name ?name)))
    ;(retract (Recipe (name ?recipe)))
)

(defrule RecommendAddon
    (User 
        (name ?name)
        (cuisine-preference ?cuisine-pref)
    )
    (AddOn 
        (name ?addon)
        (cuisine ?cuisine)
    )
    (test (eq ?cuisine ?cuisine-pref)) ; Mencocokkan jenis minuman dengan preferensi kuliner pengguna
    =>
    (printout t "Based on your preferences, we recommend a " ?addon " AddOn that pairs well with your " ?cuisine " dish." crlf)
)

(defrule RecommendDrink
    (User 
        (name ?name)
        (cuisine-preference ?cuisine-pref)
    )
    (Drink 
        (name ?drink)
        (cuisine ?cuisine)
    )
    (test (eq ?cuisine ?cuisine-pref)) ; Mencocokkan jenis minuman dengan preferensi kuliner pengguna
    =>
    (printout t "Based on your preferences, we recommend a " ?drink " drink that pairs well with your " ?cuisine " dish." crlf)
)

(defrule RecommendDessert
    (User 
        (name ?name)
        (cuisine-preference ?cuisine-pref)
    )
    (Dessert 
        (name ?dessert)
        (cuisine ?cuisine)
    )
    (test (eq ?cuisine ?cuisine-pref)) ; Mencocokkan jenis minuman dengan preferensi kuliner pengguna
    =>
    (printout t "Based on your preferences, we recommend a " ?dessert " Dessert that pairs well with your " ?cuisine " dish." crlf)
)

(defrule ExitRecommendation
   (User (name ?name))
   =>
   (printout t "Thank you for using the personalized recipe recommender, " ?name "!" crlf)
   ;(retract (User (name ?name)))
   ;(exit)
)

; set initial facts

(deffacts SampleRecipes
    (Recipe 
        (name "Pizza Margherita") 
        (cuisine Italian) 
        (difficulty Easy)
        (ingredients "dough, tomato sauce, fresh mozzarella, basil, olive oil") 
        (instructions "1. Roll out the dough. 2. Spread tomato sauce. 3. Add mozzarella and basil. 4. Drizzle olive oil. 5. Bake until golden brown.")
    )

    (Recipe 
        (name "Biryani") 
        (cuisine Indian) 
        (difficulty Intermediate)
        (ingredients "basmati rice, chicken, yogurt, spices") 
        (instructions "1. Marinate chicken. 2. Cook rice. 3. Layer rice and chicken. 4. Dum cook until done.")
    )

    (Recipe 
        (name "Hamburger") 
        (cuisine American) 
        (difficulty Easy)
        (ingredients "ground beef, bun, lettuce, tomato, onion, ketchup, mustard") 
        (instructions "1. Form beef into patties. 2. Grill. 3. Assemble with bun and condiments.")
    )
    (Recipe 
        (name "Spaghetti Carbonara") 
        (cuisine Italian) 
        (difficulty Easy)
        (ingredients "spaghetti, eggs, bacon, Parmesan cheese") 
        (instructions "1. Cook spaghetti. 2. Fry bacon. 3. Mix eggs and cheese. 4. Toss with pasta.")
    )

    (Recipe 
        (name "Chicken Tikka Masala") 
        (cuisine Indian) 
        (difficulty Intermediate)
        (ingredients "chicken, yogurt, tomato sauce, spices") 
        (instructions "1. Marinate chicken. 2. Cook chicken. 3. Simmer in sauce.")
    )

    (Recipe 
        (name "Caesar Salad") 
        (cuisine American) 
        (difficulty Easy)
        (ingredients "romaine lettuce, croutons, Caesar dressing") 
        (instructions "1. Toss lettuce with dressing. 2. Add croutons.")
    )
    (Recipe 
        (name "Sushi Rolls") 
        (cuisine Japanese) 
        (difficulty Intermediate)
        (ingredients "rice, nori, fish, vegetables") 
        (instructions "1. Prepare sushi rice. 2. Lay out nori. 3. Add rice and toppings. 4. Roll and slice.")
    )
    (Recipe 
        (name "Teriyaki Chicken") 
        (cuisine Japanese) 
        (difficulty Easy)
        (ingredients "chicken, soy sauce, sugar, ginger, garlic") 
        (instructions "1. Marinate chicken. 2. Grill or pan-fry. 3. Simmer in teriyaki sauce.")
    )
)

(deffacts SampleDrinks
    (Drink
        (name "Sprite")
        (cuisine Italian)
    )

    (Drink
        (name "Cola")
        (cuisine American)
    )

    (Drink
        (name "Chai Tea")
        (cuisine Indian)
    )
        (Drink
        (name "Espresso")
        (cuisine Italian)
    )

    (Drink
        (name "Iced Tea")
        (cuisine American)
    )

    (Drink
        (name "Lassi")
        (cuisine Indian)
    )
        (Drink
        (name "Green Tea")
        (cuisine Japanese)
    )
    (Drink
        (name "Sake")
        (cuisine Japanese)
    )
)

(deffacts SampleDessert
    (Dessert
        (name "Cheese Cake")
        (cuisine Italian)
    )

    (Dessert
        (name "Ice Cream")
        (cuisine American)
    )

    (Dessert
        (name "Donut")
        (cuisine Indian)
    )
        (Dessert
        (name "Tiramisu")
        (cuisine Italian)
    )

    (Dessert
        (name "Chocolate Brownie")
        (cuisine American)
    )
    (Dessert
        (name "Gulab Jamun")
        (cuisine Indian)
    )
    (Dessert
        (name "Mochi")
        (cuisine Japanese)
    )
    (Dessert
        (name "Dorayaki")
        (cuisine Japanese)
    )
)

(deffacts SampleAddOn
    (AddOn
        (name "Egg Benedict")
        (cuisine Italian)
    )

    (AddOn
        (name "Tuna")
        (cuisine American)
    )

    (AddOn
        (name "Curry")
        (cuisine Indian)
    )
    (AddOn
        (name "Bruschetta")
        (cuisine Italian)
    )

    (AddOn
        (name "Onion Rings")
        (cuisine American)
    )
    (AddOn
        (name "Samosa")
        (cuisine Indian)
    )
        (AddOn
        (name "Edamame")
        (cuisine Japanese)
    )
    (AddOn
        (name "Gyoza")
        (cuisine Japanese)
    )
)