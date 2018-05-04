package.path = package.path .. ";../../src/?.lua"

require "Digit"
require "MNISTReader"

function love.load(arg)
	dataset = MNISTReader("../../data/")
	labels = dataset:loadLabel(1,300)
	digits = {}
	size = 40
	local count = 1
	for i=1,love.graphics.getWidth(),size do		
		for j=1,love.graphics.getHeight(),size do
			table.insert(digits,Digit(labels[count],nil,i,j,size))
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

