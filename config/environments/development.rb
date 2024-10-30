# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  setup_general_configuration
  setup_caching
  setup_active_storage
  setup_action_mailer
  setup_deprecation
  setup_active_record
  setup_logging
  setup_assets
end

private

def setup_general_configuration
  # In the development environment, your application's code is reloaded any time it changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true
end

def setup_caching
  if caching_enabled?
    enable_caching
  else
    disable_caching
  end
end

def caching_enabled?
  Rails.root.join('tmp/caching-dev.txt').exist?
end

def enable_caching
  config.action_controller.perform_caching = true
  config.action_controller.enable_fragment_cache_logging = true

  config.cache_store = :memory_store
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{2.days.to_i}"
  }
end

def disable_caching
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
end

def setup_active_storage
  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local
end

def setup_action_mailer
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
end

def setup_deprecation
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []
end

def setup_active_record
  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Highlight code that enqueued background jobs in logs.
  config.active_job.verbose_enqueue_logs = true
end

def setup_logging
  # Suppress logger output for asset requests.
  config.assets.quiet = true
end

def setup_assets
  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Raise error when a before_action's only/except options reference missing actions
  config.action_controller.raise_on_missing_callback_actions = true
end
