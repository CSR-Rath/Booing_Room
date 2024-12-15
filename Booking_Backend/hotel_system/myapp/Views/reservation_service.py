from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from myapp.models import ReservationService
from myapp.serializers import ReservationServiceSerializer


# ReservationService Views
@api_view(['GET', 'POST'])
def reservation_service_list(request):
    if request.method == 'GET':
        reservation_services = ReservationService.objects.all()
        serializer = ReservationServiceSerializer(reservation_services, many=True)
        return Response(serializer.data)
    elif request.method == 'POST':
        serializer = ReservationServiceSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'DELETE'])
def reservation_service_detail(request, id):
    try:
        reservation_service = ReservationService.objects.get(reservation_service_id=id)
    except ReservationService.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = ReservationServiceSerializer(reservation_service)
        return Response(serializer.data)
    elif request.method == 'PUT':
        serializer = ReservationServiceSerializer(reservation_service, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'DELETE':
        reservation_service.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)