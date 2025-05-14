module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoleRecoverPresetListModel", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRecoverPresetListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getEquip(arg_3_0, arg_3_1)
	return arg_3_0._equipMap[arg_3_1]
end

function var_0_0.initList(arg_4_0)
	V1a6_CachotTeamModel.instance:clearSeatInfos()

	local var_4_0 = V1a6_CachotModel.instance:getRogueInfo().teamInfo
	local var_4_1 = var_4_0:getGroupLiveHeros()
	local var_4_2 = var_4_0:getGroupEquips()

	arg_4_0._equipMap = {}

	local var_4_3 = {}

	for iter_4_0 = 1, V1a6_CachotEnum.HeroCountInGroup do
		local var_4_4 = var_4_1[iter_4_0]

		table.insert(var_4_3, var_4_4)

		local var_4_5 = var_4_2[iter_4_0]

		arg_4_0._equipMap[var_4_4] = var_4_5

		V1a6_CachotTeamModel.instance:setSeatInfo(iter_4_0, V1a6_CachotTeamModel.instance:getSeatLevel(iter_4_0), var_4_4)
	end

	arg_4_0:setList(var_4_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
