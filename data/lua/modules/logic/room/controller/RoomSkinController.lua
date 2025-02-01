module("modules.logic.room.controller.RoomSkinController", package.seeall)

slot0 = class("RoomSkinController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.clearPreviewRoomSkin(slot0)
	RoomSkinListModel.instance:setCurPreviewSkinId()
	slot0:dispatchEvent(RoomSkinEvent.ChangePreviewRoomSkin)
end

function slot0.setRoomSkinListVisible(slot0, slot1)
	if RoomSkinModel.instance:getIsShowRoomSkinList() == (slot1 ~= nil) and slot1 == RoomSkinListModel.instance:getSelectPartId() then
		return
	end

	slot7 = nil

	RoomSkinModel.instance:setIsShowRoomSkinList(slot2)

	if slot2 then
		RoomSkinListModel.instance:setRoomSkinList(slot1)

		slot7 = RoomSkinModel.instance:getEquipRoomSkin(slot1)
	end

	RoomSkinListModel.instance:setCurPreviewSkinId(slot7)
	slot0:setRoomSkinMark(slot7)
	slot0:dispatchEvent(RoomSkinEvent.SkinListViewShowChange, not slot5)
end

function slot0.selectPreviewRoomSkin(slot0, slot1)
	if not slot1 then
		return
	end

	if RoomSkinListModel.instance:getCurPreviewSkinId() and slot2 == slot1 then
		return
	end

	RoomSkinListModel.instance:setCurPreviewSkinId(slot1)
	slot0:setRoomSkinMark(slot1)
	slot0:dispatchEvent(RoomSkinEvent.ChangePreviewRoomSkin)
end

function slot0.setRoomSkinMark(slot0, slot1)
	if not slot1 then
		return
	end

	if RoomSkinModel.instance:isNewRoomSkin(slot1) then
		RoomRpc.instance:sendReadRoomSkinRequest(slot1)
	end
end

function slot0.clearInitBuildingEntranceReddot(slot0, slot1)
	if not RoomInitBuildingEnum.InitBuildingSkinReddot[slot1 or 0] then
		return
	end

	if RedDotModel.instance:isDotShow(slot2, 0) then
		RedDotRpc.instance:sendShowRedDotRequest(slot2, false)
	end
end

function slot0.confirmEquipPreviewRoomSkin(slot0)
	slot2 = RoomSkinListModel.instance:getCurPreviewSkinId()

	if not RoomSkinListModel.instance:getSelectPartId() or not slot2 then
		return
	end

	if not RoomSkinModel.instance:isUnlockRoomSkin(slot2) then
		GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

		return
	end

	if slot2 == RoomSkinModel.instance:getEquipRoomSkin(slot1) then
		GameFacade.showToast(ToastEnum.HasChangeRoomSink)

		return
	end

	RoomRpc.instance:sendSetRoomSkinRequest(slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
