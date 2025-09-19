module("modules.logic.survival.view.map.comp.SurvivalSimpleListPart", package.seeall)

local var_0_0 = class("SurvivalSimpleListPart", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:GetComponentInChildren(typeof(UnityEngine.UI.GridLayoutGroup))
	local var_1_1 = var_1_0.cellSize
	local var_1_2 = var_1_0.spacing
	local var_1_3 = var_1_0.padding

	var_1_0.enabled = false

	local var_1_4 = recthelper.getWidth(var_1_0.transform) - var_1_3.left - var_1_3.right
	local var_1_5 = math.floor(var_1_4 / (var_1_1.x + var_1_2.x))

	if var_1_4 - var_1_5 * (var_1_1.x + var_1_2.x) > var_1_1.x then
		var_1_5 = var_1_5 + 1
	end

	if var_1_5 < 1 then
		var_1_5 = 1
	end

	arg_1_0._leftOffset = var_1_3.left
	arg_1_0._csListScroll = SLFramework.UGUI.ListScrollView.Get(arg_1_1)

	arg_1_0._csListScroll:Init(ScrollEnum.ScrollDirV, var_1_5, var_1_1.x, var_1_1.y, var_1_2.x, var_1_2.y, var_1_3.top, var_1_3.bottom, ScrollEnum.ScrollSortNone, 10, 1, arg_1_0._onUpdateCell, arg_1_0.onUpdateFinish, arg_1_0._onSelectCell, arg_1_0)
end

function var_0_0.setList(arg_2_0, arg_2_1)
	arg_2_0._allCellComps = {}
	arg_2_0._allCellGos = {}
	arg_2_0._list = arg_2_1

	arg_2_0._csListScroll:UpdateTotalCount(#arg_2_1)
end

function var_0_0.setCellUpdateCallBack(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._updateCallback = arg_3_1
	arg_3_0._updateCallobj = arg_3_2
	arg_3_0._cellCls = arg_3_3
	arg_3_0._instGo = arg_3_4
end

function var_0_0.setRecycleCallBack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._recycleCallback = arg_4_1
	arg_4_0._recycleCallobj = arg_4_2
end

function var_0_0._onUpdateCell(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = gohelper.findChild(arg_5_1, "instGo")
	local var_5_1

	if not var_5_0 then
		var_5_0 = gohelper.clone(arg_5_0._instGo, arg_5_1, "instGo")

		gohelper.setActive(var_5_0, true)
		transformhelper.setLocalPos(var_5_0.transform, arg_5_0._leftOffset, 0, 0)

		if arg_5_0._cellCls then
			var_5_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, arg_5_0._cellCls)
			arg_5_0._allCellComps[var_5_1] = arg_5_2
		end
	elseif arg_5_0._cellCls then
		var_5_1 = MonoHelper.getLuaComFromGo(var_5_0, arg_5_0._cellCls)
		arg_5_0._allCellComps[var_5_1] = arg_5_2
	end

	if arg_5_0._allCellGos[var_5_0] and arg_5_0._allCellGos[var_5_0] ~= arg_5_2 and arg_5_0._recycleCallback then
		arg_5_0._recycleCallback(arg_5_0._recycleCallobj, var_5_0, arg_5_0._allCellGos[var_5_0], arg_5_2)
	end

	arg_5_0._allCellGos[var_5_0] = arg_5_2

	if arg_5_0._updateCallback then
		if var_5_1 then
			arg_5_0._updateCallback(arg_5_0._updateCallobj, var_5_1, arg_5_0._list[arg_5_2 + 1], arg_5_2 + 1)
		else
			arg_5_0._updateCallback(arg_5_0._updateCallobj, var_5_0, arg_5_0._list[arg_5_2 + 1], arg_5_2 + 1)
		end
	end
end

function var_0_0.getAllComps(arg_6_0)
	return arg_6_0._allCellComps
end

function var_0_0.getAllGos(arg_7_0)
	return arg_7_0._allCellGos
end

function var_0_0.onUpdateFinish(arg_8_0)
	return
end

function var_0_0._onSelectCell(arg_9_0, arg_9_1, arg_9_2)
	return
end

return var_0_0
