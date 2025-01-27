"""Internship Task - Python #3
Task Title : Todo List App
Task Overview:
You will develop a simple todo list application that saves tasks, allowing users to view and manage their tasks. The app will include functionalities for adding new tasks, editing existing tasks, and deleting tasks.
Allow users to:
▪ Add new tasks.
▪ Edit existing tasks.
▪ Remove tasks.
▪ List all task
Store Task Title - ex. Meeting at 9pm
Store Task status - New, In Progress, Completed, Cancelled
When Added the task will be by default in New state"""

task_list=[]
class Todo_list():
    def __init__(self,task_list):
        self.task_list=task_list

    def add_task(self,title):
        self.title=title
        self.task_list.append({'title':self.title,'status':'new'})

    def edit_task(self,id,title,status):
        self.id=id
        self.title=title
        self.status=status
        self.task_list[self.id]['title']=self.title  
        self.task_list[self.id]['status']=self.status

    def update_status(self,id,status):
        self.id=id
        self.status=status
        self.task_list[self.id]['status']=self.status

    def remove(self,id):
        self.id=id
        self.task_list.remove(self.task_list[id])

    def remove_completed(self):
        for task in self.task_list:
            if task['status']=='completed':
                self.task_list.remove(task)

    def display(self):
        for i,task in enumerate(self.task_list):
            print(f'{i} : {task['title']} : {task['status']}')


ob=Todo_list(task_list)
while True:
    ch=int(input('Press 1 for Add new task\nPress 2 for edit existing task\nPress 3 for remove task\nPress 4 for display tasks\nPress 5 for exit\nEnter your choice : '))
    match ch:
        case 1:
            title=input('Enter task title : ')
            ob.add_task(title)
            print('Successfully added........')
        case 2:
            c=int(input('Press 1 for edit whole task\nPress 2 for update status\nEnter your choice : '))
            if c==1:
                id=int(input('Enter task id : '))
                title=input('Enter task title : ')
                status=input('Enter task status : ')
                ob.edit_task(id,title,status)
                print('Successfully edited........')
            else:
                id=int(input('Enter task id : '))
                status=input('Enter task status : ')
                ob.update_status(id,status)
                print('Successfully updated........')
        case 3:
            c=int(input('Press 1 for remove whole task\nPress 2 for remove completed tasks\nEnter your choice : '))
            if c==1:
                id=int(input('Enter task id : '))
                ob.remove(id)
                print('Successfully removed........')
            else:
                ob.remove_completed()
                print('Completed tasks removed........')
        case 4:
            print('Task_id : Title : Status')
            ob.display()
        case 5:
            break