action :create do
    certificate = @new_resource.certificate
    key = @new_resource.key
    common_name = @new_resource.name

    directory ::File.dirname(certificate) do
        action :create
    end

    directory ::File.dirname(key) do
        action :create
    end

    unless ::File.exist?(certificate)
        execute "generate certificate" do
          command "openssl genrsa -passout pass:#{node["certs"]["password"]} -des3 -out #{key} 1024"
        end

        execute "generate signature request" do
          command <<-EOH
                openssl req -passin pass:#{node["certs"]["password"]} -subj "/C=#{node["certs"]["dn"]["country"]}/ST=#{node["certs"]["dn"]["state"]}/L=#{node["certs"]["dn"]["city"]}/O=#{node["certs"]["dn"]["organisation"]}/OU=#{node["certs"]["dn"]["department"]}/CN=#{common_name}/emailAddress=#{node["certs"]["dn"]["email"]}" -new -key #{key} -out temp.csr
                EOH
        end

        execute "sign key" do
          command <<-EOH
                cp #{key} #{key}.org
                openssl rsa -passin pass:#{node["certs"]["password"]} -in #{key}.org -out #{key}
                EOH
        end

        execute "signing the certificate" do
          command "openssl x509 -req -days 365 -in temp.csr -signkey #{key} -out #{certificate}"
        end

        file "#{key}.org" do
            action :delete
        end

        file "temp.csr" do
            action :delete
        end
    end
end
