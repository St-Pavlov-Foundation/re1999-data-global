module("modules.logic.rouge.controller.RougeStatController", package.seeall)

slot0 = class("RougeStatController", BaseController)

function slot0.addConstEvents(slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onNodeEventStatusChange, slot0.onNodeEventStatusChange, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeSendMoveRpc, slot0.beforeMoveEvent, slot0)
	RougeController.instance:registerCallback(RougeEvent.AdjustBackPack, slot0.onAdjustBackPack, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeNormalToMiddle, slot0.trackExitDungeonLayer, slot0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._onPushEndFight, slot0)
end

function slot0.clear(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onNodeEventStatusChange, slot0.onNodeEventStatusChange, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onBeforeSendMoveRpc, slot0.beforeMoveEvent, slot0)
	RougeController.instance:unregisterCallback(RougeEvent.AdjustBackPack, slot0.onAdjustBackPack, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onBeforeNormalToMiddle, slot0.trackExitDungeonLayer, slot0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, slot0._onPushEndFight, slot0)
end

function slot0._onPushEndFight(slot0)
	if FightModel.instance:getRecordMO() and slot1.fightResult then
		slot0._failResult = slot2
	end
end

function slot0.statStart(slot0)
	slot0.startTime = ServerTime.now()
	slot0._isStart = true
	slot0._isReset = false
	slot0._failResult = nil
end

function slot0.checkIsReset(slot0)
	return slot0._isReset
end

function slot0.setReset(slot0)
	slot0._isReset = true
end

slot0.EndResult = {
	Close = 3,
	Abort = 4,
	Fail = 2,
	Success = 1
}

function slot0.statEnd(slot0, slot1)
	slot2, slot3, slot4 = slot0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.FinishRouge, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.MatchId] = slot0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = slot0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = slot0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = slot0:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = slot0:getAssistList(),
		[StatEnum.EventProperties.CollectList] = slot2,
		[StatEnum.EventProperties.CollectArray] = slot3,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = slot4,
		[StatEnum.EventProperties.DungeonGold] = slot0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = slot0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = slot0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = slot0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = slot0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = slot0:getBuildTalentList(),
		[StatEnum.EventProperties.UseTime] = slot0:getUseTime(),
		[StatEnum.EventProperties.DungeonResult] = nil or slot0:getRougeResult(slot1),
		[StatEnum.EventProperties.InterrruptReason] = slot0:getInterruptReason(slot1),
		[StatEnum.EventProperties.CompletedEventNum] = slot0:getCompletedEventNum(),
		[StatEnum.EventProperties.CompletedEventId] = slot0:getCompletedEventID(),
		[StatEnum.EventProperties.CompletedEntrustId] = slot0:getCompletedEntrustId(),
		[StatEnum.EventProperties.CompletedEntrustNum] = slot0:getCompletedEntrustNum(),
		[StatEnum.EventProperties.CompletedLayers] = slot0:getCompletedLayers(),
		[StatEnum.EventProperties.DungeonPoints] = slot0:getRougePoints(),
		[StatEnum.EventProperties.RewardPoints] = slot0:getRougeRewardPoints(),
		[StatEnum.EventProperties.TalentPoints] = slot0:getRougeTalentPoints(),
		[StatEnum.EventProperties.TotalDeathNum] = slot0:getTotalDeathNum(),
		[StatEnum.EventProperties.TotalReviveNum] = slot0:getTotalReviveNum(),
		[StatEnum.EventProperties.CollectionConflateNum] = slot0:getCollectionConflateNum(),
		[StatEnum.EventProperties.BadgeName] = slot0:getBadgeName(),
		[StatEnum.EventProperties.LimiterEntry] = slot0:getAllLimiterDesc(),
		[StatEnum.EventProperties.EmblemNum] = slot0:getAddEmblemCount()
	})
end

function slot0.bakerougeInfoMo(slot0)
	slot0.rougeInfoMo = RougeModel.instance:getRougeInfo()
end

function slot0.getrougeInfoMo(slot0)
	return slot0.rougeInfoMo
end

function slot0.clearrougeInfoMo(slot0)
	slot0.rougeInfoMo = nil
end

function slot0.reInit(slot0)
	slot0:_clearInitHeroGroupList()
end

function slot0._clearInitHeroGroupList(slot0)
	slot0.initHeroNameList = nil
	slot0.initHeroObjList = nil
	slot0.assistList = {}
