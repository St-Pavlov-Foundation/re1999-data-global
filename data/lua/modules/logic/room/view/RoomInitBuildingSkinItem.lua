module("modules.logic.room.view.RoomInitBuildingSkinItem", package.seeall)

local var_0_0 = class("RoomInitBuildingSkinItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagequalitybg = gohelper.findChildImage(arg_1_0.viewGO, "#image_qualitybg")
	arg_1_0._imagebuilding = gohelper.findChildImage(arg_1_0.viewGO, "#image_building")
	arg_1_0._txtskinname = gohelper.findChildText(arg_1_0.viewGO, "#txt_skinname")
	arg_1_0._goequiped = gohelper.findChild(arg_1_0.viewGO, "#go_equiped")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_reddot")
	arg_1_0._bgClick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "bg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._bgClick:AddClickListener(arg_2_0.onClickBg, arg_2_0)
	arg_2_0:addEventCb(RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, arg_2_0.onChangeEquipSkin, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._bgClick:RemoveClickListener()
	arg_3_0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, arg_3_0.onChangeEquipSkin, arg_3_0)
end

function var_0_0.onClickBg(arg_4_0)
	if not arg_4_0.id then
		return
	end

	RoomSkinController.instance:selectPreviewRoomSkin(arg_4_0.id)
end

function var_0_0.onChangeEquipSkin(arg_5_0)
	arg_5_0:refreshState()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	arg_7_0.id = arg_7_1.id

	arg_7_0:refresh()
	RedDotController.instance:addRedDot(arg_7_0._goreddot, RedDotEnum.DotNode.RoomNewSkinItem, arg_7_0.id)
end

function var_0_0.refresh(arg_8_0)
	arg_8_0:refreshInfo()
	arg_8_0:refreshState()
end

function var_0_0.refreshInfo(arg_9_0)
	if not arg_9_0.id then
		return
	end

	local var_9_0 = RoomConfig.instance:getRoomSkinName(arg_9_0.id)

	arg_9_0._txtskinname.text = var_9_0

	local var_9_1 = RoomConfig.instance:getRoomSkinIcon(arg_9_0.id)

	if not string.nilorempty(var_9_1) then
		UISpriteSetMgr.instance:setRoomSprite(arg_9_0._imagebuilding, var_9_1)
	end

	local var_9_2 = RoomConfig.instance:getRoomSkinRare(arg_9_0.id)

	if not string.nilorempty(var_9_2) then
		UISpriteSetMgr.instance:setRoomSprite(arg_9_0._imagequalitybg, "room_qualityframe_" .. var_9_2)
	end
end

function var_0_0.refreshState(arg_10_0)
	local var_10_0 = RoomSkinModel.instance:isUnlockRoomSkin(arg_10_0.id)

	if var_10_0 then
		local var_10_1 = RoomSkinModel.instance:isEquipRoomSkin(arg_10_0.id)

		gohelper.setActive(arg_10_0._goequiped, var_10_1)
	end

	gohelper.setActive(arg_10_0._golocked, not var_10_0)
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goselected, arg_11_1)
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0.id = nil
end

return var_0_0
