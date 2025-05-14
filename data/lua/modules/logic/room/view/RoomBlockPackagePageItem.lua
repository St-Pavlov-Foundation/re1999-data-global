module("modules.logic.room.view.RoomBlockPackagePageItem", package.seeall)

local var_0_0 = class("RoomBlockPackagePageItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_0._go, "go_select")
	arg_1_0._goitem = gohelper.findChild(arg_1_0._go, "image")
end

function var_0_0.getGO(arg_2_0)
	return arg_2_0._go
end

function var_0_0.setShowIcon(arg_3_0, arg_3_1)
	arg_3_0._isShowIcon = arg_3_1

	gohelper.setActive(arg_3_0._imageIcon.gameObject, arg_3_1 and true or false)
end

function var_0_0.setSelect(arg_4_0, arg_4_1)
	arg_4_0._isSelect = arg_4_1

	gohelper.setActive(arg_4_0._goselect, arg_4_1 and true or false)
end

function var_0_0.beforeDestroy(arg_5_0)
	gohelper.setActive(arg_5_0._goitem, false)
	gohelper.setActive(arg_5_0._goselect, false)
	gohelper.setActive(arg_5_0._go, true)
end

return var_0_0
