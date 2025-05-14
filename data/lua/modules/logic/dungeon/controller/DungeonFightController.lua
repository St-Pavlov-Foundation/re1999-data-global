module("modules.logic.dungeon.controller.DungeonFightController", package.seeall)

local var_0_0 = class("DungeonFightController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._battleEpisodeType = nil
	arg_1_0._otherBattleReqAction = nil
	arg_1_0._otherBattleObj = nil
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._battleEpisodeType = nil
	arg_4_0._otherBattleReqAction = nil
	arg_4_0._otherBattleObj = nil
end

function var_0_0.enterNewbieFight(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = FightController.instance:setNewBieFightParamByEpisodeId(arg_5_2)

	arg_5_0:sendStartDungeonRequest(arg_5_1, arg_5_2, var_5_0)
end

function var_0_0.enterFightByBattleId(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	DungeonModel.instance:SetSendChapterEpisodeId(arg_6_1, arg_6_2)

	local var_6_0 = FightController.instance:setFightParamByEpisodeAndBattle(arg_6_2, arg_6_3)

	var_6_0:setDungeon(arg_6_1, arg_6_2)
	var_6_0:setPreload()
	FightController.instance:enterFightScene()
end

function var_0_0.enterWeekwalkFight(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	DungeonModel.instance:SetSendChapterEpisodeId(arg_7_1, arg_7_2)

	local var_7_0 = FightController.instance:setFightParamByEpisodeAndBattle(arg_7_2, arg_7_3)

	var_7_0:setDungeon(arg_7_1, arg_7_2)
	var_7_0:setPreload()
	FightController.instance:enterFightScene()
end

function var_0_0.enterMeilanniFight(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	DungeonModel.instance:SetSendChapterEpisodeId(arg_8_1, arg_8_2)

	local var_8_0 = FightController.instance:setFightParamByEpisodeAndBattle(arg_8_2, arg_8_3)

	var_8_0:setDungeon(arg_8_1, arg_8_2)
	var_8_0:setPreload()
	FightController.instance:enterFightScene()
end

function var_0_0.enterSeasonFight(arg_9_0, arg_9_1, arg_9_2)
	FightModel.instance:clear()
	DungeonModel.instance:SetSendChapterEpisodeId(arg_9_1, arg_9_2)

	local var_9_0 = FightController.instance:setFightParamByEpisodeId(arg_9_2)

	var_9_0:setDungeon(arg_9_1, arg_9_2)
	var_9_0:setPreload()
	FightController.instance:enterFightScene()
end

function var_0_0.enterFight(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	FightModel.instance:clear()
	DungeonModel.instance:SetSendChapterEpisodeId(arg_10_1, arg_10_2)

	local var_10_0 = FightController.instance:setFightParamByEpisodeId(arg_10_2)

	var_10_0:setDungeon(arg_10_1, arg_10_2, arg_10_3)
	var_10_0:setPreload()
	var_10_0:setAdventure(arg_10_4)
	FightController.instance:enterFightScene()
end

function var_0_0.sendStartDungeonRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	if arg_11_0._otherBattleReqAction then
		arg_11_0._otherBattleReqAction(arg_11_0._otherBattleObj)
		arg_11_0:setBattleRequestAction(nil, nil)
	else
		DungeonRpc.instance:sendStartDungeonRequest(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	end
end

function var_0_0.onReceiveStartDungeonReply(arg_12_0, arg_12_1, arg_12_2)
	FightRpc.instance:onReceiveTestFightReply(arg_12_1, arg_12_2)
end

function var_0_0.sendEndFightRequest(arg_13_0, arg_13_1)
	DungeonRpc.instance:sendEndDungeonRequest(arg_13_1)
end

function var_0_0.onReceiveEndDungeonReply(arg_14_0, arg_14_1, arg_14_2)
	FightRpc.instance:onReceiveEndFightReply(arg_14_1, arg_14_2)
end

function var_0_0.restartStage()
	local var_15_0 = FightModel.instance:getFightParam()

	var_15_0.chapterId = DungeonConfig.instance:getEpisodeCO(var_15_0.episodeId).chapterId

	DungeonRpc.instance:sendStartDungeonRequest(var_15_0.chapterId, var_15_0.episodeId, var_15_0, var_15_0.multiplication, nil, nil, true)
end

function var_0_0.restartSpStage()
	local var_16_0 = GameSceneMgr.instance:getCurScene()

	var_16_0.entityMgr:removeAllUnits()
	var_16_0.director:registRespBeginFight()
	var_16_0.bgm:resumeBgm()

	local var_16_1 = FightModel.instance:getFightParam()

	var_16_1.chapterId = DungeonConfig.instance:getEpisodeCO(var_16_1.episodeId).chapterId

	var_0_0.instance:sendStartDungeonRequest(var_16_1.chapterId, var_16_1.episodeId, var_16_1, var_16_1.multiplication)
end

function var_0_0.setBattleRequestAction(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._otherBattleReqAction = arg_17_1
	arg_17_0._otherBattleObj = arg_17_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
