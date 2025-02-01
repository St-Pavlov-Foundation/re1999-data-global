module("modules.logic.versionactivity1_3.common.Stat1_3Controller", package.seeall)

slot0 = class("Stat1_3Controller")

function slot0.trackUnlockBuff(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.buffs) do
		table.insert({}, slot7)
	end

	for slot6, slot7 in ipairs(slot1.spBuffs) do
		table.insert(slot2, slot7)
	end

	slot3 = 0

	for slot8 = #DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei), 1, -1 do
		if (slot4[slot8] and DungeonModel.instance:getEpisodeInfo(slot9.id) or nil) and slot10.star > 0 then
			slot3 = slot9.id

			break
		end
	end

	for slot8, slot9 in ipairs(slot2) do
		if not Activity126Model.instance:hasBuff(slot9) then
			if string.nilorempty(lua_activity126_buff.configDict[slot9] and slot10.name or "") then
				logError(string.format("not found buffId : %s name", slot9))
			end

			StatController.instance:track(StatEnum.EventName.UnlockBuff, {
				[StatEnum.EventProperties.BuffName] = slot11,
				[StatEnum.EventProperties.PlotProgress3] = tostring(slot3)
			})
		end
	end
end

slot0.BristleFailReasonEnum = {
	[0] = "",
	"生命值为0",
	"触碰即死陷阱",
	"玩家没有任何格子走",
	"战斗失败",
	"卡邦克鲁跟扣血怪物交互",
	"回合上限"
}

function slot0.bristleStatStart(slot0)
	slot0.bristleStartTime = ServerTime.now()
	slot0.bristleUseRead = false
end

function slot0.bristleMarkUseRead(slot0)
	slot0.bristleUseRead = true
end

function slot0.bristleStatSuccess(slot0)
	slot0:bristleStatEnd(StatEnum.Result.Success)
end

function slot0.bristleStatFail(slot0)
	slot0:bristleStatEnd(StatEnum.Result.Fail)
end

function slot0.bristleStatAbort(slot0)
	slot0:bristleStatEnd(StatEnum.Result.Abort)
end

function slot0.bristleStatReset(slot0)
	slot0:bristleStatEnd(StatEnum.Result.Reset)
	slot0:bristleStatStart()
end

function slot0.bristleStatEnd(slot0, slot1)
	if not slot0.bristleStartTime then
		return
	end

	if slot0.waitingRpc then
		return
	end

	slot0.useTime = ServerTime.now() - slot0.bristleStartTime
	slot0.mapId = Va3ChessGameModel.instance:getMapId()
	slot0.round = Va3ChessGameModel.instance:getRound()

	if slot1 == StatEnum.Result.Abort or slot1 == StatEnum.Result.Reset then
		slot0.round = slot0.round - 1
	end

	slot0.goalNum = Va3ChessGameModel.instance:getFinishGoalNum()
	slot0.episodeId = Va3ChessModel.instance:getEpisodeId()
	slot0.hp = Va3ChessGameModel.instance:getHp()

	if slot1 == StatEnum.Result.Fail then
		slot0.failReason = uv0.BristleFailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0] or ""
	else
		slot0.failReason = ""
	end

	slot0.result = slot1
	slot0.recordBristleUseRead = slot0.bristleUseRead
	slot0.waitingRpc = true
	slot0.bristleStartTime = nil

	Activity122Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act304, slot0._onReceive122Msg, slot0)
end

function slot0._onReceive122Msg(slot0)
	slot0.waitingRpc = false

	StatController.instance:track(StatEnum.EventName.ExitBristle, {
		[StatEnum.EventProperties.UseTime] = slot0.useTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = Activity122Model.instance:getEpisodeData(slot0.episodeId) and slot1.totalCount or 0,
		[StatEnum.EventProperties.RoundNum] = slot0.round,
		[StatEnum.EventProperties.GoalNum] = slot0.goalNum,
		[StatEnum.EventProperties.HearthValue] = slot0.hp,
		[StatEnum.EventProperties.Result] = slot0.result,
		[StatEnum.EventProperties.FailReason] = slot0.failReason,
		[StatEnum.EventProperties.UseRead] = slot0.recordBristleUseRead
	})
end

