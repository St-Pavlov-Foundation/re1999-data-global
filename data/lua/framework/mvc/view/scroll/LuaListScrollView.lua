module("framework.mvc.view.scroll.LuaListScrollView", package.seeall)

local var_0_0 = class("LuaListScrollView", BaseScrollView)

var_0_0.PrefabInstName = "prefabInst"

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2.emptyScrollParam)

	arg_1_0._csListScroll = nil
	arg_1_0._model = arg_1_1
	arg_1_0._param = arg_1_2
	arg_1_0._selectMOs = {}
	arg_1_0._cellCompDict = {}
end

function var_0_0.onInitView(arg_2_0)
	var_0_0.super.onInitView(arg_2_0)

	if arg_2_0._param.prefabType == ScrollEnum.ScrollPrefabFromView then
		arg_2_0._cellSourceGO = gohelper.findChild(arg_2_0.viewGO, arg_2_0._param.prefabUrl)

		gohelper.setActive(arg_2_0._cellSourceGO, false)
	end

	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, arg_2_0._param.scrollGOPath)

	arg_2_0._csListScroll = SLFramework.UGUI.ListScrollView.Get(var_2_0)

	arg_2_0._csListScroll:Init(arg_2_0._param.scrollDir, arg_2_0._param.lineCount, arg_2_0._param.cellWidth, arg_2_0._param.cellHeight, arg_2_0._param.cellSpaceH, arg_2_0._param.cellSpaceV, arg_2_0._param.startSpace, arg_2_0._param.endSpace, arg_2_0._param.sortMode, arg_2_0._param.frameUpdateMs, arg_2_0._param.minUpdateCountInFrame, arg_2_0._onUpdateCell, arg_2_0.onUpdateFinish, arg_2_0._onSelectCell, arg_2_0)
end

function var_0_0.clear(arg_3_0)
	if arg_3_0._csListScroll then
		arg_3_0._csListScroll:Clear()
	end
end

function var_0_0.onDestroyView(arg_4_0)
	var_0_0.super.onDestroyView(arg_4_0)
	arg_4_0._csListScroll:Clear()

	arg_4_0._csListScroll = nil
	arg_4_0._model = nil
	arg_4_0._param = nil
	arg_4_0._selectMOs = nil
	arg_4_0._cellCompDict = nil
end

function var_0_0.getCsListScroll(arg_5_0)
	return arg_5_0._csListScroll
end

function var_0_0.refreshScroll(arg_6_0)
	var_0_0.super.refreshScroll(arg_6_0)

	local var_6_0 = arg_6_0._model:getCount()

	arg_6_0._csListScroll:UpdateTotalCount(var_6_0)
	arg_6_0:updateEmptyGO(var_6_0)
end

function var_0_0.selectCell(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._model:getByIndex(arg_7_1)

	if not var_7_0 then
		return
	end

	if arg_7_0._param.multiSelect then
		local var_7_1 = tabletool.indexOf(arg_7_0._selectMOs, var_7_0)

		if var_7_1 and not arg_7_2 then
			table.remove(arg_7_0._selectMOs, var_7_1)
		else
			table.insert(arg_7_0._selectMOs, var_7_0)
		end
	else
		local var_7_2 = arg_7_0._selectMOs[1]

		if var_7_2 then
			local var_7_3 = arg_7_0._model:getIndex(var_7_2)

			if var_7_3 then
				arg_7_0._csListScroll:SelectCell(var_7_3 - 1, false)
			end
		end

		if arg_7_2 then
			arg_7_0._selectMOs = {
				var_7_0
			}
		else
			arg_7_0._selectMOs = {}
		end
	end

	arg_7_0._csListScroll:SelectCell(arg_7_1 - 1, arg_7_2)
end

function var_0_0.getFirstSelect(arg_8_0)
	return arg_8_0._selectMOs[1]
end

function var_0_0.getSelectList(arg_9_0)
	return arg_9_0._selectMOs
end

function var_0_0.setSelect(arg_10_0, arg_10_1)
	arg_10_0:setSelectList({
		arg_10_1
	})
end

function var_0_0.setSelectList(arg_11_0, arg_11_1)
	arg_11_0._selectMOs = {}

	if arg_11_1 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			table.insert(arg_11_0._selectMOs, iter_11_1)
		end
	end

	if arg_11_0._csListScroll then
		arg_11_0._csListScroll:UpdateVisualCells()
	end
end

function var_0_0._onUpdateCell(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = gohelper.findChild(arg_12_1, var_0_0.PrefabInstName)
	local var_12_1

	if var_12_0 then
		var_12_1 = MonoHelper.getLuaComFromGo(var_12_0, arg_12_0._param.cellClass)
	else
		if arg_12_0._param.prefabType == ScrollEnum.ScrollPrefabFromRes then
			var_12_0 = arg_12_0:getResInst(arg_12_0._param.prefabUrl, arg_12_1, var_0_0.PrefabInstName)
		elseif arg_12_0._param.prefabType == ScrollEnum.ScrollPrefabFromView then
			var_12_0 = gohelper.clone(arg_12_0._cellSourceGO, arg_12_1, var_0_0.PrefabInstName)

			gohelper.setActive(var_12_0, true)
		else
			logError("ListScrollView prefabType not support: " .. arg_12_0._param.prefabType)
		end

		var_12_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_0, arg_12_0._param.cellClass)

		var_12_1:initInternal(var_12_0, arg_12_0)

		arg_12_0._cellCompDict[var_12_1] = true
	end

	local var_12_2 = arg_12_0._model:getByIndex(arg_12_2 + 1)

	var_12_1._index = arg_12_2 + 1

	var_12_1:onUpdateMO(var_12_2)

	if tabletool.indexOf(arg_12_0._selectMOs, var_12_2) then
		var_12_1:onSelect(true)
	else
		var_12_1:onSelect(false)
	end
end

function var_0_0.onUpdateFinish(arg_13_0)
	return
end

function var_0_0._onSelectCell(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = gohelper.findChild(arg_14_1, var_0_0.PrefabInstName)

	if var_14_0 then
		local var_14_1 = MonoHelper.getLuaComFromGo(var_14_0, arg_14_0._param.cellClass)

		if var_14_1 then
			var_14_1:onSelect(arg_14_2)
		end
	end
end

return var_0_0