end

function slot0._initHeroGroupList(slot0)
	slot0.initHeroNameList = {}
	slot0.initHeroObjList = {}

	if not RougeModel.instance:getRougeInfo() then
		return
	end

	for slot7, slot8 in ipairs(RougeModel.instance:getInitHeroIds()) do
		if HeroModel.instance:getByHeroId(slot8) and not slot1.teamInfo:getAssistHeroMo(slot8) then
			slot11, slot12 = slot0:buildObj(slot9)

			table.insert(slot0.initHeroNameList, slot11)
			table.insert(slot0.initHeroObjList, slot12)
		end
	end
end

function slot0.selectInitHeroGroup(slot0, slot1, slot2)
	slot0:_clearInitHeroGroupList()

	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		slot4[#slot4 + 1] = slot9.heroId
	end

	if slot2 then
		slot4[#slot4 + 1] = slot2.heroId
	end

	RougeModel.instance:setTeamInitHeros(slot4)
	slot0:_initHeroGroupList()

	if slot2 and slot2:getHeroMO() then
		slot6, slot7 = slot0:buildObj(slot5)

		table.insert(slot0.assistList, slot7)
	end

	StatController.instance:track(StatEnum.EventName.SelectHeroGroup, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = slot0:getAssistList()
	})
end

function slot0.buildObj(slot0, slot1, slot2)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	slot4 = 0
	slot5 = 0
	slot6, slot7, slot8 = nil
	slot9 = CharacterEnum.TalentRank <= slot1.rank and slot1.talent > 0

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		slot9 = false
	end

	slot10 = 0
	slot11 = 0
	slot12 = 0
	slot13 = nil
	slot14 = 0
	slot15 = false

	if not slot1:isTrial() and RougeHeroGroupBalanceHelper.getIsBalanceMode() then
		slot10, slot17, slot12, slot13, slot14 = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(slot1.heroId)

		if slot17 and CharacterEnum.TalentRank <= slot11 and slot12 > 0 then
			slot15 = true
		end

		slot4 = slot10 and slot1.level < slot10 and slot10 or slot1.level
		slot5 = slot15 and (not slot9 or slot1.talent < slot12) and slot12 or slot1.talent

		if slot2 then
			slot6 = slot14 and slot2.level < slot14 and slot14 or slot2.level
			slot7 = slot2.refineLv
			slot8 = slot2.config.name
		else
			slot6 = 0
			slot7 = 0
			slot8 = ""
		end
	end

	slot16 = HeroConfig.instance:getHeroCO(slot1.heroId)
	slot17, slot18 = HeroConfig.instance:getShowLevel(slot4)

	return slot16.name, {
		hero_name = slot16.name,
		hero_level = slot4,
		hero_rank = slot18,
		breakthrough = slot1.exSkillLevel,
		talent = slot5,
		EquipName = slot8,
		EquipLevel = slot6,
		equip_refine = slot7
	}
end

slot0.EventType = {
	"普通战斗事件",
	"困难战斗事件（精英）",
	"精英战斗事件（层间boss）",
	"BOSS战斗事件（最终boss）",
	"奖励事件",
	"选项事件",
	"商店事件",
	"休憩事件"
}

function slot0.beforeMoveEvent(slot0)
	slot1 = {}
	slot2 = {}

	for slot7, slot8 in pairs(RougeMapModel.instance:getNodeDict()) do
		if slot8.arriveStatus == RougeMapEnum.Arrive.CanArrive then
			table.insert(slot2, slot8.eventId)

			if uv0.EventType[slot8:getEventCo().type] then
				table.insert(slot1, slot10)
			end
		end
	end

	StatController.instance:track(StatEnum.EventName.OccurOptionalEvent, {
		[StatEnum.EventProperties.OccurEventType] = slot1,
		[StatEnum.EventProperties.OccurEventID] = slot2
	})
end

function slot0.onNodeEventStatusChange(slot0, slot1, slot2)
	if slot2 ~= RougeMapEnum.EventState.Finish then
		return
	end

	slot0:tryTriggerFinishEvent(slot1)
end

function slot0.tryTriggerFinishEvent(slot0, slot1)
	slot2 = RougeMapConfig.instance:getRougeEvent(slot1)
	slot3, slot4, slot5 = slot0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.EventComplete, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.MatchId] = slot0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = slot0:getLayer(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = slot0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = slot0:getAssistList(),
		[StatEnum.EventProperties.HeroGroup] = slot0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = slot0:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = slot3,
		[StatEnum.EventProperties.CollectArray] = slot4,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = slot5,
		[StatEnum.EventProperties.DungeonGold] = slot0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = slot0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = slot0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = slot0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = slot0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = slot0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = slot0:getAllLimiterDesc(),
		[StatEnum.EventProperties.DungeonEventId] = slot1,
		[StatEnum.EventProperties.DungeonEventName] = slot2.name,
		[StatEnum.EventProperties.DungeonEventType] = uv0.EventType[slot2.type]
	})