slot0.JiaLaBoNaFailReasonEnum = {
	[Va3ChessEnum.FailReason.None] = "",
	[Va3ChessEnum.FailReason.Battle] = "战斗失败",
	[Va3ChessEnum.FailReason.CanNotMove] = "无路可走",
	[Va3ChessEnum.FailReason.MaxRound] = "精力为0",
	[Va3ChessEnum.FailReason.FailInteract] = "触发失败元件"
}

function slot0.jiaLaBoNaStatStart(slot0)
	slot0.jiaLaBoNaStartTime = ServerTime.now()
	slot0.jiaLaBoNaUseRead = false
end

function slot0.jiaLaBoNaMarkUseRead(slot0)
	slot0.jiaLaBoNaUseRead = true
end

function slot0.jiaLaBoNaStatSuccess(slot0)
	slot0:jiaLaBoNaStatEnd(StatEnum.Result.Success)
end

function slot0.jiaLaBoNaStatFail(slot0)
	slot0:jiaLaBoNaStatEnd(StatEnum.Result.Fail)
end

function slot0.jiaLaBoNaStatAbort(slot0)
	slot0:jiaLaBoNaStatEnd(StatEnum.Result.Abort)
end

function slot0.jiaLaBoNaStatReset(slot0)
	slot0:jiaLaBoNaStatEnd(StatEnum.Result.Reset)
end

function slot0.jiaLaBoNaStatEnd(slot0, slot1)
	if not slot0.jiaLaBoNaStartTime then
		return
	end

	if slot0.waitingRpc then
		return
	end

	slot0.useTime = ServerTime.now() - slot0.jiaLaBoNaStartTime
	slot0.mapId = Va3ChessGameModel.instance:getMapId()
	slot0.round = Va3ChessGameModel.instance:getRound()

	if slot1 == StatEnum.Result.Abort or slot1 == StatEnum.Result.Reset then
		slot0.round = slot0.round - 1
	end

	slot0.goalNum = Va3ChessGameModel.instance:getFinishGoalNum()
	slot0.episodeId = Va3ChessModel.instance:getEpisodeId()
	slot0.hp = Va3ChessGameModel.instance:getHp()

	if slot1 == StatEnum.Result.Fail then
		slot0.failReason = uv0.JiaLaBoNaFailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0] or ""
	else
		slot0.failReason = ""
	end

	slot0.result = slot1
	slot0.recordJiaLaBoNaUseRead = slot0.jiaLaBoNaUseRead
	slot0.waitingRpc = true
	slot0.jiaLaBoNaStartTime = nil

	Activity120Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act306, slot0._onReceive120Msg, slot0)
end

function slot0._onReceive120Msg(slot0)
	slot0.waitingRpc = false

	StatController.instance:track(StatEnum.EventName.ExitGalaBona, {
		[StatEnum.EventProperties.UseTime] = slot0.useTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = Activity120Model.instance:getEpisodeData(slot0.episodeId) and slot1.totalCount or 0,
		[StatEnum.EventProperties.RoundNum] = slot0.round,
		[StatEnum.EventProperties.GoalNum] = slot0.goalNum,
		[StatEnum.EventProperties.HearthValue] = slot0.hp,
		[StatEnum.EventProperties.Result] = slot0.result,
		[StatEnum.EventProperties.FailReason] = slot0.failReason,
		[StatEnum.EventProperties.UseRead] = slot0.recordJiaLaBoNaUseRead
	})
end

function slot0.armPuzzleStatStart(slot0)
	slot0.puzzleStartTime = ServerTime.now()
end

function slot0.puzzleStatAbort(slot0)
	slot0:puzzleStatEnd(StatEnum.Result.Abort)
end

function slot0.puzzleStatSuccess(slot0)
	slot0:puzzleStatEnd(StatEnum.Result.Success)
end

function slot0.puzzleStatReset(slot0)
	slot0:puzzleStatEnd(StatEnum.Result.Reset)
	slot0:armPuzzleStatStart()
end

function slot0.puzzleStatEnd(slot0, slot1)
	if not slot0.puzzleStartTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.ExitSokoban, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0.puzzleStartTime,
		[StatEnum.EventProperties.MapId] = tostring(ArmPuzzlePipeModel.instance:getEpisodeCo() and slot2.episodeId or ""),
		[StatEnum.EventProperties.Result] = slot1
	})

	slot0.puzzleStartTime = nil
end

slot0.instance = slot0.New()

return slot0
