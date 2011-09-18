module Nesta
  module Plugin
    module Aliases
      module Helpers
        # Add a before filter to perform any redirects requested by individual pages
        before do
          this_url = AliasTable.normalize(request.fullpath)
          table = AliasTable.all()
          if table.has?(this_url)
            redirect table[this_url], 301 # Always do permanent redirects
          end
        end
      end
      
      class AliasTable
        
        # Cache the redirects table in a static variable
        def self.all
          if  @@all.nil?
            @@all = AliasTable.build_alias_table
          end
          return @all
        end
        
        def self.build_alias_table
          table = {}
          Page.find_all().each do |p| 
            p.aliases.each  do |url| 
              table[AliasTable.normalize(url)] = p.abspath
            end
          end
        end
        
        def self.normalize(url)
          return url.gsub("+"," ").downcase #TODO: Normalize url encoding
        end
      end
    end
  end

  class App
    helpers Nesta::Plugin::Aliases::Helpers
  end
  
  class Page
  
    def aliases
      if metatdata('aliases')
        return metadata('aliases').split(/\s+/) # Aliases are separated by whitespaces. Use '+' to represent a space in a URL.
      else
        return []
      end
    end
  end
  
  
end
