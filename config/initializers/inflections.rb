# frozen_string_literal: true

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.singular(/^(t)ies$/i, '\1ie')
end
