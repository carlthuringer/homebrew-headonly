require 'formula'

class Nupic < Formula
  homepage 'http://numenta.org/nupic.html'

  head 'https://github.com/numenta/nupic.git', :revision => '94a0eefa65f5efcfb00cfa2ea2df954195746467'

  sha1 '9b06fc37f632dfe16024fe35627abbde96b09297'

  version '0.0.2'

  depends_on 'autoconf' => :build
  depends_on :python
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on :x11

  resource 'asteval' do
    url 'https://pypi.python.org/packages/source/a/asteval/asteval-0.9.1.tar.gz'
    sha1 'eb95d0fbe81fc91933f51fd10d3f7b63c2538149'
  end

  resource 'mock' do
    url 'https://pypi.python.org/packages/source/m/mock/mock-1.0.1.tar.gz'
    sha1 'ba2b1d5f84448497e14e25922c5e3293f0a91c7e'
  end

  resource 'ordereddict' do
    url 'https://pypi.python.org/packages/source/o/ordereddict/ordereddict-1.1.tar.gz'
    sha1 'ab90b67dceab55a11b609d253846fa486eb980c4'
  end

  resource 'PIL' do
    url 'http://effbot.org/downloads/Imaging-1.1.7.tar.gz'
    sha1 '76c37504251171fda8da8e63ecb8bc42a69a5c81'
  end

  resource 'psutil' do
    url 'http://psutil.googlecode.com/files/psutil-1.0.1.tar.gz'
    sha1 '3d3abb8b7a5479b7299a8d170ec25179410f24d1'
  end

  resource 'pylint' do
    url 'https://pypi.python.org/packages/source/p/pylint/pylint-0.28.0.tar.gz'
    sha1 '3c1cb9fe252b87b3fcb7c97155911ee6250c18ab'
  end

  resource 'pytest' do
    url 'https://pypi.python.org/packages/source/p/pytest/pytest-2.4.2.tar.gz'
    sha1 'e1a007c007175e425c8f2029be6b4925d64b48c2'
  end

  resource 'pytest-cov' do
    url 'https://pypi.python.org/packages/source/p/pytest-cov/pytest-cov-1.6.tar.gz'
    sha1 '0fea59e8849ee9e502a86cf418431ca89bc12a65'
  end

  resource 'pytest-xdist' do
    url 'https://pypi.python.org/packages/source/p/pytest-xdist/pytest-xdist-1.8.zip'
    sha1 '6f4767bb48fddab6b9bfc8d954493f1477a24707'
  end

  resource 'python-dateutil' do
    url 'https://pypi.python.org/packages/source/p/python-dateutil/python-dateutil-2.1.tar.gz'
    sha1 'f0de3003c346b5fb210b42233d4f71298d23826d'
  end

  resource 'PyYAML' do
    url 'https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.10.tar.gz'
    sha1 '476dcfbcc6f4ebf3c06186229e8e2bd7d7b20e73'
  end

  resource 'unittest2' do
    url 'https://pypi.python.org/packages/source/u/unittest2/unittest2-0.5.1.tar.gz'
    sha1 '2299652dc1c0155d67d6574d9f854de45d36a7ce'
  end

  resource 'validictory' do
    url 'https://pypi.python.org/packages/source/v/validictory/validictory-0.9.1.tar.gz'
    sha1 '317df4b1eb9d2051437913f7086a8480e0bc8ce7'
  end

  resource 'PyMySQL' do
    url 'https://pypi.python.org/packages/source/P/PyMySQL/PyMySQL-0.5.tar.gz'
    sha1 '8d731b1a6101685f4c683f6a815b7fcd83688109'
  end

  resource 'DBUtils' do
    url 'https://pypi.python.org/packages/source/D/DBUtils/DBUtils-1.1.tar.gz'
    sha1 'cb45c9972713767e1ced1ab40da98e58358b470a'
  end

  resource 'numpy' do
    url 'https://pypi.python.org/packages/source/n/numpy/numpy-1.7.1.tar.gz'
    sha1 '11d878214d11a25e05a24f6b27e2b838815a2588'
  end

  resource 'tweepy' do
    url 'https://pypi.python.org/packages/source/t/tweepy/tweepy-2.1.tar.gz'
    sha1 'a29bf2a2a9242ed8eb5fb7dcda921cfc0406cb37'
  end

  def install
    install_args = [ "setup.py", "install", "--prefix=#{prefix}" ]

    inreplace 'build_system/unix/configure.ac' do |s|
      s.gsub!('AC_CHECK_PROG(havepip,pip,yes,no)', '')
      s.gsub!('AM_CONDITIONAL(HAVE_PIP, [test x$havepip = xyes])', '')
      s.gsub!('AM_COND_IF(HAVE_PIP, ,AC_MSG_ERROR([Error: pip is needed for Python dependencies.]))', '')
    end

    inreplace 'bin/run_tests.py' do |s|
      s.gsub!('root = "tests"', %Q{root = "#{prefix}/src/tests"})
    end

    python do
      resource('asteval').stage { system python, *install_args }
      resource('mock').stage { system python, *install_args }
      resource('ordereddict').stage { system python, *install_args }
      resource('PIL').stage { system python, *install_args }
      resource('psutil').stage { system python, *install_args }
      resource('pylint').stage { system python, *install_args }
      resource('pytest').stage { system python, *install_args }
      resource('pytest-cov').stage { system python, *install_args }
      resource('pytest-xdist').stage { system python, *install_args }
      resource('python-dateutil').stage { system python, *install_args }
      resource('PyYAML').stage { system python, *install_args }
      resource('unittest2').stage { system python, *install_args }
      resource('validictory').stage { system python, *install_args }
      resource('PyMySQL').stage { system python, *install_args }
      resource('DBUtils').stage { system python, *install_args }
      resource('numpy').stage { system python, *install_args }
      resource('tweepy').stage { system python, *install_args }

      # Copy the source files from the temporary directory
      src = prefix + 'src'
      src.mkdir
      Dir['**'].each do |file|
        cp_r file, src
      end

      # Build
      system "./cleanbuild.sh #{libexec}/nta/eng"

      # Make bin wrapper scripts for the primary utilities in the framework
      mkdir_p bin
      python_wrapper = Pathname.new(bin/"nupic_python.sh")
      python_wrapper.write <<-EOS.undent
        #!/bin/sh
        export NTA=#{libexec}/nta/eng
        export PYTHONPATH=#{python.site_packages}/:$PYTHONPATH
        export NUPIC=#{prefix}/src
        source $NUPIC/env.sh

        exec python "$@"
      EOS

      wrap('bin/run_swarm.py')
      opf_script = Pathname.new(bin/'nupic_run_opf.sh')
      opf_script.write <<-EOS.undent
        #!/bin/sh
        exec "#{bin}/nupic_python.sh" "#{libexec}/nta/eng/share/opf/bin/OpfRunExperiment.py" $@
      EOS
    end
  end

  test do
    system "nupic_python.sh #{prefix}/src/bin/run_tests.py"
  end

  def wrap(bin_file_name)
    # copy the py file to libexec/bin
    # make a new bin/filename.sh
    mkdir_p libexec/'bin'
    cp bin_file_name, libexec/'bin/'

    bin_file = Pathname.new bin_file_name
    wrapped_bin_shell = Pathname.new bin/"nupic_#{bin_file.basename('py')}sh"
    wrapped_bin_shell.write <<-EOS.undent
      #!/bin/sh

      exec "#{bin}/nupic_python.sh" "#{libexec}/#{bin_file}" "$@"
    EOS
  end
end
