officialUrl="https://releases.mozilla.org/pub/firefox/releases/"
officialPage=$(wget -qO- "$officialUrl")
version=$(echo $officialPage | grep -oE ">[0-9][0-9.]*[a-z]*[0-9]*" | sed 's/>//g')

stableVersion=$(echo "$version" | grep -vE "[a-z]" | sort -gr | head -n 1)
betaVersion=$(echo "$version" | grep -E "[a-z]" | sort -gr | head -n 1)

fileName="firefox-$stableVersion.tar.bz2"
downloadLink="$officialUrl$stableVersion/linux-x86_64/en-US/$fileName"

if [ ! -f $fileName ];
then
    wget -O $fileName $downloadLink
fi
sudo rm /usr/lib/firefox -rf
sudo rm /usr/lib/firefox-addons -rf
sudo rm /usr/bin/firefox -f
sudo tar xvjf $fileName -C /usr/lib
sudo ln -s /usr/lib/firefox/firefox /usr/bin/firefox
