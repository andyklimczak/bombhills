# frozen_string_literal: true

def reload_page
  page.evaluate_script('window.location.reload()')
end
