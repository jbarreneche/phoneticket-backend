# encoding: UTF-8
ActiveAdmin.register AdminUser do
  index do
    column :email
    column :current_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  show do |user|
    attributes_table *[:id, :email, :sign_in_count, :current_sign_in_at, :created_at, :updated_at]
    active_admin_comments
  end

  form do |f|
    f.inputs "Información del administrador" do
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
end
