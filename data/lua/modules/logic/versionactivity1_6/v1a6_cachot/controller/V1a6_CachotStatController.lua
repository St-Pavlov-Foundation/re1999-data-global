module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotStatController", package.seeall)

slot0 = class("V1a6_CachotStatController", BaseController)
slot0.FailReasonEnum = {
	FightFail = 1,
	EventFail = 2,
	AbortFight = 3,
	GM = 4
}
slot1 = {
	[slot0.FailReasonEnum.FightFail] = "战斗全员阵亡失败-%s",
	[slot0.FailReasonEnum.EventFail] = "战斗外事件导致失败-%s",
	[slot0.FailReasonEnum.AbortFight] = "战斗主动退出-%s"
}

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:clearStatEnd()
	slot0:clearInitHeroGroup()
end

function slot0.initObjPool(slot0)
	slot0.objPool = slot0.objPool or {}
end

function slot0.getNewObj(slot0)
	slot0:initObjPool()

	if slot0.objPool and #slot0.objPool > 1 then
		return table.remove(slot0.objPool)
	end

	return {}
end

function slot0.copyValueList(slot0, slot1)
	slot2 = slot0:getNewObj()

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot7)
	end

	return slot2
end

function slot0.copyValueDict(slot0, slot1)
	slot2 = slot0:getNewObj()

	for slot6, slot7 in pairs(slot1) do
		slot2[slot6] = slot7
	end

	return slot2
end

function slot0.recycleObj(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:initObjPool()
	tabletool.clear(slot1)
	table.insert(slot0.objPool, slot1)
end

function slot0.recycleObjList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:recycleObj(slot6)
	end

	slot0:recycleObj(slot1)
end

function slot0.clearObjPool(slot0)
	slot0.objPool = nil
end

function slot0.statStart(slot0)
	slot0.startTime = ServerTime.now()
end

function slot0.statReset(slot0)
	slot0.statEnum = StatEnum.Result.Reset
end

function slot0.statAbort(slot0)
	slot0:removeRpcCallback()

	slot0.callbackId = RogueRpc.instance:sendRogueReturnRequest(V1a6_CachotEnum.ActivityId, slot0.onReceiveRogueReturnInfo, slot0)
end

function slot0.onReceiveRogueReturnInfo(slot0, slot1, slot2, slot3)
	slot0.callbackId = nil

	if slot2 ~= 0 then
		slot0:clearStatEnd()

		return
	end

	slot4 = slot0.rogueEndInfo or RogueEndingInfoMO.New()

	slot4:init(slot3.endPush)
	slot0:_statEnd(StatEnum.Result.Abort, "", slot4)
end

function slot0.removeRpcCallback(slot0)
	if slot0.callbackId then
		RogueRpc.instance:removeCallbackById(slot0.callbackId)

		slot0.callbackId = nil
	end
end

function slot0.statEnd(slot0)
	slot1 = V1a6_CachotModel.instance:getRogueEndingInfo()
	slot2, slot3 = nil

	if slot0.statEnum == StatEnum.Result.Reset then
		slot0.startTime = ServerTime.now()
		slot2 = StatEnum.Result.Reset
		slot3 = ""
	else
		slot2 = slot1:isFinish() and StatEnum.Result.Success or StatEnum.Result.Fail
		slot3 = slot0:getFailReason()
	end

	slot0:_statEnd(slot2, slot3, slot1)
end

function slot0._statEnd(slot0, slot1, slot2, slot3)
	if not slot0.startTime then
		return
	end

	slot5, slot6 = slot0:getCollectList()
	slot7, slot8 = slot0:getHeroGroupList()

	StatController.instance:track(StatEnum.EventName.ExitCachot, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0.startTime,
		[StatEnum.EventProperties.Difficulty] = slot3:getDifficulty(),
		[StatEnum.EventProperties.DungeonResult] = slot1,
		[StatEnum.EventProperties.InterruptReason] = slot2,
		[StatEnum.EventProperties.CompletedEventNum] = slot3:getFinishEventNum(),
		[StatEnum.EventProperties.CompletedEventId] = slot0:copyValueList(slot3:getFinishEventList()),
		[StatEnum.EventProperties.CompletedRoomEnum] = slot3:getRoomNum(),
		[StatEnum.EventProperties.CompletedLayers] = slot3:getLayer(),
		[StatEnum.EventProperties.DungeonPoints] = slot3:getScore(),
		[StatEnum.EventProperties.IsDoublePoints] = slot3:isDoubleScore(),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = slot7,
		[StatEnum.EventProperties.HeroGroupArray] = slot8,
		[StatEnum.EventProperties.CollectList] = slot5,
		[StatEnum.EventProperties.CollectArray] = slot6,
		[StatEnum.EventProperties.HeartBeat] = slot0:getRogueInfoMo() and slot4.heart or nil,
		[StatEnum.EventProperties.DungeonGold] = slot4 and slot4.coin or nil,
		[StatEnum.EventProperties.DungeonTokens] = slot4 and slot4.currency or nil
	})
	slot0:recycleObj(slot9)
	slot0:recycleObj(slot5)
	slot0:recycleObj(slot7)
	slot0:recycleObjList(slot6)
	slot0:recycleObjList(slot8)
	slot0:clearStatEnd()
