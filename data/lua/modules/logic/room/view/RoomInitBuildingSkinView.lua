module("modules.logic.room.view.RoomInitBuildingSkinView", package.seeall)

slot0 = class("RoomInitBuildingSkinView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "right/#go_skin/title/txt")
	slot0._txttitleEn = gohelper.findChildText(slot0.viewGO, "right/#go_skin/title/txt/txtEn")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "right/#go_skin/title/icon")
	slot0._gochange = gohelper.findChild(slot0.viewGO, "right/#go_skin/bottom/#btn_change")
	slot0._btnchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_skin/bottom/#btn_change")
	slot0._gousing = gohelper.findChild(slot0.viewGO, "right/#go_skin/bottom/#go_using")
	slot0._goget = gohelper.findChild(slot0.viewGO, "right/#go_skin/bottom/#btn_get")
	slot0._btnget = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_skin/bottom/#btn_get")
	slot0._btnclose = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "right/#go_skin/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchange:AddClickListener(slot0._btnchangeOnClick, slot0)
	slot0._btnget:AddClickListener(slot0._btngetOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, slot0.onSkinListViewShowChange, slot0)
	slot0:addEventCb(RoomSkinController.instance, RoomSkinEvent.ChangePreviewRoomSkin, slot0.onChangeRoomSkin, slot0)
	slot0:addEventCb(RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, slot0.onChangeRoomSkin, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchange:RemoveClickListener()
	slot0._btnget:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, slot0.onSkinListViewShowChange, slot0)
	slot0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.ChangePreviewRoomSkin, slot0.onChangeRoomSkin, slot0)
	slot0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, slot0.onChangeRoomSkin, slot0)
end

function slot0._btnchangeOnClick(slot0)
	RoomSkinController.instance:confirmEquipPreviewRoomSkin()
end

function slot0._btngetOnClick(slot0)
	slot2 = RoomSkinListModel.instance:getCurPreviewSkinId()

	if not RoomSkinListModel.instance:getSelectPartId() or not slot2 then
		return
	end

	slot3 = true

	if RoomConfig.instance:getRoomSkinActId(slot2) and slot4 ~= 0 then
		slot3 = ActivityModel.instance:isActOnLine(slot4)
	end

	if not slot3 then
		GameFacade.showToast(ToastEnum.SkinNotInGetTime)

		return
	end

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.Building, slot1, {
		canJump = true,
		roomSkinId = slot2
	})
end

function slot0._btncloseOnClick(slot0)
	RoomSkinController.instance:setRoomSkinListVisible()
end

function slot0.onSkinListViewShowChange(slot0)
	slot0:refreshTitle()
	slot0:refreshBtns()
end

function slot0.onChangeRoomSkin(slot0)
	slot0:refreshBtns()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshTitle()
	slot0:refreshBtns()
end

function slot0.refreshTitle(slot0)
	if not RoomSkinListModel.instance:getSelectPartId() then
		return
	end

	if slot1 == RoomInitBuildingEnum.InitBuildingId.Hall then
		UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "bg_init")

		slot0._txttitle.text = luaLang("room_initbuilding_title")
		slot0._txttitleEn.text = "Paleohall"
	else
		UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "bg_part" .. slot1)

		slot2 = RoomConfig.instance:getProductionPartConfig(slot1)
		slot0._txttitle.text = slot2.name
		slot0._txttitleEn.text = slot2.nameEn
	end
end

function slot0.refreshBtns(slot0)
	if not RoomSkinListModel.instance:getCurPreviewSkinId() then
		return
	end

	slot2 = false
	slot3 = false
	slot4 = false

	if slot1 and RoomSkinModel.instance:isUnlockRoomSkin(slot1) then
		if slot1 == RoomSkinModel.instance:getEquipRoomSkin(RoomSkinListModel.instance:getSelectPartId()) then
			slot3 = true
		else
			slot2 = true
		end
	else
		slot4 = true
	end

	gohelper.setActive(slot0._gochange, slot2)
	gohelper.setActive(slot0._gousing, slot3)
	gohelper.setActive(slot0._goget, slot4)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
