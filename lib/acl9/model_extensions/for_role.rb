module Acl9
  module ModelExtensions
    module ForRole
      def expired?
        if self.respond_to?(:expires_at)
          expires_at = self.send(:expires_at)
          if expires_at && expires_at <= Time.now
            return true
          end
        end
        false
      end
    end
  end
end