end

function slot0.clearStatEnd(slot0)
	slot0.statEnum = nil
	slot0.startTime = nil

	slot0:removeRpcCallback()
end

function slot0.recordInitHeroGroupByEnterRogue(slot0)
	slot0:recycleObj(slot0.initHeroNameList)
	slot0:recycleObjList(slot0.initHeroObjList)

	slot0.initHeroNameList, slot0.initHeroObjList = slot0:getHeroGroupList(true)
end

function slot0.recordInitHeroGroup(slot0)
	if not LoginController.instance:isEnteredGame() then
		return
	end

	slot1 = V1a6_CachotModel.instance:getRogueStateInfo()
	slot2 = slot1.lastGroup
	slot3 = slot1.lastBackupGroup
	slot4 = slot0:getNewObj()
	slot5 = slot0:getNewObj()
	slot6 = slot1.difficulty or 1

	if not slot1.difficulty or slot1.difficulty == 0 then
		slot6 = 1
	end

	if not lua_rogue_difficulty.configDict[slot6] then
		logError("not found rouge difficulty co : " .. tostring(slot6))
	end

	slot0:addGroupData(slot2, slot4, slot5, string.splitToNumber(slot7.initLevel, "#"))
	slot0:addGroupData(slot3, slot4, slot5)
	slot0:recycleObj(slot0.initHeroNameList)
	slot0:recycleObjList(slot0.initHeroObjList)

	slot0.initHeroNameList = slot4
	slot0.initHeroObjList = slot5
end

function slot0.clearInitHeroGroup(slot0)
	slot0:recycleObj(slot0.initHeroNameList)
	slot0:recycleObjList(slot0.initHeroObjList)

	slot0.initHeroNameList = nil
	slot0.initHeroObjList = nil
end

function slot0.addGroupData(slot0, slot1, slot2, slot3, slot4)
	for slot8, slot9 in ipairs(slot1.heroList) do
		if slot9 ~= "0" and HeroModel.instance:getById(slot9) then
			slot12, slot13 = slot0:buildHeroObj(slot10, slot1:getFirstEquipMo(slot8), slot4 and slot4[slot8] or nil)
			slot13.remain_HP = "100"

			table.insert(slot2, slot12)
			table.insert(slot3, slot13)
		end
	end
end

function slot0.bakeRogueInfoMo(slot0)
	slot0.rogueInfoMo = V1a6_CachotModel.instance:getRogueInfo()
end

function slot0.getRogueInfoMo(slot0)
	return slot0.rogueInfoMo
end

function slot0.clearRogueInfoMo(slot0)
	slot0.rogueInfoMo = nil
end

