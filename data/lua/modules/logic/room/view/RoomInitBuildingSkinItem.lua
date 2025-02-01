module("modules.logic.room.view.RoomInitBuildingSkinItem", package.seeall)

slot0 = class("RoomInitBuildingSkinItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagequalitybg = gohelper.findChildImage(slot0.viewGO, "#image_qualitybg")
	slot0._imagebuilding = gohelper.findChildImage(slot0.viewGO, "#image_building")
	slot0._txtskinname = gohelper.findChildText(slot0.viewGO, "#txt_skinname")
	slot0._goequiped = gohelper.findChild(slot0.viewGO, "#go_equiped")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_reddot")
	slot0._bgClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._bgClick:AddClickListener(slot0.onClickBg, slot0)
	slot0:addEventCb(RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, slot0.onChangeEquipSkin, slot0)
end

function slot0.removeEvents(slot0)
	slot0._bgClick:RemoveClickListener()
	slot0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, slot0.onChangeEquipSkin, slot0)
end

function slot0.onClickBg(slot0)
	if not slot0.id then
		return
	end

	RoomSkinController.instance:selectPreviewRoomSkin(slot0.id)
end

function slot0.onChangeEquipSkin(slot0)
	slot0:refreshState()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.id = slot1.id

	slot0:refresh()
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomNewSkinItem, slot0.id)
end

function slot0.refresh(slot0)
	slot0:refreshInfo()
	slot0:refreshState()
end

function slot0.refreshInfo(slot0)
	if not slot0.id then
		return
	end

	slot0._txtskinname.text = RoomConfig.instance:getRoomSkinName(slot0.id)

	if not string.nilorempty(RoomConfig.instance:getRoomSkinIcon(slot0.id)) then
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuilding, slot2)
	end

	if not string.nilorempty(RoomConfig.instance:getRoomSkinRare(slot0.id)) then
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagequalitybg, "room_qualityframe_" .. slot3)
	end
end

function slot0.refreshState(slot0)
	if RoomSkinModel.instance:isUnlockRoomSkin(slot0.id) then
		gohelper.setActive(slot0._goequiped, RoomSkinModel.instance:isEquipRoomSkin(slot0.id))
	end

	gohelper.setActive(slot0._golocked, not slot1)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1)
end

function slot0.onDestroy(slot0)
	slot0.id = nil
end

return slot0
