module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      begin
        token = request.params[:token]
        if (current_user = User.where(token: token).first)
          current_user
        else
          reject_unauthorized_connection
        end
      rescue => e
        p e
        reject_unauthorized_connection
      end
    end
  end
end
