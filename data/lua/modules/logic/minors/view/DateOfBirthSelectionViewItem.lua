module("modules.logic.minors.view.DateOfBirthSelectionViewItem", package.seeall)

local var_0_0 = class("DateOfBirthSelectionViewItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._dropdown = gohelper.findChildDropdown(arg_1_0.viewGO, "")
	arg_1_0._arrowTran = gohelper.findChild(arg_1_0.viewGO, "arrow").transform
	arg_1_0._dropdownClick = gohelper.getClick(arg_1_0.viewGO, "")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._dropdownClick:AddClickListener(arg_2_0._onDropdownClick, arg_2_0)
	arg_2_0._dropdown:AddOnValueChanged(arg_2_0._onDropDownValueChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._dropdown:RemoveOnValueChanged()
	arg_3_0._dropdownClick:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	arg_4_0:_refresh()
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0._onDropDownValueChange(arg_6_0)
	local var_6_0 = arg_6_0._mo
	local var_6_1 = var_6_0._parent
	local var_6_2 = var_6_0.type
	local var_6_3 = arg_6_0._dropdown:GetValue()

	if var_6_1:getDropDownSelectedIndex(var_6_2) ~= var_6_3 then
		var_6_1:onClickDropDownOption(var_6_2, var_6_3)
	end
end

function var_0_0._refresh(arg_7_0)
	arg_7_0._dropdown:ClearOptions()

	arg_7_0._options = arg_7_0:_getOptions()

	arg_7_0._dropdown:AddOptions(arg_7_0._options)
	arg_7_0._dropdown:SetValue(arg_7_0:_getSelectedIndex())
end

function var_0_0._getOptions(arg_8_0)
	local var_8_0 = arg_8_0._mo
	local var_8_1 = var_8_0.type

	return var_8_0._parent:getDropDownOption(var_8_1)
end

function var_0_0._getSelectedIndex(arg_9_0)
	local var_9_0 = arg_9_0._mo
	local var_9_1 = var_9_0.type

	return var_9_0._parent:getDropDownSelectedIndex(var_9_1)
end

local var_0_1 = UnityEngine.UI.ScrollRect
local var_0_2 = 12
local var_0_3 = 73
local var_0_4 = 5
local var_0_5 = var_0_2 + var_0_3

function var_0_0._onDropdownClick(arg_10_0)
	local var_10_0 = arg_10_0._dropdown:GetValue()
	local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "Dropdown List")

	if not var_10_1 then
		return
	end

	local var_10_2 = var_10_1:GetComponent(typeof(var_0_1))

	if not var_10_2 then
		return
	end

	local var_10_3 = var_10_2.content

	if not var_10_3 then
		return
	end

	local var_10_4 = arg_10_0._options and #arg_10_0._options or 0
	local var_10_5 = var_10_0 * var_0_5
	local var_10_6 = math.max(0, (var_10_4 - var_0_4) * var_0_5)

	recthelper.setAnchorY(var_10_3, math.min(var_10_6, var_10_5))
end

return var_0_0
