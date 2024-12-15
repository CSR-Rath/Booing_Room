# myapp/views_api.py
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from myapp.models import Guest
from myapp.serializers import GuestSerializer

@api_view(['GET', 'POST'])
def guest_list(request):
    if request.method == 'GET':
        guests = Guest.objects.all()
        serializer = GuestSerializer(guests, many=True)
        return Response(data={
            "response": {
                "status": 201,
                "message": "Guest created successfully",
            },
            "results": serializer.data,
        }, status=status.HTTP_201_CREATED)


    elif request.method == 'POST':
        serializer = GuestSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(data={
                "response": {
                    "status": 201,
                    "message": "Guest created successfully",
                },
                "results": serializer.data,
            }, status=status.HTTP_201_CREATED)

        return Response(data={
            "response": {
                "status": 400,
                "message": "Guest creation failed",
            },
            "errors": serializer.errors,
        }, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'DELETE'])
def guest_detail(request, id):
    try:
        guest = Guest.objects.get(id=id)
    except Guest.DoesNotExist:
        return Response(data={
            "response": {
                "status": 404,
                "message": "Guest not found",
            }
        }, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = GuestSerializer(guest)
        # return Response(serializer.data)

        return Response(data={
                "response": {
                    "status": 200,
                    "message": "Guest Detail",
                },
                "results": serializer.data,
            }, status=status.HTTP_200_OK)

    elif request.method == 'PUT':
        serializer = GuestSerializer(guest, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(data={
                "response": {
                    "status": 200,
                    "message": "Guest updated successfully",
                },
                "results": serializer.data,
            }, status=status.HTTP_200_OK)

        return Response(data={
            "response": {
                "status": 400,
                "message": "Guest update failed",
            },
            "errors": serializer.errors,
        }, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        guest.delete()
        return Response(data={
            "response": {
                "status": 204,
                "message": "Guest deleted successfully",
            }
        }, status=status.HTTP_204_NO_CONTENT)