module("framework.mvc.view.scroll.LuaTreeScrollView", package.seeall)

local var_0_0 = class("LuaTreeScrollView", BaseScrollView)

var_0_0.PrefabInstName = "prefabInst"
var_0_0.DefaultTransitionSeconds = 0.3

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2.emptyScrollParam)

	arg_1_0._csTreeScroll = nil
	arg_1_0._model = arg_1_1
	arg_1_0._param = arg_1_2
	arg_1_0._prefabInViewList = nil
	arg_1_0._nodePrefab = nil
	arg_1_0._cellCompDict = {}
	arg_1_0._selectMOs = {}
end

function var_0_0.onInitView(arg_2_0)
	var_0_0.super.onInitView(arg_2_0)

	if arg_2_0._param.prefabType == ScrollEnum.ScrollPrefabFromView then
		arg_2_0._prefabInViewList = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0._param.prefabUrls) do
			local var_2_0 = gohelper.findChild(arg_2_0.viewGO, iter_2_1)

			table.insert(arg_2_0._prefabInViewList, var_2_0)
			gohelper.setActive(var_2_0, false)
		end
	end

	local var_2_1 = gohelper.findChild(arg_2_0.viewGO, arg_2_0._param.scrollGOPath)

	arg_2_0._csTreeScroll = SLFramework.UGUI.TreeScrollView.Get(var_2_1)

	arg_2_0._csTreeScroll:Init(arg_2_0._param.scrollDir, arg_2_0._onUpdateCell, arg_2_0._onSelectCell, arg_2_0)
end

function var_0_0.getCsScroll(arg_3_0)
	return arg_3_0._csTreeScroll
end

function var_0_0.refreshScroll(arg_4_0)
	var_0_0.super.refreshScroll(arg_4_0)
	arg_4_0._csTreeScroll:UpdateTreeInfoList(arg_4_0._model:getInfoList())
	arg_4_0:updateEmptyGO(arg_4_0._model:getRootCount())
end

function var_0_0._onUpdateCell(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = gohelper.findChild(arg_5_1, var_0_0.PrefabInstName)
	local var_5_1

	if var_5_0 then
		var_5_1 = MonoHelper.getLuaComFromGo(var_5_0, arg_5_0._param.cellClass)
	else
		if arg_5_0._param.prefabType == ScrollEnum.ScrollPrefabFromRes then
			var_5_0 = arg_5_0:getResInst(arg_5_0._param.prefabUrls[arg_5_2], arg_5_1, var_0_0.PrefabInstName)
		elseif arg_5_0._param.prefabType == ScrollEnum.ScrollPrefabFromView then
			var_5_0 = gohelper.clone(arg_5_0._prefabInViewList[arg_5_2], arg_5_1, var_0_0.PrefabInstName)

			gohelper.setActive(var_5_0, true)
		else
			logError("TreeScrollView prefabType not support: " .. arg_5_0._param.prefabType)
		end

		var_5_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, arg_5_0._param.cellClass)

		var_5_1:initInternal(var_5_0, arg_5_0)

		arg_5_0._cellCompDict[var_5_1] = true
	end

	local var_5_2 = arg_5_0._model:getByIndex(arg_5_3 + 1, arg_5_4 + 1)

	var_5_1._rootIndex = arg_5_3 + 1
	var_5_1._nodeIndex = arg_5_4 + 1

	if arg_5_4 == -1 then
		var_5_1:onUpdateRootMOInternal(var_5_2)
	else
		var_5_1:onUpdateNodeMOInternal(var_5_2)
	end

	if tabletool.indexOf(arg_5_0._selectMOs, var_5_2) then
		var_5_1:onSelect(true)
	else
		var_5_1:onSelect(false)
	end
end

function var_0_0._onSelectCell(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = gohelper.findChild(arg_6_1, var_0_0.PrefabInstName)

	MonoHelper.getLuaComFromGo(var_6_0, arg_6_0._param.cellClass):onSelect(arg_6_2)
end

function var_0_0.selectCell(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0._model:getByIndex(arg_7_1, arg_7_2)

	if var_7_0 then
		local var_7_1 = tabletool.indexOf(arg_7_0._selectMOs, var_7_0)

		if var_7_1 and not arg_7_3 then
			table.remove(arg_7_0._selectMOs, var_7_1)
		elseif arg_7_3 and not var_7_1 then
			table.insert(arg_7_0._selectMOs, var_7_0)
		end

		arg_7_0._csTreeScroll:SelectCell(arg_7_1 - 1, arg_7_2 - 1, arg_7_3)
	end
end

function var_0_0.getSelectItems(arg_8_0)
	return arg_8_0._selectMOs
end

function var_0_0.setSelectItems(arg_9_0, arg_9_1)
	arg_9_0._selectMOs = arg_9_1

	arg_9_0._csTreeScroll:UpdateCells(true, false)
end

function var_0_0.expand(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	if arg_10_0:isInTransition(arg_10_1) then
		return
	end

	if arg_10_2 == nil then
		arg_10_2 = true
	end

	arg_10_3 = arg_10_3 or var_0_0.DefaultTransitionSeconds

	arg_10_0._csTreeScroll:Expand(arg_10_1 - 1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
end

function var_0_0.shrink(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	if arg_11_0:isInTransition(arg_11_1) then
		return
	end

	if arg_11_2 == nil then
		arg_11_2 = true
	end

	arg_11_3 = arg_11_3 or var_0_0.DefaultTransitionSeconds

	arg_11_0._csTreeScroll:Shrink(arg_11_1 - 1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
end

function var_0_0.isInTransition(arg_12_0, arg_12_1)
	return arg_12_0._csTreeScroll:IsInTransition(arg_12_1 - 1)
end

function var_0_0.isExpand(arg_13_0, arg_13_1)
	return arg_13_0._csTreeScroll:IsExpand(arg_13_1 - 1)
end

function var_0_0.reverseRootOp(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if arg_14_0:isExpand(arg_14_1) then
		arg_14_0:shrink(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	else
		arg_14_0:expand(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	end
end

function var_0_0.clear(arg_15_0)
	if arg_15_0._csTreeScroll then
		arg_15_0._csTreeScroll:Clear()
	end
end

function var_0_0.onDestroyView(arg_16_0)
	var_0_0.super.onDestroyView(arg_16_0)

	if arg_16_0._csTreeScroll then
		arg_16_0._csTreeScroll:Clear()
	end
end

return var_0_0
