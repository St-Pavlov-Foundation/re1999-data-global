module("modules.logic.ressplit.xml.ResSplitXmlParser", package.seeall)

slot2 = {
	_TAG = "^(.-)%s.*",
	_DTD2 = "<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+[\"'](.-)[\"']%s+[\"'](.-)[\"']%s*(%b[])%s*>",
	_DTD4 = "<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+[\"'](.-)[\"']%s*>",
	_WS = "^%s*$",
	_ATTR2 = "([%w-:_]+)%s*=%s*'(.-)'",
	_ATTRERR2 = "=+?%s*'[^']*$",
	_ATTRERR1 = "=+?%s*\"[^\"]*$",
	_DTD5 = "<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+[\"'](.-)[\"']%s+[\"'](.-)[\"']%s*>",
	_DTD3 = "<!DOCTYPE%s.->",
	_TRAILINGWS = "%s+$",
	_PI = "<%?(.-)%?>",
	_DTD1 = "<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+[\"'](.-)[\"']%s*(%b[])%s*>",
	_COMMENT = "<!%-%-(.-)%-%->",
	_ATTR1 = "([%w-:_]+)%s*=%s*\"(.-)\"",
	_TAGEXT = "(%/?)>",
	_XML = "^([^<]*)<(%/?)([^>]-)(%/?)>",
	_LEADINGWS = "^%s+",
	_CDATA = "<%!%[CDATA%[(.-)%]%]>",
	_errstr = {
		unmatchedTagErr = "Unbalanced Tag",
		incompleteXmlErr = "Incomplete XML Document",
		endTagErr = "End Tag Attributes Invalid",
		xmlErr = "Error Parsing XML",
		declStartErr = "XMLDecl not at start of document",
		cdataErr = "Error Parsing CDATA",
		piErr = "Error Parsing Processing Instruction",
		commentErr = "Error Parsing Comment",
		declAttrErr = "Invalid XMLDecl attributes",
		declErr = "Error Parsing XMLDecl",
		dtdErr = "Error Parsing DTD"
	},
	_ENTITIES = {
		["&apos;"] = "'",
		["&gt;"] = ">",
		["&lt;"] = "<",
		["&amp;"] = "&",
		["&quot;"] = "\"",
		["&#(%d+);"] = function (slot0)
			if tonumber(slot0) >= 0 and slot1 < 256 then
				return string.char(slot1)
			end

			return "&#" .. slot0 .. ";"
		end,
		["&#x(%x+);"] = function (slot0)
			if tonumber(slot0, 16) >= 0 and slot1 < 256 then
				return string.char(slot1)
			end

			return "&#x" .. slot0 .. ";"
		end
	},
	new = function (slot0, slot1)
		slot2 = {
			handler = slot0,
			options = slot1,
			_stack = {}
		}

		setmetatable(slot2, uv0)

		slot2.__index = uv0

		return slot2
	end,
	parse = function (slot0, slot1, slot2)
		if type(slot0) ~= "table" or getmetatable(slot0) ~= uv0 then
			error("You must call xmlparser:parse(parameters) instead of xmlparser.parse(parameters)")
		end

		if slot2 == nil then
			slot2 = true
		end

		slot0.handler.parseAttributes = slot2
		slot3 = {
			match = 0,
			pos = 1,
			endMatch = 0
		}

		while slot3.match do
			if not uv1(slot0, slot1, slot3) then
				break
			end

			slot3.startText = slot3.match
			slot3.endText = slot3.match + string.len(slot3.text) - 1
			slot3.match = slot3.match + string.len(slot3.text)
			slot3.text = uv2(slot0, uv3(slot0, slot3.text))

			if slot3.text ~= "" and uv4(slot0.handler, "text") then
				slot0.handler:text(slot3.text, nil, slot3.match, slot3.endText)
			end

			uv5(slot0, slot1, slot3)

			slot3.pos = slot3.endMatch + 1
		end
	end
}

function slot3(slot0, slot1)
	if slot0 == nil then
		return false
	end

	if slot0[slot1] == nil then
		return uv0(getmetatable(slot0), slot1)
	else
		return true
	end
