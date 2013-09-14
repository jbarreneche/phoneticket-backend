ActiveAdmin.register User do

  menu :priority => 2
  actions :index, :show, :edit, :update
  EXCLUDE_COLUMNS = [:encrypted_password, :reset_password_token, :confirmation_token, :auth_token,
    :reset_password_sent_at, :remember_created_at, :last_sign_in_at, :last_sign_in_ip,
    :unconfirmed_email]

  index do
    column :email
    column :document
    column :disabled do |user|
      I18n.t("values.bool.#{!!user.disabled?}", default: !!user.disabled?)
    end
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

  show do |user|
    visible_attributes = (default_attribute_table_rows - EXCLUDE_COLUMNS)
    attributes_table do
      visible_attributes.each do |attr_name|
        if attr_name == :disabled
          row :disabled do
            I18n.t("values.bool.#{!!user.disabled?}", default: !!user.disabled?)
          end
        else
          row attr_name
        end
      end
    end
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
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit user: [:email, :password, :password_confirmation,
        :first_name, :last_name, :date_of_birth, :document,
        :address, :phone_number]
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
