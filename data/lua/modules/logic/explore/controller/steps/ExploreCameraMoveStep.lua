module("modules.logic.explore.controller.steps.ExploreCameraMoveStep", package.seeall)

slot0 = class("ExploreCameraMoveStep", ExploreStepBase)

function slot0.onStart(slot0)
	slot0.moveTime = slot0._data.moveTime
	slot0.keepTime = slot0._data.keepTime

	if ExploreMapTriggerController.instance:getMap():getUnit(slot0._data.id) then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.MoveCamera)

		slot0.tarPos = slot3:getPos()
		slot0.startPos = slot2:getHero():getPos()
		slot0.offPos = slot0.tarPos - slot0.startPos
		slot5 = {
			alwaysLast = true,
			stepType = ExploreEnum.StepType.CameraMoveBack,
			keepTime = slot0.keepTime
		}

		if slot0.offPos.sqrMagnitude > 100 then
			ViewMgr.instance:openView(ViewName.ExploreBlackView)
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
		else
			slot5.fromPos = slot0.tarPos
			slot5.offPos = slot0.offPos
			slot5.moveTime = slot0.moveTime
			slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0.moveTime, slot0.moveToTar, slot0.moveToTarDone, slot0)
		end

		ExploreStepController.instance:insertClientStep(slot5)
	else
		logError("Explore not find unit:" .. slot1)
		slot0:onDone()
	end
end

function slot0.moveToTar(slot0, slot1)
	slot2 = slot0.startPos + slot0.offPos * slot1

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, slot2)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot2)
end

function slot0.moveToTarDone(slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, slot0.tarPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot0.tarPos)
	slot0:onDone()
end

function slot0.startMoveBack(slot0)
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0.moveTime, slot0.moveBack, slot0.moveBackDone, slot0)
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, slot0.tarPos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, slot0.tarPos)
	TaskDispatcher.runDelay(slot0._delayLoadObj, slot0, 0.1)
end

function slot0._delayLoadObj(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function slot0.onBlackEnd(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.ExploreBlackView then
		slot0:onDone()
	end
end

function slot0.onDestory(slot0)
	uv0.super.onDestory(slot0)
	TaskDispatcher.cancelTask(slot0._delayLoadObj, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)
	TaskDispatcher.cancelTask(slot0.startMoveBack, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

return slot0
