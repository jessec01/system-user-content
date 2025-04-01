from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.
def index(request):
    return HttpResponse('index page')
def hello_world(request,username):
    return HttpResponse("<h2>Hello %s</h2> " % username)