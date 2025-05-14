module("modules.logic.ressplit.xml.ResSplitXmlParser", package.seeall)

local function var_0_0(arg_1_0)
	local var_1_0 = tonumber(arg_1_0)

	if var_1_0 >= 0 and var_1_0 < 256 then
		return string.char(var_1_0)
	end

	return "&#" .. arg_1_0 .. ";"
end

local function var_0_1(arg_2_0)
	local var_2_0 = tonumber(arg_2_0, 16)

	if var_2_0 >= 0 and var_2_0 < 256 then
		return string.char(var_2_0)
	end

	return "&#x" .. arg_2_0 .. ";"
end

local var_0_2 = {
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
		["&#(%d+);"] = var_0_0,
		["&#x(%x+);"] = var_0_1
	}
}

function var_0_2.new(arg_3_0, arg_3_1)
	local var_3_0 = {
		handler = arg_3_0,
		options = arg_3_1,
		_stack = {}
	}

	setmetatable(var_3_0, var_0_2)

	var_3_0.__index = var_0_2

	return var_3_0
end

local function var_0_3(arg_4_0, arg_4_1)
	if arg_4_0 == nil then
		return false
	end

	if arg_4_0[arg_4_1] == nil then
		return var_0_3(getmetatable(arg_4_0), arg_4_1)
	else
		return true
	end
end

local function var_0_4(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.options.errorHandler then
		arg_5_0.options.errorHandler(arg_5_1, arg_5_2)
	end
end

local function var_0_5(arg_6_0, arg_6_1)
	if arg_6_0.options.stripWS then
		arg_6_1 = string.gsub(arg_6_1, "^%s+", "")
		arg_6_1 = string.gsub(arg_6_1, "%s+$", "")
	end

	return arg_6_1
end

local function var_0_6(arg_7_0, arg_7_1)
	if arg_7_0.options.expandEntities then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._ENTITIES) do
			arg_7_1 = string.gsub(arg_7_1, iter_7_0, iter_7_1)
		end
	end

	return arg_7_1
end

local function var_0_7(arg_8_0, arg_8_1)
	local var_8_0 = {
		name = string.gsub(arg_8_1, arg_8_0._TAG, "%1"),
		attrs = {}
	}

	local function var_8_1(arg_9_0, arg_9_1)
		var_8_0.attrs[arg_9_0] = var_0_6(arg_8_0, arg_9_1)
		var_8_0.attrs._ = 1
	end

	string.gsub(arg_8_1, arg_8_0._ATTR1, var_8_1)
	string.gsub(arg_8_1, arg_8_0._ATTR2, var_8_1)

	if var_8_0.attrs._ then
		var_8_0.attrs._ = nil
	else
		var_8_0.attrs = nil
	end

	return var_8_0
end

