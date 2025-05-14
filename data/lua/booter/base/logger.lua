module("booter.base.logger", package.seeall)

function concatMsg(...)
	local var_1_0 = {
		...
	}

	return table.concat(var_1_0, " ")
end

function _addTraceback(...)
	return concatMsg(...) .. debug.traceback("", 2)
end

function logNormal(...)
	local var_3_0 = concatMsg(...)

	if canLogNormal and var_3_0 then
		print(var_3_0)
	end
end

function logWarn(...)
	local var_4_0 = concatMsg(...)

	if canLogWarn and var_4_0 then
		printWarn(var_4_0)
	end
end

function logError(...)
	if canLogError then
		printError(_addTraceback(...))
	end
end

function forceLog(...)
	local var_6_0 = ...

	forcePrint(var_6_0)
end

function dump(arg_7_0, arg_7_1, arg_7_2)
	if type(arg_7_2) ~= "number" then
		arg_7_2 = 3
	end

	local var_7_0 = {}
	local var_7_1 = {}

	local function var_7_2(arg_8_0)
		if type(arg_8_0) == "string" then
			arg_8_0 = "\"" .. arg_8_0 .. "\""
		end

		return tostring(arg_8_0)
	end

	local var_7_3 = string.split(debug.traceback("", 2), "\n")

	print("dump from: " .. string.trim(var_7_3[3]))

	local function var_7_4(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
		arg_9_1 = arg_9_1 or "<var>"
		spc = ""

		if type(arg_9_4) == "number" then
			spc = string.rep(" ", arg_9_4 - string.len(var_7_2(arg_9_1)))
		end

		if type(arg_9_0) ~= "table" then
			var_7_1[#var_7_1 + 1] = string.format("%s%s%s = %s", arg_9_2, var_7_2(arg_9_1), spc, var_7_2(arg_9_0))
		elseif var_7_0[arg_9_0] then
			var_7_1[#var_7_1 + 1] = string.format("%s%s%s = *REF*", arg_9_2, arg_9_1, spc)
		else
			var_7_0[arg_9_0] = true

			if arg_9_3 > arg_7_2 then
				var_7_1[#var_7_1 + 1] = string.format("%s%s = *MAX NESTING*", arg_9_2, arg_9_1)
			else
				var_7_1[#var_7_1 + 1] = string.format("%s%s = {", arg_9_2, var_7_2(arg_9_1))

				local var_9_0 = arg_9_2 .. "    "
				local var_9_1 = {}
				local var_9_2 = 0
				local var_9_3 = {}

				for iter_9_0, iter_9_1 in pairs(arg_9_0) do
					var_9_1[#var_9_1 + 1] = iter_9_0

					local var_9_4 = var_7_2(iter_9_0)
					local var_9_5 = string.len(var_9_4)

					if var_9_2 < var_9_5 then
						var_9_2 = var_9_5
					end

					var_9_3[iter_9_0] = iter_9_1
				end

				table.sort(var_9_1, function(arg_10_0, arg_10_1)
					if type(arg_10_0) == "number" and type(arg_10_1) == "number" then
						return arg_10_0 < arg_10_1
					else
						return tostring(arg_10_0) < tostring(arg_10_1)
					end
				end)

				for iter_9_2, iter_9_3 in ipairs(var_9_1) do
					var_7_4(var_9_3[iter_9_3], iter_9_3, var_9_0, arg_9_3 + 1, var_9_2)
				end

				var_7_1[#var_7_1 + 1] = string.format("%s}", arg_9_2)
			end
		end
	end

	var_7_4(arg_7_0, arg_7_1, "- ", 1)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		print(iter_7_1)
	end
end

setGlobal("logNormal", logNormal)
setGlobal("logWarn", logWarn)
setGlobal("logError", logError)
setGlobal("forceLog", forceLog)
setGlobal("dump", dump)
