module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessRefreshStep", package.seeall)

slot0 = class("EliminateChessRefreshStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	if EliminateChessModel.instance:getNeedResetData() == nil then
		slot0:onDone(true)

		return
	end

	EliminateChessController.instance:handleEliminateChessInfo(slot1.info)
	EliminateChessController.instance:handleMatch3Tips(slot1.match3tips)
	EliminateChessItemController.instance:refreshChess()
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.RefreshInitChessShow, false)
	EliminateChessModel.instance:setNeedResetData(nil)
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateEnum.AniTime.InitDrop)
end

return slot0
