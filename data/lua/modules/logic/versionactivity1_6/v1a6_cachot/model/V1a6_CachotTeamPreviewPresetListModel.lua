module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotTeamPreviewPresetListModel", package.seeall)

local var_0_0 = class("V1a6_CachotTeamPreviewPresetListModel")

function var_0_0.getEquip(arg_1_0, arg_1_1)
	return arg_1_0._equipMap[arg_1_1]
end

function var_0_0.initList(arg_2_0)
	local var_2_0 = V1a6_CachotModel.instance:getRogueInfo().teamInfo
	local var_2_1 = var_2_0:getGroupHeros()
	local var_2_2 = var_2_0:getGroupEquips()

	arg_2_0._equipMap = {}

	local var_2_3 = {}

	for iter_2_0 = 1, V1a6_CachotEnum.HeroCountInGroup do
		local var_2_4 = var_2_1[iter_2_0] or HeroSingleGroupMO.New()

		table.insert(var_2_3, var_2_4)

		local var_2_5 = var_2_2[iter_2_0]

		arg_2_0._equipMap[var_2_4] = var_2_5

		V1a6_CachotTeamModel.instance:setSeatInfo(iter_2_0, V1a6_CachotTeamModel.instance:getSeatLevel(iter_2_0), var_2_4)
	end

	return var_2_3
end

var_0_0.instance = var_0_0.New()

return var_0_0