end

function slot4(slot0, slot1, slot2)
	if slot0.options.errorHandler then
		slot0.options.errorHandler(slot1, slot2)
	end
end

function slot5(slot0, slot1)
	if slot0.options.stripWS then
		slot1 = string.gsub(string.gsub(slot1, "^%s+", ""), "%s+$", "")
	end

	return slot1
end

function slot6(slot0, slot1)
	if slot0.options.expandEntities then
		for slot5, slot6 in pairs(slot0._ENTITIES) do
			slot1 = string.gsub(slot1, slot5, slot6)
		end
	end

	return slot1
end

function slot7(slot0, slot1)
	function slot3(slot0, slot1)
		uv0.attrs[slot0] = uv1(uv2, slot1)
		uv0.attrs._ = 1
	end

	string.gsub(slot1, slot0._ATTR1, slot3)
	string.gsub(slot1, slot0._ATTR2, slot3)

	if ({
		name = string.gsub(slot1, slot0._TAG, "%1"),
		attrs = {}
	}).attrs._ then
		slot2.attrs._ = nil
	else
		slot2.attrs = nil
	end

	return slot2
end

function slot8(slot0, slot1, slot2)
	slot2.match, slot2.endMatch, slot2.text = string.find(slot1, slot0._PI, slot2.pos)

	if not slot2.match then
		uv0(slot0, slot0._errstr.declErr, slot2.pos)
	end

	if slot2.match ~= 1 then
		uv0(slot0, slot0._errstr.declStartErr, slot2.pos)
	end

	if uv1(slot0, slot2.text).attrs and slot3.attrs.version == nil then
		uv0(slot0, slot0._errstr.declAttrErr, slot2.pos)
	end

	if uv2(slot0.handler, "decl") then
		slot0.handler:decl(slot3, slot2.match, slot2.endMatch)
	end

	return slot3
end

function slot9(slot0, slot1, slot2)
	slot3 = {}
	slot2.match, slot2.endMatch, slot2.text = string.find(slot1, slot0._PI, slot2.pos)

	if not slot2.match then
		uv0(slot0, slot0._errstr.piErr, slot2.pos)
	end

	if uv1(slot0.handler, "pi") then
		if string.sub(slot2.text, string.len(uv2(slot0, slot2.text).name) + 1) ~= "" then
			if slot3.attrs then
				slot3.attrs._text = slot4
			else
				slot3.attrs = {
					_text = slot4
				}
			end
		end

		slot0.handler:pi(slot3, slot2.match, slot2.endMatch)
	end

	return slot3
end

function slot10(slot0, slot1, slot2)
	slot2.match, slot2.endMatch, slot2.text = string.find(slot1, slot0._COMMENT, slot2.pos)

	if not slot2.match then
		uv0(slot0, slot0._errstr.commentErr, slot2.pos)
	end

	if uv1(slot0.handler, "comment") then
		slot2.text = uv2(slot0, uv3(slot0, slot2.text))

		slot0.handler:comment(slot2.text, next, slot2.match, slot2.endMatch)
	end
end

function slot11(slot0, slot1, slot2)
	for slot7, slot8 in pairs({
		slot0._DTD1,
		slot0._DTD2,
		slot0._DTD3,
		slot0._DTD4,
		slot0._DTD5
	}) do
		slot9, slot10, slot11, slot12, slot13, slot14, slot15 = string.find(slot1, slot8, slot2)

		if slot9 then
			return slot9, slot10, {
				_root = slot11,
				_type = slot12,
				_name = slot13,
				_uri = slot14,
				_internal = slot15
			}
		end
	end

	return nil
end

function slot12(slot0, slot1, slot2)
	slot2.match, slot2.endMatch, _ = uv0(slot0, slot1, slot2.pos)

	if not slot2.match then
		uv1(slot0, slot0._errstr.dtdErr, slot2.pos)
	end

	if uv2(slot0.handler, "dtd") then
		slot0.handler:dtd({
			name = "DOCTYPE",
			value = string.sub(slot1, slot2.match + 10, slot2.endMatch - 1)
		}, slot2.match, slot2.endMatch)
	end
