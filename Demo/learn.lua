package.path = package.path .. ";../src/?.lua"
package.path = package.path .. ";../lib/?.lua"

require "MNISTReader"
require "Decode"
require "NeuralNetwork"

function stringImage2table(str)
	local len = #str
	local img ={}
	str:gsub(".", function(c)
		local value = Decode.uint8(c)
		table.insert(img,value)

	end)
	assert(#str == #img)
	return img
end

dataset = MNISTReader("../data/")
train_labels = dataset:loadLabel(1,900)
train_images = dataset:loadImages(1,900)

test_labels = dataset:loadLabel(1,900)
test_images = dataset:loadImages(1,900,stringImage2table)

output = {}
for i=0,9 do
	local out_vec= {}
	for j=1,10 do
		out_vec[j] = 0
	end
	out_vec[i+1] = 1
	output[i] = out_vec
end

print(type(test_images))
print(type(test_images[1]))
print(#test_images[1])
print(type(test_images[1][1]))

nn = NeuralNetwork(784,1000,10)

local count = 0
for i=1,100 do
	count = count+1
	nn:train(test_images[i],output[test_labels[i]])
end