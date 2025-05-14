module("modules.logic.rouge.view.RougeCollectionCompCellItem", package.seeall)

local var_0_0 = class("RougeCollectionCompCellItem", RougeCollectionBaseSlotCellItem)

function var_0_0.onInit(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.onInit(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#effect")
end

var_0_0.PlayEffectDuration = 0.8

function var_0_0.onPlaceCollection(arg_2_0, arg_2_1)
	arg_2_0:updateCellState(RougeEnum.LineState.Green)
	arg_2_0:hideInsideLines(arg_2_1)
end

function var_0_0._hideEffect(arg_3_0)
	gohelper.setActive(arg_3_0._goeffect, false)
end

function var_0_0.revertCellState(arg_4_0, arg_4_1)
	var_0_0.super.revertCellState(arg_4_0, arg_4_1)
end

function var_0_0.hideInsideLines(arg_5_0, arg_5_1)
	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			local var_5_0 = arg_5_0._directionTranMap[iter_5_1]

			if var_5_0 then
				gohelper.setActive(var_5_0.gameObject, false)
			end
		end
	end
end

function var_0_0.playGetCollectionEffect(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._hideEffect, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._hideEffect, arg_6_0, var_0_0.PlayEffectDuration)
	gohelper.setActive(arg_6_0._goeffect, true)
end

function var_0_0.__onDispose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._hideEffect, arg_7_0)
	var_0_0.super.__onDispose(arg_7_0)
end

return var_0_0
