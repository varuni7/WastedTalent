import cv2
from PIL import Image
# Python program to explain os.listdir() method 


# Load image that the tourist wants to find similar 
img = Image.open('test.jpg')


# Convert image to grayscale
gray_img = img.convert('L')


	
# test image
image = cv2.imread('test.jpg')	
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
histogram = cv2.calcHist([gray_image], [0],
						None, [256], [0, 256])

# data1 image
image = cv2.imread('painting1.jpeg')
gray_image1 = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
histogram1 = cv2.calcHist([gray_image1], [0],
						None, [256], [0, 256])

# data2 image
image = cv2.imread('painting2.jpeg')
gray_image2 = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
histogram2 = cv2.calcHist([gray_image2], [0],
						None, [256], [0, 256])


c1, c2 = 0, 0

# Euclidean Distance between data1 and test
i = 0
while i<len(histogram) and i<len(histogram1):
	c1+=(histogram[i]-histogram1[i])**2
	i+= 1
c1 = c1**(1 / 2)


# Euclidean Distance between both the datasets and test
i = 0
while i<len(histogram) and i<len(histogram2):
	c2+=(histogram[i]-histogram2[i])**2
	i+= 1
c2 = c2**(1 / 2)

if(c1<c2):
	print("painting1.jpg is more similar to test.jpg as compare to painting2.jpg")
else:
	print("painting1.jpg is more similar to test.jpg as compare to painting2.jpg")
