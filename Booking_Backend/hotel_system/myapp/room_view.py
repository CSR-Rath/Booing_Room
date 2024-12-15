
# from django.shortcuts import render, redirect, get_object_or_404
# from .models import Room, RoomType, Amenity, RoomAmenity
#
# def room_list(request):
#     rooms = Room.objects.all()
#     context = {
#         'rooms': rooms
#     }
#     return render(request, 'Rooms/room_list.html', context)
#
# def room_detail(request, room_number):
#     room = get_object_or_404(Room, room_number=room_number)
#     amenities = RoomAmenity.objects.filter(room=room)
#     context = {
#         'room': room,
#         'amenities': amenities
#     }
#     return render(request, 'Rooms/room_detail.html', context)

# def room_create(request):
#     if request.method == 'POST':
#         # Handle room creation logic
#         return redirect('room_list')
#     room_types = RoomType.objects.all()
#     amenities = Amenity.objects.all()
#     context = {
#         'room_types': room_types,
#         'amenities': amenities
#     }
#     return render(request, 'Rooms/room_form.html', context)

# def room_update(request, room_number):
#     room = get_object_or_404(Room, room_number=room_number)
#     if request.method == 'POST':
#         # Handle room update logic
#         return redirect('room_detail', room_number=room.room_number)
#     room_types = RoomType.objects.all()
#     amenities = Amenity.objects.all()
#     context = {
#         'room': room,
#         'room_types': room_types,
#         'amenities': amenities
#     }
#     return render(request, 'Rooms/room_form.html', context)
#
# def room_delete(request, room_number):
#     room = get_object_or_404(Room, room_number=room_number)
#     if request.method == 'POST':
#         # Handle room deletion logic
#         room.delete()
#         return redirect('room_list')
#     context = {
#         'room': room
#     }
#     return render(request, 'Rooms/room_confirm_delete.html', context)