function slot0.getRunningEvents(slot0)
	if not slot0:getRogueInfoMo() then
		return ""
	end

	if not slot1:getSelectEvents() or #slot2 < 1 then
		return ""
	end

	slot3 = slot0:getNewObj()

	for slot7, slot8 in ipairs(slot2) do
		if slot8.status == V1a6_CachotEnum.EventStatus.Start then
			table.insert(slot3, slot8.eventId)
		end
	end

	slot0:recycleObj(slot3)

	return table.concat(slot3, "-")
end

function slot0.getFailReason(slot0)
	if not V1a6_CachotModel.instance:getRogueEndingInfo() then
		return nil
	end

	if slot1:isFinish() then
		return nil
	end

	return string.format(uv0[slot1:getFailReason()] or uv0[uv1.FailReasonEnum.FightFail], slot0:getRunningEvents())
end

function slot0.getCollectList(slot0)
	if not V1a6_CachotModel.instance:getRogueInfo() then
		return nil, 
	end

	slot4 = slot0:getNewObj()
	slot5 = slot0:getNewObj()
	slot6 = slot0:getNewObj()

	for slot10, slot11 in pairs(slot1.collections) do
		if V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot11.cfgId) then
			table.insert(slot4, slot12.name)

			slot6[slot11.id] = true
			slot13 = slot0:getNewObj()
			slot13.collection_name = slot12.name
			slot13.collection_num = 1

			if slot11.leftUid ~= 0 then
				if slot1.collectionMap[slot11.leftUid] then
					slot6[slot14.id] = true
					slot13.enchant_collection_left_name = V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot14.cfgId).name
					slot13.enchant_collection_left_num = 1
				else
					logError(string.format("collectMo.id : '%s' not found left uid : '%s'", slot11.id, slot11.leftUid))
				end
			end

			if slot11.rightUid ~= 0 then
				if slot3[slot11.rightUid] then
					slot6[slot14.id] = true
					slot13.enchant_collection_right_name = V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot14.cfgId).name
					slot13.enchant_collection_right_num = 1
				else
					logError(string.format("collectMo.id : '%s' not found right uid : '%s'", slot11.id, slot11.rightUid))
				end
			end

			table.insert(slot5, slot13)
		end
	end

	return slot4, slot5
end

function slot0.getHeroGroupList(slot0, slot1)
	if not V1a6_CachotModel.instance:getRogueInfo() then
		return nil, 
	end

	slot3 = slot2.teamInfo
	slot4 = slot0:getNewObj()
	slot5 = slot0:getNewObj()

	for slot12, slot13 in ipairs(slot3:getGroupHeros()) do
		if HeroModel.instance:getById(slot13.heroUid) then
			slot17, slot18 = slot0:buildHeroObj(slot14, slot3:getGroupEquips()[slot12], slot3.groupBoxStar[slot12])
			slot18.remain_HP = slot3.lifeMap[slot14.heroId].lifePercent

			if not slot1 then
				slot18.field_level = slot16
			end

			table.insert(slot4, slot17)
			table.insert(slot5, slot18)
		end
	end

	for slot13, slot14 in ipairs(slot3:getSupportHeros()) do
		if HeroModel.instance:getById(slot14.heroUid) then
			slot17, slot18 = slot0:buildHeroObj(slot15, slot7[slot13 + 4], nil)
			slot18.remain_HP = slot3.lifeMap[slot15.heroId].lifePercent

			if not slot1 then
				slot18.field_level = 0
			end

			table.insert(slot4, slot17)
			table.insert(slot5, slot18)
		end
	end

	return slot4, slot5
end

