quiz = [{"Q1" : "Python is known as :", "options": ["A compiled language", "An interpreted language", "A machine language", "An assembly language"], "answer": "An interpreted language"},
        {"Q2" : "Which version of Python removed the print statement?", "options": ["Python 1.x", "Python 2.x", "Python 3.x", "Python 4.x"], "answer": "Python 3.x"},
        {"Q3" : "Python is a :", "options": ["Low-level language", "High-level language", "Middle-level language", "Machine-level language"], "answer": "High-level language"},
        {"Q4":"Which of these data types does Python not natively support?","options": ["Lists", "Tuples", "Arrays", "Dictionaries"], "answer": "Arrays"},
        {"Q5":"Which of the following is a mutable data type in Python?","options": ["String", "Tuple", "List", "Dictionary"], "answer": "List"}]
       

score = 0

print("Welcome to the quiz!")
print()
print("*"*50)
print()
print("Please answer the following questions:")
print()

for question in quiz:
    q_key = list(question.keys())[0]  
    q_value = question[q_key] 
    options = question["options"]  
    print(f"{q_key}: {q_value}")
    print("Options:", ", ".join(options))  
    print()
    user_answer = input("Enter your answer: ")
    print()
    if user_answer.lower() == question["answer"].lower():
        score += 1
     
        
print("Thank you for taking the quiz!")
print()
print("*"*50)
print(f"Your score is {score} out of {len(quiz)}")