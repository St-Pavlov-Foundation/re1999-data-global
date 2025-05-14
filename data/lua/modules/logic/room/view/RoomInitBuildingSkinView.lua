module("modules.logic.room.view.RoomInitBuildingSkinView", package.seeall)

local var_0_0 = class("RoomInitBuildingSkinView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "right/#go_skin/title/txt")
	arg_1_0._txttitleEn = gohelper.findChildText(arg_1_0.viewGO, "right/#go_skin/title/txt/txtEn")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_skin/title/icon")
	arg_1_0._gochange = gohelper.findChild(arg_1_0.viewGO, "right/#go_skin/bottom/#btn_change")
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_skin/bottom/#btn_change")
	arg_1_0._gousing = gohelper.findChild(arg_1_0.viewGO, "right/#go_skin/bottom/#go_using")
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "right/#go_skin/bottom/#btn_get")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_skin/bottom/#btn_get")
	arg_1_0._btnclose = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "right/#go_skin/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btnget:AddClickListener(arg_2_0._btngetOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, arg_2_0.onSkinListViewShowChange, arg_2_0)
	arg_2_0:addEventCb(RoomSkinController.instance, RoomSkinEvent.ChangePreviewRoomSkin, arg_2_0.onChangeRoomSkin, arg_2_0)
	arg_2_0:addEventCb(RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, arg_2_0.onChangeRoomSkin, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btnget:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, arg_3_0.onSkinListViewShowChange, arg_3_0)
	arg_3_0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.ChangePreviewRoomSkin, arg_3_0.onChangeRoomSkin, arg_3_0)
	arg_3_0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.ChangeEquipRoomSkin, arg_3_0.onChangeRoomSkin, arg_3_0)
end

function var_0_0._btnchangeOnClick(arg_4_0)
	RoomSkinController.instance:confirmEquipPreviewRoomSkin()
end

function var_0_0._btngetOnClick(arg_5_0)
	local var_5_0 = RoomSkinListModel.instance:getSelectPartId()
	local var_5_1 = RoomSkinListModel.instance:getCurPreviewSkinId()

	if not var_5_0 or not var_5_1 then
		return
	end

	local var_5_2 = true
	local var_5_3 = RoomConfig.instance:getRoomSkinActId(var_5_1)

	if var_5_3 and var_5_3 ~= 0 then
		var_5_2 = ActivityModel.instance:isActOnLine(var_5_3)
	end

	if not var_5_2 then
		GameFacade.showToast(ToastEnum.SkinNotInGetTime)

		return
	end

	local var_5_4 = {
		canJump = true,
		roomSkinId = var_5_1
	}

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.Building, var_5_0, var_5_4)
end

function var_0_0._btncloseOnClick(arg_6_0)
	RoomSkinController.instance:setRoomSkinListVisible()
end

function var_0_0.onSkinListViewShowChange(arg_7_0)
	arg_7_0:refreshTitle()
	arg_7_0:refreshBtns()
end

function var_0_0.onChangeRoomSkin(arg_8_0)
	arg_8_0:refreshBtns()
end

function var_0_0._editableInitView(arg_9_0)
	return
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:refreshTitle()
	arg_11_0:refreshBtns()
end

function var_0_0.refreshTitle(arg_12_0)
	local var_12_0 = RoomSkinListModel.instance:getSelectPartId()

	if not var_12_0 then
		return
	end

	if var_12_0 == RoomInitBuildingEnum.InitBuildingId.Hall then
		UISpriteSetMgr.instance:setRoomSprite(arg_12_0._imageicon, "bg_init")

		arg_12_0._txttitle.text = luaLang("room_initbuilding_title")
		arg_12_0._txttitleEn.text = "Paleohall"
	else
		UISpriteSetMgr.instance:setRoomSprite(arg_12_0._imageicon, "bg_part" .. var_12_0)

		local var_12_1 = RoomConfig.instance:getProductionPartConfig(var_12_0)

		arg_12_0._txttitle.text = var_12_1.name
		arg_12_0._txttitleEn.text = var_12_1.nameEn
	end
end

function var_0_0.refreshBtns(arg_13_0)
	local var_13_0 = RoomSkinListModel.instance:getCurPreviewSkinId()

	if not var_13_0 then
		return
	end

	local var_13_1 = false
	local var_13_2 = false
	local var_13_3 = false

	if var_13_0 and RoomSkinModel.instance:isUnlockRoomSkin(var_13_0) then
		local var_13_4 = RoomSkinListModel.instance:getSelectPartId()

		if var_13_0 == RoomSkinModel.instance:getEquipRoomSkin(var_13_4) then
			var_13_2 = true
		else
			var_13_1 = true
		end
	else
		var_13_3 = true
	end

	gohelper.setActive(arg_13_0._gochange, var_13_1)
	gohelper.setActive(arg_13_0._gousing, var_13_2)
	gohelper.setActive(arg_13_0._goget, var_13_3)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
