--[[	BLIZZARD IF YOU'RE READING THIS I'M BEGGING FOR YOUR HELP.
		Please let me fetch either player level from the given guid (will also help BadBoy_Levels)
		or let me fetch if the player is in a guild or not from the given guid (spammers never guilded)
		or both!

		I can then, 1) Skip scanning all chat from non-guilded WoW players, 2) skip scanning all chat from
		players above level 10, this would near enough eliminate any chance of false positives.
]]--

--DO NOT MODIFY DATABASE OR YOU MAY REPORT INNOCENT PEOPLE, HEURISTIC FUNCTION DEPENDS ON WORDS BEING ON CERTAIN LINES
local triggers = {
	--White
	"recruit", --1
	"dkp", --2
	"looking", --3 --guild
	"lf[gm]", --4

	--English - Common
	"bonus", --5
	"buy", --6
	"cheap", --7
	"code", --8
	"coupon", --9
	"customer", --10
	"deliver", --11
	"discount", --12
	"gold", --13
	"lowest", --14
	"order", --15
	"payment", --16
	"powerle?ve?l", --17
	"price", --18
	"promoti[on][gn]", --19
	"reduced", --20
	"safe", --21
	"server", --22
	"service", --23
	"stock", --24
	"well?come", --25

	--French - Common
	"livraison", --delivery --26

	--German - Common
	"billigster", --cheapest --27
	"lieferung", --delivery --28
	"preis", --price --29
	"willkommen", --welcome --30

	--Spanish - Common
	"barato", --cheap --31
	"gratuito", --free --32
	"r[\195\161a]pido", --fast --33
	"seguro", --safe/secure --34
	"servicio", --service --35

	--Heavy
	"only[\226\130\172%$\194\163]+%d+[%.%-]?%d*[fp][oe]r%d+%.?%d*[kg]", --36 --Add separate line if they start approx prices
	"[\226\130\172%$\194\163]+%d+%.?%d+[/\98=]%d+%.?%d*[kg]", --37
	"only%d+%.?%d*eur?o?s?[fp][oe]r%d+%.?%d*[kg]", --38
	"%d+%.?%d*[\226\130\172%$\194\163]+[/\98=]%d+%.?%d*[kg]", --39
	"only[\226\130\172%$\194\163]+%d+[%.%-]?%d*{%S-}%d+%.?%d*[kg]", --40 --Add separate line if they start approx prices
	"%d+%.?%d*[kg][/\98=][\226\130\172%$\194\163]+%d+", --41
	"%d+%.?%d*[kg][/\98=]%d+%.?%d*[\226\130\172%$\194\163]+", --42
	"%d+%.?%d*[kg][/\98=]%d+%.?%d*eur", --43
	"%d+%.?%d*eur?o?s?[/\98=]%d+%.?%d*[kg]", --44
	"%d+%.?%d*usd[/\98=]%d+%.?%d*[kg]", --45

	--Heavy Strict
	"www[%.,{]", --46
	"[%.,]c[o0@]m", --47
	"[%.,]c{circle}m", --48
	"[%.,]c{rt2}m", --49
	"[%.,]cqm", --50
	"[%.,]net", --51

	--Phishing - English
	"account", --52
	"blizz", --53
	"claim", --54
	"congratulations", --55
	"free", --56
	"gift", --57
	"launch", --58
	"log[io]n", --59
	"luckyplayer", --60
	"mount", --61
	"pleasevisit", --62
	"receive", --63
	"surprise", --64
	"suspe[cn][td]ed", --65 --suspected/suspended
	"system", --66

	--Phishing - German
	"berechtigt", --entitled --67
	"erhalten", --get/receive --68
	"deaktiviert", --deactivated --69
	"konto", --acount --70
	"kostenlos", --free --71
	"qualifiziert", --qualified --72

	--Personal Whispers
	"server.*purchase.*gold.*deliv", --sorry to bother,currently we have 29200g on this server, wondering if you might purchase some gold today? 15mins delivery:)
	"%d+.*lfggameteam", --actually we have 10kg in stock from Lfggame team ,do you want some?
	"free.*powerleveling.*level.*%d+.*interested", --Hello there! I am offering free powerleveling from level 70-80! Perhaps you are intrested? :)v
	"friend.*price.*%d+k.*gold", --dear friend.. may i tell you the price for 10k wow gold ?^^
	"we.*%d+k.*stock.*realm", --hi, we got 25k+++ in stock on this realm. r u interested?:P
	"we.*%d+k.*stock.*gold", --Sorry to bother you , We have 26k gold in stock right now. Are you intrested in buying some gold today?
	"we.*%d+k.*gold.*buy", --Sorry to bother. We got around 27.4k gold on this server, wondering if you might buy some quick gold with face to face trading ingame?
	"so?rr?y.*interest.*cheap.*gold", --sorry to trouble you , just wondering whether you have  any interest in getting some cheap gold at this moment ,dear dude ? ^^
	"we.*%d+k.*stock.*interest", --hi,we have 40k in stock today,interested ?:)
	"we.*%d%d%d+g.*stock.*price", --hi,we have the last 23600g in stock now ,ill give you the bottom price.do u need any?:D
	"hi.*%d%d+k.*stock.*interest", --hi ,30k++in stock any interest?:)
	"wondering.*you.*need.*buy.*g.*so?r?ry", --I am sunny, just wondering if you might need to buy some G. If not, sry to bother.:)
	"buy.*wow.*curr?ency.*deliver", --Would u like to buy WOW CURRENCY on our site?:)We deliver in 5min:-)
	"interest.*%d+kg.*price.*delive", --:P any interested in the last 30kg with the bottom price.. delivery within 5 to 10 mins:)
	"sorr?y.*bother.*another.*wow.*account.*use", --Hi,mate,sorry to bother,may i ask if u have another wow account that u dont use?:)
	"hello.*%d%d+k.*stock.*buy.*now", --hello mate :) 40k stock now,wanna buy some now?^^
	"price.*%d%d+g.*sale.*gold", --Excuse me. Bottom price!.  New and fresh 30000 G is for sale. Are you intrested in buying some gold today?
	"so?rr?y.*you.*tellyou.*%d+k.*wow.*gold", --sorry to bother you,may i tell you how much for 5k wow gold
	"excuse.*do.*need.*buy.*wow.*gold", --Excuse me,do u need to buy some wowgold?
	"bother.*%d%d%d+g.*server.*quick.*gold", --Sry to bother you, We have 57890 gold on this server do you want to purchase some quick gold today?
	"hey.*interest.*some.*fast.*%d+kg.*left", --hey,interested in some g fast?got 27kg left atm:)
	"know.*need.*buy.*gold.*delivery", --hi,its kitty here. may i know if you need to buy some quick gold today. 20-50 mins delivery speed,
	"may.*know.*have.*account.*don.*use", -- Hi ,May i know if you have an useless account that you dont use now ? :)
	"company.*le?ve?l.*char.*%d%d.*free", --our company  can lvl your char to lvl 80 for FREE.
	"so?r?ry.*need.*cheap.*gold.*%d+", --sorry to disurb you. do you need some cheap gold 20k just need 122eur(108GBP)
	"stock.*gold.*wonder.*buy.*so?rr?y", --Full stock gold! Wondering you might wanna buy some today ? sorry for bothering you.
	"hi.*you.*need.*gold.*we.*promotion", --[hi.do] you need some gold atm?we now have a promotion for it ^^
	"brbgame.*need.*gold.*only.*fast.*deliver", --sry to bother i am maria from brbgame, may i pease enquire as to whether u r in need of wow gold ?:P only 3$ per k with fast delivery !\
	"so?r?ry.*bother.*still.*%d+k.*left.*buy.*gold", --sry to bother you ,we still have around 52k left atm, you wanna buy some gold quickly today ?
	"may.*ask.*whether.*interest.*ing.*boe.*stuff.*rocket", --hmm, may i ask whether u r interested in g or boe stuffs such as X-53 Touring Rocket:P

	--Casino
	"%d+%-%d+.*d[ou][ub]ble.*%d+%-%d+.*tripp?le", --10 minimum 400 max\roll\61-97 double, 98-100 triple, come roll,
	"casino.*%d+x2.*%d+x3", --{star} CASINO {star} roll 64-99x2 your wager roll 100x3 your wager min bet 50g max 10k will show gold 100% legit (no inbetween rolls plz){diamond} good luck {diamond}
	"casino.*%d+.*double.*%d+.*tripp?le", --The Golden Casino is offering 60+ Doubles, and 80+ Tripples!
	"casino.*whisper.*info", --<RollReno's Casino> <Whisper for more information!>
	"d[ou][ub]ble.*%d+%-%d+.*%d+%-%d+.*tripp?le", --come too the Free Roller  gaming house!  and have ur luck of winning gold! :) pst me for invite:)  double is  62-96 97-100 tripple we also play blackjack---- u win double if you beat the host in blackjack
	"d[ou][ub]ble.*%d+%-%d+.*tripp?le.*%d+%-%d+", --come to free roller gaming house! and have u luck of winning gold :) pst for invite :) double is 62-96 triple is 97-100. we also play blacjack---u win doubleif u beat host in blacjack

	--Advanced URL's/Misc
	"^%W+.*mmoggg", -->>> MMOGGG is recruiting now!
	"%d+.*items.*deliver.*k4gg", --10K=13.98For more items and for fast delivery,come toWWW.K4gg.C@M
	"customer.*promotion.*cost.*gold", --Dear customer: This is kyla from promotion site : mmowin ^_^Long time no see , how is going? Been miss ya :)As the cataclysm coming and the market cost line for gold and boe item has been down a lot recently , we will send present if ya get 30k or 50k
	--40$ for 10k gold or 45$ for  10k gold + 1 rocket  + one month  time card  .   25$ for  a  rocket .  we have  all boe items and 264 gears selled . if u r interested in .  plz whsiper me . :) ty
	--$45=10k + one X-53 Touring Rocket, $107=30K + X-53 Touring Rocket, the promotion will be done in 10 minutes, if you like it, plz whisper me :) ty 
	"%$.*rocket.*%$.*rocket.*ple?a?[sz]", --$45 for 10k with a rocket {star} and 110$ for 30k with a Rocket{moon},if you like,plz pst
	"wts.*rocket.*%d+[kg].*free", --!!!!!! WTS*X-53 TOURING ROCKET Mount(2seats)for 10000G (RAF things), you also can get a free month game time,PST me !!!
	"{.*}.*mm4ss.*{.*}", --{triangle}www.mm4ss.com{triangle} --multi
	"promotion.*serve.*%d+k", --Special promotion in this serve now, 21$ for 10k
	"pkpkg.*gear.*pet", --WWW.PkPkg.C{circle}M more gears,mount,pet and items on
	"euro.*gold.*safer.*trade", --Only 1.66 Euros per 1000 gold, More safer trade model.
	--WWW.PVPBank.C{circle}MCODE=itempvp(20% price off)
	"www[%.,]pvpbank[%.,]c.*%d+", --Wir haben mehr Ausr?stungen, Mounts und Items, die Sie mochten. Professionelles Team fuer 300 Personen sind 24 Stunde fuer Sie da.Wenn Sie Fragen haben,wenden Sie an uns bitteWWW.PVPBank.C{circle}M7 Tage 24 Uhr Service.
	"^%W+mm[0o]%[?yy[%.,]c[0o]m%W+$", --May 10
	"^%W+diymm[0o]game[%.,]c[0o]m%W+$", --June 10
	"sell.*safe.*fast.*site.*gold2wow", --()()Hot selling:safest and fastest trade,reliable site gold2wow()() --June 10
	"^%W+m+oggg[%.,][cd][oe]m?%W+$", --April 10
	"%W+mmo4store[%.,]c[0o]m%W+", --June 10
	"friend.*website.*gold4guild", --October 09
	"friend.*website.*gg4g", --January 09
	"friend.*website.*wowseller", --April 10
	"^%W+w*[%.,]?gold4guild[%.,]c[o0]m%W+$", --October 09
	"^%W+w*[%.,]?wowseller[%.,]c[o0]m%W+$", --April 10
	"^%W+gg4g[%.,][ce][ou]m?%W+$", --January 09
	"^www[%.,]ignmax[%.,]com$", --December 09
	"wts.*boeitems.*sale.*ignah", --wts [Lightning-Infused Leggings] [Carapace of Forgotten Kings] we have all the Boe items,mats and t10/t10.5 for sale .<www.ignah.com>!!
	"mmoarm2teeth.*wanna.*gear.*season.*wowgold", --hey,this is [3w.mmoarm2teeth.com](3w=www).do you wanna get heroic ICC gear,season8 gear and wow gold?
	"skillcopper.*wow.*mount.*gold", --skillcopper.eu Oldalunk ujabb termekekel bovult WoWTCG Loot Card-okal pl.:(Mount: Spectral Tiger, pet: Tuskarr Kite, Spectral Kitten Fun cuccok: Papa Hummel es meg sok mas) Gold, GC, CD kulcsok Akcio! Latogass el oldalunkra skillcopper.eu
}

