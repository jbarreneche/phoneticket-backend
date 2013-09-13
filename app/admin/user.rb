ActiveAdmin.register User do

  menu :priority => 2
  actions :index, :show, :edit, :update
  EXCLUDE_COLUMNS = [:encrypted_password, :reset_password_token, :confirmation_token, :auth_token]

  index do
    column :email
    column :disabled
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :confirmed_at
    actions do |user|
      links = raw('')
      links << link_to('Habilitar', enable_admin_user_path(user), method: :put) if user.disabled?
      links << link_to('Inhabilitar', disable_admin_user_path(user), method: :put) unless user.disabled?
      links
    end
  end

  filter :email
  filter :disabled

  show do |ad|
    attributes_table *(default_attribute_table_rows - EXCLUDE_COLUMNS)
    active_admin_comments
  end

  form do |f|
    f.inputs "User details" do
      f.input :first_name
      f.input :last_name
      f.input :phone_number
      f.input :date_of_birth
      f.input :document
      f.input :address
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
      redirect_to :back, notice: I18n.t("admin.user.disabled")
    else
      redirect_to :back, error: user.errors.full_messages
    end
  end


  member_action :enable, :method => :put do
    user = User.find(params[:id])
    if user.enable!
      redirect_to :back, notice: I18n.t("admin.user.enabled")
    else
      redirect_to :back, error: user.errors.full_messages
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
