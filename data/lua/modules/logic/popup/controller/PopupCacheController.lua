module("modules.logic.popup.controller.PopupCacheController", package.seeall)

slot0 = class("PopupCacheController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._viewChangeCheckIsInMainView, slot0)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.MainView then
		return
	end

	slot0:_viewChangeCheckIsInMainView()
end

function slot0._viewChangeCheckIsInMainView(slot0)
	if not PopupCacheModel.instance:getCount() or slot1 <= 0 then
		return
	end

	if not MainController.instance:isInMainView() then
		return
	end

	if PopupHelper.checkInGuide() then
		return
	end

	slot0:showCachePopupView()
end

function slot0.showCachePopupView(slot0)
	if not PopupCacheModel.instance:popNextPopupParam() then
		return
	end

	if slot1.customPopupFunc then
		slot2(slot1)
	else
		slot0:defaultShowCommonPropView(slot1)
	end
end

function slot0.defaultShowCommonPropView(slot0, slot1)
	if not (slot1 and slot1.materialDataMOList) then
		return
	end

	RoomController.instance:popUpRoomBlockPackageView(slot2)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot2)
end

function slot0.tryCacheGetPropView(slot0, slot1, slot2)
	if type(slot2) ~= "table" then
		logError(string.format("PopupCacheController:tryCacheGetPropView error, need table param"))

		return false
	end

	slot3 = false

	for slot8, slot9 in ipairs(slot1 and PopupEnum.CheckCacheGetApproach[slot1] or {}) do
		if PopupEnum.CheckCacheHandler[slot9] and slot10() or false then
			slot2.cacheType = slot9

			PopupCacheModel.instance:recordCachePopupParam(slot2)

			slot3 = true

			break
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
