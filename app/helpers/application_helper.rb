module ApplicationHelper

	def title
		#Return a Base title on a per page basis
		base_title= "Ruby on rails Sample app"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	
	def logo
		"#{image_tag("logo.png", :alt=>"Sample App", :class=>"round")}"
	end
	
end
