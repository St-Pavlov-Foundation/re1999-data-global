module("modules.logic.rouge.controller.RougeStatController", package.seeall)

local var_0_0 = class("RougeStatController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onNodeEventStatusChange, arg_1_0.onNodeEventStatusChange, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeSendMoveRpc, arg_1_0.beforeMoveEvent, arg_1_0)
	RougeController.instance:registerCallback(RougeEvent.AdjustBackPack, arg_1_0.onAdjustBackPack, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeNormalToMiddle, arg_1_0.trackExitDungeonLayer, arg_1_0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_1_0._onPushEndFight, arg_1_0)
end

function var_0_0.clear(arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNodeEventStatusChange, arg_2_0.onNodeEventStatusChange, arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onBeforeSendMoveRpc, arg_2_0.beforeMoveEvent, arg_2_0)
	RougeController.instance:unregisterCallback(RougeEvent.AdjustBackPack, arg_2_0.onAdjustBackPack, arg_2_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onBeforeNormalToMiddle, arg_2_0.trackExitDungeonLayer, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_2_0._onPushEndFight, arg_2_0)
end

function var_0_0._onPushEndFight(arg_3_0)
	local var_3_0 = FightModel.instance:getRecordMO()
	local var_3_1 = var_3_0 and var_3_0.fightResult

	if var_3_1 then
		arg_3_0._failResult = var_3_1
	end
end

function var_0_0.statStart(arg_4_0)
	arg_4_0.startTime = ServerTime.now()
	arg_4_0._isStart = true
	arg_4_0._isReset = false
	arg_4_0._failResult = nil
end

function var_0_0.checkIsReset(arg_5_0)
	return arg_5_0._isReset
end

function var_0_0.setReset(arg_6_0)
	arg_6_0._isReset = true
end

var_0_0.EndResult = {
	Close = 3,
	Abort = 4,
	Fail = 2,
	Success = 1
}

function var_0_0.statEnd(arg_7_0, arg_7_1)
	local var_7_0, var_7_1, var_7_2 = arg_7_0:getCollectionInfo()
	local var_7_3

	StatController.instance:track(StatEnum.EventName.FinishRouge, {
		[StatEnum.EventProperties.Season] = arg_7_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_7_0:getVersion(),
		[StatEnum.EventProperties.MatchId] = arg_7_0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = arg_7_0:getDifficulty(),
		[StatEnum.EventProperties.Build] = arg_7_0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = arg_7_0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_7_0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_7_0:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = arg_7_0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = arg_7_0:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = arg_7_0:getAssistList(),
		[StatEnum.EventProperties.CollectList] = var_7_0,
		[StatEnum.EventProperties.CollectArray] = var_7_1,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = var_7_2,
		[StatEnum.EventProperties.DungeonGold] = arg_7_0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = arg_7_0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = arg_7_0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = arg_7_0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = arg_7_0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = arg_7_0:getBuildTalentList(),
		[StatEnum.EventProperties.UseTime] = arg_7_0:getUseTime(),
		[StatEnum.EventProperties.DungeonResult] = var_7_3 or arg_7_0:getRougeResult(arg_7_1),
		[StatEnum.EventProperties.InterrruptReason] = arg_7_0:getInterruptReason(arg_7_1),
		[StatEnum.EventProperties.CompletedEventNum] = arg_7_0:getCompletedEventNum(),
		[StatEnum.EventProperties.CompletedEventId] = arg_7_0:getCompletedEventID(),
		[StatEnum.EventProperties.CompletedEntrustId] = arg_7_0:getCompletedEntrustId(),
		[StatEnum.EventProperties.CompletedEntrustNum] = arg_7_0:getCompletedEntrustNum(),
		[StatEnum.EventProperties.CompletedLayers] = arg_7_0:getCompletedLayers(),
		[StatEnum.EventProperties.DungeonPoints] = arg_7_0:getRougePoints(),
		[StatEnum.EventProperties.RewardPoints] = arg_7_0:getRougeRewardPoints(),
		[StatEnum.EventProperties.TalentPoints] = arg_7_0:getRougeTalentPoints(),
		[StatEnum.EventProperties.TotalDeathNum] = arg_7_0:getTotalDeathNum(),
		[StatEnum.EventProperties.TotalReviveNum] = arg_7_0:getTotalReviveNum(),
		[StatEnum.EventProperties.CollectionConflateNum] = arg_7_0:getCollectionConflateNum(),
		[StatEnum.EventProperties.BadgeName] = arg_7_0:getBadgeName(),
		[StatEnum.EventProperties.LimiterEntry] = arg_7_0:getAllLimiterDesc(),
		[StatEnum.EventProperties.EmblemNum] = arg_7_0:getAddEmblemCount()
	})
end

function var_0_0.bakerougeInfoMo(arg_8_0)
	arg_8_0.rougeInfoMo = RougeModel.instance:getRougeInfo()
end

function var_0_0.getrougeInfoMo(arg_9_0)
	return arg_9_0.rougeInfoMo
end

function var_0_0.clearrougeInfoMo(arg_10_0)
	arg_10_0.rougeInfoMo = nil
end

function var_0_0.reInit(arg_11_0)
	arg_11_0:_clearInitHeroGroupList()
end

function var_0_0._clearInitHeroGroupList(arg_12_0)
	arg_12_0.initHeroNameList = nil
	arg_12_0.initHeroObjList = nil
	arg_12_0.assistList = {}
end

function var_0_0._initHeroGroupList(arg_13_0)
	arg_13_0.initHeroNameList = {}
	arg_13_0.initHeroObjList = {}

	local var_13_0 = RougeModel.instance:getRougeInfo()

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0.teamInfo
	local var_13_2 = RougeModel.instance:getInitHeroIds()

	for iter_13_0, iter_13_1 in ipairs(var_13_2) do
		local var_13_3 = HeroModel.instance:getByHeroId(iter_13_1)
		local var_13_4 = var_13_1:getAssistHeroMo(iter_13_1)

		if var_13_3 and not var_13_4 then
			local var_13_5, var_13_6 = arg_13_0:buildObj(var_13_3)

			table.insert(arg_13_0.initHeroNameList, var_13_5)
			table.insert(arg_13_0.initHeroObjList, var_13_6)
		end
	end
end

function var_0_0.selectInitHeroGroup(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:_clearInitHeroGroupList()

	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		var_14_0[#var_14_0 + 1] = iter_14_1.heroId
	end

	if arg_14_2 then
		var_14_0[#var_14_0 + 1] = arg_14_2.heroId
	end

	RougeModel.instance:setTeamInitHeros(var_14_0)
	arg_14_0:_initHeroGroupList()

	if arg_14_2 then
		local var_14_1 = arg_14_2:getHeroMO()

		if var_14_1 then
			local var_14_2, var_14_3 = arg_14_0:buildObj(var_14_1)

			table.insert(arg_14_0.assistList, var_14_3)
		end
	end

	StatController.instance:track(StatEnum.EventName.SelectHeroGroup, {
		[StatEnum.EventProperties.Season] = arg_14_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_14_0:getVersion(),
		[StatEnum.EventProperties.Difficulty] = arg_14_0:getDifficulty(),
		[StatEnum.EventProperties.Build] = arg_14_0:getBuild(),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_14_0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_14_0:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = arg_14_0:getAssistList()
	})
end

function var_0_0.buildObj(arg_15_0, arg_15_1, arg_15_2)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	local var_15_0 = 0
	local var_15_1 = 0
	local var_15_2
	local var_15_3
	local var_15_4
	local var_15_5 = arg_15_1.rank >= CharacterEnum.TalentRank and arg_15_1.talent > 0

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		var_15_5 = false
	end

	local var_15_6 = 0
	local var_15_7 = 0
	local var_15_8 = 0
	local var_15_9
	local var_15_10 = 0
	local var_15_11 = false

	if not arg_15_1:isTrial() and RougeHeroGroupBalanceHelper.getIsBalanceMode() then
		local var_15_12, var_15_13, var_15_14, var_15_15, var_15_16 = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(arg_15_1.heroId)

		if var_15_13 and var_15_13 >= CharacterEnum.TalentRank and var_15_14 > 0 then
			var_15_11 = true
		end

		var_15_0 = var_15_12 and var_15_12 > arg_15_1.level and var_15_12 or arg_15_1.level
		var_15_1 = var_15_11 and (not var_15_5 or var_15_14 > arg_15_1.talent) and var_15_14 or arg_15_1.talent

		if arg_15_2 then
			var_15_2 = var_15_16 and var_15_16 > arg_15_2.level and var_15_16 or arg_15_2.level
			var_15_3 = arg_15_2.refineLv
			var_15_4 = arg_15_2.config.name
		else
			var_15_2 = 0
			var_15_3 = 0
			var_15_4 = ""
		end
	end

	local var_15_17 = HeroConfig.instance:getHeroCO(arg_15_1.heroId)
	local var_15_18, var_15_19 = HeroConfig.instance:getShowLevel(var_15_0)
	local var_15_20 = {
		hero_name = var_15_17.name,
		hero_level = var_15_0,
		hero_rank = var_15_19,
		breakthrough = arg_15_1.exSkillLevel,
		talent = var_15_1,
		EquipName = var_15_4,
		EquipLevel = var_15_2,
		equip_refine = var_15_3
	}

	return var_15_17.name, var_15_20
end

var_0_0.EventType = {
	"普通战斗事件",
	"困难战斗事件（精英）",
	"精英战斗事件（层间boss）",
	"BOSS战斗事件（最终boss）",
	"奖励事件",
	"选项事件",
	"商店事件",
	"休憩事件"
}

function var_0_0.beforeMoveEvent(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_2 = RougeMapModel.instance:getNodeDict()

	for iter_16_0, iter_16_1 in pairs(var_16_2) do
		if iter_16_1.arriveStatus == RougeMapEnum.Arrive.CanArrive then
			table.insert(var_16_1, iter_16_1.eventId)

			local var_16_3 = iter_16_1:getEventCo()
			local var_16_4 = var_0_0.EventType[var_16_3.type]

			if var_16_4 then
				table.insert(var_16_0, var_16_4)
			end
		end
	end

	StatController.instance:track(StatEnum.EventName.OccurOptionalEvent, {
		[StatEnum.EventProperties.OccurEventType] = var_16_0,
		[StatEnum.EventProperties.OccurEventID] = var_16_1
	})
end

function var_0_0.onNodeEventStatusChange(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 ~= RougeMapEnum.EventState.Finish then
		return
	end

	arg_17_0:tryTriggerFinishEvent(arg_17_1)
end

function var_0_0.tryTriggerFinishEvent(arg_18_0, arg_18_1)
	local var_18_0 = RougeMapConfig.instance:getRougeEvent(arg_18_1)
	local var_18_1, var_18_2, var_18_3 = arg_18_0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.EventComplete, {
		[StatEnum.EventProperties.Season] = arg_18_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_18_0:getVersion(),
		[StatEnum.EventProperties.MatchId] = arg_18_0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = arg_18_0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = arg_18_0:getLayer(),
		[StatEnum.EventProperties.Build] = arg_18_0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = arg_18_0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_18_0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_18_0:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = arg_18_0:getAssistList(),
		[StatEnum.EventProperties.HeroGroup] = arg_18_0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = arg_18_0:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = var_18_1,
		[StatEnum.EventProperties.CollectArray] = var_18_2,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = var_18_3,
		[StatEnum.EventProperties.DungeonGold] = arg_18_0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = arg_18_0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = arg_18_0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = arg_18_0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = arg_18_0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = arg_18_0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = arg_18_0:getAllLimiterDesc(),
		[StatEnum.EventProperties.DungeonEventId] = arg_18_1,
		[StatEnum.EventProperties.DungeonEventName] = var_18_0.name,
		[StatEnum.EventProperties.DungeonEventType] = var_0_0.EventType[var_18_0.type]
	})
end

function var_0_0.statRougeChoiceEvent(arg_19_0)
	local var_19_0 = RougeMapModel.instance:getCurEvent()
	local var_19_1 = var_19_0 and var_19_0.id
	local var_19_2 = RougeMapModel.instance:getCurChoiceId()
	local var_19_3 = var_19_2 and lua_rouge_choice.configDict[var_19_2]
	local var_19_4 = var_19_3 and var_19_3.desc
	local var_19_5, var_19_6, var_19_7 = arg_19_0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.RougeConfirmSelectOption, {
		[StatEnum.EventProperties.Season] = arg_19_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_19_0:getVersion(),
		[StatEnum.EventProperties.MatchId] = arg_19_0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = arg_19_0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = arg_19_0:getLayer(),
		[StatEnum.EventProperties.Build] = arg_19_0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = arg_19_0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_19_0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_19_0:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = arg_19_0:getAssistList(),
		[StatEnum.EventProperties.HeroGroup] = arg_19_0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = arg_19_0:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = var_19_5,
		[StatEnum.EventProperties.CollectArray] = var_19_6,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = var_19_7,
		[StatEnum.EventProperties.DungeonGold] = arg_19_0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = arg_19_0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = arg_19_0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = arg_19_0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = arg_19_0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = arg_19_0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = arg_19_0:getAllLimiterDesc(),
		[StatEnum.EventProperties.DungeonEventId] = var_19_1,
		[StatEnum.EventProperties.DungeonEventName] = var_19_0.name,
		[StatEnum.EventProperties.DungeonEventType] = var_0_0.EventType[var_19_0.type],
		[StatEnum.EventProperties.RougeEventChoiceId] = var_19_2,
		[StatEnum.EventProperties.RougeEventChoiceName] = var_19_4
	})
end

function var_0_0.startAdjustBackPack(arg_20_0)
	arg_20_0.startAdjustTime = ServerTime.now()
	arg_20_0._isopenbackpack = true
end

function var_0_0.onAdjustBackPack(arg_21_0)
	if not arg_21_0._isopenbackpack then
		return
	end

	arg_21_0._adjustbackpack = true
end

function var_0_0.clearBackpack(arg_22_0)
	arg_22_0._adjustbackpack = false
	arg_22_0._isopenbackpack = false
end

function var_0_0.endAdjustBackPack(arg_23_0)
	local var_23_0, var_23_1, var_23_2 = arg_23_0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.ExitRougeBackpack, {
		[StatEnum.EventProperties.Season] = arg_23_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_23_0:getVersion(),
		[StatEnum.EventProperties.MatchId] = arg_23_0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = arg_23_0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = arg_23_0:getLayer(),
		[StatEnum.EventProperties.Build] = arg_23_0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = arg_23_0:getTeamLevel(),
		[StatEnum.EventProperties.HeroGroup] = arg_23_0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = arg_23_0:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = var_23_0,
		[StatEnum.EventProperties.CollectArray] = var_23_1,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = var_23_2,
		[StatEnum.EventProperties.DungeonGold] = arg_23_0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = arg_23_0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = arg_23_0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = arg_23_0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = arg_23_0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = arg_23_0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = arg_23_0:getAllLimiterDesc(),
		[StatEnum.EventProperties.UseTime] = arg_23_0:getAdjustBackPackTime(),
		[StatEnum.EventProperties.IsBackPackAdjust] = arg_23_0:getAdjustBackPack()
	})
	arg_23_0:clearBackpack()
end

var_0_0.operateType = {
	Auto = 1,
	Clear = 2
}

function var_0_0.operateCollection(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1 == var_0_0.operateType.Auto and "一键填入" or "清空"
	local var_24_1, var_24_2, var_24_3 = arg_24_0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.OperateCollection, {
		[StatEnum.EventProperties.Season] = arg_24_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_24_0:getVersion(),
		[StatEnum.EventProperties.MatchId] = arg_24_0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = arg_24_0:getDifficulty(),
		[StatEnum.EventProperties.Build] = arg_24_0:getBuild(),
		[StatEnum.EventProperties.Layer] = arg_24_0:getLayer(),
		[StatEnum.EventProperties.FieldLevel] = arg_24_0:getTeamLevel(),
		[StatEnum.EventProperties.HeroGroup] = arg_24_0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = arg_24_0:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = var_24_1,
		[StatEnum.EventProperties.CollectArray] = var_24_2,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = var_24_3,
		[StatEnum.EventProperties.DungeonGold] = arg_24_0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = arg_24_0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = arg_24_0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = arg_24_0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = arg_24_0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = arg_24_0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = arg_24_0:getAllLimiterDesc(),
		[StatEnum.EventProperties.RougeOperationType] = var_24_0
	})
end

function var_0_0.trackExitDungeonLayer(arg_25_0)
	local var_25_0, var_25_1, var_25_2 = arg_25_0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.ExitRougeLayer, {
		[StatEnum.EventProperties.Season] = arg_25_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_25_0:getVersion(),
		[StatEnum.EventProperties.MatchId] = arg_25_0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = arg_25_0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = arg_25_0:getLayer(),
		[StatEnum.EventProperties.Build] = arg_25_0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = arg_25_0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_25_0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_25_0:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = arg_25_0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = arg_25_0:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = arg_25_0:getAssistList(),
		[StatEnum.EventProperties.CollectList] = var_25_0,
		[StatEnum.EventProperties.CollectArray] = var_25_1,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = var_25_2,
		[StatEnum.EventProperties.DungeonGold] = arg_25_0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = arg_25_0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = arg_25_0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = arg_25_0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = arg_25_0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = arg_25_0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = arg_25_0:getAllLimiterDesc()
	})
end

function var_0_0.trackUpdateTalent(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	local var_26_0 = lua_rouge_style_talent.configDict[arg_26_1]
	local var_26_1 = var_26_0 and var_26_0.desc
	local var_26_2, var_26_3, var_26_4 = arg_26_0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.UpdateTalent, {
		[StatEnum.EventProperties.Season] = arg_26_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_26_0:getVersion(),
		[StatEnum.EventProperties.MatchId] = arg_26_0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = arg_26_0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = arg_26_0:getLayer(),
		[StatEnum.EventProperties.Build] = arg_26_0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = arg_26_0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_26_0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_26_0:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = arg_26_0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = arg_26_0:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = arg_26_0:getAssistList(),
		[StatEnum.EventProperties.CollectList] = var_26_2,
		[StatEnum.EventProperties.CollectArray] = var_26_3,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = var_26_4,
		[StatEnum.EventProperties.DungeonGold] = arg_26_0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = arg_26_0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = arg_26_0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = arg_26_0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = arg_26_0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = arg_26_0:getBuildTalentList(),
		[StatEnum.EventProperties.BuildTalentId] = tostring(arg_26_1),
		[StatEnum.EventProperties.BuildTalentDescribe] = var_26_1,
		[StatEnum.EventProperties.LimiterEntry] = arg_26_0:getAllLimiterDesc()
	})
end

function var_0_0.trackUseMapSkill(arg_27_0, arg_27_1)
	local var_27_0, var_27_1, var_27_2 = arg_27_0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.UseMapSkill, {
		[StatEnum.EventProperties.Season] = arg_27_0:getSeason(),
		[StatEnum.EventProperties.Version] = arg_27_0:getVersion(),
		[StatEnum.EventProperties.MatchId] = arg_27_0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = arg_27_0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = arg_27_0:getLayer(),
		[StatEnum.EventProperties.Build] = arg_27_0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = arg_27_0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_27_0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_27_0:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = arg_27_0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = arg_27_0:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = arg_27_0:getAssistList(),
		[StatEnum.EventProperties.CollectList] = var_27_0,
		[StatEnum.EventProperties.CollectArray] = var_27_1,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = var_27_2,
		[StatEnum.EventProperties.DungeonGold] = arg_27_0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = arg_27_0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = arg_27_0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = arg_27_0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = arg_27_0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = arg_27_0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = arg_27_0:getAllLimiterDesc(),
		[StatEnum.EventProperties.MapSkill] = tostring(arg_27_1)
	})
end

function var_0_0.getCurrentHeroGroupList(arg_28_0)
	local var_28_0 = {}
	local var_28_1 = {}
	local var_28_2 = RougeModel.instance:getRougeInfo()

	if not var_28_2 then
		return nil
	end

	local var_28_3 = var_28_2.teamInfo
	local var_28_4 = var_28_3:getBattleHeroList()
	local var_28_5 = var_28_3:getGroupEquips()

	for iter_28_0, iter_28_1 in ipairs(var_28_4) do
		local var_28_6 = var_28_5[iter_28_0]

		if iter_28_1 then
			local var_28_7, var_28_8 = arg_28_0:buildObj(iter_28_1, var_28_6)

			table.insert(var_28_0, var_28_7)
			table.insert(var_28_1, var_28_8)
		end
	end

	return var_28_0, var_28_1
end

function var_0_0.getUnlockTalentNameList(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = RougeOutsideModel.instance:season()
	local var_29_2 = RougeTalentModel.instance:getUnlockTalent()

	for iter_29_0, iter_29_1 in ipairs(var_29_2) do
		local var_29_3 = RougeTalentConfig.instance:getBranchConfigByID(var_29_1, iter_29_1).name

		table.insert(var_29_0, var_29_3)
	end

	return var_29_0
end

var_0_0.Effect2Chinese = {
	"电能",
	"吞噬",
	"升级"
}

function var_0_0.getCollectionInfo(arg_30_0)
	local var_30_0 = {}
	local var_30_1 = {}
	local var_30_2 = {}
	local var_30_3 = RougeCollectionModel.instance:getSlotAreaCollection()

	for iter_30_0, iter_30_1 in pairs(var_30_3) do
		local var_30_4 = iter_30_1:getAllEnchantCfgId()
		local var_30_5 = iter_30_1:getCollectionCfgId()
		local var_30_6 = RougeCollectionConfig.instance:getCollectionName(var_30_5, var_30_4)
		local var_30_7 = {
			"</color>",
			"<#.->"
		}

		for iter_30_2, iter_30_3 in ipairs(var_30_7) do
			var_30_6 = string.gsub(var_30_6, iter_30_3, "")
		end

		table.insert(var_30_0, var_30_6)

		local var_30_8 = {
			collection_name = var_30_6
		}

		var_30_8.collection_num = 1

		for iter_30_4, iter_30_5 in ipairs(var_30_4) do
			if iter_30_5 ~= 0 then
				local var_30_9 = RougeCollectionConfig.instance:getCollectionDescsCfg(iter_30_5)

				for iter_30_6, iter_30_7 in ipairs(var_30_9) do
					var_30_8["enchant_collection_name" .. iter_30_4] = iter_30_7.name
					var_30_8["enchant_collection_num" .. iter_30_4] = 1

					break
				end
			end
		end

		table.insert(var_30_1, var_30_8)

		for iter_30_8, iter_30_9 in pairs(RougeEnum.EffectActiveType) do
			if iter_30_1:isEffectActive(iter_30_9) then
				local var_30_10 = var_0_0.Effect2Chinese[iter_30_9]

				table.insert(var_30_2, var_30_10)
			end
		end
	end

	return var_30_0, var_30_1, var_30_2
end

function var_0_0.getSeason(arg_31_0)
	local var_31_0 = RougeModel.instance:getRougeInfo()

	if not var_31_0 then
		return nil
	end

	return var_31_0.season
end

function var_0_0.getVersion(arg_32_0)
	local var_32_0 = RougeModel.instance:getRougeInfo()

	return var_32_0 and var_32_0.version
end

function var_0_0.getGameNum(arg_33_0)
	local var_33_0 = RougeModel.instance:getRougeInfo()

	return var_33_0 and var_33_0.gameNum
end

function var_0_0.getDifficulty(arg_34_0)
	local var_34_0 = RougeModel.instance:getRougeInfo()

	if not var_34_0 then
		return nil
	end

	return var_34_0.difficulty
end

function var_0_0.getBuild(arg_35_0)
	local var_35_0 = RougeModel.instance:getRougeInfo()

	if not var_35_0 then
		return nil
	end

	local var_35_1 = var_35_0.season
	local var_35_2 = var_35_0.style

	return lua_rouge_style.configDict[var_35_1][var_35_2].desc
end

function var_0_0.getLayer(arg_36_0)
	return RougeMapModel.instance:getLayerId()
end

function var_0_0.getTeamLevel(arg_37_0)
	local var_37_0 = RougeModel.instance:getRougeInfo()

	if not var_37_0 then
		return nil
	end

	return var_37_0.teamLevel
end

function var_0_0.getInitHeroNameList(arg_38_0)
	if not arg_38_0.initHeroNameList then
		arg_38_0:_initHeroGroupList()
	end

	return arg_38_0.initHeroNameList
end

function var_0_0.getInitHeroObjList(arg_39_0)
	if not arg_39_0.initHeroObjList then
		arg_39_0:_initHeroGroupList()
	end

	return arg_39_0.initHeroObjList
end

function var_0_0.getHeroGroup(arg_40_0)
	local var_40_0 = {}
	local var_40_1 = RougeModel.instance:getTeamInfo()
	local var_40_2 = var_40_1 and var_40_1:getAllHeroId()

	if var_40_2 then
		for iter_40_0, iter_40_1 in ipairs(var_40_2) do
			if not var_40_1:getAssistHeroMo(iter_40_1) then
				local var_40_3 = HeroConfig.instance:getHeroCO(iter_40_1)

				var_40_0[#var_40_0 + 1] = var_40_3 and var_40_3.name or ""
			end
		end
	end

	return var_40_0
end

function var_0_0.getHeroGroupArray(arg_41_0)
	local var_41_0 = {}
	local var_41_1 = RougeModel.instance:getTeamInfo()
	local var_41_2 = var_41_1 and var_41_1:getAllHeroId()

	if var_41_2 then
		local var_41_3 = {}
		local var_41_4 = var_41_1:getBattleHeroList()

		for iter_41_0, iter_41_1 in ipairs(var_41_4) do
			var_41_3[iter_41_1.heroId] = iter_41_1.supportHeroId
		end

		for iter_41_2, iter_41_3 in ipairs(var_41_2) do
			if not var_41_1:getAssistHeroMo(iter_41_3) then
				local var_41_5 = HeroModel.instance:getByHeroId(iter_41_3)

				if var_41_5 then
					local var_41_6 = 0
					local var_41_7 = 0
					local var_41_8 = 0

					if RougeHeroGroupBalanceHelper.getIsBalanceMode() then
						var_41_6, var_41_7, var_41_8 = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(iter_41_3)
						var_41_6 = var_41_6 or 0
						var_41_7 = var_41_7 or 0
						var_41_8 = var_41_8 or 0
					end

					local var_41_9 = {}
					local var_41_10 = var_41_6 > var_41_5.level and var_41_6 or var_41_5.level
					local var_41_11 = var_41_7 > var_41_5.rank and var_41_7 or var_41_5.rank
					local var_41_12 = var_41_8 > var_41_5.talent and var_41_8 or var_41_5.talent

					var_41_9.hero_name = var_41_5.config.name
					var_41_9.hero_level = var_41_10
					var_41_9.hero_rank = var_41_11
					var_41_9.breakthrough = var_41_5.exSkillLevel
					var_41_9.talent = var_41_12

					local var_41_13 = var_41_1:getHeroInfo(iter_41_3)

					var_41_9.rationality_num = var_41_13 and var_41_13:getStressValue() or 0

					local var_41_14 = var_41_5:hasDefaultEquip()

					if var_41_14 then
						var_41_9.EquipName = var_41_14.config.name
						var_41_9.EquipLevel = var_41_14.level
						var_41_9.equip_refine = var_41_14.refineLv
					end

					local var_41_15 = var_41_1:getHeroHp(iter_41_3)

					var_41_9.remaining_HP = var_41_15 and var_41_15.life / 10 or 0

					local var_41_16 = var_41_3[iter_41_3]

					if var_41_16 and var_41_16 ~= 0 then
						local var_41_17 = HeroConfig.instance:getHeroCO(var_41_16)
						local var_41_18 = var_41_1:getSupportSkill(var_41_16)
						local var_41_19 = lua_skill.configDict[var_41_18]
						local var_41_20 = RougeModel.instance:isInitHero(var_41_16)

						var_41_9.support_heroname = var_41_17 and var_41_17.name or nil
						var_41_9.support_heroskill = var_41_19 and var_41_19.name or nil
						var_41_9.support_is_recruit = not var_41_20
					end

					if var_41_1:inTeam(iter_41_3) then
						var_41_9.combat_is_recruit = not RougeModel.instance:isInitHero(iter_41_3)
					end

					var_41_0[#var_41_0 + 1] = var_41_9
				end
			end
		end
	end

	return var_41_0
end

function var_0_0.getCoin(arg_42_0)
	local var_42_0 = RougeModel.instance:getRougeInfo()

	if not var_42_0 then
		return nil
	end

	return var_42_0.coin
end

function var_0_0.getMedium(arg_43_0)
	local var_43_0 = RougeModel.instance:getRougeInfo()

	if not var_43_0 then
		return nil
	end

	return var_43_0.power
end

function var_0_0.getTalentNameList(arg_44_0)
	return (arg_44_0:getUnlockTalentNameList())
end

function var_0_0.getConsumeTalentPoint(arg_45_0)
	return (RougeTalentModel.instance:getHadConsumeTalentPoint())
end

function var_0_0.getBuildTalentLevel(arg_46_0)
	local var_46_0 = RougeModel.instance:getRougeInfo()

	if not var_46_0 then
		return nil
	end

	return var_46_0.teamLevel
end

function var_0_0.getBuildTalentList(arg_47_0)
	local var_47_0 = {}
	local var_47_1 = RougeModel.instance:getRougeInfo()

	if not var_47_1 then
		return nil
	end

	local var_47_2 = var_47_1.talentInfo

	for iter_47_0, iter_47_1 in ipairs(var_47_2) do
		if iter_47_1 and iter_47_1.isActive == 1 then
			local var_47_3 = iter_47_1.id
			local var_47_4 = lua_rouge_style_talent.configDict[var_47_3]

			table.insert(var_47_0, var_47_4.desc)
		end
	end

	return var_47_0
end

function var_0_0.getAssistList(arg_48_0)
	local var_48_0 = {}
	local var_48_1 = {}
	local var_48_2 = RougeModel.instance:getTeamInfo()
	local var_48_3 = var_48_2:getBattleHeroList()

	for iter_48_0, iter_48_1 in ipairs(var_48_3) do
		var_48_1[iter_48_1.heroId] = iter_48_1.supportHeroId
	end

	local var_48_4 = var_48_2:getAssistHeroMo()

	if var_48_4 then
		local var_48_5 = var_48_4.heroId
		local var_48_6 = var_48_4.config
		local var_48_7 = {}
		local var_48_8 = 0
		local var_48_9 = 0
		local var_48_10 = 0

		if RougeHeroGroupBalanceHelper.getIsBalanceMode() then
			var_48_8, var_48_9, var_48_10 = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(var_48_5)
			var_48_8 = var_48_8 or 0
			var_48_9 = var_48_9 or 0
			var_48_10 = var_48_10 or 0
		end

		local var_48_11 = var_48_8 > var_48_4.level and var_48_8 or var_48_4.level
		local var_48_12 = var_48_9 > var_48_4.rank and var_48_9 or var_48_4.rank
		local var_48_13 = var_48_10 > var_48_4.talent and var_48_10 or var_48_4.talent

		var_48_7.hero_name = var_48_6.name
		var_48_7.hero_level = var_48_11
		var_48_7.hero_rank = var_48_12
		var_48_7.breakthrough = var_48_4.exSkillLevel
		var_48_7.talent = var_48_13

		local var_48_14 = var_48_4:hasDefaultEquip()

		if var_48_14 then
			var_48_7.EquipName = var_48_14.config.name
			var_48_7.EquipLevel = var_48_14.level
			var_48_7.equip_refine = var_48_14.refineLv
		end

		local var_48_15 = var_48_2:getHeroHp(var_48_5)

		var_48_7.remaining_HP = var_48_15 and var_48_15.life / 10 or 0

		local var_48_16 = var_48_2:getHeroInfo(var_48_5)

		var_48_7.rationality_num = var_48_16 and var_48_16:getStressValue() or 0

		local var_48_17 = var_48_2:getAssistTargetHero(var_48_5)

		if var_48_17 then
			local var_48_18 = HeroConfig.instance:getHeroCO(var_48_17.heroId)

			var_48_7.support_target_name = var_48_18 and var_48_18.name or nil

			local var_48_19 = var_48_2:getSupportSkill(var_48_5)
			local var_48_20 = lua_skill.configDict[var_48_19]

			var_48_7.support_heroskill = var_48_20 and var_48_20.name or nil
		else
			local var_48_21 = var_48_1[var_48_5]

			if var_48_21 and var_48_21 ~= 0 then
				local var_48_22 = HeroConfig.instance:getHeroCO(var_48_21)
				local var_48_23 = var_48_2:getSupportSkill(var_48_21)
				local var_48_24 = lua_skill.configDict[var_48_23]

				var_48_7.support_heroname = var_48_22 and var_48_22.name or nil
				var_48_7.support_heroskill = var_48_24 and var_48_24.name or nil
				var_48_7.support_is_recruit = not RougeModel.instance:isInitHero(var_48_21)
			end
		end

		var_48_0[#var_48_0 + 1] = var_48_7
	end

	return var_48_0
end

function var_0_0.getRougeResult(arg_49_0, arg_49_1)
	local var_49_0

	if arg_49_1 then
		if arg_49_1 == var_0_0.EndResult.Close then
			var_49_0 = "主动返回退出"
		elseif arg_49_1 == var_0_0.EndResult.Abort then
			var_49_0 = "重置"
		end
	else
		local var_49_1 = RougeModel.instance:getEndId()

		var_49_0 = var_49_1 and var_49_1 ~= 0 and "成功" or "失败"
	end

	return var_49_0
end

function var_0_0.getInterruptReason(arg_50_0, arg_50_1)
	local var_50_0

	if arg_50_1 then
		if arg_50_1 == var_0_0.EndResult.Close then
			var_50_0 = "主动放弃探索"
		end
	else
		local var_50_1 = RougeModel.instance:getEndId()

		if not var_50_1 or var_50_1 == 0 then
			local var_50_2 = RougeMapModel.instance:getCurEvent()
			local var_50_3 = var_50_2 and var_50_2.id

			if arg_50_0._failResult then
				if arg_50_0._failResult == FightEnum.FightResult.Abort then
					var_50_0 = "战斗主动退出"

					if var_50_3 then
						var_50_0 = var_50_3 and var_50_0 .. var_50_3 or var_50_0 .. 0
					end
				elseif arg_50_0._failResult == FightEnum.FightResult.Fail then
					var_50_0 = "战斗失败"

					if var_50_3 then
						var_50_0 = var_50_3 and var_50_0 .. var_50_3 or var_50_0 .. 0
					end
				end
			end
		end
	end

	return var_50_0
end

function var_0_0.getCompletedEventNum(arg_51_0)
	local var_51_0 = RougeModel.instance:getRougeResult()

	if not var_51_0 then
		return
	end

	if var_51_0.finishEventId and #var_51_0.finishEventId > 0 then
		return #var_51_0.finishEventId
	end
end

function var_0_0.getCompletedEventID(arg_52_0)
	local var_52_0 = RougeModel.instance:getRougeResult()

	if not var_52_0 then
		return
	end

	if var_52_0.finishEventId and #var_52_0.finishEventId > 0 then
		return var_52_0.finishEventId
	end
end

function var_0_0.getCompletedEntrustId(arg_53_0)
	local var_53_0 = RougeModel.instance:getRougeResult()

	if not var_53_0 then
		return
	end

	if var_53_0.finishEntrustId and #var_53_0.finishEntrustId > 0 then
		return var_53_0.finishEntrustId
	end
end

function var_0_0.getCompletedEntrustNum(arg_54_0)
	local var_54_0 = RougeModel.instance:getRougeResult()

	if not var_54_0 then
		return
	end

	if var_54_0.finishEntrustId and #var_54_0.finishEntrustId > 0 then
		return #var_54_0.finishEntrustId
	end
end

function var_0_0.getCompletedLayers(arg_55_0)
	local var_55_0 = RougeModel.instance:getRougeResult()

	if not var_55_0 then
		return
	end

	local var_55_1, var_55_2 = var_55_0:getLayerCountAndScore()

	return var_55_1
end

function var_0_0.getRougePoints(arg_56_0)
	local var_56_0 = RougeModel.instance:getRougeResult()

	if not var_56_0 then
		return 0
	end

	return var_56_0.finalScore
end

function var_0_0.getRougeRewardPoints(arg_57_0)
	local var_57_0 = RougeModel.instance:getRougeResult()

	if not var_57_0 then
		return
	end

	return var_57_0.addPoint
end

function var_0_0.getRougeTalentPoints(arg_58_0)
	local var_58_0 = RougeModel.instance:getRougeResult()

	if not var_58_0 then
		return 0
	end

	return var_58_0.addGeniusPoint
end

function var_0_0.getTotalDeathNum(arg_59_0)
	local var_59_0 = RougeModel.instance:getRougeResult()

	if not var_59_0 then
		return 0
	end

	return var_59_0.deadNum
end

function var_0_0.getTotalReviveNum(arg_60_0)
	local var_60_0 = RougeModel.instance:getRougeResult()

	if not var_60_0 then
		return 0
	end

	return var_60_0.reviveNum
end

function var_0_0.getCollectionConflateNum(arg_61_0)
	local var_61_0 = RougeModel.instance:getRougeResult()

	if not var_61_0 then
		return 0
	end

	local var_61_1 = 0
	local var_61_2 = var_61_0:getCompositeCollectionIdAndCount()

	if var_61_2 and #var_61_2 > 0 then
		for iter_61_0, iter_61_1 in ipairs(var_61_2) do
			if iter_61_1 and iter_61_1[2] then
				var_61_1 = var_61_1 + iter_61_1[2]
			end
		end
	end

	return var_61_1
end

function var_0_0.getBadgeName(arg_62_0)
	local var_62_0 = {}
	local var_62_1 = arg_62_0:getSeason()
	local var_62_2 = RougeModel.instance:getRougeResult()

	if not var_62_2 then
		return
	end

	if var_62_2.badge2Score then
		for iter_62_0, iter_62_1 in pairs(var_62_2.badge2Score) do
			local var_62_3 = RougeConfig.instance:getRougeBadgeCO(var_62_1, iter_62_1[1])

			if var_62_3 and var_62_3.name then
				table.insert(var_62_0, var_62_3.name)
			end
		end
	end

	return var_62_0
end

function var_0_0.getUseTime(arg_63_0)
	local var_63_0 = 0

	if arg_63_0:checkIsReset() or not arg_63_0.startTime then
		return var_63_0
	end

	if arg_63_0.startTime then
		var_63_0 = ServerTime.now() - arg_63_0.startTime
	end

	return var_63_0
end

function var_0_0.getAdjustBackPackTime(arg_64_0)
	if not arg_64_0.startAdjustTime then
		return 0
	else
		return ServerTime.now() - arg_64_0.startAdjustTime
	end
end

function var_0_0.getAdjustBackPack(arg_65_0)
	return arg_65_0._adjustbackpack and true or false
end

function var_0_0.getAllLimiterDesc(arg_66_0)
	local var_66_0 = {}
	local var_66_1 = RougeModel.instance:getRougeInfo()
	local var_66_2 = var_66_1 and var_66_1:getGameLimiterMo()
	local var_66_3 = var_66_2 and var_66_2:getLimiterIds()

	for iter_66_0, iter_66_1 in ipairs(var_66_3 or {}) do
		local var_66_4 = RougeDLCConfig101.instance:getLimiterCo(iter_66_1)

		table.insert(var_66_0, var_66_4 and var_66_4.desc)
	end

	local var_66_5 = var_66_2 and var_66_2:getLimiterBuffIds()

	for iter_66_2, iter_66_3 in ipairs(var_66_5 or {}) do
		local var_66_6 = RougeDLCConfig101.instance:getLimiterBuffCo(iter_66_3)

		table.insert(var_66_0, var_66_6 and var_66_6.desc)
	end

	return var_66_0
end

function var_0_0.getAddEmblemCount(arg_67_0)
	local var_67_0 = RougeModel.instance:getRougeResult()
	local var_67_1 = var_67_0 and var_67_0:getLimiterResultMo()

	return var_67_1 and var_67_1:getLimiterAddEmblem() or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
