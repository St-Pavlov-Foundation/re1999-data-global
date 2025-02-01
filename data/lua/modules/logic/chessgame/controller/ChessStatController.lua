module("modules.logic.chessgame.controller.ChessStatController", package.seeall)

slot0 = class("ChessStatController")

function slot0.startStat(slot0)
	slot0.startTime = ServerTime.now()
end

function slot0.statSuccess(slot0)
	slot0:_statEnd(StatEnum.Result.Success)
end

function slot0.statFail(slot0)
	slot0:_statEnd(StatEnum.Result.Fail)
end

function slot0.statReset(slot0)
	slot0:_statEnd(StatEnum.Result.Reset)
	slot0:startStat()
end

function slot0.statAbort(slot0)
	slot0:_statEnd(StatEnum.Result.Abort)
end

function slot0._statEnd(slot0, slot1)
	if not slot0.startTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.ExitLanShouPaActivity, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0.startTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(ChessModel.instance:getEpisodeId()),
		[StatEnum.EventProperties.RoundNum] = ChessGameModel.instance:getRound(),
		[StatEnum.EventProperties.GoalNum] = ChessGameModel.instance:getCompletedCount(),
		[StatEnum.EventProperties.Result] = slot1,
		[StatEnum.EventProperties.BackNum] = ChessGameModel.instance:getRollBackNum()
	})
	ChessGameModel.instance:clearRound()
	ChessGameModel.instance:clearRollbackNum()

	slot0.startTime = nil
end

slot0.instance = slot0.New()

return slot0
