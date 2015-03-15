class Consul < FPM::Cookery::Recipe
  name 'consul'

  version '0.5.0'
  revision '1'
  description 'Consul Service Discovery Platform'

  homepage 'https://www.consul.io'
  source "https://dl.bintray.com/mitchellh/consul/#{version}_linux_amd64.zip"
  sha256 '161f2a8803e31550bd92a00e95a3a517aa949714c19d3124c46e56cfdc97b088'

  maintainer 'Darron Froese <darron@froese.org'
  vendor 'octohost'

  license 'Mozilla Public License, version 2.0'

  conflicts 'consul'
  replaces 'consul'

  build_depends 'unzip'

  def build
    safesystem "mkdir -p #{builddir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/#{version}_linux_amd64/consul #{builddir}/usr/local/bin/"
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/usr/local/bin/consul #{destdir}/usr/local/bin/consul"
    etc('init').install_p workdir('consul.upstart'), 'consul.conf'
    etc('default').install_p workdir('consul.default'), 'consul'
  end
end
