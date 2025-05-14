module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotStatController", package.seeall)

local var_0_0 = class("V1a6_CachotStatController", BaseController)

var_0_0.FailReasonEnum = {
	FightFail = 1,
	EventFail = 2,
	AbortFight = 3,
	GM = 4
}

local var_0_1 = {
	[var_0_0.FailReasonEnum.FightFail] = "战斗全员阵亡失败-%s",
	[var_0_0.FailReasonEnum.EventFail] = "战斗外事件导致失败-%s",
	[var_0_0.FailReasonEnum.AbortFight] = "战斗主动退出-%s"
}

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearStatEnd()
	arg_2_0:clearInitHeroGroup()
end

function var_0_0.initObjPool(arg_3_0)
	arg_3_0.objPool = arg_3_0.objPool or {}
end

function var_0_0.getNewObj(arg_4_0)
	arg_4_0:initObjPool()

	if arg_4_0.objPool and #arg_4_0.objPool > 1 then
		return table.remove(arg_4_0.objPool)
	end

	return {}
end

function var_0_0.copyValueList(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getNewObj()

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		table.insert(var_5_0, iter_5_1)
	end

	return var_5_0
end

function var_0_0.copyValueDict(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getNewObj()

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		var_6_0[iter_6_0] = iter_6_1
	end

	return var_6_0
end

function var_0_0.recycleObj(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	arg_7_0:initObjPool()
	tabletool.clear(arg_7_1)
	table.insert(arg_7_0.objPool, arg_7_1)
end

function var_0_0.recycleObjList(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0:recycleObj(iter_8_1)
	end

	arg_8_0:recycleObj(arg_8_1)
end

function var_0_0.clearObjPool(arg_9_0)
	arg_9_0.objPool = nil
end

function var_0_0.statStart(arg_10_0)
	arg_10_0.startTime = ServerTime.now()
end

function var_0_0.statReset(arg_11_0)
	arg_11_0.statEnum = StatEnum.Result.Reset
end

function var_0_0.statAbort(arg_12_0)
	arg_12_0:removeRpcCallback()

	arg_12_0.callbackId = RogueRpc.instance:sendRogueReturnRequest(V1a6_CachotEnum.ActivityId, arg_12_0.onReceiveRogueReturnInfo, arg_12_0)
end

function var_0_0.onReceiveRogueReturnInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.callbackId = nil

	if arg_13_2 ~= 0 then
		arg_13_0:clearStatEnd()

		return
	end

	local var_13_0 = arg_13_0.rogueEndInfo or RogueEndingInfoMO.New()

	var_13_0:init(arg_13_3.endPush)
	arg_13_0:_statEnd(StatEnum.Result.Abort, "", var_13_0)
end

function var_0_0.removeRpcCallback(arg_14_0)
	if arg_14_0.callbackId then
		RogueRpc.instance:removeCallbackById(arg_14_0.callbackId)

		arg_14_0.callbackId = nil
	end
end

function var_0_0.statEnd(arg_15_0)
	local var_15_0 = V1a6_CachotModel.instance:getRogueEndingInfo()
	local var_15_1
	local var_15_2
	local var_15_3

	if arg_15_0.statEnum == StatEnum.Result.Reset then
		arg_15_0.startTime = ServerTime.now()
		var_15_1 = StatEnum.Result.Reset
		var_15_3 = ""
	else
		var_15_1 = var_15_0:isFinish() and StatEnum.Result.Success or StatEnum.Result.Fail
		var_15_3 = arg_15_0:getFailReason()
	end

	arg_15_0:_statEnd(var_15_1, var_15_3, var_15_0)
end

function var_0_0._statEnd(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0.startTime then
		return
	end

	local var_16_0 = arg_16_0:getRogueInfoMo()
	local var_16_1, var_16_2 = arg_16_0:getCollectList()
	local var_16_3, var_16_4 = arg_16_0:getHeroGroupList()
	local var_16_5 = arg_16_0:copyValueList(arg_16_3:getFinishEventList())

	StatController.instance:track(StatEnum.EventName.ExitCachot, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_16_0.startTime,
		[StatEnum.EventProperties.Difficulty] = arg_16_3:getDifficulty(),
		[StatEnum.EventProperties.DungeonResult] = arg_16_1,
		[StatEnum.EventProperties.InterruptReason] = arg_16_2,
		[StatEnum.EventProperties.CompletedEventNum] = arg_16_3:getFinishEventNum(),
		[StatEnum.EventProperties.CompletedEventId] = var_16_5,
		[StatEnum.EventProperties.CompletedRoomEnum] = arg_16_3:getRoomNum(),
		[StatEnum.EventProperties.CompletedLayers] = arg_16_3:getLayer(),
		[StatEnum.EventProperties.DungeonPoints] = arg_16_3:getScore(),
		[StatEnum.EventProperties.IsDoublePoints] = arg_16_3:isDoubleScore(),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_16_0.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_16_0.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = var_16_3,
		[StatEnum.EventProperties.HeroGroupArray] = var_16_4,
		[StatEnum.EventProperties.CollectList] = var_16_1,
		[StatEnum.EventProperties.CollectArray] = var_16_2,
		[StatEnum.EventProperties.HeartBeat] = var_16_0 and var_16_0.heart or nil,
		[StatEnum.EventProperties.DungeonGold] = var_16_0 and var_16_0.coin or nil,
		[StatEnum.EventProperties.DungeonTokens] = var_16_0 and var_16_0.currency or nil
	})
	arg_16_0:recycleObj(var_16_5)
	arg_16_0:recycleObj(var_16_1)
	arg_16_0:recycleObj(var_16_3)
	arg_16_0:recycleObjList(var_16_2)
	arg_16_0:recycleObjList(var_16_4)
	arg_16_0:clearStatEnd()
end

function var_0_0.clearStatEnd(arg_17_0)
	arg_17_0.statEnum = nil
	arg_17_0.startTime = nil

	arg_17_0:removeRpcCallback()
end

function var_0_0.recordInitHeroGroupByEnterRogue(arg_18_0)
	arg_18_0:recycleObj(arg_18_0.initHeroNameList)
	arg_18_0:recycleObjList(arg_18_0.initHeroObjList)

	arg_18_0.initHeroNameList, arg_18_0.initHeroObjList = arg_18_0:getHeroGroupList(true)
end

function var_0_0.recordInitHeroGroup(arg_19_0)
	if not LoginController.instance:isEnteredGame() then
		return
	end

	local var_19_0 = V1a6_CachotModel.instance:getRogueStateInfo()
	local var_19_1 = var_19_0.lastGroup
	local var_19_2 = var_19_0.lastBackupGroup
	local var_19_3 = arg_19_0:getNewObj()
	local var_19_4 = arg_19_0:getNewObj()
	local var_19_5 = var_19_0.difficulty or 1

	if not var_19_0.difficulty or var_19_0.difficulty == 0 then
		var_19_5 = 1
	end

	local var_19_6 = lua_rogue_difficulty.configDict[var_19_5]

	if not var_19_6 then
		logError("not found rouge difficulty co : " .. tostring(var_19_5))
	end

	local var_19_7 = string.splitToNumber(var_19_6.initLevel, "#")

	arg_19_0:addGroupData(var_19_1, var_19_3, var_19_4, var_19_7)
	arg_19_0:addGroupData(var_19_2, var_19_3, var_19_4)
	arg_19_0:recycleObj(arg_19_0.initHeroNameList)
	arg_19_0:recycleObjList(arg_19_0.initHeroObjList)

	arg_19_0.initHeroNameList = var_19_3
	arg_19_0.initHeroObjList = var_19_4
end

function var_0_0.clearInitHeroGroup(arg_20_0)
	arg_20_0:recycleObj(arg_20_0.initHeroNameList)
	arg_20_0:recycleObjList(arg_20_0.initHeroObjList)

	arg_20_0.initHeroNameList = nil
	arg_20_0.initHeroObjList = nil
end

function var_0_0.addGroupData(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1.heroList) do
		if iter_21_1 ~= "0" then
			local var_21_0 = HeroModel.instance:getById(iter_21_1)

			if var_21_0 then
				local var_21_1 = arg_21_1:getFirstEquipMo(iter_21_0)
				local var_21_2, var_21_3 = arg_21_0:buildHeroObj(var_21_0, var_21_1, arg_21_4 and arg_21_4[iter_21_0] or nil)

				var_21_3.remain_HP = "100"

				table.insert(arg_21_2, var_21_2)
				table.insert(arg_21_3, var_21_3)
			end
		end
	end
end

function var_0_0.bakeRogueInfoMo(arg_22_0)
	arg_22_0.rogueInfoMo = V1a6_CachotModel.instance:getRogueInfo()
end

function var_0_0.getRogueInfoMo(arg_23_0)
	return arg_23_0.rogueInfoMo
end

function var_0_0.clearRogueInfoMo(arg_24_0)
	arg_24_0.rogueInfoMo = nil
end

function var_0_0.getRunningEvents(arg_25_0)
	local var_25_0 = arg_25_0:getRogueInfoMo()

	if not var_25_0 then
		return ""
	end

	local var_25_1 = var_25_0:getSelectEvents()

	if not var_25_1 or #var_25_1 < 1 then
		return ""
	end

	local var_25_2 = arg_25_0:getNewObj()

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		if iter_25_1.status == V1a6_CachotEnum.EventStatus.Start then
			table.insert(var_25_2, iter_25_1.eventId)
		end
	end

	local var_25_3 = table.concat(var_25_2, "-")

	arg_25_0:recycleObj(var_25_2)

	return var_25_3
end

function var_0_0.getFailReason(arg_26_0)
	local var_26_0 = V1a6_CachotModel.instance:getRogueEndingInfo()

	if not var_26_0 then
		return nil
	end

	if var_26_0:isFinish() then
		return nil
	end

	local var_26_1 = var_0_1[var_26_0:getFailReason()] or var_0_1[var_0_0.FailReasonEnum.FightFail]
	local var_26_2 = arg_26_0:getRunningEvents()

	return string.format(var_26_1, var_26_2)
end

function var_0_0.getCollectList(arg_27_0)
	local var_27_0 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_27_0 then
		return nil, nil
	end

	local var_27_1 = var_27_0.collections
	local var_27_2 = var_27_0.collectionMap
	local var_27_3 = arg_27_0:getNewObj()
	local var_27_4 = arg_27_0:getNewObj()
	local var_27_5 = arg_27_0:getNewObj()

	for iter_27_0, iter_27_1 in pairs(var_27_1) do
		local var_27_6 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(iter_27_1.cfgId)

		if var_27_6 then
			table.insert(var_27_3, var_27_6.name)

			var_27_5[iter_27_1.id] = true

			local var_27_7 = arg_27_0:getNewObj()

			var_27_7.collection_name = var_27_6.name
			var_27_7.collection_num = 1

			if iter_27_1.leftUid ~= 0 then
				local var_27_8 = var_27_2[iter_27_1.leftUid]

				if var_27_8 then
					var_27_5[var_27_8.id] = true
					var_27_7.enchant_collection_left_name = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_27_8.cfgId).name
					var_27_7.enchant_collection_left_num = 1
				else
					logError(string.format("collectMo.id : '%s' not found left uid : '%s'", iter_27_1.id, iter_27_1.leftUid))
				end
			end

			if iter_27_1.rightUid ~= 0 then
				local var_27_9 = var_27_2[iter_27_1.rightUid]

				if var_27_9 then
					var_27_5[var_27_9.id] = true
					var_27_7.enchant_collection_right_name = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_27_9.cfgId).name
					var_27_7.enchant_collection_right_num = 1
				else
					logError(string.format("collectMo.id : '%s' not found right uid : '%s'", iter_27_1.id, iter_27_1.rightUid))
				end
			end

			table.insert(var_27_4, var_27_7)
		end
	end

	return var_27_3, var_27_4
end

function var_0_0.getHeroGroupList(arg_28_0, arg_28_1)
	local var_28_0 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_28_0 then
		return nil, nil
	end

	local var_28_1 = var_28_0.teamInfo
	local var_28_2 = arg_28_0:getNewObj()
	local var_28_3 = arg_28_0:getNewObj()
	local var_28_4 = var_28_1:getGroupHeros()
	local var_28_5 = var_28_1:getGroupEquips()
	local var_28_6 = var_28_1.groupBoxStar

	for iter_28_0, iter_28_1 in ipairs(var_28_4) do
		local var_28_7 = HeroModel.instance:getById(iter_28_1.heroUid)

		if var_28_7 then
			local var_28_8 = var_28_5[iter_28_0]
			local var_28_9 = var_28_6[iter_28_0]
			local var_28_10, var_28_11 = arg_28_0:buildHeroObj(var_28_7, var_28_8, var_28_9)

			var_28_11.remain_HP = var_28_1.lifeMap[var_28_7.heroId].lifePercent

			if not arg_28_1 then
				var_28_11.field_level = var_28_9
			end

			table.insert(var_28_2, var_28_10)
			table.insert(var_28_3, var_28_11)
		end
	end

	local var_28_12 = var_28_1:getSupportHeros()

	for iter_28_2, iter_28_3 in ipairs(var_28_12) do
		local var_28_13 = HeroModel.instance:getById(iter_28_3.heroUid)

		if var_28_13 then
			local var_28_14 = var_28_5[iter_28_2 + 4]
			local var_28_15, var_28_16 = arg_28_0:buildHeroObj(var_28_13, var_28_14, nil)

			var_28_16.remain_HP = var_28_1.lifeMap[var_28_13.heroId].lifePercent

			if not arg_28_1 then
				var_28_16.field_level = 0
			end

			table.insert(var_28_2, var_28_15)
			table.insert(var_28_3, var_28_16)
		end
	end

	return var_28_2, var_28_3
end

function var_0_0.buildHeroObj(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = HeroConfig.instance:getHeroCO(arg_29_1.heroId)
	local var_29_1, var_29_2 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_29_1, arg_29_3)
	local var_29_3, var_29_4 = HeroConfig.instance:getShowLevel(var_29_1)
	local var_29_5
	local var_29_6
	local var_29_7

	if arg_29_2 then
		var_29_5 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(arg_29_2, arg_29_3)
		var_29_6 = arg_29_2.refineLv
		var_29_7 = arg_29_2.config.name
	else
		var_29_5 = 0
		var_29_6 = 0
		var_29_7 = ""
	end

	local var_29_8 = arg_29_0:getNewObj()

	var_29_8.hero_name = var_29_0.name
	var_29_8.hero_level = var_29_1
	var_29_8.hero_rank = var_29_4
	var_29_8.breakthrough = arg_29_1.exSkillLevel
	var_29_8.talent = var_29_2
	var_29_8.EquipName = var_29_7
	var_29_8.EquipLevel = var_29_5
	var_29_8.equip_refine = var_29_6

	return var_29_0.name, var_29_8
end

function var_0_0.clearStartEventDict(arg_30_0)
	if arg_30_0.startEventDict then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.startEventDict) do
			arg_30_0:recycleObj(iter_30_1)
		end

		tabletool.clear(arg_30_0.startEventDict)
	end
end

function var_0_0.recycleEventObj(arg_31_0, arg_31_1)
	if not arg_31_0.startEventDict then
		return
	end

	if arg_31_0.startEventDict[arg_31_1] then
		arg_31_0:recycleObj(arg_31_0.startEventDict[arg_31_1])

		arg_31_0.startEventDict[arg_31_1] = nil
	end
end

function var_0_0.initEventStartHandle(arg_32_0)
	if not arg_32_0.startEventHandleDict then
		arg_32_0.startEventHandleDict = {
			[V1a6_CachotEnum.EventType.HeroPosUpgrade] = arg_32_0.onStartHeroPosUpgradeEvent
		}
	end
end

function var_0_0.onStartHeroPosUpgradeEvent(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getNewObj()
	local var_33_1 = V1a6_CachotModel.instance:getRogueInfo().teamInfo

	var_33_0.groupBoxStar = arg_33_0:copyValueList(var_33_1.groupBoxStar)

	return var_33_0
end

function var_0_0.statStartEvent(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return
	end

	if arg_34_1.status ~= V1a6_CachotEnum.EventStatus.Start then
		return
	end

	arg_34_0.startEventDict = arg_34_0.startEventDict or {}

	if arg_34_0.startEventDict[arg_34_1.eventId] then
		return
	end

	arg_34_0:initEventStartHandle()

	local var_34_0 = lua_rogue_event.configDict[arg_34_1.eventId]
	local var_34_1 = arg_34_0.startEventHandleDict[var_34_0.type]

	if not var_34_1 then
		return
	end

	arg_34_0.startEventDict[arg_34_1.eventId] = var_34_1(arg_34_0, arg_34_1)
end

function var_0_0.getObtainHeroNameList(arg_35_0, arg_35_1)
	if not arg_35_1 then
		return
	end

	if lua_rogue_event.configDict[arg_35_1.eventId].type ~= V1a6_CachotEnum.EventType.CharacterGet then
		return
	end

	arg_35_0.obtainHeroList = arg_35_0.obtainHeroList or {}

	tabletool.clear(arg_35_0.obtainHeroList)

	local var_35_0 = HeroConfig.instance:getHeroCO(arg_35_1.option)

	if not var_35_0 then
		if arg_35_1.option ~= 0 then
			logError("not config hero , heroId : " .. tostring(arg_35_1.option))
		end

		return nil
	end

	table.insert(arg_35_0.obtainHeroList, var_35_0.name)

	return arg_35_0.obtainHeroList
end

function var_0_0.getSeatUpList(arg_36_0, arg_36_1)
	if not arg_36_1 then
		return
	end

	if lua_rogue_event.configDict[arg_36_1.eventId].type ~= V1a6_CachotEnum.EventType.HeroPosUpgrade then
		return
	end

	if not arg_36_0.startEventDict then
		return
	end

	local var_36_0 = arg_36_0.startEventDict[arg_36_1.eventId]

	if not var_36_0 then
		return
	end

	local var_36_1 = arg_36_0:getNewObj()
	local var_36_2 = V1a6_CachotModel.instance:getRogueInfo().teamInfo

	for iter_36_0, iter_36_1 in ipairs(var_36_2.groupBoxStar) do
		if iter_36_1 ~= var_36_0.groupBoxStar[iter_36_0] then
			local var_36_3 = arg_36_0:getNewObj()

			var_36_3.field_id = iter_36_0
			var_36_3.field_before_level = var_36_0.groupBoxStar[iter_36_0]
			var_36_3.field_after_level = iter_36_1

			table.insert(var_36_1, var_36_3)
		end
	end

	arg_36_0:recycleEventObj(arg_36_1.eventId)

	if #var_36_1 > 0 then
		return var_36_1
	end

	arg_36_0:recycleObjList(var_36_1)
end

function var_0_0.getStoryOptionId(arg_37_0, arg_37_1)
	if not arg_37_1 then
		return
	end

	if lua_rogue_event.configDict[arg_37_1.eventId].type ~= V1a6_CachotEnum.EventType.ChoiceSelect then
		return
	end

	return tostring(arg_37_1.option)
end

function var_0_0.getPromptOptionId(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return
	end

	local var_38_0 = lua_rogue_event.configDict[arg_38_1.eventId]

	if var_38_0.type ~= V1a6_CachotEnum.EventType.Tip then
		return
	end

	return tostring(var_38_0.eventId)
end

function var_0_0.initChangeLifeHeroNameList(arg_39_0)
	arg_39_0.changeLifeHeroNameList = arg_39_0.changeLifeHeroNameList or {}

	tabletool.clear(arg_39_0.changeLifeHeroNameList)
end

function var_0_0.setChangeLife(arg_40_0, arg_40_1)
	arg_40_0:initChangeLifeHeroNameList()

	for iter_40_0, iter_40_1 in ipairs(arg_40_1) do
		local var_40_0 = HeroConfig.instance:getHeroCO(iter_40_1.heroId)

		if var_40_0 then
			table.insert(arg_40_0.changeLifeHeroNameList, var_40_0.name)
		end
	end
end

function var_0_0.initBloodReturnHeroNameList(arg_41_0)
	arg_41_0.bloodReturnHeroNameList = arg_41_0.bloodReturnHeroNameList or {}

	tabletool.clear(arg_41_0.bloodReturnHeroNameList)
end

function var_0_0.getBloodReturnHeroNameList(arg_42_0, arg_42_1)
	if not arg_42_1 then
		return
	end

	local var_42_0 = lua_rogue_event.configDict[arg_42_1.eventId]

	if var_42_0.type ~= V1a6_CachotEnum.EventType.CharacterCure then
		return
	end

	local var_42_1 = lua_rogue_event_life.configDict[var_42_0.eventId]

	if not var_42_1 then
		return
	end

	local var_42_2 = string.splitToNumber(var_42_1.num, "#")[1]

	if var_42_2 == V1a6_CachotEnum.CureEventType.Single then
		local var_42_3 = HeroConfig.instance:getHeroCO(arg_42_1.option)

		if var_42_3 then
			arg_42_0:initBloodReturnHeroNameList()
			table.insert(arg_42_0.bloodReturnHeroNameList, var_42_3.name)

			return arg_42_0.bloodReturnHeroNameList
		else
			logError("not find heroid  config : " .. tostring(arg_42_1.option))

			return nil
		end
	elseif var_42_2 == V1a6_CachotEnum.CureEventType.Random then
		return arg_42_0.changeLifeHeroNameList
	elseif var_42_2 == V1a6_CachotEnum.CureEventType.All then
		return arg_42_0.changeLifeHeroNameList
	else
		logError("not handle type : " .. tostring(var_42_1.num))

		return nil
	end
end

function var_0_0.initReviveHeroNameList(arg_43_0)
	arg_43_0.reviveHeroNameList = arg_43_0.reviveHeroNameList or {}

	tabletool.clear(arg_43_0.reviveHeroNameList)
end

function var_0_0.getReviveHeroNameList(arg_44_0, arg_44_1)
	if not arg_44_1 then
		return
	end

	local var_44_0 = lua_rogue_event.configDict[arg_44_1.eventId]

	if var_44_0.type ~= V1a6_CachotEnum.EventType.CharacterRebirth then
		return
	end

	local var_44_1 = lua_rogue_event_revive.configDict[var_44_0.eventId]

	if not var_44_1 then
		return
	end

	local var_44_2 = string.splitToNumber(var_44_1.num, "#")[1]

	if var_44_2 == V1a6_CachotEnum.CureEventType.Single then
		local var_44_3 = HeroConfig.instance:getHeroCO(arg_44_1.option)

		if var_44_3 then
			arg_44_0:initReviveHeroNameList()
			table.insert(arg_44_0.reviveHeroNameList, var_44_3.name)

			return arg_44_0.reviveHeroNameList
		else
			logError("not find heroid  config : " .. tostring(arg_44_1.option))

			return nil
		end
	elseif var_44_2 == V1a6_CachotEnum.CureEventType.Random then
		return arg_44_0.changeLifeHeroNameList
	elseif var_44_2 == V1a6_CachotEnum.CureEventType.All then
		return arg_44_0.changeLifeHeroNameList
	else
		logError("not handle type : " .. tostring(var_44_1.num))

		return nil
	end
end

function var_0_0.addBuyGoods(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	if not arg_45_1 then
		return
	end

	if lua_rogue_event.configDict[arg_45_1.eventId].type ~= V1a6_CachotEnum.EventType.Store then
		return
	end

	local var_45_0 = cjson.decode(arg_45_1.eventData)

	if not var_45_0 then
		return
	end

	local var_45_1 = var_45_0.buy

	if not var_45_1 then
		return
	end

	arg_45_2 = arg_45_2 or arg_45_0:getNewObj()
	arg_45_3 = arg_45_3 or arg_45_0:getNewObj()

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		local var_45_2 = lua_rogue_goods.configDict[iter_45_1]

		if var_45_2 and var_45_2.creator ~= 0 then
			local var_45_3 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_45_2.creator)

			if var_45_3 then
				table.insert(arg_45_2, var_45_3.name)

				local var_45_4 = arg_45_0:getNewObj()

				var_45_4.collection_name = var_45_3.name
				var_45_4.collection_num = 1

				table.insert(arg_45_3, var_45_4)
			end
		end
	end
end

function var_0_0.statFinishEvent(arg_46_0, arg_46_1)
	if not arg_46_1 or arg_46_1.status ~= V1a6_CachotEnum.EventStatus.Finish then
		return
	end

	local var_46_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_46_1 = V1a6_CachotRoomConfig.instance:getCoByRoomId(var_46_0.room)
	local var_46_2 = lua_rogue_event.configDict[arg_46_1.eventId]
	local var_46_3, var_46_4 = arg_46_0:getCollectList()
	local var_46_5, var_46_6 = arg_46_0:getHeroGroupList()
	local var_46_7 = arg_46_0:getSeatUpList(arg_46_1)

	arg_46_0:addBuyGoods(arg_46_1, var_46_3, var_46_4)
	StatController.instance:track(StatEnum.EventName.CompleteCachotEvent, {
		[StatEnum.EventProperties.Difficulty] = var_46_0.difficulty,
		[StatEnum.EventProperties.Layer] = var_46_0.layer,
		[StatEnum.EventProperties.RoomId] = var_46_1.id,
		[StatEnum.EventProperties.RoomName] = var_46_1.name,
		[StatEnum.EventProperties.DungeonEventId] = tostring(var_46_2.id),
		[StatEnum.EventProperties.DungeonEventName] = var_46_2.title,
		[StatEnum.EventProperties.DungeonEventType] = tostring(var_46_2.type),
		[StatEnum.EventProperties.InitialHeroGroup] = arg_46_0.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_46_0.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = var_46_5,
		[StatEnum.EventProperties.HeroGroupArray] = var_46_6,
		[StatEnum.EventProperties.CollectList] = var_46_3,
		[StatEnum.EventProperties.CollectArray] = var_46_4,
		[StatEnum.EventProperties.HeartBeat] = var_46_0.heart,
		[StatEnum.EventProperties.DungeonGold] = var_46_0.coin,
		[StatEnum.EventProperties.DungeonTokens] = var_46_0.currency,
		[StatEnum.EventProperties.CachotObtainHero] = arg_46_0:getObtainHeroNameList(arg_46_1),
		[StatEnum.EventProperties.FieldUp] = var_46_7,
		[StatEnum.EventProperties.StoryOptionId] = arg_46_0:getStoryOptionId(arg_46_1),
		[StatEnum.EventProperties.PromptOptionId] = arg_46_0:getPromptOptionId(arg_46_1),
		[StatEnum.EventProperties.BloodReturnHero] = arg_46_0:getBloodReturnHeroNameList(arg_46_1),
		[StatEnum.EventProperties.ReviveHero] = arg_46_0:getReviveHeroNameList(arg_46_1)
	})
	arg_46_0:recycleObj(var_46_5)
	arg_46_0:recycleObj(var_46_3)
	arg_46_0:recycleObjList(var_46_6)
	arg_46_0:recycleObjList(var_46_4)
	arg_46_0:recycleObjList(var_46_7)
end

function var_0_0.statEnterRoom(arg_47_0)
	arg_47_0.enterRoomTime = ServerTime.now()

	local var_47_0 = V1a6_CachotModel.instance:getRogueInfo()

	arg_47_0.beforeCoin = var_47_0.coin
	arg_47_0.beforeCurrency = var_47_0.currency
	arg_47_0.beforeCollectionDict = arg_47_0:copyValueDict(var_47_0.collectionMap)
end

function var_0_0.getCostAndReward(arg_48_0)
	if not arg_48_0.enterRoomTime then
		return
	end

	local var_48_0 = arg_48_0:getNewObj()
	local var_48_1 = arg_48_0:getNewObj()
	local var_48_2 = V1a6_CachotModel.instance:getRogueInfo()

	if arg_48_0.beforeCoin ~= var_48_2.coin then
		local var_48_3 = ItemConfig.instance:getItemConfig(MaterialEnum.MaterialType.Currency, V1a6_CachotEnum.CoinId)
		local var_48_4 = arg_48_0:getNewObj()

		var_48_4.materialtype = MaterialEnum.MaterialType.Currency
		var_48_4.materialname = var_48_3.name

		if arg_48_0.beforeCoin > var_48_2.coin then
			var_48_4.materialnum = arg_48_0.beforeCoin - var_48_2.coin

			table.insert(var_48_0, var_48_4)
		else
			var_48_4.materialnum = var_48_2.coin - arg_48_0.beforeCoin

			table.insert(var_48_1, var_48_4)
		end
	end

	if arg_48_0.beforeCurrency ~= var_48_2.currency then
		local var_48_5 = ItemConfig.instance:getItemConfig(MaterialEnum.MaterialType.Currency, V1a6_CachotEnum.CurrencyId)
		local var_48_6 = arg_48_0:getNewObj()

		var_48_6.materialtype = MaterialEnum.MaterialType.Currency
		var_48_6.materialname = var_48_5.name

		if arg_48_0.beforeCurrency > var_48_2.currency then
			var_48_6.materialnum = arg_48_0.beforeCurrency - var_48_2.currency

			table.insert(var_48_0, var_48_6)
		else
			var_48_6.materialnum = var_48_2.currency - arg_48_0.beforeCurrency

			table.insert(var_48_1, var_48_6)
		end
	end

	local var_48_7 = var_48_2.collectionMap

	for iter_48_0, iter_48_1 in pairs(var_48_7) do
		if not arg_48_0.beforeCollectionDict[iter_48_0] then
			local var_48_8 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(iter_48_1.cfgId)
			local var_48_9 = arg_48_0:getNewObj()

			var_48_9.materialtype = MaterialEnum.MaterialType.None
			var_48_9.materialname = var_48_8.name
			var_48_9.materialnum = 1

			table.insert(var_48_1, var_48_9)
		end
	end

	for iter_48_2, iter_48_3 in pairs(arg_48_0.beforeCollectionDict) do
		if not var_48_7[iter_48_2] then
			local var_48_10 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(iter_48_3.cfgId)
			local var_48_11 = arg_48_0:getNewObj()

			var_48_11.materialtype = MaterialEnum.MaterialType.None
			var_48_11.materialname = var_48_10.name
			var_48_11.materialnum = 1

			table.insert(var_48_0, var_48_11)
		end
	end

	return var_48_0, var_48_1
end

function var_0_0.statFinishRoom(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_0.enterRoomTime then
		return
	end

	local var_49_0 = V1a6_CachotRoomConfig.instance:getCoByRoomId(arg_49_1)

	if not var_49_0 then
		return
	end

	local var_49_1 = V1a6_CachotModel.instance:getRogueInfo()
	local var_49_2, var_49_3 = arg_49_0:getCollectList()
	local var_49_4, var_49_5 = arg_49_0:getHeroGroupList()
	local var_49_6, var_49_7 = arg_49_0:getCostAndReward()

	StatController.instance:track(StatEnum.EventName.ExitCachotRoom, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_49_0.enterRoomTime,
		[StatEnum.EventProperties.Difficulty] = var_49_1.difficulty,
		[StatEnum.EventProperties.Layer] = arg_49_2,
		[StatEnum.EventProperties.RoomId] = var_49_0.id,
		[StatEnum.EventProperties.RoomName] = var_49_0.name,
		[StatEnum.EventProperties.InitialHeroGroup] = arg_49_0.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = arg_49_0.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = var_49_4,
		[StatEnum.EventProperties.HeroGroupArray] = var_49_5,
		[StatEnum.EventProperties.CollectList] = var_49_2,
		[StatEnum.EventProperties.CollectArray] = var_49_3,
		[StatEnum.EventProperties.HeartBeat] = var_49_1.heart,
		[StatEnum.EventProperties.DungeonGold] = var_49_1.coin,
		[StatEnum.EventProperties.DungeonTokens] = var_49_1.currency,
		[StatEnum.EventProperties.CachotCost] = var_49_6,
		[StatEnum.EventProperties.CachotReward] = var_49_7
	})

	arg_49_0.enterRoomTime = nil

	arg_49_0:clearStartEventDict()
	arg_49_0:recycleObj(var_49_2)
	arg_49_0:recycleObj(var_49_4)
	arg_49_0:recycleObjList(var_49_3)
	arg_49_0:recycleObjList(var_49_5)
	arg_49_0:recycleObjList(var_49_6)
	arg_49_0:recycleObjList(var_49_7)
end

function var_0_0.statUnlockCollection(arg_50_0, arg_50_1)
	if not arg_50_1 then
		return
	end

	local var_50_0 = arg_50_0:getNewObj()

	for iter_50_0, iter_50_1 in ipairs(arg_50_1) do
		tabletool.clear(var_50_0)

		local var_50_1 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(iter_50_1)

		var_50_0[StatEnum.EventProperties.CollectionId] = iter_50_1
		var_50_0[StatEnum.EventProperties.CollectionName] = var_50_1 and var_50_1.name or ""

		StatController.instance:track(StatEnum.EventName.UnlockCachotCollection, var_50_0)
	end

	arg_50_0:recycleObj(var_50_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
