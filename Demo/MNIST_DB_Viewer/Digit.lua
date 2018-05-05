package.path = package.path .. ";../../lib/?.lua"
require "Class"


Digit = class()


function Digit:init(label,image,x,y,size)
	self.label = label
	self.image = image
	self.x     = x
	self.y     = y
	self.size  = size
end

function Digit:draw()
	if self.image then love.graphics.draw( self.image, self.x, self.y) end
	love.graphics.print(self.label,self.x,self.y)
end