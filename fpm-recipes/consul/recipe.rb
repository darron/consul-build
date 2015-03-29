class Consul < FPM::Cookery::Recipe
  name 'consul'

  version '0.5.1-dev'
  revision '1'
  description 'Consul Service Discovery Platform'

  homepage 'https://www.consul.io'
  source 'http://shared.froese.org/2015/consul-0.5.1-dev.tgz'
  sha256 '83fa3a539dc67dc1e46dd729e038527db72cdcb28517beb1f264e5b782fb9a69'

  maintainer 'Darron Froese <darron@froese.org'
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
