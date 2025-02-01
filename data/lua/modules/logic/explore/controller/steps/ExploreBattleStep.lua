module("modules.logic.explore.controller.steps.ExploreBattleStep", package.seeall)

slot0 = class("ExploreBattleStep", ExploreStepBase)

function slot0.onStart(slot0)
	slot1 = ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId())

	DungeonFightController.instance:enterFightByBattleId(slot1.chapterId, slot1.episodeId, slot0._data.battleId)
	slot0:onDone()
end

return slot0
