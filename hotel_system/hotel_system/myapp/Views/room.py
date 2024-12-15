from rest_framework.decorators import api_view
from rest_framework.response import Response
from myapp.models import Room
from myapp.serializers import RoomSerializer
from rest_framework import status




@api_view(['GET', 'POST'])
def room_list(request):
    if request.method == 'GET':
        is_available = request.query_params.get('is_available', None)

        if is_available:
            rooms = Room.objects.filter(is_available=is_available)
        else:
            rooms = Room.objects.all()

        serializer = RoomSerializer(rooms, many=True)
        return Response(data={
            "response": {
                "status": 200,
                "count": rooms.count(),
                "message": "Room List",
            },
            "results": serializer.data,
        }, status=status.HTTP_200_OK)

    elif request.method == 'POST':
        serializer = RoomSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(data={
                "response": {
                    "status": 201,
                    "message": "Room Created",
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

# Room Views
# @api_view(['GET', 'POST'])
# def room_list(request):
#     if request.method == 'GET':
#         rooms = Room.objects.all()
#         serializer = RoomSerializer(rooms, many=True)
#         return Response(data={
#             "response": {
#                 "status": 200,
#                 "count": rooms.count(),
#                 "message": "Room List",
#             },
#             "results": serializer.data,
#         }, status=status.HTTP_201_CREATED)
#
#
#     elif request.method == 'POST':
#         serializer = RoomSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(data={
#                 "response": {
#                     "status": 200,
#                     "message": "Room created successfully",
#                 },
#                 "results": serializer.data,
#             }, status=status.HTTP_201_CREATED)
#
#         return Response(data={
#             "response": {
#                 "status": 400,
#                 "message": "Room creation failed",
#             },
#             "errors": serializer.errors,
#         }, status=status.HTTP_400_BAD_REQUEST)
#
#

@api_view(['GET', 'PUT', 'DELETE'])
def room_detail(request, id):
    try:
        room = Room.objects.get(id=id)
    except Room.DoesNotExist:
        return Response(data={
            "response": {
                "status": 404,
                "message": "Room not found",
            }
        }, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = RoomSerializer(room)
        # return Response(serializer.data)
        return Response(data={
            "response": {
                "status": 200,
                "message": "Room Found",
            },
            "results": serializer.data,
        }, status=status.HTTP_200_OK)


    elif request.method == 'PUT':
        serializer = RoomSerializer(room, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(data={
                "response": {
                    "status": 200,
                    "message": "Room updated successfully",
                },
                "results": serializer.data,
            }, status=status.HTTP_200_OK)

        return Response(data={
            "response": {
                "status": 400,
                "message": "Room update failed",
            },
            "errors": serializer.errors,
        }, status=status.HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        room.delete()
        return Response(data={
            "response": {
                "status": 202,
                "message": "Room deleted successfully",
            }
        }, status=status.HTTP_204_NO_CONTENT)
