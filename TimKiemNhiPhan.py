def BinarySearch(array, x, low, high):
    while low <= high:
        mid = (low + high) // 2
        if array[mid] == x:
            return mid
        elif array[mid] < x:
            low = mid + 1
        else:
            high = mid - 1
    return -1

array = []
print("Nhap so luong phan tu cua day: ")
n = int(input())
print("Nhap cac phan tu cua day so: ")
for i in range(n):
    s = int(input())
    array.append(s)
print("Nhap so can tim: ")
x = int(input())

result = BinarySearch(array, x, 0, len(array)-1)

if result != -1:
    print("Vi tri cua " + str(x) + " la: " + str(result))
else:
    print("Khong tim thay gia tri can tim.")