module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "EliteBox"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Returns a value in a human friendly unit
  def human_readable(value)
    in_bytes = { "T" => 1099511627776,
                 "G" => 1073741824,
                 "M" => 1048576,
                 "K" => 1024 }

    unit = 'B'
    in_bytes.detect do |u, b|
      if value >= b
        unit = u
        value /= b
      end
    end

    value = value.round(1)
    value.to_s << unit
  end

  def comment
  end
end
