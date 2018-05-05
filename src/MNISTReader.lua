package.path = package.path .. ";../lib/?.lua"

require 'Decode'
require 'Class'

MNISTReader = class()

function hex_dump (str)
    local len = string.len( str )
    local dump = ""
    local hex = ""
    local asc = ""
    
    for i = 1, len do
        if 1 == i % 8 then
            dump = dump .. hex .. asc .. "\n"
            hex = string.format( "%04x: ", i - 1 )
            asc = ""
        end
        
        local ord = string.byte( str, i )
        hex = hex .. string.format( "%02x ", ord )
        if ord >= 32 and ord <= 126 then
            asc = asc .. string.char( ord )
        else
            asc = asc .. "."
        end
    end

    
    return dump .. hex .. string.rep( "   ", 8 - len % 8 ) .. asc
end

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
	file = self.mode == 'dataset' and self.images_file or self.train_images_file
	local magicNumber     = Decode.uint32(file:read(4))
	local numberOfImage   = Decode.uint32(file:read(4))
	print("image count : ".. numberOfImage)
	local numberOfRows    = Decode.uint32(file:read(4))
	local numberOfColumns = Decode.uint32(file:read(4))
	assert(start+count < numberOfImage,'out of bound')
	local header_size_byte = 16; 
	file:seek('set',header_size_byte+start)
	data = file:read(count*numberOfRows*numberOfRows)
	ret = {}
	for i=1,count do
		local sub = data:sub((i-1)*numberOfRows*numberOfRows,(i)*numberOfRows*numberOfRows)
		table.insert(ret,sub)
	end
	return ret
end

function MNISTReader:loadLabel(start, count)
	file = self.mode == 'dataset' and self.labels_file or self.train_labels_file
	local magicNumber = Decode.uint32(file:read(4))
	local numberOfLabel = Decode.uint32(file:read(4))
	print("label count : ".. numberOfLabel)
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

