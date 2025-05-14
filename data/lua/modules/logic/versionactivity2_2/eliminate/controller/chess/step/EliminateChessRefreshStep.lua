module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessRefreshStep", package.seeall)

local var_0_0 = class("EliminateChessRefreshStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = EliminateChessModel.instance:getNeedResetData()

	if var_1_0 == nil then
		arg_1_0:onDone(true)

		return
	end

	EliminateChessController.instance:handleEliminateChessInfo(var_1_0.info)
	EliminateChessController.instance:handleMatch3Tips(var_1_0.match3tips)
	EliminateChessItemController.instance:refreshChess()
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.RefreshInitChessShow, false)
	EliminateChessModel.instance:setNeedResetData(nil)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateEnum.AniTime.InitDrop)
end

return var_0_0
