# frozen_string_literal: true
class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.json
  def create
    resource = nil
    if(comment_params['commentable_type'] == 'post')
      resource = Post.find(comment_params['commentable_id'])
    elsif(comment_params['commentable_type'] == 'spot')
      resource = Spot.find(comment_params['commentable_id'])
    end

    body = comment_params['body']

    @comment = Comment.build_from(resource, current_user.id, body)

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
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end
