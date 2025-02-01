module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTweenCamera", package.seeall)

slot0 = class("WaitGuideActionExploreTweenCamera", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.MoveCamera)

	if not ExploreController.instance:getMap() then
		logError("不在密室中？？？")
		slot0:onDone(true)
	else
		slot4, slot5 = nil

		if string.split(slot0.actionParam, "#")[1] == "POS" then
			slot5 = tonumber(slot3[4]) or 0
			slot9 = 0

			if ExploreMapModel.instance:getNode(ExploreHelper.getKeyXY(tonumber(slot3[2]) or 0, tonumber(slot3[3]) or 0)) then
				slot9 = slot8.rawHeight
			end

			slot4 = Vector3.New(slot6 + 0.5, slot9, slot7 + 0.5)
		elseif slot3[1] == "ID" then
			if slot2:getUnit(tonumber(slot3[2])) then
				slot4 = slot6:getPos()
			end

			slot5 = tonumber(slot3[3]) or 0
		elseif slot3[1] == "HERO" then
			if slot2:getHero() then
				slot4 = slot6:getPos()
			end

			slot5 = tonumber(slot3[2]) or 0

			ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, slot0.onHeroPosChange, slot0)
		else
			logError("暂不支持相机移动类型")
		end

		if not slot4 then
			slot0:onDone(true)
		else
			slot0._movePos = slot4
			slot0._moveTime = slot5

			if slot5 > 0 then
				GuideBlockMgr.instance:startBlock(slot5)
			end

			slot0:_beginMove()
		end
	end
end

function slot0.onHeroPosChange(slot0, slot1)
	slot0._movePos = slot1
	slot0._offPos = slot0._movePos - slot0._beginPos
end

function slot0._beginMove(slot0)
	slot0._beginPos = CameraMgr.instance:getFocusTrs().position
	slot0._offPos = slot0._movePos - slot0._beginPos

	if slot0._offPos.sqrMagnitude > 100 then
		ViewMgr.instance:openView(ViewName.ExploreBlackView)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	else
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0._moveTime, slot0._moveToTar, slot0._moveToTarDone, slot0)
	end
end

function slot0._moveToTar(slot0, slot1)
	slot2 = slot0._beginPos + slot0._offPos * slot1

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, slot2)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot2)
end

function slot0._moveToTarDone(slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, slot0._movePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot0._movePos)
	slot0:onDone(true)
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, slot0._movePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot0._movePos)
	TaskDispatcher.runDelay(slot0._delayLoadObj, slot0, 0.1)
end

function slot0._delayLoadObj(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, slot0._onBlackEnd, slot0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function slot0._onBlackEnd(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.ExploreBlackView then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	TaskDispatcher.cancelTask(slot0._delayLoadObj, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.MoveCamera)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, slot0.onHeroPosChange, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0._onBlackEnd, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

return slot0
