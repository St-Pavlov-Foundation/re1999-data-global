module("modules.logic.scene.room.comp.RoomSceneViewComp", package.seeall)

slot0 = class("RoomSceneViewComp", BaseSceneComp)
slot0.OnOpenView = 1

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot6 = ViewEvent.OnOpenView
	slot7 = slot0._onOpenView

	ViewMgr.instance:registerCallback(slot6, slot7, slot0)

	slot0._views = {
		[ViewName.RoomView] = false
	}

	for slot6, slot7 in pairs(slot0._views) do
		ViewMgr.instance:openView(slot6, true)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot0._views[slot1] ~= nil then
		slot0._views[slot1] = true

		slot0:_check()
	end
end

function slot0._check(slot0)
	for slot4, slot5 in pairs(slot0._views) do
		if slot5 == false then
			return
		end
	end

	for slot5, slot6 in ipairs(RoomController.instance:getOpenViews()) do
		if slot6.viewName == ViewName.RoomInitBuildingView then
			RoomMapController.instance:openRoomInitBuildingView(0, slot6.param)
		else
			ViewMgr.instance:openView(slot6.viewName, slot6.param)
		end
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:dispatchEvent(uv0.OnOpenView)
end

function slot0.onSceneClose(slot0)
	slot4 = ViewEvent.OnOpenView
	slot5 = slot0._onOpenView

	ViewMgr.instance:unregisterCallback(slot4, slot5, slot0)

	for slot4, slot5 in pairs(slot0._views) do
		ViewMgr.instance:closeView(slot4, true)
	end

	ViewMgr.instance:closeAllPopupViews()
end

return slot0
