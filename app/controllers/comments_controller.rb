# frozen_string_literal: true
class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.json
  def create
    post = Post.find(comment_params['post_id'])
    body = comment_params['body']

    @comment = Comment.build_from(post, current_user.id, body)

    if @comment.save
      render json: @comment, include: :user
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :body)
  end
end
