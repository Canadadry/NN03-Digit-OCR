package.path = package.path .. ";../lib/?.lua"

require 'Decode'

MNISTReader = class()


local       images_filename = 't10k-images.idx3-ubyte'
local       labels_filename = 't10k-labels.idx1-ubyte'
local train_images_filename = 'train-images.idx3-ubyte'
local train_labels_filename = 'train-labels.idx1-ubyte'

function MNISTReader:init(folder)
	      self.images_file  = assert(io.open(folder ..       images_filename,'rb'))
	      self.labels_file  = assert(io.open(folder ..       labels_filename,'rb'))
	self.train_images_file  = assert(io.open(folder .. train_images_filename,'rb'))
	self.train_labels_file  = assert(io.open(folder .. train_labels_filename,'rb'))
end

function MNISTReader:fromDataSet()
	self.mode = 'dataset'
end

function MNISTReader:fromDataTrain()
	self.mode = 'datatrain'
end

function MNISTReader:loadImages(start, count)

end

function MNISTReader:loadLabel(start, count)
	file = self.mode == 'dataset' and self.labels_file or self.train_labels_file
	local magicNumber = Decode.uint32(file:read(4))
	local numberOfLabel = Decode.uint32(file:read(4))
	assert(start+count < numberOfLabel,'out of bound');
	local header_size_byte = 8; 
	file:seek('set',header_size_byte+start)
	data = file:read(count)
	ret = {}
	for i=1,count do
		table.insert(ret,Decode.uint8(data,i-1))
	end
	return ret
end

