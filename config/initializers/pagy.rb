require 'pagy/extras/overflow'
require 'pagy/extras/i18n'

# default :empty_page (other options :last_page and :exception )
Pagy::VARS[:overflow] = :last_page