
from django.shortcuts import render, redirect

from myapp.models import Room, Reservation, History, Guest


#========================= Home =========================
def home(request):
    # Your home page view
    return render(request, 'index.html')

#========================= Dashboard =========================
def dashboard(request):
    # Your home page view

    rooms = Room.objects.all()
    guests = Guest.objects.all()
    reservations = Reservation.objects.all()
    occupied_rooms = rooms.filter(is_available='occupied').count()
    available_rooms = rooms.filter(is_available='available').count()

    context = {
        'rooms': rooms,
        'guests': guests,
        'occupied_rooms': occupied_rooms,
        'available_rooms': available_rooms,
        'reservations': reservations,
    }
    return render(request, 'dashboard/dashboard.html',context)


#========================= Room =========================

def get_room_list(request):

    rooms = Room.objects.all()
    context = {
        'rooms': rooms
    }
    return render(request, 'room/room_list.html', context)

def create_room_post(request):
    print('create_room_post')

    if request.method == 'POST':

        room_number = request.POST['room_number']
        room_type = request.POST['room_type']
        price_per_night = request.POST['price_per_night']

        room = Room.objects.create(
            room_number=room_number,
            room_type=room_type,
            price_per_night=price_per_night,
            is_available= 'available'
        )
        room.save()

    return redirect('/create_room/')


def create_room(request):

    return render(request, 'room/create_room.html')


def booking(request):

    guest = Guest.objects.all()
    rooms = Room.objects.all()
    context = {
        'guests': guest,
        'rooms': rooms
    }
    print("rooms == > ", rooms )
    print("guest == > ", guest)


    # Your home page view
    return render(request, 'booking/booking.html', context)
    # return render(request, 'booking/booking.html')


#========================= Booking =========================
def reports(request):
    # Your home page view
    return render(request, 'reports/reports.html')

def create_reservation_post(request):
    guest_id = request.POST['guest']
    room_id = request.POST['room']
    check_in_date = request.POST['check_in_date']
    check_out_date = request.POST['check_out_date']

    guest = Guest.objects.get(id=guest_id)
    room = Room.objects.get(id=room_id)
    reservation = Reservation.objects.create(
        guest=guest,
        room=room,
        check_in_date=check_in_date,
        check_out_date=check_out_date,
        total_amount=room.price_per_night,
        status='padding'
    )

    # Update room availability
    room.is_available = 'occupied'
    room.save()

    return redirect('/booking/')



def get_reservations_list(request):

    reservations = Reservation.objects.all()
    context = {
        'reservations': reservations
    }
    return render(request, 'booking/reservation_list.html', context)




def settings(request):
    # Your home page view
    return render(request, 'settings/setting.html')

#========================= Room =========================
def login(request):
    # Your home page view
    return render(request, 'loging_register/login.html')

def register(request):
    # Your home page view
    return render(request, 'loging_register/register.html')

#========================= Room =========================



#========================= Guests =========================
def guests(request):
    # Your home page view
    return render(request, 'guests/guests.html')

def get_guests_list(request):

    guest = Guest.objects.all()

    print(guest.count())
    context = {
        'guests': guest
    }
    return render(request, 'guests/guests_list.html', context)


def create_guest_post(request):
    print("create_guest_post")

    if request.method == 'POST':
        # Retrieve the form data from the request
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        email = request.POST['email']
        phone = request.POST['phone']
        address = request.POST['address']
        # gender = request.POST['gender']

        # Create a new Guest object and save it to the database
        guest = Guest.objects.create(
            first_name=first_name,
            last_name=last_name,
            # gender = request.POST['gender'],
            email=email,
            phone=phone,
            address=address
        )
        guest.save()

        # Redirect the user to a success page or the guest list page
    return redirect('/create_guest/')


def get_history_list(request):

    histories = History.objects.all().order_by('action_date')
    context = {
        'histories': histories
    }
    return render(request, 'reports/reports.html', context)





