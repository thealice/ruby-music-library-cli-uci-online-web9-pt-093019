class SiteGenerator
    attr_reader :path

    def initialize(path)
        @path = path
        FileUtils.mkdir_p path
    end

    def generate_index
        html = <<-HTML
            <h1>Welcome to the Ruby Music Site</h1>

            <ul>
                <li><a href="artists/index.html">Artists - #{Artist.all.size}</a></li>
                <li><a href="genres/index.html">Genres - #{Genre.all.size}</a></li>
                <li><a href="songs/index.html">Songs - #{Song.all.size}</a></li>
            </ul>
        HTML
        File.write("#{path}/index.html", html)
    end

    def call
        generate_index
    end
end