module("modules.logic.ressplit.xml.ResSplitXml2lua", package.seeall)

local var_0_0 = {
	_VERSION = "1.5-2"
}

local function var_0_1(arg_1_0, arg_1_1)
	if arg_1_0 == nil then
		return
	end

	arg_1_1 = arg_1_1 or 1

	local var_1_0 = string.rep(" ", arg_1_1 * 2)

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if type(iter_1_1) == "table" then
			print(var_1_0 .. iter_1_0)
			var_0_1(iter_1_1, arg_1_1 + 1)
		else
			print(var_1_0 .. iter_1_0 .. "=" .. iter_1_1)
		end
	end
end

function var_0_0.parser(arg_2_0)
	if arg_2_0 == var_0_0 then
		error("You must call ResSplitXml2lua.parse(handler) instead of ResSplitXml2lua:parse(handler)")
	end

	local var_2_0 = {
		expandEntities = 1,
		stripWS = 1,
		errorHandler = function(arg_3_0, arg_3_1)
			error(string.format("%s [char=%d]\n", arg_3_0 or "Parse Error", arg_3_1))
		end
	}

	return ResSplitXmlParser.new(arg_2_0, var_2_0)
end

function var_0_0.printable(arg_4_0)
	var_0_1(arg_4_0)
end

function var_0_0.toString(arg_5_0)
	local var_5_0 = ""
	local var_5_1 = ""

	if type(arg_5_0) ~= "table" then
		return arg_5_0
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		if type(iter_5_1) == "table" then
			iter_5_1 = var_0_0.toString(iter_5_1)
		end

		var_5_1 = var_5_1 .. var_5_0 .. string.format("%s=%s", iter_5_0, iter_5_1)
		var_5_0 = ","
	end

	return "{" .. var_5_1 .. "}"
end

function var_0_0.loadFile(arg_6_0)
	local var_6_0, var_6_1 = io.open(arg_6_0, "r")

	if var_6_0 then
		local var_6_2 = var_6_0:read("*a")

		var_6_0:close()

		return var_6_2
	end

	error(var_6_1)
end

local function var_0_2(arg_7_0)
	local var_7_0 = ""

	arg_7_0 = arg_7_0 or {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		var_7_0 = var_7_0 .. " " .. iter_7_0 .. "=" .. "\"" .. iter_7_1 .. "\""
	end

	return var_7_0
end

local function var_0_3(arg_8_0)
	if type(arg_8_0) == "table" then
		for iter_8_0, iter_8_1 in pairs(arg_8_0) do
			return iter_8_0
		end

		return nil
	end

	return arg_8_0
end

local function var_0_4(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = string.rep(" ", arg_9_3 * 2)
	local var_9_1 = ""
	local var_9_2 = ""

	if type(arg_9_2) == "table" then
		var_9_2 = var_0_2(arg_9_2._attr)
		arg_9_2._attr = nil
		var_9_1 = #arg_9_2 == 1 and var_9_0 .. tostring(arg_9_2[1]) or var_0_0.toXml(arg_9_2, arg_9_1, arg_9_3 + 1)
		var_9_1 = "\n" .. var_9_1 .. "\n" .. var_9_0
	else
		var_9_1 = tostring(arg_9_2)
	end

	table.insert(arg_9_0, var_9_0 .. "<" .. arg_9_1 .. var_9_2 .. ">" .. var_9_1 .. "</" .. arg_9_1 .. ">")
end

function var_0_0.toXml(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or 1

	local var_10_0 = arg_10_2

	arg_10_1 = arg_10_1 or ""

	local var_10_1 = arg_10_1 ~= "" and arg_10_2 == 1 and {
		"<" .. arg_10_1 .. ">"
	} or {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0) do
		if type(iter_10_1) == "table" then
			if type(iter_10_0) == "number" then
				var_0_4(var_10_1, arg_10_1, iter_10_1, arg_10_2)
			else
				arg_10_2 = arg_10_2 + 1

				if type(var_0_3(iter_10_1)) == "number" then
					var_0_4(var_10_1, iter_10_0, iter_10_1, arg_10_2)
				else
					var_0_4(var_10_1, iter_10_0, iter_10_1, arg_10_2)
				end
			end
		else
			if type(iter_10_0) == "number" then
				iter_10_0 = arg_10_1
			end

			var_0_4(var_10_1, iter_10_0, iter_10_1, arg_10_2)
		end
	end

	if arg_10_1 ~= "" and var_10_0 == 1 then
		table.insert(var_10_1, "</" .. arg_10_1 .. ">\n")
	end

	return table.concat(var_10_1, "\n")
end

return var_0_0
