# frozen_string_literal: true
class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!, except: [:create, :destroy]
  before_action :require_permission, except: [:create]

  # POST /comments
  # POST /comments.json
  def create
    resource = Comment.find_commentable(comment_params['commentable_type'], comment_params['commentable_id'])
    body = comment_params['body']
    @comment = Comment.build_from(resource, current_user.id, body)
    if @comment.save
      render json: @comment, include: { user: { methods: :avatar_url } }
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end

  def require_permission
    super(@comment)
  end
end