-- GLOBALS: print, SetCVar, GetTime, strreplace, ipairs, UnitInParty, UnitInRaid, UnitIsInMyGuild, ComplainChat, CanComplainChat, BNGetNumFriends, BNGetNumFriendToons, BNGetFriendToonInfo, GetRealmName
local orig, prevReportTime, prevLineId, fnd, result = COMPLAINT_ADDED, 0, 0, string.find, nil
local function filter(_, event, msg, player, _, _, _, flag, channelId, _, _, _, lineId)
	if lineId == prevLineId then
		return result --Incase a message is sent more than once (registered to more than 1 chatframe)
	else
		prevLineId = lineId
		if event == "CHAT_MSG_CHANNEL" and channelId == 0 then result = nil return end --Only scan official custom channels (gen/trade)
		if not CanComplainChat(lineId) or UnitIsInMyGuild(player) or UnitInRaid(player) or UnitInParty(player) then result = nil return end --Don't scan ourself/friends/GMs/guildies or raid/party members
		if event == "CHAT_MSG_WHISPER" then --These scan prevention checks only apply to whispers, it would be too heavy to apply to all chat
			if flag == "GM" then result = nil return end --GM's can't get past the CanComplainChat call but "apparently" someone had a GM reported by the phishing filter which I don't believe, no harm in having this check I guess
			--RealID support, don't scan people that whisper us via their character instead of RealID
			--that aren't on our friends list, but are on our RealID list. CanComplainChat should really support this...
			for i=1, select(2, BNGetNumFriends()) do
				local toon = BNGetNumFriendToons(i)
				for j=1, toon do
					local _, rName, rGame, rServer = BNGetFriendToonInfo(i, j)
					if rName == player and rGame == "WoW" and rServer == GetRealmName() then
						result = nil return
					end
				end
			end
		end
	end
	local debug = msg --Save original message format
	msg = (msg):lower() --Lower all text, remove capitals
	msg = strreplace(msg, " ", "") --Remove spaces
	local points = 0
	local phishPoints = 0
	local strict = nil
	for k, v in ipairs(triggers) do --Scan database
		if fnd(msg, v) then --Found a match
			if k>72 then --!!!CHANGE ME ACCORDING TO DATABASE ENTRIES!!!
				points = points + 9 --Instant report
			elseif k>51 and k<73 then
				phishPoints = phishPoints + 1
			elseif k>45 and k<52 and not strict then
				points = points + 2 --Only 1 trigger can get points in the strict section
				phishPoints = phishPoints + 1
				strict = true
			elseif k>35 and k<46 then
				points = points + 2 --Heavy section gets 2 points
			elseif k>4 and k<36 then
				points = points + 1 --All else gets 1 point
			elseif k<5 then
				points = points - 2
				phishPoints = phishPoints - 2 --Remove points for safe words
			end
			if points > 3 or phishPoints > 3 then
				if BADBOY_DEBUG then print("|cFF33FF99BadBoy_REPORT|r:", debug) end --Debug
				local time = GetTime()
				if (time - prevReportTime) > 0.5 then --Timer to prevent spamming reported messages on multi line spam
					prevReportTime = time
					COMPLAINT_ADDED = "|cFF33FF99BadBoy|r: "..orig.." |Hplayer:"..player.."|h["..player.."]|h" --Add name to reported message
					if BADBOY_POPUP then --Manual reporting via popup
						--Add original spam line to Blizzard popup message
						StaticPopupDialogs["CONFIRM_REPORT_SPAM_CHAT"].text = REPORT_SPAM_CONFIRMATION .."\n\n".. strreplace(debug, "%", "%%")
						local dialog = StaticPopup_Show("CONFIRM_REPORT_SPAM_CHAT", player)
						dialog.data = lineId
					else
						ComplainChat(lineId) --Automatically report
					end
				end
				result = true
				return true
			end
		end
	end
	result = nil
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", filter)

--Function for disabling BadBoy reports and misc required functions
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function(_, _, msg)
	if msg == orig then
		return --Manual spam report, back down
	elseif msg == COMPLAINT_ADDED then
		COMPLAINT_ADDED = orig --Reset reported message to default for manual reporting
		if BADBOY_POPUP then
			--Reset popup message to default for manual reporting
			StaticPopupDialogs["CONFIRM_REPORT_SPAM_CHAT"].text = REPORT_SPAM_CONFIRMATION
		end
		if BADBOY_SILENT then
			return true --Filter out the report if enabled
		end
	else
		--Ninja this in here to prevent creating a login function & frame
		--We force this on so we don't have spam that would have been filtered, reported on the forums
		SetCVar("spamFilter", 1)
	end
end)

