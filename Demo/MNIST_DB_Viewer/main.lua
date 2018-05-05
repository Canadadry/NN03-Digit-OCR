package.path = package.path .. ";../../src/?.lua"

require "Digit"
require "MNISTReader"

function love.load(arg)
	dataset = MNISTReader("../../data/")
	labels = dataset:loadLabel(1,300)
	images = dataset:loadImages(1,300)
	digits = {}
	size = 40
	local count = 1
	for i=1,love.graphics.getWidth(),size do		
		for j=1,love.graphics.getHeight(),size do
			local img = stringToImage(images[count],28,28) 
			table.insert(digits,Digit(labels[count],img,i,j,size))
			count = count+1
		end
	end 
end

function love.update(dt)
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

end

function love.draw(dt)
	for i,v in ipairs(digits) do
		v:draw()
	end
end


function stringToImage(str,width,height)
	width  = width  or 28
	height = height or 28

	local img =  love.image.newImageData( width, height )
	img:mapPixel(function (x, y, r, g, b, a)
		local pos = x + y * width
		print(str)
		print(Decode.uint8(str,pos))
		return Decode.uint8(str,pos), 0,0,1
	end)

	return  love.graphics.newImage( img )
end

