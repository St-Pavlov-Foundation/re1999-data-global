module("modules.logic.sp01.assassin2.controller.VersionActivity2_9DungeonController", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonController", VersionActivityFixedDungeonController)

function var_0_0.onInitFinish(arg_1_0)
	return
end

function var_0_0.getUnlockEpisodeCount(arg_2_0, arg_2_1)
	local var_2_0 = 0
	local var_2_1 = DungeonConfig.instance:getChapterEpisodeCOList(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		if iter_2_1 and DungeonModel.instance:getEpisodeInfo(iter_2_1.id) or nil then
			var_2_0 = var_2_0 + 1
		end
	end

	return var_2_0
end

function var_0_0.openFightSuccView(arg_3_0, arg_3_1, arg_3_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_9FightSuccView, arg_3_1, arg_3_2)
end

function var_0_0.openAssassinStoryDialogView(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if not arg_4_1 then
		logError("播放对话失败 dialogId is nil")

		return
	end

	TipDialogController.instance:openTipDialogView(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
end

function var_0_0.startEpisodeLittleGame(arg_5_0, arg_5_1)
	local var_5_0 = VersionActivity2_9DungeonHelper.getEpisdoeLittleGameType(arg_5_1)

	if not var_5_0 then
		return
	end

	if var_5_0 == VersionActivity2_9DungeonEnum.LittleGameType.Eye then
		var_0_0.instance:startEyeGame(arg_5_1)
	elseif var_5_0 == VersionActivity2_9DungeonEnum.LittleGameType.Line then
		var_0_0.instance:startLineGame(arg_5_1)
	elseif var_5_0 == VersionActivity2_9DungeonEnum.LittleGameType.Point then
		var_0_0.instance:startPointGame(arg_5_1)
	else
		logError(string.format("未定义操作 episodeId = %s, littleGameType = %s", arg_5_1, var_5_0))
	end
end

function var_0_0.startEyeGame(arg_6_0, arg_6_1)
	local var_6_0 = {
		episodeId = arg_6_1
	}

	ViewMgr.instance:openView(ViewName.AssassinEyeGameView, var_6_0)
end

function var_0_0.startLineGame(arg_7_0, arg_7_1)
	local var_7_0 = {
		episodeId = arg_7_1
	}

	ViewMgr.instance:openView(ViewName.AssassinLineGameView, var_7_0)
end

function var_0_0.startPointGame(arg_8_0, arg_8_1)
	local var_8_0 = {
		episodeId = arg_8_1
	}

	ViewMgr.instance:openView(ViewName.AssassinPointGameView, var_8_0)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
