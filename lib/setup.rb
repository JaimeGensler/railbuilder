# require './lib/assets.rb'
require './lib/writer.rb'

class SetupWizard
    # include Assets
    include Writer

    def initialize(input)
        @project_name = input[:project_name].downcase.strip.gsub(/\s+/,"_").gsub(/\W/, "")
        @project_gems = make_array(input[:gems])
        @project_tables = make_array(input[:tables])
    end
    def run
        Dir.chdir("..")
        make_rails
        Dir.chdir("./#{@project_name}")
        setup_gems
        setup_tables
        setup_git
        system "atom ."
    end

    private

    def make_rails
        system("rails new #{@project_name} -d postgresql -T")
    end

    def setup_gems
        build_gemfile(@project_gems)
        system "bundle"
        system "bundle exec rails generate rspec:install"
    end

    def db_init
        system("rake db:create")
    end

    def setup_tables
        @project_models.each do |model|
            system("rails g migration create_#{model}")
            File.write("./app/models/#{model}.rb", make_model(model))
        end
    end

    def setup_specs
        File.write("./spec/rails_helper.rb", make_helper())
        @project_models.each do |model|
            File.write("./spec/#{model}_spec.rb", make_spec(model))
        end
    end

    def make_array(str)
        na = ["na", "none", "nothing", "nil", "n", "a"]
        list = str.downcase.strip.split(/[\/, ]+/).uniq
        list.reject { |word| (na.any? { |nul| /\A#{nul}\z/i.match? word}) }
    end

end