end

function slot0.statRougeChoiceEvent(slot0)
	slot4 = RougeMapModel.instance:getCurChoiceId() and lua_rouge_choice.configDict[slot3]
	slot6, slot7, slot8 = slot0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.RougeConfirmSelectOption, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.MatchId] = slot0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = slot0:getLayer(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = slot0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0:getInitHeroObjList(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = slot0:getAssistList(),
		[StatEnum.EventProperties.HeroGroup] = slot0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = slot0:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = slot6,
		[StatEnum.EventProperties.CollectArray] = slot7,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = slot8,
		[StatEnum.EventProperties.DungeonGold] = slot0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = slot0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = slot0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = slot0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = slot0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = slot0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = slot0:getAllLimiterDesc(),
		[StatEnum.EventProperties.DungeonEventId] = RougeMapModel.instance:getCurEvent() and slot1.id,
		[StatEnum.EventProperties.DungeonEventName] = slot1.name,
		[StatEnum.EventProperties.DungeonEventType] = uv0.EventType[slot1.type],
		[StatEnum.EventProperties.RougeEventChoiceId] = slot3,
		[StatEnum.EventProperties.RougeEventChoiceName] = slot4 and slot4.desc
	})
end

function slot0.startAdjustBackPack(slot0)
	slot0.startAdjustTime = ServerTime.now()
	slot0._isopenbackpack = true
end

function slot0.onAdjustBackPack(slot0)
	if not slot0._isopenbackpack then
		return
	end

	slot0._adjustbackpack = true
end

function slot0.clearBackpack(slot0)
	slot0._adjustbackpack = false
	slot0._isopenbackpack = false
end

function slot0.endAdjustBackPack(slot0)
	slot1, slot2, slot3 = slot0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.ExitRougeBackpack, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.MatchId] = slot0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = slot0:getLayer(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = slot0:getTeamLevel(),
		[StatEnum.EventProperties.HeroGroup] = slot0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = slot0:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = slot1,
		[StatEnum.EventProperties.CollectArray] = slot2,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = slot3,
		[StatEnum.EventProperties.DungeonGold] = slot0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = slot0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = slot0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = slot0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = slot0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = slot0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = slot0:getAllLimiterDesc(),
		[StatEnum.EventProperties.UseTime] = slot0:getAdjustBackPackTime(),
		[StatEnum.EventProperties.IsBackPackAdjust] = slot0:getAdjustBackPack()
	})
	slot0:clearBackpack()
end

slot0.operateType = {
	Auto = 1,
	Clear = 2
}

function slot0.operateCollection(slot0, slot1)
	slot3, slot4, slot5 = slot0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.OperateCollection, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.MatchId] = slot0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.Layer] = slot0:getLayer(),
		[StatEnum.EventProperties.FieldLevel] = slot0:getTeamLevel(),
		[StatEnum.EventProperties.HeroGroup] = slot0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = slot0:getHeroGroupArray(),
		[StatEnum.EventProperties.CollectList] = slot3,
		[StatEnum.EventProperties.CollectArray] = slot4,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = slot5,
		[StatEnum.EventProperties.DungeonGold] = slot0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = slot0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = slot0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = slot0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = slot0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = slot0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = slot0:getAllLimiterDesc(),
		[StatEnum.EventProperties.RougeOperationType] = slot1 == uv0.operateType.Auto and "一键填入" or "清空"
	})
end

function slot0.trackExitDungeonLayer(slot0)
	slot1, slot2, slot3 = slot0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.ExitRougeLayer, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.MatchId] = slot0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = slot0:getLayer(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = slot0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = slot0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = slot0:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = slot0:getAssistList(),
		[StatEnum.EventProperties.CollectList] = slot1,
		[StatEnum.EventProperties.CollectArray] = slot2,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = slot3,
		[StatEnum.EventProperties.DungeonGold] = slot0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = slot0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = slot0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = slot0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = slot0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = slot0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = slot0:getAllLimiterDesc()
	})
