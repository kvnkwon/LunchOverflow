class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    post = Post.find(params[:post_id])
    params[:comment][:user_id] = session[:user_id]
    @comment = post.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(comments_params)
      redirect_to comment_path(comment.id)
    else
      render 'edit'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to root_path
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    redirect_to post_path(@comment.post)
  end

  def downvote
   @comment = Comment.find(params[:id])
   @comment.downvote_by current_user
   redirect_to post_path(@comment.post)
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

end
