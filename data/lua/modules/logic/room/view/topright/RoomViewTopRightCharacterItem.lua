module("modules.logic.room.view.topright.RoomViewTopRightCharacterItem", package.seeall)

local var_0_0 = class("RoomViewTopRightCharacterItem", RoomViewTopRightBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._resourceItem.simageicon = gohelper.findChildImage(arg_2_0._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(arg_2_0._resourceItem.simageicon, "img_juese")
	arg_2_0:_setShow(true)
end

function var_0_0._onClick(arg_3_0)
	local var_3_0 = RoomCharacterModel.instance:getMaxCharacterCount()
	local var_3_1 = RoomMapModel.instance:getAllBuildDegree()
	local var_3_2 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(var_3_1)

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.Character
	})
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmCharacter, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.UnUseCharacter, arg_4_0._refreshUI, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0._refreshUI(arg_6_0)
	local var_6_0 = RoomCharacterModel.instance:getMaxCharacterCount()
	local var_6_1 = RoomCharacterModel.instance:getConfirmCharacterCount()

	arg_6_0._resourceItem.txtquantity.text = string.format("%d/%d", var_6_1, var_6_0)
end

function var_0_0._customOnDestory(arg_7_0)
	return
end

return var_0_0
