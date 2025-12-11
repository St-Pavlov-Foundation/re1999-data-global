module("modules.logic.survival.view.map.comp.SurvivalSimpleListPart", package.seeall)

local var_0_0 = class("SurvivalSimpleListPart", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or {}
	arg_1_0._minUpdate = arg_1_1.minUpdate or 1
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:GetComponentInChildren(typeof(UnityEngine.UI.GridLayoutGroup))
	local var_2_1 = var_2_0.cellSize
	local var_2_2 = var_2_0.spacing
	local var_2_3 = var_2_0.padding

	var_2_0.enabled = false

	local var_2_4 = recthelper.getWidth(var_2_0.transform) - var_2_3.left - var_2_3.right
	local var_2_5 = math.floor(var_2_4 / (var_2_1.x + var_2_2.x))

	if var_2_4 - var_2_5 * (var_2_1.x + var_2_2.x) > var_2_1.x then
		var_2_5 = var_2_5 + 1
	end

	if var_2_5 < 1 then
		var_2_5 = 1
	end

	arg_2_0._leftOffset = var_2_3.left
	arg_2_0._csListScroll = SLFramework.UGUI.ListScrollView.Get(arg_2_1)

	arg_2_0._csListScroll:Init(ScrollEnum.ScrollDirV, var_2_5, var_2_1.x, var_2_1.y, var_2_2.x, var_2_2.y, var_2_3.top, var_2_3.bottom, ScrollEnum.ScrollSortNone, 10, arg_2_0._minUpdate, arg_2_0._onUpdateCell, arg_2_0.onUpdateFinish, arg_2_0._onSelectCell, arg_2_0)
end

function var_0_0.setList(arg_3_0, arg_3_1)
	arg_3_0._allCellComps = {}
	arg_3_0._allCellGos = {}
	arg_3_0._list = arg_3_1

	arg_3_0._csListScroll:UpdateTotalCount(#arg_3_1)
end

function var_0_0.setOpenAnimation(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._animInterval = arg_4_1
	arg_4_0._animationStartTime = Time.time
	arg_4_0._groupNum = arg_4_2 or 1
end

function var_0_0.setCellUpdateCallBack(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0._updateCallback = arg_5_1
	arg_5_0._updateCallobj = arg_5_2
	arg_5_0._cellCls = arg_5_3
	arg_5_0._instGo = arg_5_4
end

function var_0_0.setRecycleCallBack(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._recycleCallback = arg_6_1
	arg_6_0._recycleCallobj = arg_6_2
end

function var_0_0._onUpdateCell(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = gohelper.findChild(arg_7_1, "instGo")
	local var_7_1

	if not var_7_0 then
		var_7_0 = gohelper.clone(arg_7_0._instGo, arg_7_1, "instGo")

		gohelper.setActive(var_7_0, true)
		transformhelper.setLocalPos(var_7_0.transform, arg_7_0._leftOffset, 0, 0)

		if arg_7_0._cellCls then
			var_7_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0, arg_7_0._cellCls)
			arg_7_0._allCellComps[var_7_1] = arg_7_2
		end
	elseif arg_7_0._cellCls then
		var_7_1 = MonoHelper.getLuaComFromGo(var_7_0, arg_7_0._cellCls)
		arg_7_0._allCellComps[var_7_1] = arg_7_2
	end

	if arg_7_0._allCellGos[var_7_0] and arg_7_0._allCellGos[var_7_0] ~= arg_7_2 and arg_7_0._recycleCallback then
		arg_7_0._recycleCallback(arg_7_0._recycleCallobj, var_7_0, arg_7_0._allCellGos[var_7_0], arg_7_2)
	end

	arg_7_0._allCellGos[var_7_0] = arg_7_2

	if arg_7_0._updateCallback then
		if var_7_1 then
			arg_7_0._updateCallback(arg_7_0._updateCallobj, var_7_1, arg_7_0._list[arg_7_2 + 1], arg_7_2 + 1)
		else
			arg_7_0._updateCallback(arg_7_0._updateCallobj, var_7_0, arg_7_0._list[arg_7_2 + 1], arg_7_2 + 1)
		end
	end

	if arg_7_0._animationStartTime then
		local var_7_2 = var_7_1:getItemAnimators()

		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			iter_7_1:Play(UIAnimationName.Open, 0, 0)
			iter_7_1:Update(0)

			local var_7_3 = math.floor(arg_7_2 / arg_7_0._groupNum)
			local var_7_4 = arg_7_0._animationStartTime + arg_7_0._animInterval * var_7_3
			local var_7_5 = iter_7_1:GetCurrentAnimatorStateInfo(0).length
			local var_7_6 = (Time.time - var_7_4) / var_7_5

			iter_7_1:Play(UIAnimationName.Open, 0, var_7_6)
			iter_7_1:Update(0)
		end
	end
end

function var_0_0.getAllComps(arg_8_0)
	return arg_8_0._allCellComps
end

function var_0_0.getAllGos(arg_9_0)
	return arg_9_0._allCellGos
end

function var_0_0.onUpdateFinish(arg_10_0)
	return
end

function var_0_0._onSelectCell(arg_11_0, arg_11_1, arg_11_2)
	return
end

return var_0_0
