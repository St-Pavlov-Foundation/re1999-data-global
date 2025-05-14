module("modules.logic.versionactivity1_9.fairyland.config.FairyLandConfig", package.seeall)

local var_0_0 = class("FairyLandConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"fairyland_puzzle",
		"fairyland_puzzle_talk",
		"fairy_land_element",
		"fairyland_text"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "fairyland_puzzle" then
		arg_3_0._fairlyLandPuzzleConfig = arg_3_2
	elseif arg_3_1 == "fairyland_puzzle_talk" then
		arg_3_0:_initDialog()
	elseif arg_3_1 == "fairy_land_element" then
		arg_3_0._fairlyLandElementConfig = arg_3_2
	end
end

function var_0_0.getFairlyLandPuzzleConfig(arg_4_0, arg_4_1)
	return arg_4_0._fairlyLandPuzzleConfig.configDict[arg_4_1]
end

function var_0_0.getTalkStepConfig(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getTalkConfig(arg_5_1)

	return var_5_0 and var_5_0[arg_5_2]
end

function var_0_0.getElements(arg_6_0)
	return arg_6_0._fairlyLandElementConfig.configList
end

function var_0_0.getElementConfig(arg_7_0, arg_7_1)
	return arg_7_0._fairlyLandElementConfig.configDict[arg_7_1]
end

function var_0_0._initDialog(arg_8_0)
	arg_8_0._dialogList = {}

	local var_8_0
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(lua_fairyland_puzzle_talk.configList) do
		local var_8_2 = arg_8_0._dialogList[iter_8_1.id]

		if not var_8_2 then
			var_8_2 = {}
			var_8_0 = var_8_1
			arg_8_0._dialogList[iter_8_1.id] = var_8_2
		end

		if iter_8_1.type == "selector" then
			var_8_0 = tonumber(iter_8_1.param)
			var_8_2[var_8_0] = var_8_2[var_8_0] or {}
		elseif iter_8_1.type == "selectorend" then
			var_8_0 = var_8_1
		else
			var_8_2[var_8_0] = var_8_2[var_8_0] or {}

			table.insert(var_8_2[var_8_0], iter_8_1)
		end
	end
end

function var_0_0.getDialogConfig(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._dialogList[arg_9_1]

	return var_9_0 and var_9_0[arg_9_2]
end

function var_0_0.addTextDict(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_3[arg_10_2]

	if not var_10_0 then
		var_10_0 = {}
		arg_10_3[arg_10_2] = var_10_0
	end

	table.insert(var_10_0, arg_10_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