function slot0.buildHeroObj(slot0, slot1, slot2, slot3)
	slot4 = HeroConfig.instance:getHeroCO(slot1.heroId)
	slot5, slot6 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(slot1, slot3)
	slot7, slot8 = HeroConfig.instance:getShowLevel(slot5)
	slot9, slot10, slot11 = nil

	if slot2 then
		slot9 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(slot2, slot3)
		slot10 = slot2.refineLv
		slot11 = slot2.config.name
	else
		slot9 = 0
		slot10 = 0
		slot11 = ""
	end

	slot12 = slot0:getNewObj()
	slot12.hero_name = slot4.name
	slot12.hero_level = slot5
	slot12.hero_rank = slot8
	slot12.breakthrough = slot1.exSkillLevel
	slot12.talent = slot6
	slot12.EquipName = slot11
	slot12.EquipLevel = slot9
	slot12.equip_refine = slot10

	return slot4.name, slot12
end

function slot0.clearStartEventDict(slot0)
	if slot0.startEventDict then
		for slot4, slot5 in pairs(slot0.startEventDict) do
			slot0:recycleObj(slot5)
		end

		tabletool.clear(slot0.startEventDict)
	end
end

function slot0.recycleEventObj(slot0, slot1)
	if not slot0.startEventDict then
		return
	end

	if slot0.startEventDict[slot1] then
		slot0:recycleObj(slot0.startEventDict[slot1])

		slot0.startEventDict[slot1] = nil
	end
end

function slot0.initEventStartHandle(slot0)
	if not slot0.startEventHandleDict then
		slot0.startEventHandleDict = {
			[V1a6_CachotEnum.EventType.HeroPosUpgrade] = slot0.onStartHeroPosUpgradeEvent
		}
	end
end

function slot0.onStartHeroPosUpgradeEvent(slot0, slot1)
	slot2 = slot0:getNewObj()
	slot2.groupBoxStar = slot0:copyValueList(V1a6_CachotModel.instance:getRogueInfo().teamInfo.groupBoxStar)

	return slot2
end

