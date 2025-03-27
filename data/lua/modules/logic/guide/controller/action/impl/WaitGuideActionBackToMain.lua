module("modules.logic.guide.controller.action.impl.WaitGuideActionBackToMain", package.seeall)

slot0 = class("WaitGuideActionBackToMain", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onEnterMainScene, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._checkInMain, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkInMain, slot0)

	slot0._needView = slot0.actionParam

	slot0:_checkInMain()
end

function slot0._onEnterMainScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:_checkInMain()
	end
end

function slot0._checkInMain(slot0)
	if slot0:checkGuideLock() then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main and not GameSceneMgr.instance:isLoading() and not GameSceneMgr.instance:isClosing() then
		slot4 = false

		for slot9, slot10 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
			if slot10 ~= slot0._needView and (ViewMgr.instance:isModal(slot10) or ViewMgr.instance:isFull(slot10)) then
				slot4 = true

				break
			end
		end

		if not slot4 and (string.nilorempty(slot0._needView) or ViewMgr.instance:isOpen(slot0._needView)) then
			slot0:_removeEvents()
			slot0:onDone(true)
		end
	end
end

function slot0._removeEvents(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneType.Main, slot0._onEnterMainScene, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._checkInMain, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkInMain, slot0)
end

function slot0.clearWork(slot0)
	slot0:_removeEvents()
end

return slot0