end

function slot13(slot0, slot1, slot2)
	slot2.match, slot2.endMatch, slot2.text = string.find(slot1, slot0._CDATA, slot2.pos)

	if not slot2.match then
		uv0(slot0, slot0._errstr.cdataErr, slot2.pos)
	end

	if uv1(slot0.handler, "cdata") then
		slot0.handler:cdata(slot2.text, nil, slot2.match, slot2.endMatch)
	end
end

function slot14(slot0, slot1, slot2)
	while true do
		slot2.errStart, slot2.errEnd = string.find(slot2.tagstr, slot0._ATTRERR1)

		if slot2.errEnd == nil then
			slot2.errStart, slot2.errEnd = string.find(slot2.tagstr, slot0._ATTRERR2)

			if slot2.errEnd == nil then
				break
			end
		end

		slot2.extStart, slot2.extEnd, slot2.endt2 = string.find(slot1, slot0._TAGEXT, slot2.endMatch + 1)
		slot2.tagstr = slot2.tagstr .. string.sub(slot1, slot2.endMatch, slot2.extEnd - 1)

		if not slot2.match then
			uv0(slot0, slot0._errstr.xmlErr, slot2.pos)
		end

		slot2.endMatch = slot2.extEnd
	end

	slot3 = uv1(slot0, slot2.tagstr)

	if slot2.endt1 == "/" then
		if uv2(slot0.handler, "endtag") then
			if slot3.attrs then
				uv0(slot0, string.format("%s (/%s)", slot0._errstr.endTagErr, slot3.name), slot2.pos)
			end

			if table.remove(slot0._stack) ~= slot3.name then
				uv0(slot0, string.format("%s (/%s)", slot0._errstr.unmatchedTagErr, slot3.name), slot2.pos)
			end

			slot0.handler:endtag(slot3, slot2.match, slot2.endMatch)
		end
	else
		table.insert(slot0._stack, slot3.name)

		if uv2(slot0.handler, "starttag") then
			slot0.handler:starttag(slot3, slot2.match, slot2.endMatch)
		end

		if slot2.endt2 == "/" then
			table.remove(slot0._stack)

			if uv2(slot0.handler, "endtag") then
				slot0.handler:endtag(slot3, slot2.match, slot2.endMatch)
			end
		end
	end

	return slot3
end

function slot15(slot0, slot1, slot2)
	if string.find(string.sub(slot2.tagstr, 1, 5), "?xml%s") then
		uv0(slot0, slot1, slot2)
	elseif string.sub(slot2.tagstr, 1, 1) == "?" then
		uv1(slot0, slot1, slot2)
	elseif string.sub(slot2.tagstr, 1, 3) == "!--" then
		uv2(slot0, slot1, slot2)
	elseif string.sub(slot2.tagstr, 1, 8) == "!DOCTYPE" then
		uv3(slot0, slot1, slot2)
	elseif string.sub(slot2.tagstr, 1, 8) == "![CDATA[" then
		uv4(slot0, slot1, slot2)
	else
		uv5(slot0, slot1, slot2)
	end
end

function slot16(slot0, slot1, slot2)
	slot2.match, slot2.endMatch, slot2.text, slot2.endt1, slot2.tagstr, slot2.endt2 = string.find(slot1, slot0._XML, slot2.pos)

	if not slot2.match then
		if string.find(slot1, slot0._WS, slot2.pos) then
			if #slot0._stack ~= 0 then
				uv0(slot0, slot0._errstr.incompleteXmlErr, slot2.pos)
			else
				return false
			end
		else
			uv0(slot0, slot0._errstr.xmlErr, slot2.pos)
		end
	end

	slot2.text = slot2.text or ""
	slot2.tagstr = slot2.tagstr or ""
	slot2.match = slot2.match or 0

	return slot2.endMatch ~= nil
end

slot2.__index = slot2

return slot2
