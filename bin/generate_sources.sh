fd '.optimus' | entr -s 'mvn generate-sources -DskipTests && osascript -e \"display notification 'Sources rebuilt!!!'\"'

