ActiveAdmin.register_page "Sales Dashboard" do
  menu if: proc{current_user.sales?}
  breadcrumb { false }


  content do
    tabs do
      tab :customers do
        columns class: "cols-adjust" do
          column do
            panel "MY CUSTOMERS", class: "orders" do
              render partial: "sales_customers"
            end
          end
        end
      end

      tab :orders do
        columns class: "cols-adjust" do
          column do
            panel "CUSTOMER ORDERS" do
              render partial: "sales_customers_orders"
            end
          end
        end
      end

      # tab :customers do
      #   columns class: "cols-adjust" do
      #     column do
      #       panel "RECENT CUSTOMERS" do
      #         table_for User.where(admin: false).order("id desc").limit(10).each do |user|

      #           column(:customer_name) { |user| (user.forname ? user.forname : 'Unknown') + ' ' + (user.surname ? user.surname : 'User')}

      #           column(:customer_email) { |user| link_to(user.email, admin_staff_path(user)) }
      #           column(:last_signed) { |user| user.last_sign_in_at }
      #         end
      #       end
      #     end
      #   end
      # end
    end
  end
end
