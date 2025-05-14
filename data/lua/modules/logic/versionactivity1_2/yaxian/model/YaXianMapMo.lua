module("modules.logic.versionactivity1_2.yaxian.model.YaXianMapMo", package.seeall)

local var_0_0 = pureTable("YaXianMapMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1

	arg_1_0:updateMO(arg_1_2)
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.episodeId = arg_2_1.id
	arg_2_0.currentRound = arg_2_1.currentRound
	arg_2_0.currentEvent = arg_2_1.currentEvent

	arg_2_0:updateInteractObjects(arg_2_1.interactObjects)
	arg_2_0:updateFinishInteracts(arg_2_1.finishInteracts)

	arg_2_0.episodeCo = YaXianConfig.instance:getEpisodeConfig(arg_2_0.actId, arg_2_0.episodeId)
	arg_2_0.mapId = arg_2_0.episodeCo.mapId
end

function var_0_0.updateInteractObjects(arg_3_0, arg_3_1)
	arg_3_0.interactObjs = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = YaXianGameInteractMO.New()

		var_3_0:init(arg_3_0.actId, iter_3_1)
		table.insert(arg_3_0.interactObjs, var_3_0)
	end
end

function var_0_0.updateFinishInteracts(arg_4_0, arg_4_1)
	arg_4_0.finishInteracts = arg_4_1
end

return var_0_0
