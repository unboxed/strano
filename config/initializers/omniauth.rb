Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Strano.github_key, Strano.github_secret, :scope => "user,repo"
  
  ldap_config = YAML.load_file("#{Rails.root}/config/ldap.yml")[Rails.env]
  provider :ldap,
    :title => ldap_config['title'], 
    :host => ldap_config['host'], 
    :port => ldap_config['port'].to_i,
    :method => ldap_config['method'].to_sym,
    :base => ldap_config['base'], 
    :uid => ldap_config['uid'], 
    :bind_dn => ldap_config['bind_dn'], 
    :password => ldap_config['password'] 
end
