module("framework.mvc.view.ToggleListView", package.seeall)

local var_0_0 = class("ToggleListView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._tabContainerId = arg_1_1
	arg_1_0._toggleGroupPath = arg_1_2
	arg_1_0._toggleChecker = arg_1_3
	arg_1_0._toggleCheckerObj = arg_1_4
	arg_1_0._toggleGroupGO = nil
	arg_1_0._toggleGroup = nil
	arg_1_0._toggleDict = {}
	arg_1_0._tabContainer = nil
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._toggleGroupGO = gohelper.findChild(arg_2_0.viewGO, arg_2_0._toggleGroupPath)
	arg_2_0._toggleGroup = arg_2_0._toggleGroupGO:GetComponent(typeof(UnityEngine.UI.ToggleGroup))

	local var_2_0 = arg_2_0._toggleGroupGO.transform
	local var_2_1 = var_2_0.childCount

	for iter_2_0 = 1, var_2_1 do
		local var_2_2 = var_2_0:GetChild(iter_2_0 - 1).gameObject

		if var_2_2:GetComponent(typeof(UnityEngine.UI.Toggle)) then
			local var_2_3 = gohelper.onceAddComponent(var_2_2, typeof(SLFramework.UGUI.ToggleWrap))
			local var_2_4 = string.getLastNum(var_2_3.name)

			arg_2_0._toggleDict[var_2_4 or iter_2_0] = var_2_3
		end
	end
end

function var_0_0.addEvents(arg_3_0)
	if arg_3_0._toggleChecker then
		for iter_3_0, iter_3_1 in pairs(arg_3_0._toggleDict) do
			iter_3_1:AddBlockClick(arg_3_0._onBlockToggle, arg_3_0, iter_3_0)
		end
	end
end

function var_0_0.removeEvents(arg_4_0)
	if arg_4_0._toggleChecker then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._toggleDict) do
			iter_4_1:RemoveBlockClick()
		end
	end
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam and arg_5_0.viewParam.defaultTabIds and arg_5_0.viewParam.defaultTabIds[arg_5_0._tabContainerId] or 1
	local var_5_1 = arg_5_0._toggleGroup.allowSwitchOff

	arg_5_0._toggleGroup.allowSwitchOff = true

	for iter_5_0, iter_5_1 in pairs(arg_5_0._toggleDict) do
		iter_5_1:AddOnValueChanged(arg_5_0._onToggleValueChanged, arg_5_0, iter_5_0)

		iter_5_1.isOn = iter_5_0 == var_5_0
	end

	arg_5_0._toggleGroup.allowSwitchOff = var_5_1
end

function var_0_0.onClose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._toggleDict) do
		iter_6_1:RemoveOnValueChanged()
	end
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._toggleGroupPath = nil
	arg_7_0._toggleGroupGO = nil
	arg_7_0._toggleGroup = nil
	arg_7_0._toggleDict = nil
end

function var_0_0._onBlockToggle(arg_8_0, arg_8_1)
	if arg_8_0._toggleChecker and (arg_8_0._toggleCheckerObj and arg_8_0._toggleChecker(arg_8_0._toggleCheckerObj, arg_8_1) or not arg_8_0._toggleCheckerObj and not arg_8_0._toggleChecker(arg_8_1)) then
		arg_8_0._toggleDict[arg_8_1]:TriggerClick()
	end
end

function var_0_0._onToggleValueChanged(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		arg_9_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, arg_9_0._tabContainerId, arg_9_1)
	end
end

return var_0_0
