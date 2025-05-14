module("modules.logic.room.view.topright.RoomViewTopRightLayoutShareItem", package.seeall)

local var_0_0 = class("RoomViewTopRightLayoutShareItem", RoomViewTopRightBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._ismap = arg_1_0._param.ismap
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._resourceItem.simageicon = gohelper.findChildImage(arg_2_0._resourceItem.go, "icon")

	UISpriteSetMgr.instance:setRoomSprite(arg_2_0._resourceItem.simageicon, "room_layout_icon_redu")
end

function var_0_0._onClick(arg_3_0)
	if RoomController.instance:isVisitMode() then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.PlanShare,
		shareCount = arg_3_0:_getQuantity()
	})
end

function var_0_0.addEventListeners(arg_4_0)
	return
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0._refreshUI(arg_6_0)
	local var_6_0 = true

	if arg_6_0._ismap and not RoomController.instance:isVisitShareMode() then
		var_6_0 = false
	end

	if var_6_0 then
		arg_6_0._resourceItem.txtquantity.text = arg_6_0:_getQuantity()
	end

	arg_6_0:_setShow(var_6_0)
end

function var_0_0._getQuantity(arg_7_0)
	if arg_7_0._ismap then
		local var_7_0 = RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode())

		return var_7_0 and var_7_0.useCount or 0
	end

	return RoomLayoutModel.instance:getUseCount()
end

return var_0_0
