module("modules.logic.patface.config.PatFaceConfig", package.seeall)

local var_0_0 = class("PatFaceConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._patFaceConfigList = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"pat_face"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.order or 0
	local var_4_1 = arg_4_1.order or 0

	if var_4_0 ~= var_4_1 then
		return var_4_0 < var_4_1
	end

	return arg_4_0.id < arg_4_1.id
end

function var_0_0.pat_faceConfigLoaded(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.configList) do
		local var_5_1 = iter_5_1.id

		var_5_0[#var_5_0 + 1] = {
			id = var_5_1,
			order = iter_5_1.patFaceOrder,
			config = iter_5_1
		}
	end

	table.sort(var_5_0, var_0_1)

	arg_5_0._patFaceConfigList = var_5_0
end

local function var_0_2(arg_6_0, arg_6_1)
	local var_6_0

	if arg_6_0 then
		var_6_0 = lua_pat_face.configDict[arg_6_0]
	end

	if not var_6_0 and not arg_6_1 then
		logError(string.format("PatFaceConfig:getCfg error, cfg is nil, id:%s", arg_6_0))
	end

	return var_6_0
end

function var_0_0.getPatFaceActivityId(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1 = var_0_2(arg_7_1)

	if var_7_1 then
		var_7_0 = var_7_1.patFaceActivityId
	end

	return var_7_0
end

function var_0_0.getPatFaceViewName(arg_8_0, arg_8_1)
	local var_8_0 = ""
	local var_8_1 = var_0_2(arg_8_1)

	if var_8_1 then
		var_8_0 = var_8_1.patFaceViewName
	end

	return var_8_0
end

function var_0_0.getPatFaceStoryId(arg_9_0, arg_9_1)
	local var_9_0 = 0
	local var_9_1 = var_0_2(arg_9_1)

	if var_9_1 then
		var_9_0 = var_9_1.patFaceStoryId
	end

	return var_9_0
end

function var_0_0.getPatFaceOrder(arg_10_0, arg_10_1)
	local var_10_0 = 0
	local var_10_1 = var_0_2(arg_10_1)

	if var_10_1 then
		var_10_0 = var_10_1.patFaceOrder
	end

	return var_10_0
end

function var_0_0.getPatFaceConfigList(arg_11_0)
	return arg_11_0._patFaceConfigList or {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
