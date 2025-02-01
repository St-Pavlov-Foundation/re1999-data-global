module("modules.logic.explore.controller.steps.ExploreRoleMoveStep", package.seeall)

slot0 = class("ExploreRoleMoveStep", ExploreStepBase)

function slot0.onStart(slot0)
	slot1 = ExploreController.instance:getMap():getHero()

	if ExploreModel.instance.isReseting then
		slot1:setPosByNode(slot0._data, false)
		slot0:onDone()

		return
	end

	if slot1:isMoving() and ExploreHelper.getDistance(slot1.nodePos, slot0._data) == 1 then
		ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, slot0._onCharacterNodeChange, slot0)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, slot0._onCharacterNodeChange, slot0)
	else
		slot0:onDone()
	end
end

function slot0._onCharacterNodeChange(slot0)
	slot0:onDone()
end

function slot0.onDestory(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, slot0._onCharacterNodeChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, slot0._onCharacterNodeChange, slot0)
	uv0.super.onDestory(slot0)
end

return slot0
