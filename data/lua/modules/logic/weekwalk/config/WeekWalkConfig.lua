module("modules.logic.weekwalk.config.WeekWalkConfig", package.seeall)

local var_0_0 = class("WeekWalkConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"weekwalk",
		"weekwalk_element",
		"weekwalk_buff",
		"weekwalk_buff_pool",
		"weekwalk_level",
		"weekwalk_bonus",
		"weekwalk_element_res",
		"weekwalk_dialog",
		"weekwalk_question",
		"weekwalk_pray",
		"weekwalk_handbook",
		"weekwalk_branch",
		"weekwalk_type",
		"weekwalk_scene",
		"weekwalk_rule"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "weekwalk_dialog" then
		arg_3_0:_initDialog()
	elseif arg_3_1 == "weekwalk" then
		arg_3_0:_initWeekwalk()
	end
end

function var_0_0.getSceneConfigByLayer(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(lua_weekwalk.configList) do
		if iter_4_1.layer == arg_4_1 then
			return lua_weekwalk_scene.configDict[iter_4_1.sceneId]
		end
	end
end

function var_0_0._initWeekwalk(arg_5_0)
	arg_5_0._issueList = {}

	for iter_5_0, iter_5_1 in ipairs(lua_weekwalk.configList) do
		if iter_5_1.issueId > 0 then
			local var_5_0 = arg_5_0._issueList[iter_5_1.issueId] or {}

			arg_5_0._issueList[iter_5_1.issueId] = var_5_0

			table.insert(var_5_0, iter_5_1)
		end
	end
end

function var_0_0.getDeepLayer(arg_6_0, arg_6_1)
	return arg_6_0._issueList[arg_6_1]
end

function var_0_0._initDialog(arg_7_0)
	arg_7_0._dialogList = {}

	local var_7_0
	local var_7_1 = "0"

	for iter_7_0, iter_7_1 in ipairs(lua_weekwalk_dialog.configList) do
		local var_7_2 = arg_7_0._dialogList[iter_7_1.id]

		if not var_7_2 then
			var_7_2 = {
				optionParamList = {}
			}
			var_7_0 = var_7_1
			arg_7_0._dialogList[iter_7_1.id] = var_7_2
		end

		if not string.nilorempty(iter_7_1.option_param) then
			table.insert(var_7_2.optionParamList, tonumber(iter_7_1.option_param))
		end

		if iter_7_1.type == "selector" then
			var_7_0 = iter_7_1.param
			var_7_2[var_7_0] = var_7_2[var_7_0] or {}
			var_7_2[var_7_0].type = iter_7_1.type
			var_7_2[var_7_0].option_param = iter_7_1.option_param
		elseif iter_7_1.type == "selectorend" then
			var_7_0 = var_7_1
		elseif iter_7_1.type == "random" then
			local var_7_3 = iter_7_1.param

			var_7_2[var_7_3] = var_7_2[var_7_3] or {}
			var_7_2[var_7_3].type = iter_7_1.type
			var_7_2[var_7_3].option_param = iter_7_1.option_param

			table.insert(var_7_2[var_7_3], iter_7_1)
		else
			var_7_2[var_7_0] = var_7_2[var_7_0] or {}

			table.insert(var_7_2[var_7_0], iter_7_1)
		end
	end
end

function var_0_0.getDialog(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._dialogList[arg_8_1]

	return var_8_0 and var_8_0[arg_8_2]
end

function var_0_0.getOptionParamList(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._dialogList[arg_9_1]

	return var_9_0 and var_9_0.optionParamList
end

function var_0_0.getMapConfig(arg_10_0, arg_10_1)
	return lua_weekwalk.configDict[arg_10_1]
end

function var_0_0.getMapTypeConfig(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return nil
	end

	local var_11_0 = arg_11_0:getMapConfig(arg_11_1)

	return lua_weekwalk_type.configDict[var_11_0.type]
end

function var_0_0.getElementConfig(arg_12_0, arg_12_1)
	local var_12_0 = lua_weekwalk_element.configDict[arg_12_1]

	if not var_12_0 then
		logError(string.format("getElementConfig no config id:%s", arg_12_1))
	end

	return var_12_0
end

function var_0_0.getLevelConfig(arg_13_0, arg_13_1)
	return lua_weekwalk_level.configDict[arg_13_1]
end

function var_0_0.getBonus(arg_14_0, arg_14_1, arg_14_2)
	return lua_weekwalk_bonus.configDict[arg_14_1][arg_14_2].bonus
end

function var_0_0.getQuestionConfig(arg_15_0, arg_15_1)
	return lua_weekwalk_question.configDict[arg_15_1]
end

function var_0_0.getMapBranchCoList(arg_16_0, arg_16_1)
	if arg_16_0.mapIdToBranchCoDict then
		return arg_16_0.mapIdToBranchCoDict[arg_16_1]
	end

	arg_16_0.mapIdToBranchCoDict = {}

	for iter_16_0, iter_16_1 in ipairs(lua_weekwalk_branch.configList) do
		if not arg_16_0.mapIdToBranchCoDict[iter_16_1.mapId] then
			arg_16_0.mapIdToBranchCoDict[iter_16_1.mapId] = {}
		end

		table.insert(arg_16_0.mapIdToBranchCoDict[iter_16_1.mapId], iter_16_1)
	end

	return arg_16_0.mapIdToBranchCoDict[arg_16_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
