PDFKit.configure do |config|
  config.default_options = { page_size: 'A4', print_media_type: true, quiet: false }  
  
  #wkhtmltopdf
  if RUBY_PLATFORM =~ /linux/
    wkhtmltopdf_executable = 'wkhtmltopdf-amd64'
  elsif RUBY_PLATFORM =~ /darwin/
    wkhtmltopdf_executable = 'wkhtmltopdf-osx'
  else
    raise "Unsupported. Must be running linux or intel-based Mac OS."
  end
  config.wkhtmltopdf = Rails.root.join('vendor','bin', wkhtmltopdf_executable).to_s
  config.root_url = "http://localhost"
  config.verbose = false
  
end