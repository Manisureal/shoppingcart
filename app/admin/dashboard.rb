ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }, if: proc{ current_user.admin? }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    tabs do
      tab :orders do
        columns class: "cols-adjust" do
          column do
            panel "RECENT ORDERS", class: "orders" do
              table_for Order.where(status: ["Ordered", "Incomplete"]).order("id desc").limit(10) do
                column("Order#") { |order| link_to(order.id, admin_order_path(order)) }
                column("Ordered Date") { |order| order.created_at }
                column("Updated Date") { |order| (order.updated_at == order.created_at) ? "Not Updated" : order.updated_at }
                column("Status") { |order| status_tag(order.status, class: order.status == "Ordered" ? "error" : "warning") }
                # column("Customer") { |order| link_to(order.user.forname.to_s + ' ' + order.user.surname.to_s, admin_customer_path(order.user)) }
                column("Customer") { |order| link_to(order.company.name.to_s, admin_company_path(order.company)) }
                # require
                column("Total")   { |order| number_to_currency order.total_price }
                column("Take Order") { |order| link_to( icon('check'), admin_order_path(order) + "?take_order=true" ) }
              end
            end
          end
        end

        columns class: "cols-adjust" do
          column do
            panel "MISSING TRACKING NOs" do
              render partial: "tracking_no_form"
            end
          end
        end
      end

      tab :stock_check_in do
        columns class: "cols-adjust" do
          column do
            panel "STOCK CHECK INs" do
              render partial: "stock_checkin_form"
            end
          end
        end
      end

      tab :stocks_levels do
        columns class: "cols-adjust" do
          column do
            panel "STOCK LEVELS" do
              table_for Product.all.where(active: true).each.sort { |x,y| x.current_stock_level <=> y.current_stock_level } do |product|
                column(:product_code) { |product| link_to(product.product_code, admin_product_path(product))}
                column(:description) { |product| link_to(product.description.truncate(42), admin_product_path(product))}
                column(:pack_size)
                column(:price) { |product| number_to_currency product.price}
                column(:current_stock) { |product| label(product.current_stock_level,
                  class: (product.current_stock_level > product.minimum_stock.to_i) ? "status good-level" :
                   (product.current_stock_level == 0 || product.current_stock_level < 0) ? "status bad-level" :
                   (product.current_stock_level.to_i <= product.minimum_stock.to_i) ? "status okay-level" : nil)
                }
                column() { |p| link_to icon('plus'), new_admin_product_stock_path(p) }
              end
            end
          end
        end
      end

      tab :stock_count do
        columns class: "cols-adjust" do
          column do
            panel "STOCK COUNT", id: "stock-panel" do
              render 'date_range_search'
            end
          end
        end
      end

      tab :product_stock_checks do
        columns class: "cols-adjust" do
          column do
            panel "Product Stock Check".upcase do
              # render partial: 'admin/dashboard/product_stock_checks/product_stock_query'
              render partial: "product_stock_query"
            end
          end
        end
      end

      tab :pharmacy_search do
        columns class: "cols-adjust" do
          column do
            panel "FIND A NEARBY PHARMACY" do
              render partial: "pharmacy_search"
            end
          end
          column do
            panel "PHARMACY RESULTS MAP", id: "pharmacy-map" do
              render partial: "pharmacy_search_map"
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

      # tab :reports do
      #   columns class: "cols-adjust" do
      #     column do
      #       panel "TOP SPENDING CUSTOMERS" do
      #         # table_for User.where(admin: false).sort_by{|s|s.orders.count}.reverse.each do |user|
      #         # table_for Company.all.sort_by{|s|s.orders.count}.reverse.each do |company|
      #         #   column(:company) { |company| company.company.name }
      #         #   column(:customer) { |company| (company.forname ? company.forname : 'Unknown') + ' ' + (company.surname ? company.surname : 'User')}
      #         #   column(:email) { |company| link_to(company.email, admin_staff_path(company)) }
      #         #   column(:total_orders) { |company| company.orders.count }
      #         # end
      #         # company_orders_count = Company.all.joins(:orders).group(:company_id).count
      #         # company_orders_count.each_with_index do |value, index|
      #         #   @company_id = value[0]
      #         #   @company_orders_count = value[1]
      #         # end
      #         # table_for Company.all.joins(:orders).distinct(:name).sort_by{|s|s.orders.count}.each do |c|
      #         #   column(:company_name) { |c| c.name }
      #         #   column(:contact) { |c| c.contact_name }
      #         #   column(:email) { |c| c.email }
      #         #   column(:orders_count) { |c| c.orders.count }
      #         # # render partial: 'customer_reports'
      #         # end
      #       end
      #     end
      #   end
      # end
      if current_user.id == 100 || current_user.id == 102 || current_user.id == 105
        tab :sales_staff_reports do
          columns class: "cols-adjust" do
            column do
              panel "SALES STAFF REPORTS" do
                render partial: "sales_staff_query"
              end
            end
          end
        end
      end
    end
  end

  # Custom Dashboard Controller Action/Method
  page_action :stock_search do
    if @date_from = params[:date_from].blank? ? nil : Date.parse(params[:date_from])
      respond_to do |format|
        format.js # actually means: if the client ask for js -> return file.js
      end
    end
  end

  page_action :product_stock_query_search do
    @results = params[:product_stock_query]
    respond_to do |format|
      format.js # actually means: if the client ask for js -> return file.js
    end
  end

  page_action :sales_staff_reports do
    @sales_rep = params[:sales_staff_query]
    @start_date = params[:start_date].blank? ? nil : Date.parse(params[:start_date])
    @end_date = params[:end_date].blank? ? nil : Date.parse(params[:end_date])
    @sales_staff_companies_orders = Order.where("orders.created_at >= ? AND orders.created_at <= ?", @start_date.to_datetime.midnight..@start_date.to_datetime.end_of_day, @end_date.to_datetime.to_time.end_of_day)
                                    .joins(:company).where("companies.account_owner = ?", @sales_rep).page(params[:companies_orders])
                                    .per(30).order("orders.id desc")
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"#{User.find(@sales_rep).forname+"'s"}_Customers_Orders_#{Date.today}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
      format.js # actually means: if the client ask for js -> return file.js
    end
  end

  page_action :pharmacy_search do
    if params[:search].present?
      @pharmacy = Company.near(params[:search], 50)
      @geocode_postcode = Geocoder.search(params[:search])
      @result = @geocode_postcode.first.coordinates
    else
      @pharmacy = Company.all
    end
    respond_to do |format|
      format.js
    end
  end
  # member_actions are only to be created under specific Models as they need to be prepended with an id for a specific model item CRUD action
  # page_action just works on a standalone page such as this dashboard page

end
