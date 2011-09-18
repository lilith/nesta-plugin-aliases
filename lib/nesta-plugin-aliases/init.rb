module Nesta
  module Plugin
    module Aliases
      module Helpers
        # If your plugin needs any helper methods, add them here...
      end
    end
  end

  class App
    helpers Nesta::Plugin::Aliases::Helpers
  end
end
