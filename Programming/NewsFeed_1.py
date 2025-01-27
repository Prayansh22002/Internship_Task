"""Internship Task - Python Task #2
Task Title: Build a Dynamic News Feed with Pagination
Overview - In this task, you will develop a simple news feed application where users can add news title, description, news image path and save it.
Application should display option / menu to add news feed and list existing news feed.
> Select your choice
1. Add news details
2. List news
3. Exit app
After option 1 section app should ask
Enter News Title
Enter News details
Enter Photo path or url
On Selection of option 2 App should display all news added"""

news_list=[
        {"title": "Python 3.12 Released", "details": "Python 3.12 includes many new features and optimizations.", "photo_path": "https://exe.com/python312.jpg"},
        {"title": "AI Breakthrough", "details": "A new AI model can generate music with lyrics.", "photo_path": "https://example.com/ai-music.jpg"},
        {"title": "SpaceX Launch", "details": "SpaceX successfully launched 60 new satellites.", "photo_path": "https://example.com/spacex.jpg"}
        ]

class News_feed():
    def __init__(self,news_list):
        self.news_list=news_list

    def add_news(self,title,details,photo_path):
        self.title=title
        self.details=details
        self.photo_path=photo_path
        news_list.append({'title':self.title,'details':self.details,'photo_path':self.photo_path})

    def display(self):
        print('News title         :          News Details         :           Image')
        for i in news_list:
            print(f'{i['title']} : {i['details']} : {i['photo_path']}')

ob=News_feed(news_list)
while True:
# 1. Add news details
# 2. List news
# 3. Exit app
    ch=int(input('Press 1 for Add News\nPress 2 for List News\nPress 3 for Exit App\nEnter your choice : '))
    match ch:
        case 1:
            title=input('Enter news title : ')
            details=input('Enter news details : ')
            photo_path=input('Enter photo path or url : ')
            ob.add_news(title,details,photo_path)
            print('Successfully Added..........')
        case 2:
            ob.display()
        case 3:
            break

