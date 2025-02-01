module("modules.logic.explore.controller.steps.ExploreSpikeStep", package.seeall)

slot0 = class("ExploreSpikeStep", ExploreStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data.triggerInteractId

	GameSceneMgr.instance:getCurScene().stat:onTriggerSpike(slot1)
	ExploreModel.instance:addChallengeCount()

	if not ExploreController.instance:getMap():getUnit(slot1) or slot2:getUnitType() ~= ExploreEnum.ItemType.Spike then
		slot0:onDone()

		return
	end

	ViewMgr.instance:closeView(ViewName.ExploreEnterView)
	ExploreMapModel.instance:updatHeroPos(slot0._data.x, slot0._data.y, 0)
	ExploreHeroFallAnimFlow.instance:begin(slot0._data, slot1)
	slot0:onDone()
end

return slot0
