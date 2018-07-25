Rails.application.configure do
  config.before_initialize do
    Rails.application.load_tasks
    Rake::Task['sql_full_group_by:enable'].invoke
  end
end
