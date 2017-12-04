class TitleBracketsValidator

	# const variable for making things easier
	SEPARATORS = ['{}', '[]', '()']

	def initialize(arg)
	end

	def validate(arg)
		@value = arg
		@valid = true

		SEPARATORS.each do |check|
			#call another method for checking 
			unless valid(check)
				@valid = false
				@value.errors.add(:title)
			end
		end

	end

	def valid(brackets)
		return false if @value.title.include?(brackets) #check if there are any empty brackets
		return false unless all_brackets_closed(brackets) #check if all brackets are closed after being opened ect
		true #otherwise valid is true
	end


	#checking titles for having paired brackets and if they are opened and closed correctly
	def all_brackets_closed(brackets)
		#create temporary object with as many sentences as many opening brackets we have in title
		temp = "#{@value.title}".split(brackets.first)
		temp.each_with_index do |batch, index| 
			results = batch.include?(brackets.last)
			unless (index.zero? ? !results : results)
				return false
			end
		end
		#create temporary object with as many sentences as many closing brackets we have in title
		temp2 = "#{@value.title} ".split(brackets.last)
		temp2.each_with_index do |batch, index|
			results = batch.include?(brackets.first)
			unless ((index == temp2.size - 1) ? !results : results)
				return false
			end
		end
		true
	end

end