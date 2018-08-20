module ActiveAdmin
  module Views
    class Footer < Component

      def build(namespace)
        super :id => "footer"
        super :style => "font-size:1.5em;color:#696969;"

        div do
          # small "Created with love at Caremeds - #{Date.today.year}"
        end
      end

    end
  end
end
