class GemSemver::VersionUpdater 
  attr_accessor :update_type, :output, :gem_name, :version_file_path, :version_file, :current_version, :current_major_version,  :current_minor_version, :current_patch_version, :new_version

  def initialize(type:)
    @update_type = type ? type.downcase : nil
    @output = []
    @gem_name = Dir.pwd.split('/').last
    @version_file_path = File.join(Dir.pwd, "lib/#{gem_name}/version.rb")
    validate_input
    print_output
  end

  def validate_input
    @output << "Whoops! Something went wrong"
    if !update_type
      @output << "Make sure you pass an argument: (bump minor)"
    elsif !["major", "minor", "patch"].include?(update_type)
      @output << "Make sure to specify the type of update (major | minor | patch)"
      @output << "Run one of these: bump major | bump minor | bump patch"
    elsif !File.exist?(version_file_path)
      @output << "Current directory doesn't have a version.rb file at: "
      @output << "#{Dir.pwd}/lib/#{gem_name}/version.rb"
      @output << "Make sure you're in the root directory of your gem and that the"
      @output << "lib/#{gem_name}/version.rb file exists."
    elsif !File.exist?(File.join(Dir.pwd, "Gemfile.lock"))
      @output << "Current directory doesn't have a Gemfile.lock in it"
      @output << "Make sure you're in the root directory of your gem and that the"
      @output << "Gemfile.lock file exists (fill in the required fields in your"
      @output << "gemspec and run bundle install to create it)."
    else
      @output.pop
      update_version
    end
  end

  def update_version
    capture_version_number
    if update_type == "major"
      @current_major_version = (current_major_version.to_i + 1).to_s
      @current_minor_version = "0"
      @current_patch_version = "0"
      @output << "Major version change:"
    elsif update_type == "minor"
      @current_minor_version = (current_minor_version.to_i + 1).to_s
      @current_patch_version = "0"
      @output << "Minor version change:"
    elsif update_type == "patch"
      @current_patch_version = (current_patch_version.to_i + 1).to_s
      @output << "Patch version change:"
    end
    @new_version = [current_major_version, current_minor_version, current_patch_version].join('.')
    @output << "Current version: #{new_version}"
    update_version_file
    update_gemfile_lock
  end

  def capture_version_number
    @version_file = File.open(version_file_path)
    content = @version_file.read
    @current_version = content.scan(/['"]([^"]*)['"]/)[0][0]
    @current_major_version, @current_minor_version, @current_patch_version = @current_version.split('.')
    @version_file.close
  end

  def update_version_file 
    tmp = Tempfile.new("new_version") 
    File.foreach(@version_file) do |line|
      tmp << line.gsub(current_version, new_version)
    end
    tmp.close
    FileUtils.rm(["#{version_file.path}.bak"]) if File.exist?("#{version_file.path}.bak")
    FileUtils.cp(version_file.path, "#{version_file.path}.bak")
    FileUtils.mv(tmp, version_file.path)
  end

  def update_gemfile_lock
    tmp = Tempfile.new("new_gemfile_lock")
    gemfile_lock = File.open(File.join(Dir.pwd, "Gemfile.lock"))
    File.foreach(gemfile_lock) do |line|
      tmp << line.gsub("#{gem_name} (#{current_version})", "#{gem_name} (#{new_version})")
    end
    tmp.close
    FileUtils.rm(["#{gemfile_lock.path}.bak"]) if File.exist?("#{gemfile_lock.path}.bak")
    FileUtils.cp(gemfile_lock.path, "#{gemfile_lock.path}.bak")
    FileUtils.mv(tmp, gemfile_lock.path)
  end

  def print_output
    output.each { |m| puts m }
  end


end