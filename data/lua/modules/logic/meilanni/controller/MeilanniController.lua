module("modules.logic.meilanni.controller.MeilanniController", package.seeall)

local var_0_0 = class("MeilanniController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._statViewTime = nil
	arg_1_0._statViewCostAP = 0
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._statViewTime = nil
	arg_4_0._statViewCostAP = 0
end

function var_0_0.activityIsEnd(arg_5_0)
	local var_5_0 = ActivityModel.instance:getActMO(MeilanniEnum.activityId)

	if not var_5_0 then
		return false
	end

	return var_5_0:getRealEndTimeStamp() <= ServerTime.now()
end

function var_0_0.openMeilanniView(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = arg_6_1 or {}

	if not arg_6_1.mapId then
		local var_6_0 = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		if var_6_0 then
			arg_6_1.mapId = MeilanniModel.instance:getMapIdByBattleId(var_6_0)
		end

		if not arg_6_1.mapId then
			arg_6_1.mapId = MeilanniModel.instance:getCurMapId()
		end
	end

	if arg_6_1.mapId then
		MeilanniModel.instance:setCurMapId(arg_6_1.mapId)
	end

	ViewMgr.instance:openView(ViewName.MeilanniView, arg_6_1, arg_6_2)
	arg_6_0:statStart()
end

function var_0_0.openMeilanniMainView(arg_7_0, arg_7_1, arg_7_2)
	Activity108Rpc.instance:sendGet108InfosRequest(MeilanniEnum.activityId, function()
		ViewMgr.instance:openView(ViewName.MeilanniMainView, arg_7_1, arg_7_2)
	end, arg_7_0)
end

function var_0_0.immediateOpenMeilanniMainView(arg_9_0, arg_9_1, arg_9_2)
	ViewMgr.instance:openView(ViewName.MeilanniMainView, arg_9_1, arg_9_2)
end

function var_0_0.openMeilanniBossInfoView(arg_10_0, arg_10_1, arg_10_2)
	ViewMgr.instance:openView(ViewName.MeilanniBossInfoView, arg_10_1, arg_10_2)
end

function var_0_0.openMeilanniTaskView(arg_11_0, arg_11_1, arg_11_2)
	ViewMgr.instance:openView(ViewName.MeilanniTaskView, arg_11_1, arg_11_2)
end

function var_0_0.openMeilanniEntrustView(arg_12_0, arg_12_1, arg_12_2)
	ViewMgr.instance:openView(ViewName.MeilanniEntrustView, arg_12_1, arg_12_2)
end

function var_0_0.openMeilanniSettlementView(arg_13_0, arg_13_1, arg_13_2)
	ViewMgr.instance:openView(ViewName.MeilanniSettlementView, arg_13_1, arg_13_2)
end

function var_0_0.startBattle(arg_14_0, arg_14_1)
	MeilanniModel.instance:setBattleElementId(arg_14_1)
	Activity108Rpc.instance:sendEnterFightEventRequest(MeilanniEnum.activityId, arg_14_1)
end

function var_0_0.enterFight(arg_15_0, arg_15_1)
	local var_15_0 = MeilanniModel.instance:getCurMapId()
	local var_15_1 = MeilanniModel.instance:getEventInfo(var_15_0, arg_15_1):getBattleId()
	local var_15_2 = MeilanniEnum.episodeId

	DungeonModel.instance.curLookEpisodeId = var_15_2

	local var_15_3 = DungeonConfig.instance:getEpisodeCO(var_15_2)

	DungeonFightController.instance:enterMeilanniFight(var_15_3.chapterId, var_15_2, var_15_1)
end

function var_0_0.getScoreDesc(arg_16_0)
	if arg_16_0 ~= 0 then
		local var_16_0

		if arg_16_0 > 0 then
			var_16_0 = string.format("<#9D1111><b>[</b>%s+%s<b>]</b></color>", luaLang("meilanni_pingfen"), arg_16_0)
		else
			var_16_0 = string.format("<#4E7656><b>[</b>%s%s<b>]</b></color>", luaLang("meilanni_pingfen"), arg_16_0)
		end

		return var_16_0
	end
end

function var_0_0.statStart(arg_17_0)
	if arg_17_0._statViewTime then
		return
	end

	local var_17_0 = MeilanniModel.instance:getCurMapId()
	local var_17_1 = MeilanniModel.instance:getMapInfo(var_17_0)

	if not var_17_1 then
		return
	end

	arg_17_0._statViewCostAP = var_17_1:getTotalCostAP()
	arg_17_0._statViewTime = ServerTime.now()
end

function var_0_0.statEnd(arg_18_0, arg_18_1)
	if not arg_18_0._statViewTime then
		return
	end

	local var_18_0 = ServerTime.now() - arg_18_0._statViewTime
	local var_18_1 = MeilanniModel.instance:getCurMapId()
	local var_18_2 = MeilanniModel.instance:getMapInfo(var_18_1)

	if not var_18_2 then
		return
	end

	local var_18_3 = var_18_2.score
	local var_18_4 = var_18_2:getTotalCostAP()
	local var_18_5 = var_18_4
	local var_18_6 = math.max(0, var_18_4 - arg_18_0._statViewCostAP)
	local var_18_7 = var_18_2.totalCount

	arg_18_0._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitMeilanniActivity, {
		[StatEnum.EventProperties.UseTime] = var_18_0,
		[StatEnum.EventProperties.MapId] = tostring(var_18_1),
		[StatEnum.EventProperties.ChallengesNum] = var_18_7,
		[StatEnum.EventProperties.ActionPoint] = var_18_5,
		[StatEnum.EventProperties.IncrementActionPoint] = var_18_6,
		[StatEnum.EventProperties.Score] = var_18_3,
		[StatEnum.EventProperties.Result] = arg_18_1 or StatEnum.Result.None
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
