module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreClickNode", package.seeall)

slot0 = class("WaitGuideActionExploreClickNode", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	slot4 = tonumber(slot2[2]) or 0
	slot5 = tonumber(slot2[3]) or 0
	slot7, slot8 = ExploreMapModel.instance:getHeroPos()

	if slot7 == (tonumber(string.split(slot0.actionParam, "#")[1]) or 0) and slot8 == slot4 and ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.Normal then
		slot0:onDone(true)

		return
	end

	slot10 = 0

	if ExploreMapModel.instance:getNode(ExploreHelper.getKeyXY(slot3, slot4)) then
		slot10 = slot9.rawHeight
	end

	slot0._targetPos = Vector3.New(slot3 + 0.5, slot10 + slot5, slot4 + 0.5)

	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, slot0._setMaskPosAndClickAction, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._setMaskPosAndClickAction, slot0)

	if not ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenViewFinish, slot0)
	else
		slot0:_setMaskPosAndClickAction()
	end
end

function slot0._checkOpenViewFinish(slot0, slot1, slot2)
	if ViewName.GuideView ~= slot1 then
		return
	end

	slot0:_setMaskPosAndClickAction()
end

function slot0._setMaskPosAndClickAction(slot0)
	if not ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		return
	end

	GuideController.instance:dispatchEvent(GuideEvent.SetMaskPosition, slot0._targetPos, true)
	GuideViewMgr.instance:setHoleClickCallback(slot0._onHoldClick, slot0)
end

function slot0._getScreenPos(slot0)
	return CameraMgr.instance:getMainCamera():WorldToScreenPoint(slot0._targetPos)
end

function slot0._onHoldClick(slot0, slot1)
	slot2 = slot0:_getScreenPos()

	if slot1 or not slot0._isForceGuide or slot0:isOutScreen(slot2) then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickMap, slot2)
		GuideController.instance:dispatchEvent(GuideEvent.SetMaskPosition, nil)
		GuideViewMgr.instance:close()
		slot0:onDone(true)
	end
end

function slot0.isOutScreen(slot0, slot1)
	if slot1.x < 0 or slot1.y < 0 or UnityEngine.Screen.width < slot1.x or UnityEngine.Screen.height < slot1.y then
		return true
	end

	return false
end

function slot0.clearWork(slot0)
	GuideViewMgr.instance:setHoleClickCallback(nil, )
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, slot0._setMaskPosAndClickAction, slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._setMaskPosAndClickAction, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenViewFinish, slot0)
end

return slot0
