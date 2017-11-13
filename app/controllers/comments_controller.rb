class CommentsController < ApplicationController
before_action :authenticate_user!
load_and_authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to @post
    else
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
