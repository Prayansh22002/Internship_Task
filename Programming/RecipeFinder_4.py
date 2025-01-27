"""Internship Task - Python Task #4
Recipe Finder Application
Problem Statement: Create a recipe finder app that lets users:
1. Search Recipes:
○ Type ingredients into an input field and press Enter.
○ Fetch matching recipes stored as an array of objects.
2. Bonus Features:
○ Allow recipe filtering by type (e.g., Lunch, Breakfast) using a dropdown menu."""


recipe_list= [
            {"name": "Pancakes", "ingredients": ["flour", "milk", "egg"], "type": "Breakfast"},
            {"name": "Omelette", "ingredients": ["egg", "cheese", "milk"], "type": "Breakfast"},
            {"name": "Grilled Cheese Sandwich", "ingredients": ["bread", "cheese", "butter"], "type": "Lunch"},
            {"name": "Caesar Salad", "ingredients": ["lettuce", "croutons", "cheese", "dressing"], "type": "Lunch"},
            {"name": "Spaghetti Bolognese", "ingredients": ["spaghetti", "tomato", "meat", "cheese"], "type": "Dinner"},
            {"name": "Chicken Curry", "ingredients": ["chicken", "curry powder", "onion", "tomato"], "type": "Dinner"},
            {"name": "Fruit Smoothie", "ingredients": ["banana", "milk", "honey", "berries"], "type": "Breakfast"},
            {"name": "Veggie Wrap", "ingredients": ["tortilla", "lettuce", "tomato", "avocado"], "type": "Lunch"},
            {"name": "Beef Stew", "ingredients": ["beef", "potato", "carrot", "onion"], "type": "Dinner"},
            {"name": "Chocolate Cake", "ingredients": ["flour", "cocoa", "sugar", "egg"], "type": "Dessert"}
        ]

class Recipe():
    def __init__(self,recipe_list):
        self.recipe_list=recipe_list
        
    def ingredients(self,ing):
        self.ing=set(ing)
        match_ingredients=[recipe for recipe in self.recipe_list if self.ing.issubset(set(recipe['ingredients']))]
        ls=[i for i in match_ingredients]
        print(ls)

    def filter_by(self,choice):
        print('Recipe Name  :  Ingredients_list  : Type')
        for recipe in recipe_list:
            if recipe['type']==choice:
                print(f'{recipe['name']} : {recipe['ingredients']} : {recipe['type']}')


ob=Recipe(recipe_list)
while True:
    ch=int(input('Press 1 for Search Recipe by Ingredients\nPress 2 for filter Recipe by type\nPress 3 for Exit\nEnter your choice : '))
    match ch:
        case 1:
            i=input('Enter Ingredients seperated by commas : ').split(',')
            print(ob.ingredients(i))
        case 2:
            choice=input('Breakfast\nLunch\nDinner\nDessert\nEnter your choice : ')
            ob.filter_by(choice)
        case 3:
            break

    




