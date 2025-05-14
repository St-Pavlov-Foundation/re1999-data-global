module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessPlayEffectStep", package.seeall)

local var_0_0 = class("EliminateChessPlayEffectStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0, var_1_1, var_1_2 = EliminateChessModel.instance:getRecordCurNeedShowEffectAndXYAndClear()

	arg_1_0.effectType = var_1_2

	if var_1_0 == nil or var_1_1 == nil or arg_1_0.effectType == nil then
		arg_1_0:onDone(true)

		return
	end

	local var_1_3 = EliminateChessItemController.instance:getChessItem(var_1_0, var_1_1)

	if not var_1_3 then
		logError("步骤 PlayEffect 棋子：" .. var_1_0, var_1_1 .. "不存在")
		arg_1_0:onDone(true)

		return
	end

	local var_1_4, var_1_5 = var_1_3:getGoPos()

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, arg_1_0.effectType, var_1_0, var_1_1, var_1_4, var_1_5, true, arg_1_0._onPlayEnd, arg_1_0)
end

function var_0_0._onPlayEnd(arg_2_0)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.PlayEliminateEffect, arg_2_0.effectType, nil, nil, 0, 0, false, nil, nil)
	arg_2_0:onDone(true)
end

return var_0_0