end

function slot0.trackUpdateTalent(slot0, slot1)
	if not slot1 then
		return
	end

	slot4, slot5, slot6 = slot0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.UpdateTalent, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.MatchId] = slot0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = slot0:getLayer(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = slot0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = slot0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = slot0:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = slot0:getAssistList(),
		[StatEnum.EventProperties.CollectList] = slot4,
		[StatEnum.EventProperties.CollectArray] = slot5,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = slot6,
		[StatEnum.EventProperties.DungeonGold] = slot0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = slot0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = slot0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = slot0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = slot0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = slot0:getBuildTalentList(),
		[StatEnum.EventProperties.BuildTalentId] = tostring(slot1),
		[StatEnum.EventProperties.BuildTalentDescribe] = lua_rouge_style_talent.configDict[slot1] and slot2.desc,
		[StatEnum.EventProperties.LimiterEntry] = slot0:getAllLimiterDesc()
	})
end

function slot0.trackUseMapSkill(slot0, slot1)
	slot2, slot3, slot4 = slot0:getCollectionInfo()

	StatController.instance:track(StatEnum.EventName.UseMapSkill, {
		[StatEnum.EventProperties.Season] = slot0:getSeason(),
		[StatEnum.EventProperties.Version] = slot0:getVersion(),
		[StatEnum.EventProperties.MatchId] = slot0:getGameNum(),
		[StatEnum.EventProperties.Difficulty] = slot0:getDifficulty(),
		[StatEnum.EventProperties.Layer] = slot0:getLayer(),
		[StatEnum.EventProperties.Build] = slot0:getBuild(),
		[StatEnum.EventProperties.FieldLevel] = slot0:getTeamLevel(),
		[StatEnum.EventProperties.InitialHeroGroup] = slot0:getInitHeroNameList(),
		[StatEnum.EventProperties.InitialHeroGroupArray] = slot0:getInitHeroObjList(),
		[StatEnum.EventProperties.HeroGroup] = slot0:getHeroGroup(),
		[StatEnum.EventProperties.DungeonHeroGroup] = slot0:getHeroGroupArray(),
		[StatEnum.EventProperties.FriendAssistHeroGroupArray] = slot0:getAssistList(),
		[StatEnum.EventProperties.CollectList] = slot2,
		[StatEnum.EventProperties.CollectArray] = slot3,
		[StatEnum.EventProperties.ActivatedLinkageEffect] = slot4,
		[StatEnum.EventProperties.DungeonGold] = slot0:getCoin(),
		[StatEnum.EventProperties.DungeonMedium] = slot0:getMedium(),
		[StatEnum.EventProperties.OutsideTalentInfomation] = slot0:getTalentNameList(),
		[StatEnum.EventProperties.OutsideTalentPoint] = slot0:getConsumeTalentPoint(),
		[StatEnum.EventProperties.BuildTalentLevel] = slot0:getBuildTalentLevel(),
		[StatEnum.EventProperties.BuildTalentList] = slot0:getBuildTalentList(),
		[StatEnum.EventProperties.LimiterEntry] = slot0:getAllLimiterDesc(),
		[StatEnum.EventProperties.MapSkill] = tostring(slot1)
	})
end

function slot0.getCurrentHeroGroupList(slot0)
	slot1 = {}
	slot2 = {}

	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	slot4 = slot3.teamInfo

	for slot10, slot11 in ipairs(slot4:getBattleHeroList()) do
		if slot11 then
			slot13, slot14 = slot0:buildObj(slot11, slot4:getGroupEquips()[slot10])

			table.insert(slot1, slot13)
			table.insert(slot2, slot14)
		end
	end

	return slot1, slot2
end

function slot0.getUnlockTalentNameList(slot0)
	slot1 = {}

	for slot7, slot8 in ipairs(RougeTalentModel.instance:getUnlockTalent()) do
		table.insert(slot1, RougeTalentConfig.instance:getBranchConfigByID(RougeOutsideModel.instance:season(), slot8).name)
	end

	return slot1
end

slot0.Effect2Chinese = {
	"电能",
	"吞噬",
	"升级"
}

