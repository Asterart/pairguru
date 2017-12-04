class CommentsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	# If we want to show top commenters to not logged in user we can use this:
	# before_action :authenticate_user!, except: [:index, :top_commenter]
	before_action :find_movie!, except: [:top_commenter]
	# For task numer 6
	before_action :top_comm, only: [:top_commenter]

	def index
		@comments = @movie.comments
	end

	def create
		@comment = @movie.comments.create(comment_params)
		@comment.user = current_user
		if @comment.save
				flash[:notice] = "Thank you for adding comment"
				redirect_to movie_path(@movie)
		else
			flash[:warning] = "#{@comment.errors.full_messages}"
			redirect_to movie_path(@movie)
		end
	end

	def destroy
		@comment = @movie.comments.find(params[:id])
		if @comment.user_id == current_user.id
			@comment.destroy
			flash[:notice] = "Comment deleted"
			redirect_to movie_path(@movie)
		end
	end

	def top_commenter
		# For task numer 6
	end



	private

		def find_movie!
			@movie = Movie.find(params[:movie_id])
		end

		def comment_params
			params.require(:comment).permit(:body).merge({user_id: current_user.id})
		end


# For task numer 6
		def top_comm
			@commenters = User.all.order('comments.id DESC').joins('LEFT JOIN comments ON 
				comments.user_id == users.id').group('users.id').where('comments.created_at >= ?',
				1.week.ago.utc).limit(10)
		end
end
