module("modules.logic.scene.newbie.NewbieScene", package.seeall)

slot0 = class("NewbieScene", BaseScene)

function slot0._createAllComps(slot0)
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenFinish, slot0)
	TaskDispatcher.cancelTask(slot0._resetScenePos, slot0)
	slot0:_removeEvents()
end

function slot0.onPrepared(slot0)
	uv0.super.onPrepared(slot0)

	if slot0.level then
		if gohelper.isNil(slot0.level:getSceneGo()) then
			return
		end

		slot0:_moveScene(0.5)

		if ViewMgr.instance:isOpenFinish(ViewName.StoryView) then
			slot0:_onOpenFinish(ViewName.StoryView)

			return
		end

		slot0:_addEvents()
	end
end

function slot0._addEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenFinish, slot0)
	MainController.instance:registerCallback(MainEvent.GuideSetDelayTime, slot0._onGuideSetDelayTime, slot0)
end

function slot0._removeEvents(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenFinish, slot0)
	MainController.instance:unregisterCallback(MainEvent.GuideSetDelayTime, slot0._onGuideSetDelayTime, slot0)
end

function slot0._onGuideSetDelayTime(slot0, slot1)
	if gohelper.isNil(slot0.level:getSceneGo()) then
		return
	end

	slot0:_moveScene(slot1)
	TaskDispatcher.runDelay(slot0._resetScenePos, slot0, 2)
end

function slot0._moveScene(slot0, slot1)
	if gohelper.isNil(slot0.level:getSceneGo()) then
		return
	end

	transformhelper.setLocalPosXY(slot2.transform, 0, 100)

	slot0._delayTime = tonumber(slot1)
end

function slot0._onOpenFinish(slot0, slot1)
	if slot1 == ViewName.StoryView and slot0._delayTime then
		TaskDispatcher.cancelTask(slot0._resetScenePos, slot0)
		TaskDispatcher.runDelay(slot0._resetScenePos, slot0, slot0._delayTime)

		slot0._delayTime = nil
	end
end

function slot0._resetScenePos(slot0)
	if gohelper.isNil(slot0.level:getSceneGo()) then
		return
	end

	transformhelper.setLocalPosXY(slot1.transform, 0, 0)
end

function slot0.onStart(slot0, slot1, slot2)
	if not DungeonModel.instance:hasPassLevel(10003) then
		slot0:onPrepared()
	else
		if not slot0._isAddComps then
			slot0._isAddComps = true

			slot0:_addComp("level", NewbieSceneLevelComp)
			slot0:_addComp("camera", CommonSceneCameraComp)

			slot6 = MainSceneYearAnimationComp

			slot0:_addComp("yearAnimation", slot6)

			for slot6, slot7 in ipairs(slot0._allComps) do
				if slot7.onInit then
					slot7:onInit()
				end
			end

			slot0.yearAnimation.forcePlayAnimation = true
		end

		uv0.super.onStart(slot0, slot1, 10101)
	end
end

return slot0
