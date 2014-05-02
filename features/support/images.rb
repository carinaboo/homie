module ImageHelpers
	def image_path(size)
		case size
		when "small"
			File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "fixtures", "house.jpg"))
		else
			raise "don't know where to find a #{size} image"
		end
	end
end

World(ImageHelpers)	