module("modules.logic.scene.common.camera.MainCameraMgr", package.seeall)

slot0 = class("MainCameraMgr")

function slot0.ctor(slot0)
	slot0._viewList = {}

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0._onOpenView(slot0, slot1)
	slot0:_checkCamera()
end

function slot0._onCloseView(slot0, slot1)
	slot0:_setCamera(slot1, false)

	slot0._viewList[slot1] = nil

	slot0:_checkCamera()
end

function slot0._onScreenResize(slot0)
	slot0:_checkCamera()
end

function slot0.addView(slot0, slot1, slot2, slot3, slot4)
	slot0._viewList[slot1] = {
		setCallback = slot2,
		resetCallback = slot3,
		target = slot4
	}

	slot0:_checkCamera()
end

function slot0._checkCamera(slot0)
	if slot0:_getTopViewCamera() then
		slot0:_setCamera(slot1, true)
	end
end

function slot0._setCamera(slot0, slot1, slot2)
	if slot0._isLock then
		return
	end

	if not slot0._viewList[slot1] then
		return
	end

	if slot2 then
		if slot3.setCallback then
			slot3.setCallback(slot3.target)
		end
	else
		slot0:_resetCamera()

		if slot3.resetCallback then
			slot3.resetCallback(slot3.target)
		end
	end
end

function slot0._resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false

	transformhelper.setLocalPos(slot1.transform, 0, 0, 0)
end

function slot0._getTopViewCamera(slot0)
	for slot5 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if slot0._viewList[slot1[slot5]] then
			return slot6
		end
	end
end

function slot0.setLock(slot0, slot1)
	slot0._isLock = slot1

	if not slot1 then
		slot0:_checkCamera()
	end
end

slot0.instance = slot0.New()

return slot0
