module("modules.configschecker.ConfigsCheckerStrBuf", package.seeall)

local var_0_0 = table.insert
local var_0_1 = string.format
local var_0_2 = debug.getinfo
local var_0_3 = table.concat
local var_0_4 = class("ConfigsCheckerStrBuf")

function var_0_4.ctor(arg_1_0, arg_1_1)
	arg_1_0:init(arg_1_1)
end

function var_0_4.init(arg_2_0, arg_2_1)
	arg_2_0:clean()

	local var_2_0 = var_0_2(5, "Slf")

	arg_2_0._srcloc = var_0_1("%s : line %s", var_2_0.source, var_2_0.currentline)
	arg_2_0._source = arg_2_1 or arg_2_0._source
end

function var_0_4.clean(arg_3_0)
	arg_3_0._list = {}
	arg_3_0._srcloc = "[Unknown]"
	arg_3_0._source = "[Unknown]"
end

function var_0_4.empty(arg_4_0)
	return #arg_4_0._list == 0
end

function var_0_4._beginOnce(arg_5_0)
	if not arg_5_0:empty() then
		return
	end

	var_0_0(arg_5_0._list, var_0_1("%s =========== begin", arg_5_0._srcloc))
	var_0_0(arg_5_0._list, var_0_1("source: %s", arg_5_0._source))
end

function var_0_4._endOnce(arg_6_0)
	if arg_6_0._list[-11235] then
		return
	end

	arg_6_0._list[-11235] = true

	arg_6_0:appendLine(var_0_1("%s =========== end", arg_6_0._srcloc))
end

function var_0_4._logIfGot(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0:empty() then
		return
	end

	arg_7_0:_endOnce()
	arg_7_1(var_0_3(arg_7_0._list, "\n"))

	if not arg_7_2 then
		arg_7_0:clean()
	end
end

function var_0_4.appendLine(arg_8_0, arg_8_1)
	if type(arg_8_1) == type(true) then
		arg_8_1 = tostring(arg_8_1)
	elseif arg_8_1 == nil then
		arg_8_1 = "nil"
	end

	arg_8_0:_beginOnce()
	var_0_0(arg_8_0._list, arg_8_1)
end

function var_0_4.appendLineIfOK(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 then
		return
	end

	arg_9_0:appendLine(arg_9_2)
end

function var_0_4.logErrorIfGot(arg_10_0, arg_10_1)
	arg_10_0:_logIfGot(logError, arg_10_1)
end

function var_0_4.logWarnIfGot(arg_11_0, arg_11_1)
	arg_11_0:_logIfGot(logWarn, arg_11_1)
end

function var_0_4.logNormalIfGot(arg_12_0, arg_12_1)
	arg_12_0:_logIfGot(logNormal, arg_12_1)
end

return var_0_4
