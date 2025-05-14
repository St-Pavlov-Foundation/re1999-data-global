module("modules.ugui.scroll.ListScrollCellExtend", package.seeall)

local var_0_0 = class("ListScrollCellExtend", ListScrollCell)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableAddEvents(arg_4_0)
	return
end

function var_0_0._editableRemoveEvents(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	return
end

function var_0_0.init(arg_7_0, arg_7_1)
	arg_7_0.viewGO = arg_7_1

	arg_7_0:onInitView()
end

function var_0_0.addEventListeners(arg_8_0)
	arg_8_0:addEvents()
	arg_8_0:_editableAddEvents()
end

function var_0_0.removeEventListeners(arg_9_0)
	arg_9_0:removeEvents()
	arg_9_0:_editableRemoveEvents()
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	return
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0:onDestroyView()
end

return var_0_0