function slot0.statStartEvent(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1.status ~= V1a6_CachotEnum.EventStatus.Start then
		return
	end

	slot0.startEventDict = slot0.startEventDict or {}

	if slot0.startEventDict[slot1.eventId] then
		return
	end

	slot0:initEventStartHandle()

	if not slot0.startEventHandleDict[lua_rogue_event.configDict[slot1.eventId].type] then
		return
	end

	slot0.startEventDict[slot1.eventId] = slot3(slot0, slot1)
end

function slot0.getObtainHeroNameList(slot0, slot1)
	if not slot1 then
		return
	end

	if lua_rogue_event.configDict[slot1.eventId].type ~= V1a6_CachotEnum.EventType.CharacterGet then
		return
	end

	slot0.obtainHeroList = slot0.obtainHeroList or {}

	tabletool.clear(slot0.obtainHeroList)

	if not HeroConfig.instance:getHeroCO(slot1.option) then
		if slot1.option ~= 0 then
			logError("not config hero , heroId : " .. tostring(slot1.option))
		end

		return nil
	end

	table.insert(slot0.obtainHeroList, slot3.name)

	return slot0.obtainHeroList
end

function slot0.getSeatUpList(slot0, slot1)
	if not slot1 then
		return
	end

	if lua_rogue_event.configDict[slot1.eventId].type ~= V1a6_CachotEnum.EventType.HeroPosUpgrade then
		return
	end

	if not slot0.startEventDict then
		return
	end

	if not slot0.startEventDict[slot1.eventId] then
		return
	end

	slot4 = slot0:getNewObj()

	for slot10, slot11 in ipairs(V1a6_CachotModel.instance:getRogueInfo().teamInfo.groupBoxStar) do
		if slot11 ~= slot3.groupBoxStar[slot10] then
			slot12 = slot0:getNewObj()
			slot12.field_id = slot10
			slot12.field_before_level = slot3.groupBoxStar[slot10]
			slot12.field_after_level = slot11

			table.insert(slot4, slot12)
		end
	end

	slot0:recycleEventObj(slot1.eventId)

	if #slot4 > 0 then
		return slot4
	end

	slot0:recycleObjList(slot4)
end

function slot0.getStoryOptionId(slot0, slot1)
	if not slot1 then
		return
	end

	if lua_rogue_event.configDict[slot1.eventId].type ~= V1a6_CachotEnum.EventType.ChoiceSelect then
		return
	end

	return tostring(slot1.option)
end

function slot0.getPromptOptionId(slot0, slot1)
	if not slot1 then
		return
	end

	if lua_rogue_event.configDict[slot1.eventId].type ~= V1a6_CachotEnum.EventType.Tip then
		return
	end

	return tostring(slot2.eventId)
end

function slot0.initChangeLifeHeroNameList(slot0)
	slot0.changeLifeHeroNameList = slot0.changeLifeHeroNameList or {}

	tabletool.clear(slot0.changeLifeHeroNameList)
end

function slot0.setChangeLife(slot0, slot1)
	slot0:initChangeLifeHeroNameList()

	for slot5, slot6 in ipairs(slot1) do
		if HeroConfig.instance:getHeroCO(slot6.heroId) then
			table.insert(slot0.changeLifeHeroNameList, slot7.name)
		end
	end
end

function slot0.initBloodReturnHeroNameList(slot0)
	slot0.bloodReturnHeroNameList = slot0.bloodReturnHeroNameList or {}

	tabletool.clear(slot0.bloodReturnHeroNameList)
end

function slot0.getBloodReturnHeroNameList(slot0, slot1)
	if not slot1 then
		return
	end

	if lua_rogue_event.configDict[slot1.eventId].type ~= V1a6_CachotEnum.EventType.CharacterCure then
		return
	end

	if not lua_rogue_event_life.configDict[slot2.eventId] then
		return
	end

	if string.splitToNumber(slot3.num, "#")[1] == V1a6_CachotEnum.CureEventType.Single then
		if HeroConfig.instance:getHeroCO(slot1.option) then
			slot0:initBloodReturnHeroNameList()
			table.insert(slot0.bloodReturnHeroNameList, slot6.name)

			return slot0.bloodReturnHeroNameList
		else
			logError("not find heroid  config : " .. tostring(slot1.option))

			return nil
		end
	elseif slot5 == V1a6_CachotEnum.CureEventType.Random then
		return slot0.changeLifeHeroNameList
	elseif slot5 == V1a6_CachotEnum.CureEventType.All then
		return slot0.changeLifeHeroNameList
	else
		logError("not handle type : " .. tostring(slot3.num))

		return nil
	end
end

function slot0.initReviveHeroNameList(slot0)
	slot0.reviveHeroNameList = slot0.reviveHeroNameList or {}

	tabletool.clear(slot0.reviveHeroNameList)
end

function slot0.getReviveHeroNameList(slot0, slot1)
	if not slot1 then
		return
	end

	if lua_rogue_event.configDict[slot1.eventId].type ~= V1a6_CachotEnum.EventType.CharacterRebirth then
		return
	end

	if not lua_rogue_event_revive.configDict[slot2.eventId] then
		return
	end

	if string.splitToNumber(slot3.num, "#")[1] == V1a6_CachotEnum.CureEventType.Single then
		if HeroConfig.instance:getHeroCO(slot1.option) then
			slot0:initReviveHeroNameList()
			table.insert(slot0.reviveHeroNameList, slot6.name)

			return slot0.reviveHeroNameList
		else
			logError("not find heroid  config : " .. tostring(slot1.option))

			return nil
		end
	elseif slot5 == V1a6_CachotEnum.CureEventType.Random then
		return slot0.changeLifeHeroNameList
	elseif slot5 == V1a6_CachotEnum.CureEventType.All then
		return slot0.changeLifeHeroNameList
	else
		logError("not handle type : " .. tostring(slot3.num))

		return nil
	end
end

function slot0.addBuyGoods(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if lua_rogue_event.configDict[slot1.eventId].type ~= V1a6_CachotEnum.EventType.Store then
		return
	end

	if not cjson.decode(slot1.eventData) then
		return
	end

	if not slot5.buy then
		return
	end

	for slot10, slot11 in ipairs(slot6) do
		if lua_rogue_goods.configDict[slot11] and slot12.creator ~= 0 and V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot12.creator) then
			table.insert(slot2 or slot0:getNewObj(), slot13.name)

			slot14 = slot0:getNewObj()
			slot14.collection_name = slot13.name
			slot14.collection_num = 1

			table.insert(slot3 or slot0:getNewObj(), slot14)
		end
	end
end

function slot0.statFinishEvent(slot0, slot1)
	if not slot1 or slot1.status ~= V1a6_CachotEnum.EventStatus.Finish then
		return
	end

	slot2 = V1a6_CachotModel.instance:getRogueInfo()
	slot3 = V1a6_CachotRoomConfig.instance:getCoByRoomId(slot2.room)
	slot4 = lua_rogue_event.configDict[slot1.eventId]
	slot5, slot6 = slot0:getCollectList()
	slot7, slot8 = slot0:getHeroGroupList()
	slot9 = slot0:getSeatUpList(slot1)

	slot0:addBuyGoods(slot1, slot5, slot6)
	StatController.instance:track(StatEnum.EventName.CompleteCachotEvent, {
		[StatEnum.EventProperties.Difficulty] = slot2.difficulty,
		[StatEnum.EventProperties.Layer] = slot2.layer,
		[StatEnum.EventProperties.RoomId] = slot3.id,
		[StatEnum.EventProperties.RoomName] = slot3.name,
		[StatEnum.EventProperties.DungeonEventId] = tostring(slot4.id),
		[StatEnum.EventProperties.DungeonEventName] = slot4.title,
		[StatEnum.EventProperties.DungeonEventType] = tostring(slot4.type),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = slot7,
		[StatEnum.EventProperties.HeroGroupArray] = slot8,
		[StatEnum.EventProperties.CollectList] = slot5,
		[StatEnum.EventProperties.CollectArray] = slot6,
		[StatEnum.EventProperties.HeartBeat] = slot2.heart,
		[StatEnum.EventProperties.DungeonGold] = slot2.coin,
		[StatEnum.EventProperties.DungeonTokens] = slot2.currency,
		[StatEnum.EventProperties.CachotObtainHero] = slot0:getObtainHeroNameList(slot1),
		[StatEnum.EventProperties.FieldUp] = slot9,
		[StatEnum.EventProperties.StoryOptionId] = slot0:getStoryOptionId(slot1),
		[StatEnum.EventProperties.PromptOptionId] = slot0:getPromptOptionId(slot1),
		[StatEnum.EventProperties.BloodReturnHero] = slot0:getBloodReturnHeroNameList(slot1),
		[StatEnum.EventProperties.ReviveHero] = slot0:getReviveHeroNameList(slot1)
	})
	slot0:recycleObj(slot7)
	slot0:recycleObj(slot5)
	slot0:recycleObjList(slot8)
	slot0:recycleObjList(slot6)
	slot0:recycleObjList(slot9)
end

function slot0.statEnterRoom(slot0)
	slot0.enterRoomTime = ServerTime.now()
	slot1 = V1a6_CachotModel.instance:getRogueInfo()
	slot0.beforeCoin = slot1.coin
	slot0.beforeCurrency = slot1.currency
	slot0.beforeCollectionDict = slot0:copyValueDict(slot1.collectionMap)
end

function slot0.getCostAndReward(slot0)
	if not slot0.enterRoomTime then
		return
	end

	slot2 = slot0:getNewObj()

	if slot0.beforeCoin ~= V1a6_CachotModel.instance:getRogueInfo().coin then
		slot5 = slot0:getNewObj()
		slot5.materialtype = MaterialEnum.MaterialType.Currency
		slot5.materialname = ItemConfig.instance:getItemConfig(MaterialEnum.MaterialType.Currency, V1a6_CachotEnum.CoinId).name

		if slot3.coin < slot0.beforeCoin then
			slot5.materialnum = slot0.beforeCoin - slot3.coin

			table.insert(slot0:getNewObj(), slot5)
		else
			slot5.materialnum = slot3.coin - slot0.beforeCoin

			table.insert(slot2, slot5)
		end
	end

	if slot0.beforeCurrency ~= slot3.currency then
		slot5 = slot0:getNewObj()
		slot5.materialtype = MaterialEnum.MaterialType.Currency
		slot5.materialname = ItemConfig.instance:getItemConfig(MaterialEnum.MaterialType.Currency, V1a6_CachotEnum.CurrencyId).name

		if slot3.currency < slot0.beforeCurrency then
			slot5.materialnum = slot0.beforeCurrency - slot3.currency

			table.insert(slot1, slot5)
		else
			slot5.materialnum = slot3.currency - slot0.beforeCurrency

			table.insert(slot2, slot5)
		end
	end

	for slot8, slot9 in pairs(slot3.collectionMap) do
		if not slot0.beforeCollectionDict[slot8] then
			slot11 = slot0:getNewObj()
			slot11.materialtype = MaterialEnum.MaterialType.None
			slot11.materialname = V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot9.cfgId).name
			slot11.materialnum = 1

			table.insert(slot2, slot11)
		end
	end

	for slot8, slot9 in pairs(slot0.beforeCollectionDict) do
		if not slot4[slot8] then
			slot11 = slot0:getNewObj()
			slot11.materialtype = MaterialEnum.MaterialType.None
			slot11.materialname = V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot9.cfgId).name
			slot11.materialnum = 1

			table.insert(slot1, slot11)
		end
	end

	return slot1, slot2
