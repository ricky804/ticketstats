module ApplicationHelper
  def ticket_url(ticket)
    "https://support.cdnetworks.com/Ticket/Display.html?id=#{ticket}"
  end

  def badge_important(str)
    # "<span class='badge badge-info'>#{number}</span>".html_safe
    raw("<span class='badge badge-important'>#{str}</span>")
  end

  def badge_info(str)
    raw("<span class='badge badge-info'>#{str}</span>")
  end
end
