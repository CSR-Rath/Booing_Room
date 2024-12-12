from django.core import validators
from django.db import models
from django.contrib.auth.models import AbstractUser

class Guest(models.Model):
    id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    email = models.EmailField(max_length=100,unique=True)
    phone = models.CharField(max_length=15)
    address = models.CharField(max_length=100)

class Room(models.Model):
    id = models.AutoField(primary_key=True)
    room_name = models.CharField(max_length=100)
    room_type = models.CharField(max_length=100)
    price_per_night = models.FloatField()
    is_available = models.CharField(
        max_length=10,
        choices=[('available', 'Available'), ('occupied', 'Occupied')]
    )

class Reservation(models.Model):
    reservation_id = models.AutoField(primary_key=True)
    guest = models.ForeignKey(Guest, on_delete=models.CASCADE)
    room = models.ForeignKey(Room, on_delete=models.SET_NULL, null=True)
    check_in_date = models.DateField()
    check_out_date = models.DateField()
    total_amount =  models.FloatField()
    status = models.CharField(max_length=20,
                              choices=[('pending', 'pending'),
                                       ('success', 'success'),
                                       ('failed', 'failed')],
                              default='pending')

    # create_at =

class Employee(models.Model):
    employee_id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    position = models.CharField(max_length=50)
    salary = models.DecimalField(max_digits=10, decimal_places=2)

class Service(models.Model):
    service_id = models.AutoField(primary_key=True)
    service_name = models.CharField(max_length=100)
    service_description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)

class Payment(models.Model):
    payment_id = models.AutoField(primary_key=True)
    reservation = models.ForeignKey(Reservation, on_delete=models.CASCADE)
    payment_date = models.DateField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_method = models.CharField(max_length=50)

class Feedback(models.Model):
    feedback_id = models.AutoField(primary_key=True)
    guest = models.ForeignKey(Guest, on_delete=models.CASCADE)
    reservation = models.ForeignKey(Reservation, on_delete=models.CASCADE)
    feedback_date = models.DateField()
    rating = models.IntegerField(validators=[
        validators.MinValueValidator(1),
        validators.MaxValueValidator(5)
    ])
    comments = models.TextField()

class ReservationService(models.Model):
    reservation_service_id = models.AutoField(primary_key=True)
    reservation = models.ForeignKey(Reservation, on_delete=models.CASCADE)
    service = models.ForeignKey(Service, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    total_price = models.DecimalField(max_digits=10, decimal_places=2)

class History(models.Model):
    id = models.AutoField(primary_key=True)
    action_type = models.CharField(max_length=50)
    guest_id = models.ForeignKey(Guest, on_delete=models.CASCADE, null=True)
    room_id = models.ForeignKey(Room, on_delete=models.SET_NULL, null=True)
    reservation = models.ForeignKey(Reservation, on_delete=models.SET_NULL, null=True)
    service_id = models.ForeignKey(Service, on_delete=models.SET_NULL, null=True)
    action_date = models.DateTimeField(auto_now_add=True)
    details = models.TextField()