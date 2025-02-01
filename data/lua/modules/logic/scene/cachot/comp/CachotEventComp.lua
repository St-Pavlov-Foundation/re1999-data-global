module("modules.logic.scene.cachot.comp.CachotEventComp", package.seeall)

slot0 = class("CachotEventComp", BaseSceneComp)

function slot0.init(slot0)
	slot0._isShowEvents = true
	slot0._eventItems = {}
	slot0._preloadComp = slot0:getCurScene().preloader
	slot0._levelComp = slot0:getCurScene().level

	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, slot0._clearEvents, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.TriggerEvent, slot0._clearEvents, slot0)
	slot0._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0.onSceneLevelLoaded, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._checkHaveViewOpen, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._checkHaveViewOpen, slot0)

	if slot0._levelComp:getSceneGo() then
		slot0:onSceneLevelLoaded()
	end
end

function slot0._checkHaveViewOpen(slot0)
	slot1 = ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	})

	if PopupController.instance:getPopupCount() > 0 then
		slot1 = false
	end

	if ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView) then
		slot1 = false
	end

	if slot0._isShowEvents ~= slot1 then
		slot0._isShowEvents = slot1

		for slot5, slot6 in pairs(slot0._eventItems) do
			gohelper.setActive(slot6.go, slot1)
		end
	end
end

function slot0._clearEvents(slot0)
	for slot4, slot5 in pairs(slot0._eventItems) do
		gohelper.destroy(slot5.go)
	end

	slot0._eventItems = {}
end

function slot0.onSceneLevelLoaded(slot0)
	slot0:_checkHaveViewOpen()

	for slot5 = 1, #V1a6_CachotRoomModel.instance:getRoomEventMos() do
		slot6 = slot1[slot5]
		slot8 = slot0._preloadComp:getResInst(CachotScenePreloader.EventItem, slot0._levelComp:getEventTr(slot6.index).gameObject)

		gohelper.removeEffectNode(slot8)

		slot0._eventItems[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(slot8, CachotEventItem)

		slot0._eventItems[slot5]:updateMo(slot6)
		gohelper.setActive(slot8, slot0._isShowEvents)
	end
end

function slot0.onSceneClose(slot0)
	slot0._eventItems = {}

	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, slot0._clearEvents, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.TriggerEvent, slot0._clearEvents, slot0)
	slot0._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0.onSceneLevelLoaded, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._checkHaveViewOpen, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._checkHaveViewOpen, slot0)
end

return slot0
