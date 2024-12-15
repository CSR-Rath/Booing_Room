
from django.contrib import admin
from django.urls import path
# from rest_framework_simplejwt.views import TokenObtainPairView

from myapp import views, room_view
from myapp.Views.employee import employee_list, employee_detail
from myapp.Views.feedback import feedback_list, feedback_detail
from myapp.Views.guest import guest_list, guest_detail

# urlpatterns = [
#     path('', views.home, name='bookings'),
# #========================= Dashboard =========================
#     path('dashboard', views.dashboard, name='dashboard'),
# #========================= Guests =========================
#     path('room_list', views.get_room_list, name='room_list'),
#     path('create_room', views.create_room, name='create_room'),
#     path('create_room_port', views.create_room_post, name='create_room'),
# #========================= Booking =========================
#     path('booking', views.booking, name='booking'),
#     path('create_reservation_post', views.create_reservation_post, name='create_reservation_post'),
#     path('get_reservations_list', views.get_reservations_list, name='get_reservations_list'),
#
# #========================= Guests =========================
#     path('create_guest', views.guests, name='guests'),
#     path('guests_list', views.get_guests_list, name='guests_list'),
#     path('create_guest_post', views.create_guest_post, name='create_guest_post'),
#
#     path('reports', views.reports, name='reports'),
#     path('settings', views.settings, name='settings'),
#     path('login', views.login, name='login'),
#     path('register', views.register, name='register'),
#     path('history/', views.get_history_list, name='history_list'),
#
# #========================= API =========================
#
#
#     path('api/guests/', guest_list, name='guest_list'),  # GET and POST for guests
#     path('api/guests/<int:id>/', guest_detail, name='guest_detail'),  # GET, PUT, DELETE for specific guest
#
#
# ]

# myapp/urls.py
from django.urls import path

from myapp.Views.history import history_list, history_detail
from myapp.Views.payment import payment_list, payment_detail
from myapp.Views.reservation import reservation_list, reservation_detail
from myapp.Views.reservation_service import reservation_service_list, reservation_service_detail
from myapp.Views.room import room_list, room_detail
from myapp.Views.service import service_list, service_detail



urlpatterns = [
    # path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),

    # Guest URLs
    path('api/geusts', guest_list, name='guest_list'),
    path('api/geusts/<int:id>', guest_detail, name='guest_detail'),

    # Room URLs
    path('api/rooms', room_list, name='room_list'),
    path('api/rooms/<int:id>', room_detail, name='room_detail'),

    # path('api/room-types', room_type_list, name='room_type_list'),
    # path('api/room-types/<int:id>', room_type_detail, name='room_type_detail'),

    # Reservation URLs
    path('api/reservations', reservation_list, name='reservation_list'),
    path('api/reservations/<int:id>', reservation_detail, name='reservation_detail'),

    # Employee URLs
    path('api/employees', employee_list, name='employee_list'),
    path('api/employees/<int:id>', employee_detail, name='employee_detail'),

    # Service URLs
    path('api/services', service_list, name='service_list'),
    path('api/services/<int:id>', service_detail, name='service_detail'),

    # Payment URLs
    path('api/payments', payment_list, name='payment_list'),
    path('api/payments/<int:id>', payment_detail, name='payment_detail'),

    # Feedback URLs
    path('api/feedbacks', feedback_list, name='feedback_list'),
    path('api/feedbacks/<int:id>', feedback_detail, name='feedback_detail'),

    # ReservationService URLs
    path('api/reservation-services', reservation_service_list, name='reservation_service_list'),
    path('api/reservation-services/<int:id>', reservation_service_detail, name='reservation_service_detail'),

    # History URLs
    path('api/histories', history_list, name='history_list'),
    path('api/histories/<int:id>', history_detail, name='history_detail'),
]