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
      if user.disabled?
        link_to('Habilitar', enable_admin_user_path(user), method: :put)
      else
        link_to('Inhabilitar', disable_admin_user_path(user), method: :put)
      end
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
      params.permit user: [:email, :password, :password_confirmation]
    end
  end

  member_action :disable, :method => :put do
    user = User.find(params[:id])
    if user.disable!
      redirect_to({action: :show}, notice: I18n.t("admin.user.disabled"))
    else
      redirect_to({action: :show}, error: user.errors.full_messages)
    end
  end


  member_action :enable, :method => :put do
    user = User.find(params[:id])
    if user.enable!
      redirect_to({action: :show}, notice: I18n.t("admin.user.enabled"))
    else
      redirect_to({action: :show}, error: user.errors.full_messages)
    end
  end

  action_item only: [:show] do
    if user.disabled?
      link_to('Habilitar', enable_admin_user_path(user), method: :put)
    else
      link_to('Inhabilitar', disable_admin_user_path(user), method: :put)
    end
  end

end
