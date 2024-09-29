class GdbMultiarch < Formula
  desc "The GNU Debugger with multi-architecture support"
  homepage "https://www.gnu.org/software/gdb/"
  url "https://ftp.gnu.org/gnu/gdb/gdb-15.1.tar.xz"
  sha256 "38254eacd4572134bca9c5a5aa4d4ca564cbbd30c369d881f733fb6b903354f2"

  depends_on "pkg-config" => :build
  depends_on "python@3.11"
  depends_on "gettext"
  depends_on "gmp"
  depends_on "mpfr"
  depends_on "libmpc"
  depends_on "isl"
  depends_on "zlib"
  
  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-targets=all",  # Enable multi-architecture support
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    # Rename the gdb binary to gdb-multiarch to avoid conflict
    mv bin/"gdb", bin/"gdb-multiarch"
    mv bin/"gdb-add-index", bin/"gdb-add-index-multiarch"
    mv include/"gdb", include/"gdb-multiarch" if Dir.exist?(include/"gdb")
    mv share/"gdb", share/"gdb-multiarch" if Dir.exist?(share/"gdb")
  end

  test do
    system "#{bin}/gdb"-multiarch, "--version"
  end
end