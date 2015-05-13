class Consul < FPM::Cookery::Recipe
  name 'consul'

  version '0.5.1'
  revision '2'
  description 'Consul Service Discovery Platform'

  homepage 'https://www.consul.io'
  source "https://dl.bintray.com/mitchellh/consul/#{version}_linux_amd64.zip"
  sha256 '967ad75865b950698833eaf26415ba48d8a22befb5d4e8c77630ad70f251b100'

  maintainer 'Darron Froese <darron@froese.org>'
  vendor 'octohost'

  license 'Mozilla Public License, version 2.0'

  conflicts 'consul'
  replaces 'consul'

  build_depends 'unzip'

  def build
    safesystem "mkdir -p #{builddir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/consul #{builddir}/usr/local/bin/"
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/usr/local/bin/consul #{destdir}/usr/local/bin/consul"
    etc('init').install_p workdir('consul.upstart'), 'consul.conf'
    etc('default').install_p workdir('consul.default'), 'consul'
  end
end
