"""
URL configuration for hotel_system project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from myapp import views, room_view

urlpatterns = [
    path('', views.home, name='bookings'),
#========================= Dashboard =========================
    path('dashboard/', views.dashboard, name='dashboard'),
#========================= Guests =========================
    path('room_list/', views.get_room_list, name='room_list'),
    path('create_room/', views.create_room, name='create_room'),
    path('create_room_port/', views.create_room_post, name='create_room'),
#========================= Booking =========================
    path('booking/', views.booking, name='booking'),
    path('create_reservation_post/', views.create_reservation_post, name='create_reservation_post'),
    path('get_reservations_list/', views.get_reservations_list, name='get_reservations_list'),

#========================= Guests =========================
    path('create_guest/', views.guests, name='guests'),
    path('guests_list/', views.get_guests_list, name='guests_list'),
    # path('create_guest_post/', views.create_guest_post, name='create_guest_post'),

    path('create_guest_post/', views.create_guest_post, name='create_guest_post'),

    path('reports/', views.reports, name='reports'),
    path('settings/', views.settings, name='settings'),
    path('login/', views.login, name='login'),
    path('register/', views.register, name='register'),


#========================= history =========================
    path('history/', views.get_history_list, name='history_list'),



]