end

function slot0.statFinishRoom(slot0, slot1, slot2)
	if not slot0.enterRoomTime then
		return
	end

	if not V1a6_CachotRoomConfig.instance:getCoByRoomId(slot1) then
		return
	end

	slot4 = V1a6_CachotModel.instance:getRogueInfo()
	slot5, slot6 = slot0:getCollectList()
	slot7, slot8 = slot0:getHeroGroupList()
	slot9, slot10 = slot0:getCostAndReward()

	StatController.instance:track(StatEnum.EventName.ExitCachotRoom, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0.enterRoomTime,
		[StatEnum.EventProperties.Difficulty] = slot4.difficulty,
		[StatEnum.EventProperties.Layer] = slot2,
		[StatEnum.EventProperties.RoomId] = slot3.id,
		[StatEnum.EventProperties.RoomName] = slot3.name,
		[StatEnum.EventProperties.InitialHeroGroup] = slot0.initHeroNameList,
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0.initHeroObjList,
		[StatEnum.EventProperties.HeroGroup] = slot7,
		[StatEnum.EventProperties.HeroGroupArray] = slot8,
		[StatEnum.EventProperties.CollectList] = slot5,
		[StatEnum.EventProperties.CollectArray] = slot6,
		[StatEnum.EventProperties.HeartBeat] = slot4.heart,
		[StatEnum.EventProperties.DungeonGold] = slot4.coin,
		[StatEnum.EventProperties.DungeonTokens] = slot4.currency,
		[StatEnum.EventProperties.CachotCost] = slot9,
		[StatEnum.EventProperties.CachotReward] = slot10
	})

	slot0.enterRoomTime = nil

	slot0:clearStartEventDict()
	slot0:recycleObj(slot5)
	slot0:recycleObj(slot7)
	slot0:recycleObjList(slot6)
	slot0:recycleObjList(slot8)
	slot0:recycleObjList(slot9)
	slot0:recycleObjList(slot10)
end

function slot0.statUnlockCollection(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot0:getNewObj()

	for slot6, slot7 in ipairs(slot1) do
		tabletool.clear(slot2)

		slot2[StatEnum.EventProperties.CollectionId] = slot7
		slot2[StatEnum.EventProperties.CollectionName] = V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot7) and slot8.name or ""

		StatController.instance:track(StatEnum.EventName.UnlockCachotCollection, slot2)
	end

	slot0:recycleObj(slot2)
end

slot0.instance = slot0.New()

return slot0
