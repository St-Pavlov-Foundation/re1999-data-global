module("modules.logic.room.view.backpack.RoomBackpackCritterItem", package.seeall)

local var_0_0 = class("RoomBackpackCritterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goCritterIcon = gohelper.findChild(arg_1_0.viewGO, "#go_critterIcon")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_2_0._onCritterInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, arg_2_0._onCritterLockStatusChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_3_0._onCritterInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeLockStatus, arg_3_0._onCritterLockStatusChange, arg_3_0)
end

function var_0_0._onCritterInfoUpdate(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._mo and arg_4_0._mo:getId()

	if not arg_4_0._critterIcon or not var_4_0 or arg_4_1 and not arg_4_1[var_4_0] then
		return
	end

	arg_4_0._critterIcon:refreshLockIcon()
	arg_4_0._critterIcon:refreshMaturityIcon()
end

function var_0_0._onCritterLockStatusChange(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._mo and arg_5_0._mo:getId()

	if not arg_5_0._critterIcon or not var_5_0 or var_5_0 ~= arg_5_1 then
		return
	end

	arg_5_0._critterIcon:refreshLockIcon()
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	if not arg_6_0._critterIcon then
		arg_6_0._critterIcon = IconMgr.instance:getCommonCritterIcon(arg_6_0._goCritterIcon)

		arg_6_0._critterIcon:setLockIconShow(true)
		arg_6_0._critterIcon:setMaturityIconShow(true)
	end

	arg_6_0._critterIcon:onUpdateMO(arg_6_0._mo)
	arg_6_0._critterIcon:setCustomClick(arg_6_0.onClickCB, arg_6_0)
	arg_6_0._critterIcon:setIsShowBuildingIcon(true)
end

function var_0_0.onClickCB(arg_7_0)
	local var_7_0 = arg_7_0._mo:isMaturity()

	CritterController.instance:openRoomCritterDetailView(not var_7_0, arg_7_0._mo)
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
