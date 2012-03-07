class Role < ActiveRecord::Base
  acts_as_authorization_role
end

class User < ActiveRecord::Base
  acts_as_authorization_subject
end

class RolesUser < ActiveRecord::Base
  belongs_to :user  # foreign key - user_id
  belongs_to :role  # foreign key - role_id
end

class Foo < ActiveRecord::Base
  acts_as_authorization_object
end

class Uuid < ActiveRecord::Base
  set_primary_key "uuid"  
  acts_as_authorization_object
end

class Bar < ActiveRecord::Base
  acts_as_authorization_object
end

class AnotherSubject < ActiveRecord::Base
  acts_as_authorization_subject :role_class_name => 'AnotherRole'
end

class AnotherRole < ActiveRecord::Base
  acts_as_authorization_role :subject_class_name => "AnotherSubject"
end

class AnotherRolesAnotherSubject < ActiveRecord::Base
  set_table_name 'another_roles_another_subjects'

  belongs_to :another_subject  # foreign key - another_subject_id
  belongs_to :another_role     # foreign key - another_role_id
end

class FooBar < ActiveRecord::Base
  acts_as_authorization_object :role_class_name => 'AnotherRole', :subject_class_name => "AnotherSubject"
end

class DifferentAssociationNameSubject < ActiveRecord::Base
	acts_as_authorization_subject :association_name => 'roles', :role_class_name => "DifferentAssociationNameRole"
end

class DifferentAssociationNameRole < ActiveRecord::Base
	acts_as_authorization_role :subject_class_name => "DifferentAssociationNameSubject"
end

class DifferentAssociationNameRolesDifferentAssociationNameSubject < ActiveRecord::Base
  set_table_name 'different_association_name_roles_different_association_name_subjects'

  belongs_to :different_association_name_subject  # foreign key - different_association_name_subject_id
  belongs_to :different_association_name_role     # foreign key - different_association_name_role_id
end

module Other

  class Assignment < ActiveRecord::Base
    set_table_name 'other_roles_other_users'

    belongs_to :user  # foreign key - user_id
    belongs_to :role  # foreign key - role_id
  end 

  class Other::OtherRolesOtherUser  < ActiveRecord::Base
    set_table_name "other_roles_other_users"

    belongs_to :user  # foreign key - user_id
    belongs_to :role  # foreign key - role_id    
  end

  class Other::User < ActiveRecord::Base
    set_table_name "other_users"
    acts_as_authorization_subject :join_table_name => "other_roles_other_users", :role_class_name => "Other::Role"
  end

  class Other::Role < ActiveRecord::Base
    set_table_name "other_roles"
    acts_as_authorization_role :join_table_name => "other_roles_other_users", :subject_class_name => "Other::User"
  end

  class Other::FooBar < ActiveRecord::Base
    set_table_name "other_foo_bars"
    acts_as_authorization_object :role_class_name => 'Other::Role', :subject_class_name => "Other::User"
  end

end
