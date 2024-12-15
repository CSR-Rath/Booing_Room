from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from myapp.models import Reservation
from myapp.serializers import ReservationSerializer

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

@api_view(['GET', 'POST'])
def reservation_list(request):
    if request.method == 'GET':
        reservations = Reservation.objects.all()
        reservations.reverse()
        serializer = ReservationSerializer(reservations, many=True)
        return Response(data={
            "response": {
                "status": 200,
                "message": "Reservation List",
            },
            "results": serializer.data,
        }, status=status.HTTP_200_OK)

    elif request.method == 'POST':
        serializer = ReservationSerializer(data=request.data)
        if serializer.is_valid():
            # Save the reservation first
            reservation = serializer.save()

            # Update the room status to "occupied"
            room = reservation.room
            if room and room.is_available == 'available':
                room.is_available = 'occupied'
                room.save()

            return Response(data={
                "response": {
                    "status": 201,
                    "message": "Reservation Created",
                },
                "results": serializer.data,
            }, status=status.HTTP_201_CREATED)

        return Response(data={
            "response": {
                "status": 400,
                "message": "Invalid Data",
            },
            "results": serializer.errors,
        }, status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET', 'PUT', 'DELETE'])
def reservation_detail(request, id):
    try:
        reservation = Reservation.objects.get(reservation_id=id)
    except Reservation.DoesNotExist:
        return Response(data={
            "response": {
                "status": 404,
                "message": "Reservation Not Found",
            },
        }, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = ReservationSerializer(reservation)
        return Response(data={
            "response": {
                "status": 200,
                "message": "Reservation Details",
            },
            "results": serializer.data,
        }, status=status.HTTP_200_OK)

    elif request.method == 'PUT':
        serializer = ReservationSerializer(reservation, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(data={
                "response": {
                    "status": 200,
                    "message": "Reservation Updated",
                },
                "results": serializer.data,
            }, status=status.HTTP_200_OK)
        return Response(data={
            "response": {
                "status": 400,
                "message": "Invalid Data",
            },
            "results": serializer.errors,
        }, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        reservation.delete()
        return Response(data={
            "response": {
                "status": 204,
                "message": "Reservation Deleted",
            },
        }, status=status.HTTP_204_NO_CONTENT)
