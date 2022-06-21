class Main
    def run()
        files = Dir['_posts/zmediumtomarkdown/*.md']
        files.each do |file|
            
            lines = File.readlines(file)
            newLines = []

            isFoundFirstIMG = false
            lines.each do |line|
                if line.include? "延伸閱讀" or line.include? "本文同步發表於" or line.include? "Like Z Realm" or line.include? "有任何問題及指教歡迎與我聯絡。" or line.include? "View original post on Medium"
                    id = file.split("-").last.split(".").first
                    newLines.append("\r\n\r\n===\r\n\r\n 本文首次發表於 Medium ➡️ [**前往查看**](https://medium.com/p/#{id}){:target="_blank"}\r\n")
                    break
                end

                matchImage = line[/(\!\[){1}.*(\]\(){1}([^\"]*)(\".*\")*\){1}/,3]
                if isFoundFirstIMG == false and !matchImage.nil?
                    matchImage = matchImage.strip
                    newLines.insert(3, "image:\r\n")
                    newLines.insert(4, "  path: #{matchImage}\r\n")

                    isFoundFirstIMG = true
                end

                newLines.append(line)
            end

            File.open(file, 'w') { |f| f.write(newLines.join) }

            puts "#{file} Optimze Done!"
        end

        puts "Optimze Markdown Footer Success!"
    end
end

main = Main.new()
main.run()