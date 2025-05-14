module("modules.logic.activity.view.show.ActivityGuestBindViewItem", package.seeall)

local var_0_0 = class("ActivityGuestBindViewItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._item = IconMgr.instance:getCommonPropItemIcon(arg_4_0._goitem)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	arg_7_0:_refresh()
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._refresh(arg_10_0)
	local var_10_0 = arg_10_0._mo.itemCO

	arg_10_0._item:setMOValue(var_10_0[1], var_10_0[2], var_10_0[3], nil, true)
end

return var_0_0
