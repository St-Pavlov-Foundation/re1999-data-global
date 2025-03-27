module("modules.logic.seasonver.act166.model.Season166Model", package.seeall)

slot0 = class("Season166Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._actInfo = {}
	slot0._battleContext = nil
	slot0.localPrefsDict = {}
	slot0._fightTalentData = {}
end

function slot0.setActInfo(slot0, slot1)
	if not slot0._actInfo[slot1.activityId] then
		slot0._actInfo[slot2] = Season166MO.New()
		slot0._curSeasonId = slot2
	end

	slot3:updateInfo(slot1)
end

function slot0.getActInfo(slot0, slot1)
	if not slot1 then
		return nil
	end

	return slot0._actInfo[slot1]
end

function slot0.getCurSeasonId(slot0)
	return slot0._curSeasonId
end

function slot0.setBattleContext(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._battleContext = Season166BattleContext.New()

	slot0._battleContext:init(slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0.getBattleContext(slot0, slot1)
	if not slot1 and not slot0._battleContext then
		logError("battleContext is nil")
	end

	return slot0._battleContext
end

function slot0.onReceiveAnalyInfo(slot0, slot1)
	if slot0:getActInfo(slot1.activityId) then
		slot2:updateAnalyInfoStage(slot1.infoId, slot1.stage)
	end
end

function slot0.onReceiveInformationBonus(slot0, slot1)
	if slot0:getActInfo(slot1.activityId) then
		slot2:onReceiveInformationBonus(slot1.bonusIds)
	end
end

function slot0.onReceiveInfoBonus(slot0, slot1)
	if slot0:getActInfo(slot1.activityId) then
		slot2:updateInfoBonus(slot1.infoId, slot1.bonusStage)
	end
end

function slot0.onReceiveUpdateInfos(slot0, slot1)
	if slot0:getActInfo(slot1.activityId) and slot2:updateInfos(slot1.updateInfos) then
		Season166Controller.instance:showToast(Season166Enum.ToastType.Info)
	end
end

function slot0.getTalentInfo(slot0, slot1, slot2)
	if slot0:getActInfo(slot1) then
		return slot3:getTalentMO(slot2)
	end
end

function slot0.onReceiveSetTalentSkill(slot0, slot1)
	Season166Controller.instance:dispatchEvent(Season166Event.SetTalentSkill, slot1.talentId, slot0:getActInfo(slot1.activityId):setTalentSkillIds(slot1.talentId, slot1.skillIds))
end

function slot0.onReceiveAct166TalentPush(slot0, slot1)
	if slot0:getActInfo(slot1.activityId) then
		slot2:updateTalentInfo(slot1.talents)
	end
end

function slot0.onReceiveAct166EnterBaseReply(slot0, slot1)
	if slot0:getActInfo(slot1.activityId) then
		slot2:setSpotBaseEnter(slot1.baseId, true)
	end
end

function slot0.onReceiveBattleFinishPush(slot0, slot1)
	if slot1.activityId ~= slot0._curSeasonId then
		logError("activityId mismatch")

		return
	end

	slot0.fightResult = slot1

	if slot0:getActInfo(slot1.activityId) and slot1.isHighestScore then
		slot2:updateMaxScore(slot1.episodeType, slot1.id, slot1.totalScore)
	end
end

function slot0.getFightResult(slot0)
	if not slot0.fightResult then
		logError("not receive 166BattleFinishPush")
	end

	return slot0.fightResult
end

function slot0.clearFightResult(slot0)
	slot0.fightResult = nil
end

function slot0.setPrefsTalent(slot0)
	PlayerPrefsHelper.setNumber(uv0.getKey(), slot0)
end

function slot0.getPrefsTalent()
	if PlayerPrefsHelper.getNumber(uv0.getKey(), 0) == 0 then
		return
	end

	return slot0
end

function slot0.getKey()
	slot0 = PlayerModel.instance:getMyUserId()

	if (uv0.instance:getCurSeasonId() or 0) == 0 then
		logError("赛季id为空,请检查")
	end

	return tostring(slot0) .. PlayerPrefsKey.Season166EquipTalentId .. slot1
end

function slot0.checkHasNewUnlockInfo(slot0)
	slot1 = slot0:getLocalUnlockState(Season166Enum.InforMainLocalSaveKey)

	if not slot0:getActInfo(slot0._curSeasonId) then
		return false
	end

	for slot7, slot8 in ipairs(Season166Config.instance:getSeasonInfos(slot0._curSeasonId)) do
		slot9 = slot2 and slot2:getInformationMO(slot8.infoId)

		if slot9 and (slot9 and Season166Enum.UnlockState or Season166Enum.LockState) ~= slot1[slot8.infoId] then
			return true
		end
	end

	return false
end

function slot0.getLocalUnlockState(slot0, slot1)
	for slot8, slot9 in ipairs(Season166Controller.instance:loadDictFromStr(Season166Controller.instance:getPlayerPrefs(slot1))) do
		slot10 = string.split(slot9, "|")
	end

	return {
		[tonumber(slot10[1])] = tonumber(slot10[2])
	}
end

function slot0.getCurUnlockTalentData(slot0, slot1)
	slot4 = {}

	for slot8, slot9 in ipairs(lua_activity166_talent_style.configDict[slot1]) do
		if slot9.level <= slot0:getTalentInfo(slot0._curSeasonId, slot1).level and slot9.needStar > 0 then
			table.insert(slot4, slot9)
		end
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot4) do
		for slot15, slot16 in ipairs(string.splitToNumber(slot10.skillId, "#")) do
			table.insert(slot5, slot16)
		end
	end

	return slot4, slot5
end

function slot0.getUnlockWithNotSelectTalents(slot0, slot1)
	slot2, slot3 = slot0:getCurUnlockTalentData(slot1)

	if tabletool.len(slot0:getTalentInfo(slot0._curSeasonId, slot1).skillIds) == 0 then
		return slot3
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot3) do
		for slot15, slot16 in ipairs(slot5) do
			if tabletool.indexOf(slot3, slot16) and slot16 ~= slot11 then
				table.insert(slot6, slot11)
			end
		end
	end

	return slot6
end

function slot0.getTalentLocalSaveKey(slot0, slot1)
	return string.format("%s_%s", Season166Enum.TalentLockSaveKey, slot1)
end

function slot0.checkHasNewTalent(slot0, slot1)
	for slot8, slot9 in ipairs(slot0:getUnlockWithNotSelectTalents(slot1)) do
		if slot0:getLocalUnlockState(slot0:getTalentLocalSaveKey(slot1))[slot9] ~= Season166Enum.UnlockState then
			return true
		end
	end

	return false
end

function slot0.checkAllHasNewTalent(slot0, slot1)
	for slot6, slot7 in pairs(lua_activity166_talent.configDict[slot1]) do
		if slot0:checkHasNewTalent(slot7.talentId) then
			return true
		end
	end

	return false
end

function slot0.checkIsBaseSpotEpisode(slot0)
	return slot0:getBattleContext() and slot1.baseId and slot1.baseId > 0
end

function slot0.checkCanShowSeasonTalent(slot0)
	slot1 = slot0:getBattleContext()

	if FightModel.instance:getFightParam() and slot2.episodeId and not Season166Controller.instance.isSeason166EpisodeType(DungeonConfig.instance:getEpisodeCO(slot2.episodeId).type) then
		return false
	end

	return slot1 and (slot1.baseId and slot1.baseId > 0 or slot1.trainId and slot1.trainId > 0)
end

function slot0.isTrainPass(slot0, slot1, slot2)
	if slot0:getActInfo(slot1) then
		return slot3:isTrainPass(slot2)
	end

	return false
end

function slot0.unpackFightReconnectData(slot0, slot1)
	if cjson.decode(slot1) then
		slot0:setFightTalentParam(slot2.talentId, slot2.talentSkillIds, slot2.talentLevel)
	end
end

function slot0.setFightTalentParam(slot0, slot1, slot2, slot3)
	slot0._fightTalentData = {
		talentId = slot1,
		talentSkillIds = {},
		talentLevel = slot3
	}

	for slot7, slot8 in ipairs(slot2) do
		table.insert(slot0._fightTalentData.talentSkillIds, slot8)
	end
end

function slot0.getFightTalentParam(slot0)
	return slot0._fightTalentData
end

function slot0.getLocalPrefsTab(slot0, slot1)
	if not slot0.localPrefsDict[slot1] then
		slot2 = {}

		if GameUtil.splitString2(Season166Controller.instance:getPlayerPrefs(slot1), true) then
			for slot8, slot9 in ipairs(slot4) do
				slot2[slot9[1]] = slot9[2]
			end
		end

		slot0.localPrefsDict[slot1] = slot2
	end

	return slot0.localPrefsDict[slot1]
end

function slot0.setLocalPrefsTab(slot0, slot1, slot2, slot3)
	if slot0:getLocalPrefsTab(slot1)[slot2] == slot3 then
		return
	end

	slot4[slot2] = slot3
	slot5 = {}

	for slot9, slot10 in pairs(slot4) do
		table.insert(slot5, string.format("%s#%s", slot9, slot10))
	end

	Season166Controller.instance:savePlayerPrefs(slot1, table.concat(slot5, "|"))
end

slot0.instance = slot0.New()

return slot0
