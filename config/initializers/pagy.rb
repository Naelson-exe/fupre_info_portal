# Pagy initializer file
# frozen_string_literal: true

# When you are done setting up your pagy configuration, remove the following line
# to avoid showing the warning message.
# See https://ddnexus.github.io/pagy/docs/api/pagy#warn-proc
Pagy::DEFAULT[:items] = 10

# Extras
# See https://ddnexus.github.io/pagy/docs/extras
# require 'pagy/extras/bootstrap'
require "pagy/extras/bootstrap"
require "pagy/extras/i18n"

# When you are done setting up your pagy configuration, remove the following line
# to avoid showing the warning message.
# See https://ddnexus.github.io/pagy/docs/api/pagy#warn-proc
Pagy::DEFAULT[:items] = 10
