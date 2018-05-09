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

output = {}
for num=0,9 do
	local out_vec= {}
	for i=1,10 do
		out_vec[i] = 0
	end
	out_vec[MNISTReader.label2index[num]] = 1
	output[num] = out_vec
end

nn = NeuralNetwork(784,1000,10)

local chunckSize = 300
local numberOfChunck = 1
for i=1,numberOfChunck do		
	local start_ = (i-1)*chunckSize + 1
	local end_   = start_ + chunckSize - 1

	for j=1,chunckSize do
		train_labels = dataset:loadLabel(start_,end_)
		train_images = dataset:loadImages(start_,end_,stringImage2table)
		nn:train(train_images[j],output[train_labels[j]])
	end
	nn:serialize('save/save_nn_'.. i .. '.lua')
	print("chunck " .. i )
end