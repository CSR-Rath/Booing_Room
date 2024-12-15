from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from myapp.models import History
from myapp.serializers import HistorySerializer


@api_view(['GET', 'POST'])
def history_list(request):
    if request.method == 'GET':
        histories = History.objects.all().order_by('id')
        serializer = HistorySerializer(histories, many=True)
        return Response(serializer.data)
    elif request.method == 'POST':
        serializer = HistorySerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'DELETE'])
def history_detail(request, id):
    try:
        history = History.objects.get(id=id)
    except History.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = HistorySerializer(history)
        return Response(serializer.data)
    elif request.method == 'PUT':
        serializer = HistorySerializer(history, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    elif request.method == 'DELETE':
        history.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)