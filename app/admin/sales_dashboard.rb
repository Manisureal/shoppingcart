ActiveAdmin.register_page "Sales Dashboard" do
  menu if: proc{current_user.sales?}, label: proc{current_user.forname.to_s + "'s" + " " + "Dashboard"}
  breadcrumb { false }


  content title: proc{current_user.forname.to_s + "'s" + " " + "Dashboard"} do
    tabs do
      tab :customers do
        columns class: "cols-adjust" do
          column do
            panel "MY CUSTOMERS" do
              render partial: "sales_customers"
            end
          end
        end
      end

      tab :orders do
        columns class: "cols-adjust" do
          column do
            panel "CUSTOMER ORDERS" do
              render partial: "sales_customers_orders_search"
            end
          end
        end
      end
    end
  end

  page_action :orders_search do
    # if @date_from = params[:date_from].blank? ? nil : DateTime.parse(params[:date_from]) and
    #    @date_to = params[:date_to].blank? ? nil : DateTime.parse(params[:date_to])
    @date_from = DateTime.parse(params[:date_from])
    @date_to = DateTime.parse(params[:date_to])
    @companies_orders = Order.where("orders.created_at >= ? AND orders.created_at <= ?", @date_from.to_datetime.midnight..@date_from.to_datetime.end_of_day, @date_to.to_datetime.to_time.end_of_day).joins(:company).where("companies.account_owner = ?", current_user.id.to_s).page(params[:companies_orders]).per(15)
    respond_to do |format|
      format.js # actually means: if the client ask for js -> return file.js
      format.csv {
        headers['Content-Disposition'] = "attachment; filename=\"companies_orders_#{Date.today}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      }
    end
  end
end
