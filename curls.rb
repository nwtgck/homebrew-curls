CURLS_VERSION = "20190111-2"

class Curls < Formula
  desc "HTTPS-default curl"
  url "https://github.com/nwtgck/curls/archive/#{CURLS_VERSION}.tar.gz"
  sha256 "70a3eb3722d1db0a862d18ec72eef6e414af579da0efd19e8d62f9dee5d7b4b0"

  # (from: https://github.com/Homebrew/homebrew-core/blob/277f808cfe3e87e771904dfd5c41f22fc45ff773/Formula/curl.rb#L15)
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./buildconf"
    system "./configure", "--without-ssl", "--with-darwinssl", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    # Rename curl to curls
    system "mv", File.join(bin, "curl"), File.join(bin, "curls")
    system "mv", File.join(bin, "curl-config"), File.join(bin, "curls-config")
    # (from: https://github.com/Homebrew/homebrew-core/blob/277f808cfe3e87e771904dfd5c41f22fc45ff773/Formula/curl.rb)
    system "make", "install", "-C", "scripts"
    libexec.install "lib/mk-ca-bundle.pl"
  end

  test do
    system "curls", "--help"
  end
end
