class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, except: [:index]
  helper_method :sort_column, :sort_direction

  respond_to :html

  def index
    @contacts = Contact.filter(filter_params).order(sort_column+" "+sort_direction).paginate(:per_page=>15,:page=>params[:page])
    respond_with(@contacts)
  end

  def show
    respond_with(@contact)
  end

  def new
    @contact = Contact.new
    respond_with(@contact)
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save
    respond_with(@contact)
  end

  def update
    @contact.update(contact_params)
    respond_with(@contact)
  end

  def destroy
    @contact.destroy
    respond_with(@contact)
  end

  private    
    
    def filter_params
      params.slice(:site_id,:contact_person,:email_address,:phone_number)
    end
    
    def sort_column
      params[:sort] || "site_id"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end
    
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:site_id, :contact_person, :phone_number, :email_address)
    end
end
