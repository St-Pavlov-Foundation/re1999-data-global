module("modules.logic.room.view.debug.RoomDebugEntranceView", package.seeall)

local var_0_0 = class("RoomDebugEntranceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btndebug = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_debug")
	arg_1_0._btninit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_init")
	arg_1_0._btnpackage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_package")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndebug:AddClickListener(arg_2_0._btndebugOnClick, arg_2_0)
	arg_2_0._btninit:AddClickListener(arg_2_0._btninitOnClick, arg_2_0)
	arg_2_0._btnpackage:AddClickListener(arg_2_0._btnpackageOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndebug:RemoveClickListener()
	arg_3_0._btninit:RemoveClickListener()
	arg_3_0._btnpackage:RemoveClickListener()
end

function var_0_0._btndebugOnClick(arg_4_0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.DebugNormal)
	ViewMgr.instance:closeAllPopupViews()
end

function var_0_0._btninitOnClick(arg_5_0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.DebugInit)
	ViewMgr.instance:closeAllPopupViews()
end

function var_0_0._btnpackageOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.RoomDebugSelectPackageView)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
