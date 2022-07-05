# digiroad-get-latest-publication
This will get latest Digiroad publication from Väylävirasto website

I made this script to ease my daily work.
No need to everyday to go https://ava.vaylapilvi.fi/ava/Tie/Digiroad/Aineistojulkaisut/latest and check if there is latest version to download.

Now, whole thing is automated.

Script can be set to run via crontab often as you like (I set it for daily).

On script first run, script will make files and download the latest version from the website.
After download, it will send email to you (using sSMTP to send emails) about new publication and it would be ready to be fetched from certain server.
After all that is done, it will record the UNIX Timestamp of the file from file header on the website to latest-vayla.txt file to further comparison.

When there is new release, it will be downloaded automatically.

Wanna give some fixes and/or suggestions? Just issue ticket or create pull request :)


HOW TO USE

1. Download the script
2. Change email@example.tld to what ever email you want to get updates
3. Set up sSMTP (or what ever linux based email client. I'm not your boss. But do remember to change how email is sent if you do that. Script was made using sSMTP as email client)
4. Give it +x permission
5. Run it
6. ???
7. Profit
