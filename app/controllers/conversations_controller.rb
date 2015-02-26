class ConversationsController < ApplicationController
  before_action :get_mailbox
  before_action :get_box,only: [:index]
  before_action :get_conversation, except: [:index, :empty_trash]
  
  def index  
   @conversations=@mailbox.send(@box).paginate(page: params[:page],per_page: 10)
  end
  
  def show
    
  end
  
  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to conversation_path(@conversation)
  end
  
  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end
 
  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end
  
  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end
  
  def mark_as_read
    @conversation.mark_as_read(current_user)
    flash[:success] = 'The conversation was marked as read.'
    redirect_to conversations_path
  end
  private
    def get_mailbox
      @mailbox||=current_user.mailbox
    end
    
    def get_box
      if params[:box].blank? || !["inbox","sentbox","trash"].include?(params[:box])
        params[:box]='inbox'
      end
      @box=params[:box]
    end
    
    def get_conversation
      @conversation||=@mailbox.conversations.find(params[:id])
    end
end
