class PostsController < ApplicationController
  before_action :find_post, only: [:show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # Index action to render all posts
  def index
    ordered_posts = Post.order(cached_votes_up: :desc)
    @posts = ordered_posts.paginate(:page => params[:page], :per_page => 30)
  end

  # New action for creating post
  def new
    @post = Post.new
  end

  # Create action saves the post into database
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save(post_params)
      flash[:notice] = "Successfully created post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  # The show action renders the individual post after retrieving the the id
  def show
  end

  # The destroy action removes the post permanently from the database
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to posts_path
    else
      flash[:alert] = "Error updating post!"
    end
  end
  
  def upvote 
    @post = Post.find(params[:id])
    @post.upvote_by current_user
    redirect_to :back
  end
  
  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title, :link)
  end

  def find_post
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound  
      redirect_to :posts
      return
    end
  end
end
