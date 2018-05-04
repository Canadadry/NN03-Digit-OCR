package.path = package.path .. ";../../src/?.lua"
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
	love.graphics.print(self.label,self.x,self.y)
end