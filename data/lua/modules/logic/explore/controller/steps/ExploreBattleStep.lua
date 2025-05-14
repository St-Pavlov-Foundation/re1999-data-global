module("modules.logic.explore.controller.steps.ExploreBattleStep", package.seeall)

local var_0_0 = class("ExploreBattleStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId())

	DungeonFightController.instance:enterFightByBattleId(var_1_0.chapterId, var_1_0.episodeId, arg_1_0._data.battleId)
	arg_1_0:onDone()
end

return var_0_0
