module("modules.logic.versionactivity1_3.common.Stat1_3Controller", package.seeall)

local var_0_0 = class("Stat1_3Controller")

function var_0_0.trackUnlockBuff(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.buffs) do
		table.insert(var_1_0, iter_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.spBuffs) do
		table.insert(var_1_0, iter_1_3)
	end

	local var_1_1 = 0
	local var_1_2 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)

	for iter_1_4 = #var_1_2, 1, -1 do
		local var_1_3 = var_1_2[iter_1_4]
		local var_1_4 = var_1_3 and DungeonModel.instance:getEpisodeInfo(var_1_3.id) or nil

		if var_1_4 and var_1_4.star > 0 then
			var_1_1 = var_1_3.id

			break
		end
	end

	for iter_1_5, iter_1_6 in ipairs(var_1_0) do
		if not Activity126Model.instance:hasBuff(iter_1_6) then
			local var_1_5 = lua_activity126_buff.configDict[iter_1_6]
			local var_1_6 = var_1_5 and var_1_5.name or ""

			if string.nilorempty(var_1_6) then
				logError(string.format("not found buffId : %s name", iter_1_6))
			end

			StatController.instance:track(StatEnum.EventName.UnlockBuff, {
				[StatEnum.EventProperties.BuffName] = var_1_6,
				[StatEnum.EventProperties.PlotProgress3] = tostring(var_1_1)
			})
		end
	end
end

var_0_0.BristleFailReasonEnum = {
	[0] = "",
	"生命值为0",
	"触碰即死陷阱",
	"玩家没有任何格子走",
	"战斗失败",
	"卡邦克鲁跟扣血怪物交互",
	"回合上限"
}

function var_0_0.bristleStatStart(arg_2_0)
	arg_2_0.bristleStartTime = ServerTime.now()
	arg_2_0.bristleUseRead = false
end

function var_0_0.bristleMarkUseRead(arg_3_0)
	arg_3_0.bristleUseRead = true
end

function var_0_0.bristleStatSuccess(arg_4_0)
	arg_4_0:bristleStatEnd(StatEnum.Result.Success)
end

function var_0_0.bristleStatFail(arg_5_0)
	arg_5_0:bristleStatEnd(StatEnum.Result.Fail)
end

function var_0_0.bristleStatAbort(arg_6_0)
	arg_6_0:bristleStatEnd(StatEnum.Result.Abort)
end

function var_0_0.bristleStatReset(arg_7_0)
	arg_7_0:bristleStatEnd(StatEnum.Result.Reset)
	arg_7_0:bristleStatStart()
end

function var_0_0.bristleStatEnd(arg_8_0, arg_8_1)
	if not arg_8_0.bristleStartTime then
		return
	end

	if arg_8_0.waitingRpc then
		return
	end

	arg_8_0.useTime = ServerTime.now() - arg_8_0.bristleStartTime
	arg_8_0.mapId = Va3ChessGameModel.instance:getMapId()
	arg_8_0.round = Va3ChessGameModel.instance:getRound()

	if arg_8_1 == StatEnum.Result.Abort or arg_8_1 == StatEnum.Result.Reset then
		arg_8_0.round = arg_8_0.round - 1
	end

	arg_8_0.goalNum = Va3ChessGameModel.instance:getFinishGoalNum()
	arg_8_0.episodeId = Va3ChessModel.instance:getEpisodeId()
	arg_8_0.hp = Va3ChessGameModel.instance:getHp()

	if arg_8_1 == StatEnum.Result.Fail then
		arg_8_0.failReason = var_0_0.BristleFailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0] or ""
	else
		arg_8_0.failReason = ""
	end

	arg_8_0.result = arg_8_1
	arg_8_0.recordBristleUseRead = arg_8_0.bristleUseRead
	arg_8_0.waitingRpc = true
	arg_8_0.bristleStartTime = nil

	Activity122Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act304, arg_8_0._onReceive122Msg, arg_8_0)
end

function var_0_0._onReceive122Msg(arg_9_0)
	local var_9_0 = Activity122Model.instance:getEpisodeData(arg_9_0.episodeId)
	local var_9_1 = var_9_0 and var_9_0.totalCount or 0

	arg_9_0.waitingRpc = false

	StatController.instance:track(StatEnum.EventName.ExitBristle, {
		[StatEnum.EventProperties.UseTime] = arg_9_0.useTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_9_0.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = var_9_1,
		[StatEnum.EventProperties.RoundNum] = arg_9_0.round,
		[StatEnum.EventProperties.GoalNum] = arg_9_0.goalNum,
		[StatEnum.EventProperties.HearthValue] = arg_9_0.hp,
		[StatEnum.EventProperties.Result] = arg_9_0.result,
		[StatEnum.EventProperties.FailReason] = arg_9_0.failReason,
		[StatEnum.EventProperties.UseRead] = arg_9_0.recordBristleUseRead
	})
end

