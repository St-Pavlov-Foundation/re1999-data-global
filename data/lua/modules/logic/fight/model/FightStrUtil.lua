local var_0_0 = class("FightStrUtil")
local var_0_1 = "true"
local var_0_2 = "false"

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.split(arg_2_0, arg_2_1)
	arg_2_0 = tostring(arg_2_0)
	arg_2_1 = tostring(arg_2_1)

	if arg_2_1 == "" then
		return false
	end

	local var_2_0 = 0
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in function()
		return string.find(arg_2_0, arg_2_1, var_2_0, true)
	end do
		table.insert(var_2_1, string.sub(arg_2_0, var_2_0, iter_2_0 - 1))

		var_2_0 = iter_2_1 + 1
	end

	table.insert(var_2_1, string.sub(arg_2_0, var_2_0))

	return var_2_1
end

function var_0_0.splitToNumber(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(var_0_0.split(arg_4_0, arg_4_1)) do
		var_4_0[iter_4_0] = tonumber(iter_4_1)
	end

	return var_4_0
end

function var_0_0.splitString2(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if string.nilorempty(arg_5_0) then
		return
	end

	arg_5_2 = arg_5_2 or "|"
	arg_5_3 = arg_5_3 or "#"

	local var_5_0 = var_0_0.split(arg_5_0, arg_5_2)

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if arg_5_1 then
			var_5_0[iter_5_0] = var_0_0.splitToNumber(iter_5_1, arg_5_3)
		else
			var_5_0[iter_5_0] = var_0_0.split(iter_5_1, arg_5_3)
		end
	end

	return var_5_0
end

function var_0_0.init(arg_6_0)
	arg_6_0.inited = true
end

function var_0_0.getSplitCache(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:logNoInFight()

	local var_7_0 = tostring(arg_7_2)

	if not arg_7_0._splitCache then
		arg_7_0._splitCache = {}
	end

	if not arg_7_0._splitCache[var_7_0] then
		arg_7_0._splitCache[var_7_0] = {}
	end

	local var_7_1 = arg_7_0._splitCache[var_7_0]
	local var_7_2 = tostring(arg_7_1)

	if not var_7_1[var_7_2] then
		var_7_1[var_7_2] = arg_7_0.split(arg_7_1, arg_7_2)
	end

	return var_7_1[var_7_2]
end

function var_0_0.getSplitToNumberCache(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:logNoInFight()

	local var_8_0 = tostring(arg_8_2)

	if not arg_8_0._splitToNumberCache then
		arg_8_0._splitToNumberCache = {}
	end

	if not arg_8_0._splitToNumberCache[var_8_0] then
		arg_8_0._splitToNumberCache[var_8_0] = {}
	end

	local var_8_1 = arg_8_0._splitToNumberCache[var_8_0]
	local var_8_2 = tostring(arg_8_1)

	if not var_8_1[var_8_2] then
		var_8_1[var_8_2] = arg_8_0.splitToNumber(arg_8_1, arg_8_2)
	end

	return var_8_1[var_8_2]
end

function var_0_0.getSplitString2Cache(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0:logNoInFight()

	if string.nilorempty(arg_9_1) then
		return
	end

	arg_9_3 = arg_9_3 or "|"
	arg_9_4 = arg_9_4 or "#"

	local var_9_0 = arg_9_2 and var_0_1 or var_0_2

	if not arg_9_0._splitString2Cache then
		arg_9_0._splitString2Cache = {}
	end

	if not arg_9_0._splitString2Cache[var_9_0] then
		arg_9_0._splitString2Cache[var_9_0] = {}
	end

	if not arg_9_0._splitString2Cache[var_9_0][arg_9_3] then
		arg_9_0._splitString2Cache[var_9_0][arg_9_3] = {}
	end

	if not arg_9_0._splitString2Cache[var_9_0][arg_9_3][arg_9_4] then
		arg_9_0._splitString2Cache[var_9_0][arg_9_3][arg_9_4] = {}
	end

	local var_9_1 = arg_9_0._splitString2Cache[var_9_0][arg_9_3][arg_9_4]
	local var_9_2 = tostring(arg_9_1)

	if not var_9_1[var_9_2] then
		var_9_1[var_9_2] = arg_9_0.splitString2(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	end

	return var_9_1[var_9_2]
end

function var_0_0.logNoInFight(arg_10_0)
	if not arg_10_0.inited and GameUtil.needLogInOtherSceneUseFightStrUtilFunc() then
		logError("不在战斗内，不要调用`FightStrUtil`相关接口")
	end
end

function var_0_0.dispose(arg_11_0)
	arg_11_0.inited = nil

	if arg_11_0._splitCache then
		arg_11_0._splitCache = nil
	end

	if arg_11_0._splitToNumberCache then
		arg_11_0._splitToNumberCache = nil
	end

	if arg_11_0._splitString2Cache then
		arg_11_0._splitString2Cache = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
