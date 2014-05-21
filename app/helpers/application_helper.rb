module ApplicationHelper
  def page_is?(page)
    return false unless page._?.to_s.is_a?(String)
    @controller_name, @action_name = *page.to_s.split('/')
    return (params[:controller] == @controller_name && params[:action] == @action_name) if @action_name
    return (params[:controller] == @controller_name)
  end

  def parse_sort_param(*args)
    _, desc, field = *params[:sort]._?.match(/^(-)?([a-z_]+(?:\.[a-z_]+)?)$/)

    if field
      hash = args.extract_options!
      db_sort_field = (hash[field] || hash[field.to_sym] || (field if field.in?(args) || field.to_sym.in?(args))).to_s

      unless db_sort_field.blank?
        if db_sort_field == field && field.match(/\./)
          fields = field.split(".", 2)
          db_sort_field = "#{fields[0].pluralize}.#{fields[1]}"
        end
        @sort_field = field
        @sort_direction = desc ? "desc" : "asc"

        "#{db_sort_field} #{@sort_direction}"
      end
    end
  end
end