function slot0.getCollectionInfo(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(RougeCollectionModel.instance:getSlotAreaCollection()) do
		for slot17, slot18 in ipairs({
			"</color>",
			"<#.->"
		}) do
			slot12 = string.gsub(RougeCollectionConfig.instance:getCollectionName(slot9:getCollectionCfgId(), slot9:getAllEnchantCfgId()), slot18, "")
		end

		table.insert(slot1, slot12)

		slot14 = {
			collection_name = slot12,
			collection_num = 1
		}

		for slot18, slot19 in ipairs(slot10) do
			if slot19 ~= 0 then
				for slot24, slot25 in ipairs(RougeCollectionConfig.instance:getCollectionDescsCfg(slot19)) do
					slot14["enchant_collection_name" .. slot18] = slot25.name
					slot14["enchant_collection_num" .. slot18] = 1

					break
				end
			end
		end

		table.insert(slot2, slot14)

		for slot18, slot19 in pairs(RougeEnum.EffectActiveType) do
			if slot9:isEffectActive(slot19) then
				table.insert(slot3, uv0.Effect2Chinese[slot19])
			end
		end
	end

	return slot1, slot2, slot3
end

function slot0.getSeason(slot0)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	return slot1.season
end

function slot0.getVersion(slot0)
	return RougeModel.instance:getRougeInfo() and slot1.version
end

function slot0.getGameNum(slot0)
	return RougeModel.instance:getRougeInfo() and slot1.gameNum
end

function slot0.getDifficulty(slot0)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	return slot1.difficulty
end

function slot0.getBuild(slot0)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	return lua_rouge_style.configDict[slot1.season][slot1.style].desc
end

function slot0.getLayer(slot0)
	return RougeMapModel.instance:getLayerId()
end

function slot0.getTeamLevel(slot0)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	return slot1.teamLevel
end

function slot0.getInitHeroNameList(slot0)
	if not slot0.initHeroNameList then
		slot0:_initHeroGroupList()
	end

	return slot0.initHeroNameList
end

function slot0.getInitHeroObjList(slot0)
	if not slot0.initHeroObjList then
		slot0:_initHeroGroupList()
	end

	return slot0.initHeroObjList
end

function slot0.getHeroGroup(slot0)
	slot1 = {}

	if RougeModel.instance:getTeamInfo() and slot2:getAllHeroId() then
		for slot7, slot8 in ipairs(slot3) do
			if not slot2:getAssistHeroMo(slot8) then
				slot1[#slot1 + 1] = HeroConfig.instance:getHeroCO(slot8) and slot10.name or ""
			end
		end
	end

	return slot1
end

function slot0.getHeroGroupArray(slot0)
	slot1 = {}

	if RougeModel.instance:getTeamInfo() and slot2:getAllHeroId() then
		slot4 = {
			[slot10.heroId] = slot10.supportHeroId
		}

		for slot9, slot10 in ipairs(slot2:getBattleHeroList()) do
			-- Nothing
		end

		for slot9, slot10 in ipairs(slot3) do
			if not slot2:getAssistHeroMo(slot10) and HeroModel.instance:getByHeroId(slot10) then
				slot13 = 0
				slot14 = 0
				slot15 = 0

				if RougeHeroGroupBalanceHelper.getIsBalanceMode() then
					slot17, slot14, slot15 = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(slot10)
					slot13 = slot17 or 0
					slot14 = slot14 or 0
					slot15 = slot15 or 0
				end

				if slot12:hasDefaultEquip() then
					-- Nothing
				end

				if slot4[slot10] and slot25 ~= 0 then
					slot28 = lua_skill.configDict[slot2:getSupportSkill(slot25)]
					slot17.support_heroname = HeroConfig.instance:getHeroCO(slot25) and slot26.name or nil
					slot17.support_heroskill = slot28 and slot28.name or nil
					slot17.support_is_recruit = not RougeModel.instance:isInitHero(slot25)
				end

				if slot2:inTeam(slot10) then
					slot17.combat_is_recruit = not RougeModel.instance:isInitHero(slot10)
				end

				slot1[#slot1 + 1] = {
					hero_name = slot12.config.name,
					hero_level = slot12.level < slot13 and slot13 or slot12.level,
					hero_rank = slot12.rank < slot14 and slot14 or slot12.rank,
					breakthrough = slot12.exSkillLevel,
					talent = slot12.talent < slot15 and slot15 or slot12.talent,
					rationality_num = slot2:getHeroInfo(slot10) and slot22:getStressValue() or 0,
					EquipName = slot23.config.name,
					EquipLevel = slot23.level,
					equip_refine = slot23.refineLv,
					remaining_HP = slot2:getHeroHp(slot10) and slot24.life / 10 or 0
				}
			end
		end
	end

	return slot1
end

function slot0.getCoin(slot0)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	return slot1.coin
end

function slot0.getMedium(slot0)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	return slot1.power
end

function slot0.getTalentNameList(slot0)
	return slot0:getUnlockTalentNameList()
end

function slot0.getConsumeTalentPoint(slot0)
	return RougeTalentModel.instance:getHadConsumeTalentPoint()
end

function slot0.getBuildTalentLevel(slot0)
	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	return slot1.teamLevel
end

function slot0.getBuildTalentList(slot0)
	slot1 = {}

	if not RougeModel.instance:getRougeInfo() then
		return nil
	end

	for slot7, slot8 in ipairs(slot2.talentInfo) do
		if slot8 and slot8.isActive == 1 then
			table.insert(slot1, lua_rouge_style_talent.configDict[slot8.id].desc)
		end
	end

	return slot1
end

function slot0.getAssistList(slot0)
	slot1 = {}
	slot2 = {
		[slot9.heroId] = slot9.supportHeroId
	}

	for slot8, slot9 in ipairs(RougeModel.instance:getTeamInfo():getBattleHeroList()) do
		-- Nothing
	end

	if slot3:getAssistHeroMo() then
		slot7 = slot5.config
		slot8 = {}
		slot9 = 0
		slot10 = 0
		slot11 = 0

		if RougeHeroGroupBalanceHelper.getIsBalanceMode() then
			slot13, slot10, slot11 = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(slot5.heroId)
			slot9 = slot13 or 0
			slot10 = slot10 or 0
			slot11 = slot11 or 0
		end

		slot8.hero_name = slot7.name
		slot8.hero_level = slot5.level < slot9 and slot9 or slot5.level
		slot8.hero_rank = slot5.rank < slot10 and slot10 or slot5.rank
		slot8.breakthrough = slot5.exSkillLevel
		slot8.talent = slot5.talent < slot11 and slot11 or slot5.talent

		if slot5:hasDefaultEquip() then
			slot8.EquipName = slot16.config.name
			slot8.EquipLevel = slot16.level
			slot8.equip_refine = slot16.refineLv
		end

		slot8.remaining_HP = slot3:getHeroHp(slot6) and slot17.life / 10 or 0
		slot8.rationality_num = slot3:getHeroInfo(slot6) and slot18:getStressValue() or 0

		if slot3:getAssistTargetHero(slot6) then
			slot8.support_target_name = HeroConfig.instance:getHeroCO(slot19.heroId) and slot20.name or nil
			slot8.support_heroskill = lua_skill.configDict[slot3:getSupportSkill(slot6)] and slot22.name or nil
		elseif slot2[slot6] and slot20 ~= 0 then
			slot23 = lua_skill.configDict[slot3:getSupportSkill(slot20)]
			slot8.support_heroname = HeroConfig.instance:getHeroCO(slot20) and slot21.name or nil
			slot8.support_heroskill = slot23 and slot23.name or nil
			slot8.support_is_recruit = not RougeModel.instance:isInitHero(slot20)
		end

		slot1[#slot1 + 1] = slot8
	end

	return slot1
end

function slot0.getRougeResult(slot0, slot1)
	slot2 = nil

	if slot1 then
		if slot1 == uv0.EndResult.Close then
			slot2 = "主动返回退出"
		elseif slot1 == uv0.EndResult.Abort then
			slot2 = "重置"
		end
	else
		slot2 = RougeModel.instance:getEndId() and slot3 ~= 0 and "成功" or "失败"
	end

	return slot2
end

function slot0.getInterruptReason(slot0, slot1)
	slot2 = nil

	if slot1 then
		if slot1 == uv0.EndResult.Close then
			slot2 = "主动放弃探索"
		end
	elseif not RougeModel.instance:getEndId() or slot3 == 0 then
		slot5 = RougeMapModel.instance:getCurEvent() and slot4.id

		if slot0._failResult then
			if slot0._failResult == FightEnum.FightResult.Abort then
				slot2 = "战斗主动退出"

				if slot5 then
					slot2 = slot5 and slot2 .. slot5 or slot2 .. 0
				end
			elseif slot0._failResult == FightEnum.FightResult.Fail then
				slot2 = "战斗失败"

				if slot5 then
					slot2 = slot5 and slot2 .. slot5 or slot2 .. 0
				end
			end
		end
	end

	return slot2
end

function slot0.getCompletedEventNum(slot0)
	if not RougeModel.instance:getRougeResult() then
		return
	end

	if slot1.finishEventId and #slot1.finishEventId > 0 then
		return #slot1.finishEventId
	end
end

function slot0.getCompletedEventID(slot0)
	if not RougeModel.instance:getRougeResult() then
		return
	end

	if slot1.finishEventId and #slot1.finishEventId > 0 then
		return slot1.finishEventId
	end
end

function slot0.getCompletedEntrustId(slot0)
	if not RougeModel.instance:getRougeResult() then
		return
	end

	if slot1.finishEntrustId and #slot1.finishEntrustId > 0 then
		return slot1.finishEntrustId
	end
end

function slot0.getCompletedEntrustNum(slot0)
	if not RougeModel.instance:getRougeResult() then
		return
	end

	if slot1.finishEntrustId and #slot1.finishEntrustId > 0 then
		return #slot1.finishEntrustId
	end
end

function slot0.getCompletedLayers(slot0)
	if not RougeModel.instance:getRougeResult() then
		return
	end

	slot2, slot3 = slot1:getLayerCountAndScore()

	return slot2
end

function slot0.getRougePoints(slot0)
	if not RougeModel.instance:getRougeResult() then
		return 0
	end

	return slot1.finalScore
end

function slot0.getRougeRewardPoints(slot0)
	if not RougeModel.instance:getRougeResult() then
		return
	end

	return slot1.addPoint
end

function slot0.getRougeTalentPoints(slot0)
	if not RougeModel.instance:getRougeResult() then
		return 0
	end

	return slot1.addGeniusPoint
end

function slot0.getTotalDeathNum(slot0)
	if not RougeModel.instance:getRougeResult() then
		return 0
	end

	return slot1.deadNum
end

function slot0.getTotalReviveNum(slot0)
	if not RougeModel.instance:getRougeResult() then
		return 0
	end

	return slot1.reviveNum
end

function slot0.getCollectionConflateNum(slot0)
	if not RougeModel.instance:getRougeResult() then
		return 0
	end

	slot2 = 0

	if slot1:getCompositeCollectionIdAndCount() and #slot3 > 0 then
		for slot7, slot8 in ipairs(slot3) do
			if slot8 and slot8[2] then
				slot2 = slot2 + slot8[2]
			end
		end
	end

	return slot2
end

function slot0.getBadgeName(slot0)
	slot1 = {}
	slot2 = slot0:getSeason()

	if not RougeModel.instance:getRougeResult() then
		return
	end

	if slot3.badge2Score then
		for slot7, slot8 in pairs(slot3.badge2Score) do
			if RougeConfig.instance:getRougeBadgeCO(slot2, slot8[1]) and slot9.name then
				table.insert(slot1, slot9.name)
			end
		end
	end

	return slot1
end

function slot0.getUseTime(slot0)
	if slot0:checkIsReset() or not slot0.startTime then
		return 0
	end

	if slot0.startTime then
		slot1 = ServerTime.now() - slot0.startTime
	end

	return slot1
end

function slot0.getAdjustBackPackTime(slot0)
	if not slot0.startAdjustTime then
		return 0
	else
		return ServerTime.now() - slot0.startAdjustTime
	end
end

function slot0.getAdjustBackPack(slot0)
	return slot0._adjustbackpack and true or false
end

function slot0.getAllLimiterDesc(slot0)
	slot3 = RougeModel.instance:getRougeInfo() and slot2:getGameLimiterMo()

	for slot8, slot9 in ipairs(slot3 and slot3:getLimiterIds() or {}) do
		table.insert({}, RougeDLCConfig101.instance:getLimiterCo(slot9) and slot10.desc)
	end

	for slot9, slot10 in ipairs(slot3 and slot3:getLimiterBuffIds() or {}) do
		table.insert(slot1, RougeDLCConfig101.instance:getLimiterBuffCo(slot10) and slot11.desc)
	end

	return slot1
end

function slot0.getAddEmblemCount(slot0)
	slot2 = RougeModel.instance:getRougeResult() and slot1:getLimiterResultMo()

	return slot2 and slot2:getLimiterAddEmblem() or 0
end

slot0.instance = slot0.New()

return slot0
