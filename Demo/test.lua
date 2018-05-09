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

function maxIndexInMatrix(t)
	local key = 1
	local max = t[1][1]

	for k, v in ipairs(t) do
	    if t[k][1] > max then
	        key, max = k, t[k][1]
	    end
	end
	return key
end

dataset = MNISTReader("../data/")

chunckSize = 100
test_labels = dataset:loadLabel(1,chunckSize)
test_images = dataset:loadImages(1,chunckSize,stringImage2table)

nn = NeuralNetwork.deserialize('save/save_nn_1.lua')

count = 0
for i=1,chunckSize do
	local output  = nn:feed(test_images[i])
	local maxIndex = maxIndexInMatrix(output.mtx)
	if MNISTReader.index2label[maxIndex]==test_labels[i] then 
		count = count + 1
	end
end

print(count, count/chunckSize)
