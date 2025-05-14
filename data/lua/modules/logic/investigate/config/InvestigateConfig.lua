module("modules.logic.investigate.config.InvestigateConfig", package.seeall)

local var_0_0 = class("InvestigateConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"investigate_info",
		"investigate_clue",
		"investigate_reward"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "investigate_info" then
		arg_2_0:_initInvestigateInfo()
	elseif arg_2_1 == "investigate_clue" then
		arg_2_0:_initInvestigateClue()
	end
end

function var_0_0._initInvestigateClue(arg_3_0)
	arg_3_0._investigateAllClueInfos = {}
	arg_3_0._investigateRelatedClueInfos = {}
	arg_3_0._investigateMapElementInfos = {}

	for iter_3_0, iter_3_1 in ipairs(lua_investigate_clue.configList) do
		arg_3_0._investigateAllClueInfos[iter_3_1.infoID] = arg_3_0._investigateAllClueInfos[iter_3_1.infoID] or {}

		table.insert(arg_3_0._investigateAllClueInfos[iter_3_1.infoID], iter_3_1)

		arg_3_0._investigateRelatedClueInfos[iter_3_1.infoID] = arg_3_0._investigateRelatedClueInfos[iter_3_1.infoID] or {}

		table.insert(arg_3_0._investigateRelatedClueInfos[iter_3_1.infoID], iter_3_1)

		if iter_3_1.mapElement > 0 then
			arg_3_0._investigateMapElementInfos[iter_3_1.mapElement] = iter_3_1
		end
	end
end

function var_0_0.getInvestigateClueInfoByElement(arg_4_0, arg_4_1)
	return arg_4_0._investigateMapElementInfos[arg_4_1]
end

function var_0_0.getInvestigateAllClueInfos(arg_5_0, arg_5_1)
	return arg_5_0._investigateAllClueInfos[arg_5_1]
end

function var_0_0.getInvestigateRelatedClueInfos(arg_6_0, arg_6_1)
	return arg_6_0._investigateRelatedClueInfos[arg_6_1]
end

function var_0_0._initInvestigateInfo(arg_7_0)
	arg_7_0._roleEntranceInfos = {}
	arg_7_0._roleGroupInfos = {}

	for iter_7_0, iter_7_1 in ipairs(lua_investigate_info.configList) do
		if not arg_7_0._roleEntranceInfos[iter_7_1.entrance] then
			arg_7_0._roleEntranceInfos[iter_7_1.entrance] = iter_7_1
		end

		local var_7_0 = arg_7_0._roleGroupInfos[iter_7_1.group] or {}

		table.insert(var_7_0, iter_7_1)

		arg_7_0._roleGroupInfos[iter_7_1.group] = var_7_0
	end
end

function var_0_0.getRoleEntranceInfos(arg_8_0)
	return arg_8_0._roleEntranceInfos
end

function var_0_0.getRoleGroupInfoList(arg_9_0, arg_9_1)
	return arg_9_0._roleGroupInfos[arg_9_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
