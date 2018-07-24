module ApplicationHelper
  def custom_title(title="") 
    basic_title = "Notebook"
    if title.empty?
      basic_title
    else
      title + " | " + basic_title
    end
  end
end
