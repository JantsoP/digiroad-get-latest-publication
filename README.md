# digiroad-get-latest-publication
This will get latest Digiroad publication from Väylävirasto website

I made this script to ease my daily work.
No need to everyday to go https://aineistot.vayla.fi/digiroad/latest/ and check if there is latest version to download.

Now, whole thing is automated.

Script can be set to run via crontab often as you like (I set it for daily).

On script first run, script will make files and download the latest version from the website.
After download, it will send email to you (using sSMTP to send emails) about new publication and it would be ready to be fetched from certain server.
After all that is done, it will record the UNIX Timestamp of the file to latest-vayla.txt file to further comparison.

When there is new release, it will be downloaded automatically.

Wanna give some fixes and/or suggestions? Just issue ticket or create pull request :)
