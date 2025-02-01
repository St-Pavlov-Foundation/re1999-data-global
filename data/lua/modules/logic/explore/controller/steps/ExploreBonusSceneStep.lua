module("modules.logic.explore.controller.steps.ExploreBonusSceneStep", package.seeall)

slot0 = class("ExploreBonusSceneStep", ExploreStepBase)

function slot0.onStart(slot0)
	ExploreSimpleModel.instance:onGetBonus(slot0._data.bonusSceneId, slot0._data.options)
	slot0:onDone()
end

return slot0
