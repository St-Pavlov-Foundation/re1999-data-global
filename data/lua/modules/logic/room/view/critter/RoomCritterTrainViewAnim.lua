module("modules.logic.room.view.critter.RoomCritterTrainViewAnim", package.seeall)

slot0 = class("RoomCritterTrainViewAnim", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._lastIshow = true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	slot0:_setShowView(slot0:_isCheckShowView())
end

function slot0._onCloseView(slot0, slot1)
	slot0:_setShowView(slot0:_isCheckShowView())
end

function slot0._setShowView(slot0, slot1)
	if slot0._lastIshow ~= slot1 then
		slot0._lastIshow = slot1

		gohelper.setActive(slot0.viewGO, slot1)

		if slot1 then
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
		else
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
		end
	end
end

function slot0._setBuildingShowView(slot0, slot1)
	if slot0._lastBuildingShow ~= slot1 then
		slot0._lastBuildingShow = slot1
	end
end

function slot0._isCheckShowView(slot0)
	if not slot0._showHitViewNameList then
		slot0._showHitViewNameList = {
			ViewName.RoomCritterTrainEventView,
			ViewName.RoomCritterTrainStoryView,
			ViewName.RoomBranchView,
			ViewName.RoomCritterTrainEventResultView
		}
	end

	for slot4, slot5 in ipairs(slot0._showHitViewNameList) do
		if ViewMgr.instance:isOpen(slot5) then
			return false
		end
	end

	return true
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
