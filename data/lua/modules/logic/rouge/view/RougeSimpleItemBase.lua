module("modules.logic.rouge.view.RougeSimpleItemBase", package.seeall)

local var_0_0 = class("RougeSimpleItemBase", ListScrollCellExtend)
local var_0_1 = table.insert
local var_0_2 = ZProj.UGUIHelper

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._staticData = {}

	if arg_1_1 then
		arg_1_0._staticData.baseViewContainer = arg_1_1.baseViewContainer
		arg_1_0._staticData.parent = arg_1_1.parent
	end
end

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)
	arg_2_0:addEventListeners()
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0:_editableInitView()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0:setData(arg_4_1)
end

function var_0_0.parent(arg_5_0)
	return arg_5_0._staticData.parent
end

function var_0_0.baseViewContainer(arg_6_0)
	return arg_6_0._staticData.baseViewContainer
end

function var_0_0._assetGetViewContainer(arg_7_0)
	return assert(arg_7_0:baseViewContainer(), "please assign baseViewContainer by ctorParam on ctor")
end

function var_0_0._assetGetParent(arg_8_0)
	return assert(arg_8_0:parent(), "please assign parent by ctorParam on ctor")
end

function var_0_0.regEvent(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0._parent then
		logWarn("regEvent")

		return
	end

	arg_9_0:_assetGetViewContainer():registerCallback(arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.unregEvent(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_0._parent then
		logWarn("unregEvent")

		return
	end

	arg_10_0:_assetGetViewContainer():unregisterCallback(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.dispatchEvent(arg_11_0, arg_11_1, ...)
	local var_11_0 = arg_11_0:baseViewContainer()

	if not var_11_0 then
		return
	end

	var_11_0:dispatchEvent(arg_11_1, ...)
end

function var_0_0.isSelected(arg_12_0)
	return arg_12_0._staticData.isSelected
end

function var_0_0.setSelected(arg_13_0, arg_13_1)
	if arg_13_0:isSelected() == arg_13_1 then
		return
	end

	arg_13_0:onSelect(arg_13_1)
end

function var_0_0.setIndex(arg_14_0, arg_14_1)
	arg_14_0._index = arg_14_1
end

function var_0_0.index(arg_15_0)
	return arg_15_0._index
end

function var_0_0.setActive(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0.viewGO, arg_16_1)
end

function var_0_0.posX(arg_17_0)
	return recthelper.getAnchorX(arg_17_0._trans)
end

function var_0_0.posY(arg_18_0)
	return recthelper.getAnchorY(arg_18_0._trans)
end

function var_0_0.transform(arg_19_0)
	return arg_19_0._trans
end

function var_0_0.setAsLastSibling(arg_20_0)
	arg_20_0._trans:SetAsLastSibling()
end

function var_0_0.setAsFirstSibling(arg_21_0)
	arg_21_0._trans:SetAsFirstSibling()
end

function var_0_0.setSiblingIndex(arg_22_0, arg_22_1)
	arg_22_0._trans:SetSiblingIndex(arg_22_1)
end

function var_0_0._onSetScrollParentGameObject(arg_23_0, arg_23_1)
	if gohelper.isNil(arg_23_1) then
		return
	end

	local var_23_0 = arg_23_0:baseViewContainer()

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0:getScrollViewGo()

	if gohelper.isNil(var_23_1) then
		return
	end

	arg_23_1.parentGameObject = var_23_1
end

function var_0_0._fillUserDataTb(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = 1
	local var_24_1 = arg_24_0[arg_24_1 .. var_24_0]

	while not gohelper.isNil(var_24_1) do
		if arg_24_2 then
			var_0_1(arg_24_2, var_24_1.gameObject)
		end

		if arg_24_3 then
			var_0_1(arg_24_3, var_24_1)
		end

		var_24_0 = var_24_0 + 1
		var_24_1 = arg_24_0[arg_24_1 .. var_24_0]
	end
end

function var_0_0._editableInitView(arg_25_0)
	arg_25_0._trans = arg_25_0.viewGO.transform
end

function var_0_0.setData(arg_26_0, arg_26_1)
	arg_26_0._mo = arg_26_1
end

function var_0_0.refresh(arg_27_0)
	arg_27_0:onUpdateMO(arg_27_0._mo)
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0:removeEventListeners()
	var_0_0.super.onDestroyView(arg_28_0)
end

function var_0_0.setGrayscale(arg_29_0, arg_29_1, arg_29_2)
	var_0_2.SetGrayscale(arg_29_1, arg_29_2)
end

return var_0_0
