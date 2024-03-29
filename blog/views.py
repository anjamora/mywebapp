from django.shortcuts import render

posts = [
    {
        'author': 'Anthony Jamora',
        'title': 'Blog Post 1',
        'content': 'First post content',
        'date_posted': 'August 27, 2022'
    },
    {
        'author': 'Sara Ushiku',
        'title': 'Blog Post 2',
        'content': 'Second post content',
        'date_posted': 'August 28, 2022'
    }
]


def home(request):
    context = {
        'posts': posts
    }
    return render(request, 'blog/home.html', context)


def about(request):
    return render(request, 'blog/about.html', {'title': 'About'})