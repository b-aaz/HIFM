#!/usr/bin/awk -f

# Copyright 2023 B-aaz
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
#  any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

BEGIN {
	# Initializing variables .
	# Number of unclosed tags in the stack .
	numoftags = 0
	# The last records RLENGTH, The RLANGTH is indicating indent level .
	lastRLENGTH = 0
	# If the current tag is a raw text tags and cant have any child nodes .
	hasnochild = 0
	# If the current tag is a void tag and does not need a closing tag .
	noclose = 0
	# If we are currently parsing a comment .
	incomment = 0
}

{
	# This macths any number of tabs at the start of the line, so the
	# RLENGTH will indicate the indent level of each line .
	match($0, /^\t*/)
	# The indent difference between this line and the last one .
	diff = RLENGTH - lastRLENGTH
	# Cutting the indent from this line . We don't need it any more .
	$0 = substr($0, RLENGTH + 1)
	# Checking for a "DOCTYPE" line, it should come before any other tags,
	# have no indents and start with "!!" .
	if (numoftags == 0 && RLENGTH == 0 && $0 ~ /^!!/) {
		# Discarding the first field, the "!!" .
		$1 = ""
		# You will see this more, this forces awk to regenerate the
		# records fields and info about them . It is good practice to
		# do it after overwriting the fields of a record .
		$0 = $0
		print "<!DOCTYPE" $0 ">"
		$0 = ""
	}
	# If we had a tag in the last record .
	# This block will look for its attributes and parse them .
	if (intag) {
		# Attributes should have the same indent level as the tag and
		# should not start with a '.' .
		if (diff == 0 && ! ($0 ~ /^\./)) {
			# This will put the equal sign between the attribute
			# and its value and will put quotes around the argument
			# if it has spaces in it .
			# It will leave boolean attributes alone .
			# TODO : intelligently escape characters and use
			# single/double quotes . 
			if (NF > 2) {
				$2 = $1 "=\"" $2
				$1 = ""
				$NF = $NF "\""
				$0 = $0
			} else if (NF == 2) {
				$2 = $1 "=" $2
				$1 = ""
				$0 = $0
			}
		} else if (diff == 0 && $0 ~ /^\.e /) {
			# HIFM supports comments in the attribute list .
			# We are in one .
			# HTML does not ...
			$0 = ""
			#(So we clear them and do not transfer them to HTML .)
		} else {
			# Closes the tag and clears the "intag" flag .
			print ">\n"
			intag = 0
		}
	}
	# This section handles printing the end tag from the stack .
	if (! intag && numoftags > 0 && tagsind[numoftags - 1] >= RLENGTH) {
		if (! incomment) {
			print "</" tags[numoftags - 1] ">"
		} else {
			print "-->"
			incomment = 0
		}
		# Frees the printed tags .
		delete tags[numoftags - 1]
		delete tagsind[numoftags - 1]
		numoftags--
		hasnochild = 0
	}
	# This section handles parsing and adding the tags to the stack .
	if (! hasnochild && $0 ~ /^\./) {
		# Cuts the '.' at the start of the tag .
		$0 = substr($0, 2)
		# HTML divs are used A LOT so they can be written as a
		# single '.' for convenience .
		if ($1 ~ /^\./) {
			# Cuts the '.' (The short hand for div) and replaces it
			# with "div" .
			$1 = "div" substr($1, 2)
			$0 = $0
		}
		# Comments in HIFM start with ".e" .
		if ($1 == "e") {
			$1 = "!--"
			incomment = 1
		}
		# The raw text tags .
		if ($1 == "style" || $1 == "script" || $1 == "textarea" ||
		    $1 == "title") {
			hasnochild = 1
		}
		# The void tags .
		if ($1 == "area" || $1 == "base" || $1 == "br" ||
		       $1 == "col" || $1 == "embed" || $1 == "hr" ||
		       $1 == "img" || $1 == "input" || $1 == "link" ||
		       $1 == "meta" || $1 == "source" || $1 == "track" ||
		       $1 == "wbr") {
			noclose = 1
		}
		# Comments do not have any attributes . 
		if (! incomment) {
			# This section handles the "class" and "id" attributes
			# .  Because these attributes are used A LOT (Thanks to
			# CSS) they can be appended to the tag line like this:
			# .div.aclass anid
			# This will be transformed to the felowing HTML :
			# <div id=anid class=aclass> 
			
			# If we have an id .
			if (NF == 2) {
				$2 = "id=" $2
			}
			# Checks to see if there is any dots in the tag name .
			if (index($1, ".")) {
				# Replaces all the dots separating the classes
				# with spaces .
				gsub("\\.", " ", $1)
				# Adds a '"' to the end of the list of classes .
				$1 = $1 "\""
				# Regenerates the fields so that we have the
				# tag name on its own at $1 .
				$0 = $0
				$1 = $1 " class=\""
				$0 = $0
			}
		}
		# If the tag is not a void tag save the tag name and indent
		# level to the tags stack .
		if (! noclose) {
			# We have two parallel stacks; the "tags" stack holds
			# the names of the unclosed tags and the "tagsind"
			# stack holds the indent level of the tag .
			tags[numoftags] = $1
			tagsind[numoftags] = RLENGTH
			numoftags++
		} else {
			noclose = 0
		}
		$0 = "<" $0
		# Comments do not have any attributes . So we won't go looking
		# for them .
		if (! incomment) {
			intag = 1
		}
	}
	print $0
	lastRLENGTH = RLENGTH
}

END {
	# If the file ended and we are still in a tag close it .
	if (intag) {
		print ">\n"
	}
	# Printing all the remaining end tags .
	while (numoftags) {
		numoftags--
		print "</" tags[numoftags] ">"
	}
}

