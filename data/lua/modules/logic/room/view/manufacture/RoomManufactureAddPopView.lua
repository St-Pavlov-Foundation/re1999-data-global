module("modules.logic.room.view.manufacture.RoomManufactureAddPopView", package.seeall)

local var_0_0 = class("RoomManufactureAddPopView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._gorightroot = gohelper.findChild(arg_1_0.viewGO, "rightRoot")
	arg_1_0._goaddPop = gohelper.findChild(arg_1_0.viewGO, "root/#go_addPop")
	arg_1_0._btncloseAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_addPop/#btn_closeAdd")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseAdd:AddClickListener(arg_2_0._btncloseAddOnClick, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0, LuaEventSystem.High)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseAdd:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
end

function var_0_0._btncloseAddOnClick(arg_4_0)
	ManufactureController.instance:clearSelectedSlotItem()
end

function var_0_0._onItemChanged(arg_5_0)
	ManufactureController.instance:updateTraceNeedItemDict()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._transroot = arg_6_0._goroot.transform
	arg_6_0.animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0._goaddPop)

	ManufactureController.instance:updateTraceNeedItemDict()
end

function var_0_0.onUpdateParam(arg_7_0)
	if arg_7_0.viewParam then
		arg_7_0.isRight = arg_7_0.viewParam.inRight
		arg_7_0.highLightManufactureItem = arg_7_0.viewParam.highLightManufactureItem
	end
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:onUpdateParam()

	if arg_8_0.isRight then
		gohelper.addChild(arg_8_0._gorightroot, arg_8_0._goaddPop)
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
