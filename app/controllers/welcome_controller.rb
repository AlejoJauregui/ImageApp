class WelcomeController < ApplicationController
  def index

    if user_signed_in?
      @images = Image.order(id: :desc)
                     .where user_id: current_user.id
    end
  end
end
