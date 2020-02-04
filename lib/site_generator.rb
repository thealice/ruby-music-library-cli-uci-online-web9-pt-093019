class SiteGenerator
    attr_reader :path

    def initialize(path)
        @path = path
    end

    def generate_index
        File.write("#{path}/index.html", "w+")
    end
end