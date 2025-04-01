from django.urls import path
from . import views
urlpatterns=[
    
    #path('admin/', admin.site.urls),
    path('',views.index),
    path('hello/<str:username>',views.hello_world)
]