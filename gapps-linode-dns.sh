#!/bin/sh
####
# Copyright (c) 2012 Tim Heckman <timothy.heckman@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify, 
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to the following 
# conditions:
#
# The above copyright notice and this permission notice shall be included in all copies 
# or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# **** IMPORTANT PLEASE READ THE FOLLOWING SECTION ****
# This script is not written by, nor maintained by, Linode.  Nor is it affiliated 
# with Linode directly in any way.  Do not contact Linode to report any issues or 
# file any bug reports regarding this script.
# **** IMPORTANT PLEASE READ THE PREVIOUS SECTION ****
####

MX_RECORDS=(
	"ASPMX.L.GOOGLE.COM"
	"ALT1.ASPMX.L.GOOGLE.COM"
	"ALT2.ASPMX.L.GOOGLE.COM"
	"ASPMX2.GOOGLEMAIL.COM"
	"ASPMX3.GOOGLEMAIL.COM"
)

MX_PRIORITY=(
	"10"
	"20"
	"20"
	"30"
	"30"
)

ARRLEN=`expr ${#MX_RECORDS[@]} - 1`

/bin/echo "####################"
/bin/echo "#  Google Apps MX  #"
/bin/echo "# Records Creation #"
/bin/echo "#      Script      #"
/bin/echo "####################"
/bin/echo

/bin/echo "This script requres you to enter your API key as well as provide the DomainID."
/bin/echo "If you are unsure of the DomainID this script will provide a URL you can view in"
/bin/echo "your browser to find your DomainID."
/bin/echo

/bin/echo -n "Enter API key: "
read API_KEY
/bin/echo

/bin/echo -n "Do you know your DomainID [y/n]: "
read KNOW_ID
/bin/echo

if [ "$KNOW_ID" == "n" -o "$KNOW_ID" == "N" ]; then
	/bin/echo "Please visit the following URL in your web browser to obtain your DomainID:"
	/bin/echo "- https://api.linode.com/?api_key=$API_KEY&api_responseformat=human&api_action=domain.list"
	/bin/echo
fi

/bin/echo -n "Enter your DomainID: "
read DOMAIN_ID
/bin/echo

for ((i=0; i <= ARRLEN; i++))
do
	API_URL="https://api.linode.com/\
?api_key=$API_KEY\
&api_action=domain.resource.create\
&domainid=$DOMAIN_ID\
&type=MX\
&target=${MX_RECORDS[i]}\
&priority=${MX_PRIORITY[i]}"
		curl "$API_URL"
		/bin/echo
done

/bin/echo
/bin/echo "Should be finished at this point (assuming no errors were generated from API calls)!"
/bin/echo "Please verify the created records within the Linode DNS Manager."
/bin/echo "<3 heckman"
exit 0