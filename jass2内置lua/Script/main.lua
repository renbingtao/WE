
require 'utility'
require 'conver_jass'
uni       = require 'unicode'
converter = require 'converter'
parser    = require 'parser'


common=io.load("jass\\common.j")
blizzard=io.load("jass\\blizzard.j")
cast=parser(common, 'common.j',   nil)
bast=parser(blizzard, 'blizzard.j',cast)

function jass2lua(name,jass)
	return converter(parser(jass,name,bast))
end
