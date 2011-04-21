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
	
end