local function var_0_8(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2.match, arg_10_2.endMatch, arg_10_2.text = string.find(arg_10_1, arg_10_0._PI, arg_10_2.pos)

	if not arg_10_2.match then
		var_0_4(arg_10_0, arg_10_0._errstr.declErr, arg_10_2.pos)
	end

	if arg_10_2.match ~= 1 then
		var_0_4(arg_10_0, arg_10_0._errstr.declStartErr, arg_10_2.pos)
	end

	local var_10_0 = var_0_7(arg_10_0, arg_10_2.text)

	if var_10_0.attrs and var_10_0.attrs.version == nil then
		var_0_4(arg_10_0, arg_10_0._errstr.declAttrErr, arg_10_2.pos)
	end

	if var_0_3(arg_10_0.handler, "decl") then
		arg_10_0.handler:decl(var_10_0, arg_10_2.match, arg_10_2.endMatch)
	end

	return var_10_0
end

local function var_0_9(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	arg_11_2.match, arg_11_2.endMatch, arg_11_2.text = string.find(arg_11_1, arg_11_0._PI, arg_11_2.pos)

	if not arg_11_2.match then
		var_0_4(arg_11_0, arg_11_0._errstr.piErr, arg_11_2.pos)
	end

	if var_0_3(arg_11_0.handler, "pi") then
		var_11_0 = var_0_7(arg_11_0, arg_11_2.text)

		local var_11_1 = string.sub(arg_11_2.text, string.len(var_11_0.name) + 1)

		if var_11_1 ~= "" then
			if var_11_0.attrs then
				var_11_0.attrs._text = var_11_1
			else
				var_11_0.attrs = {
					_text = var_11_1
				}
			end
		end

		arg_11_0.handler:pi(var_11_0, arg_11_2.match, arg_11_2.endMatch)
	end

	return var_11_0
end

local function var_0_10(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2.match, arg_12_2.endMatch, arg_12_2.text = string.find(arg_12_1, arg_12_0._COMMENT, arg_12_2.pos)

	if not arg_12_2.match then
		var_0_4(arg_12_0, arg_12_0._errstr.commentErr, arg_12_2.pos)
	end

	if var_0_3(arg_12_0.handler, "comment") then
		arg_12_2.text = var_0_6(arg_12_0, var_0_5(arg_12_0, arg_12_2.text))

		arg_12_0.handler:comment(arg_12_2.text, next, arg_12_2.match, arg_12_2.endMatch)
	end
end

local function var_0_11(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {
		arg_13_0._DTD1,
		arg_13_0._DTD2,
		arg_13_0._DTD3,
		arg_13_0._DTD4,
		arg_13_0._DTD5
	}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_1, var_13_2, var_13_3, var_13_4, var_13_5, var_13_6, var_13_7 = string.find(arg_13_1, iter_13_1, arg_13_2)

		if var_13_1 then
			return var_13_1, var_13_2, {
				_root = var_13_3,
				_type = var_13_4,
				_name = var_13_5,
				_uri = var_13_6,
				_internal = var_13_7
			}
		end
	end

	return nil
end

local function var_0_12(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2.match, arg_14_2.endMatch, _ = var_0_11(arg_14_0, arg_14_1, arg_14_2.pos)

	if not arg_14_2.match then
		var_0_4(arg_14_0, arg_14_0._errstr.dtdErr, arg_14_2.pos)
	end

	if var_0_3(arg_14_0.handler, "dtd") then
		local var_14_0 = {
			name = "DOCTYPE",
			value = string.sub(arg_14_1, arg_14_2.match + 10, arg_14_2.endMatch - 1)
		}

		arg_14_0.handler:dtd(var_14_0, arg_14_2.match, arg_14_2.endMatch)
	end
end

local function var_0_13(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2.match, arg_15_2.endMatch, arg_15_2.text = string.find(arg_15_1, arg_15_0._CDATA, arg_15_2.pos)

	if not arg_15_2.match then
		var_0_4(arg_15_0, arg_15_0._errstr.cdataErr, arg_15_2.pos)
	end

	if var_0_3(arg_15_0.handler, "cdata") then
		arg_15_0.handler:cdata(arg_15_2.text, nil, arg_15_2.match, arg_15_2.endMatch)
	end
end

local function var_0_14(arg_16_0, arg_16_1, arg_16_2)
	while true do
		arg_16_2.errStart, arg_16_2.errEnd = string.find(arg_16_2.tagstr, arg_16_0._ATTRERR1)

		if arg_16_2.errEnd == nil then
			arg_16_2.errStart, arg_16_2.errEnd = string.find(arg_16_2.tagstr, arg_16_0._ATTRERR2)

			if arg_16_2.errEnd == nil then
				break
			end
		end

		arg_16_2.extStart, arg_16_2.extEnd, arg_16_2.endt2 = string.find(arg_16_1, arg_16_0._TAGEXT, arg_16_2.endMatch + 1)
		arg_16_2.tagstr = arg_16_2.tagstr .. string.sub(arg_16_1, arg_16_2.endMatch, arg_16_2.extEnd - 1)

		if not arg_16_2.match then
			var_0_4(arg_16_0, arg_16_0._errstr.xmlErr, arg_16_2.pos)
		end

		arg_16_2.endMatch = arg_16_2.extEnd
	end

	local var_16_0 = var_0_7(arg_16_0, arg_16_2.tagstr)

	if arg_16_2.endt1 == "/" then
		if var_0_3(arg_16_0.handler, "endtag") then
			if var_16_0.attrs then
				var_0_4(arg_16_0, string.format("%s (/%s)", arg_16_0._errstr.endTagErr, var_16_0.name), arg_16_2.pos)
			end

			if table.remove(arg_16_0._stack) ~= var_16_0.name then
				var_0_4(arg_16_0, string.format("%s (/%s)", arg_16_0._errstr.unmatchedTagErr, var_16_0.name), arg_16_2.pos)
			end

			arg_16_0.handler:endtag(var_16_0, arg_16_2.match, arg_16_2.endMatch)
		end
	else
		table.insert(arg_16_0._stack, var_16_0.name)

		if var_0_3(arg_16_0.handler, "starttag") then
			arg_16_0.handler:starttag(var_16_0, arg_16_2.match, arg_16_2.endMatch)
		end

		if arg_16_2.endt2 == "/" then
			table.remove(arg_16_0._stack)

			if var_0_3(arg_16_0.handler, "endtag") then
				arg_16_0.handler:endtag(var_16_0, arg_16_2.match, arg_16_2.endMatch)
			end
		end
	end

	return var_16_0
end

local function var_0_15(arg_17_0, arg_17_1, arg_17_2)
	if string.find(string.sub(arg_17_2.tagstr, 1, 5), "?xml%s") then
		var_0_8(arg_17_0, arg_17_1, arg_17_2)
	elseif string.sub(arg_17_2.tagstr, 1, 1) == "?" then
		var_0_9(arg_17_0, arg_17_1, arg_17_2)
	elseif string.sub(arg_17_2.tagstr, 1, 3) == "!--" then
		var_0_10(arg_17_0, arg_17_1, arg_17_2)
	elseif string.sub(arg_17_2.tagstr, 1, 8) == "!DOCTYPE" then
		var_0_12(arg_17_0, arg_17_1, arg_17_2)
	elseif string.sub(arg_17_2.tagstr, 1, 8) == "![CDATA[" then
		var_0_13(arg_17_0, arg_17_1, arg_17_2)
	else
		var_0_14(arg_17_0, arg_17_1, arg_17_2)
	end
end

local function var_0_16(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2.match, arg_18_2.endMatch, arg_18_2.text, arg_18_2.endt1, arg_18_2.tagstr, arg_18_2.endt2 = string.find(arg_18_1, arg_18_0._XML, arg_18_2.pos)

	if not arg_18_2.match then
		if string.find(arg_18_1, arg_18_0._WS, arg_18_2.pos) then
			if #arg_18_0._stack ~= 0 then
				var_0_4(arg_18_0, arg_18_0._errstr.incompleteXmlErr, arg_18_2.pos)
			else
				return false
			end
		else
			var_0_4(arg_18_0, arg_18_0._errstr.xmlErr, arg_18_2.pos)
		end
	end

	arg_18_2.text = arg_18_2.text or ""
	arg_18_2.tagstr = arg_18_2.tagstr or ""
	arg_18_2.match = arg_18_2.match or 0

	return arg_18_2.endMatch ~= nil
end

function var_0_2.parse(arg_19_0, arg_19_1, arg_19_2)
	if type(arg_19_0) ~= "table" or getmetatable(arg_19_0) ~= var_0_2 then
		error("You must call xmlparser:parse(parameters) instead of xmlparser.parse(parameters)")
	end

	if arg_19_2 == nil then
		arg_19_2 = true
	end

	arg_19_0.handler.parseAttributes = arg_19_2

	local var_19_0 = {
		match = 0,
		pos = 1,
		endMatch = 0
	}

	while var_19_0.match do
		if not var_0_16(arg_19_0, arg_19_1, var_19_0) then
			break
		end

		var_19_0.startText = var_19_0.match
		var_19_0.endText = var_19_0.match + string.len(var_19_0.text) - 1
		var_19_0.match = var_19_0.match + string.len(var_19_0.text)
		var_19_0.text = var_0_6(arg_19_0, var_0_5(arg_19_0, var_19_0.text))

		if var_19_0.text ~= "" and var_0_3(arg_19_0.handler, "text") then
			arg_19_0.handler:text(var_19_0.text, nil, var_19_0.match, var_19_0.endText)
		end

		var_0_15(arg_19_0, arg_19_1, var_19_0)

		var_19_0.pos = var_19_0.endMatch + 1
	end
end

var_0_2.__index = var_0_2

return var_0_2
