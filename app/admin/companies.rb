ActiveAdmin.register Company do
  permit_params :name, :address, :postcode, :contact_name, :phone, :fax, :email, :xero_id

  filter :name, as: :select, label: "Search by Name", prompt: "Select or Type", collection: Company.all.collect { |c| c.name }, input_html: { class: 'chosen-select2' }
  filter :address, as: :select, label: "Search by Address", prompt: "Select or Type", collection: Company.all.collect { |c| c.address }, input_html: { class: 'chosen-select2' }
  filter :postcode, as: :select, label: "Search by Postcode", prompt: "Select ot Type", collection: Company.all.collect { |c| c.postcode }, input_html: { class: 'chosen-select2' }
  filter :contact_name, as: :select, label: "Search by Contact Name", prompt: "Select or Type", collection: Company.all.collect { |c| c.postcode}, input_html: { class: 'chosen-select2' }
  filter :phone, as: :select, label: "Search by Phone Number", prompt: "Select or Type", collection: Company.all.collect { |c| c.phone }, input_html: { class: 'chosen-select2' }
  filter :email, as: :select, label: "Search by Email", prompt: "Select or Type", collection: Company.all.collect { |c| c.email }, input_html: { class: 'chosen-select2' }

end
