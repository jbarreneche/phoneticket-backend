ActiveAdmin.register User do

  menu :priority => 2

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :confirmed_at
    column do |user|
      # default_actions
      link_to('Suspender', lock_admin_user_path(user))
    end
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "User details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit admin_user: [:email, :password, :password_confirmation]
    end
  end

  member_action :lock, :method => :put do
    user = User.find(params[:id])
    redirect_to({:action => :show}, {:notice => "Locked!"})
  end

  action_item only: [:show] do
    link_to('Suspender', lock_admin_user_path(user))
  end
end