var_0_0.JiaLaBoNaFailReasonEnum = {
	[Va3ChessEnum.FailReason.None] = "",
	[Va3ChessEnum.FailReason.Battle] = "战斗失败",
	[Va3ChessEnum.FailReason.CanNotMove] = "无路可走",
	[Va3ChessEnum.FailReason.MaxRound] = "精力为0",
	[Va3ChessEnum.FailReason.FailInteract] = "触发失败元件"
}

function var_0_0.jiaLaBoNaStatStart(arg_10_0)
	arg_10_0.jiaLaBoNaStartTime = ServerTime.now()
	arg_10_0.jiaLaBoNaUseRead = false
end

function var_0_0.jiaLaBoNaMarkUseRead(arg_11_0)
	arg_11_0.jiaLaBoNaUseRead = true
end

function var_0_0.jiaLaBoNaStatSuccess(arg_12_0)
	arg_12_0:jiaLaBoNaStatEnd(StatEnum.Result.Success)
end

function var_0_0.jiaLaBoNaStatFail(arg_13_0)
	arg_13_0:jiaLaBoNaStatEnd(StatEnum.Result.Fail)
end

function var_0_0.jiaLaBoNaStatAbort(arg_14_0)
	arg_14_0:jiaLaBoNaStatEnd(StatEnum.Result.Abort)
end

function var_0_0.jiaLaBoNaStatReset(arg_15_0)
	arg_15_0:jiaLaBoNaStatEnd(StatEnum.Result.Reset)
end

function var_0_0.jiaLaBoNaStatEnd(arg_16_0, arg_16_1)
	if not arg_16_0.jiaLaBoNaStartTime then
		return
	end

	if arg_16_0.waitingRpc then
		return
	end

	arg_16_0.useTime = ServerTime.now() - arg_16_0.jiaLaBoNaStartTime
	arg_16_0.mapId = Va3ChessGameModel.instance:getMapId()
	arg_16_0.round = Va3ChessGameModel.instance:getRound()

	if arg_16_1 == StatEnum.Result.Abort or arg_16_1 == StatEnum.Result.Reset then
		arg_16_0.round = arg_16_0.round - 1
	end

	arg_16_0.goalNum = Va3ChessGameModel.instance:getFinishGoalNum()
	arg_16_0.episodeId = Va3ChessModel.instance:getEpisodeId()
	arg_16_0.hp = Va3ChessGameModel.instance:getHp()

	if arg_16_1 == StatEnum.Result.Fail then
		arg_16_0.failReason = var_0_0.JiaLaBoNaFailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0] or ""
	else
		arg_16_0.failReason = ""
	end

	arg_16_0.result = arg_16_1
	arg_16_0.recordJiaLaBoNaUseRead = arg_16_0.jiaLaBoNaUseRead
	arg_16_0.waitingRpc = true
	arg_16_0.jiaLaBoNaStartTime = nil

	Activity120Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act306, arg_16_0._onReceive120Msg, arg_16_0)
end

function var_0_0._onReceive120Msg(arg_17_0)
	local var_17_0 = Activity120Model.instance:getEpisodeData(arg_17_0.episodeId)
	local var_17_1 = var_17_0 and var_17_0.totalCount or 0

	arg_17_0.waitingRpc = false

	StatController.instance:track(StatEnum.EventName.ExitGalaBona, {
		[StatEnum.EventProperties.UseTime] = arg_17_0.useTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_17_0.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = var_17_1,
		[StatEnum.EventProperties.RoundNum] = arg_17_0.round,
		[StatEnum.EventProperties.GoalNum] = arg_17_0.goalNum,
		[StatEnum.EventProperties.HearthValue] = arg_17_0.hp,
		[StatEnum.EventProperties.Result] = arg_17_0.result,
		[StatEnum.EventProperties.FailReason] = arg_17_0.failReason,
		[StatEnum.EventProperties.UseRead] = arg_17_0.recordJiaLaBoNaUseRead
	})
end

function var_0_0.armPuzzleStatStart(arg_18_0)
	arg_18_0.puzzleStartTime = ServerTime.now()
end

function var_0_0.puzzleStatAbort(arg_19_0)
	arg_19_0:puzzleStatEnd(StatEnum.Result.Abort)
end

function var_0_0.puzzleStatSuccess(arg_20_0)
	arg_20_0:puzzleStatEnd(StatEnum.Result.Success)
end

function var_0_0.puzzleStatReset(arg_21_0)
	arg_21_0:puzzleStatEnd(StatEnum.Result.Reset)
	arg_21_0:armPuzzleStatStart()
end

function var_0_0.puzzleStatEnd(arg_22_0, arg_22_1)
	if not arg_22_0.puzzleStartTime then
		return
	end

	local var_22_0 = ArmPuzzlePipeModel.instance:getEpisodeCo()
	local var_22_1 = var_22_0 and var_22_0.episodeId or ""

	StatController.instance:track(StatEnum.EventName.ExitSokoban, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_22_0.puzzleStartTime,
		[StatEnum.EventProperties.MapId] = tostring(var_22_1),
		[StatEnum.EventProperties.Result] = arg_22_1
	})

	arg_22_0.puzzleStartTime = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
