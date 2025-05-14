module("modules.logic.room.view.backpack.RoomBackpackPropView", package.seeall)

local var_0_0 = class("RoomBackpackPropView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChange, arg_3_0)
end

function var_0_0._onItemChange(arg_4_0)
	arg_4_0:refreshPropList()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshPropList()
end

function var_0_0.refreshPropList(arg_8_0)
	RoomBackpackController.instance:refreshPropBackpackList()
	arg_8_0:refreshIsEmpty()
end

function var_0_0.refreshIsEmpty(arg_9_0)
	local var_9_0 = RoomBackpackPropListModel.instance:isBackpackEmpty()

	gohelper.setActive(arg_9_0._goempty, var_9_0)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
