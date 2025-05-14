module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotTeamPreviewPrepareListModel", package.seeall)

local var_0_0 = class("V1a6_CachotTeamPreviewPrepareListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.initList(arg_3_0)
	local var_3_0 = V1a6_CachotModel.instance:getRogueInfo().teamInfo:getSupportHeros()
	local var_3_1 = math.ceil(#var_3_0 / 4)
	local var_3_2 = math.max(var_3_1, 1)

	for iter_3_0 = #var_3_0 + 1, var_3_2 * 4 do
		table.insert(var_3_0, HeroSingleGroupMO.New())
	end

	arg_3_0:setList(var_3_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
