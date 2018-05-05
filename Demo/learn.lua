package.path = package.path .. ";../src/?.lua"
package.path = package.path .. ";../lib/?.lua"

require "MNISTReader"
require "NeuralNetwork"

dataset = MNISTReader("../../data/")
train_labels = dataset:loadLabel(1,900)
train_images = dataset:loadImages(1,900)

test_labels = dataset:loadLabel(1,900)
test_images = dataset:loadImages(1,900)

nn = NeuralNetwork(784,1000,10)

local count = 0
for i=1,1000 do
	count = count+1
	nn:train(test_images[i],test_labels[i])
end