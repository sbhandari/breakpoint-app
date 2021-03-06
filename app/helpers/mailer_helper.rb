module MailerHelper
  def formatted_changes(changes)
    content_tag :ul do
      changes.map do |attribute, values|
        content_tag :li do
          old_value = '-'
          new_value = '-'
          if values[0].respond_to?(:utc) || values[1].respond_to?(:utc)
            old_value = l(values[0], :format => :long) if values[0].present?
            new_value = l(values[1], :format => :long) if values[1].present?
          else
            old_value = values[0] if values[0].present?
            new_value = values[1] if values[1].present?
          end
          "<strong>#{attribute.titleize}</strong> changed <strong>from</strong> #{old_value} <strong>to</strong> #{new_value}".html_safe
        end
      end.join.html_safe
    end
  end
end

