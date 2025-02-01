module("modules.logic.season.model.Activity104Model", package.seeall)

slot0 = class("Activity104Model", ListScrollModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._activity104MoDic = {}
	slot0._getCardList = nil
end

function slot0.setActivity104Info(slot0, slot1)
	if not slot0._activity104MoDic[slot1.activityId] then
		slot0._activity104MoDic[slot1.activityId] = Activity104Mo.New()
	end

	slot0._activity104MoDic[slot1.activityId]:init(slot1)
end

function slot0.tryGetActivityInfo(slot0, slot1, slot2, slot3)
	if not slot0:getActivityInfo(slot1, true) then
		Activity104Rpc.instance:sendGet104InfosRequest(slot1, slot2, slot3)
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Season
		})
	end

	return slot4
end

function slot0.getActivityInfo(slot0, slot1, slot2)
	if not slot0._activity104MoDic[slot1] and not slot2 then
		-- Nothing
	end

	return slot3
end

function slot0.updateItemChange(slot0, slot1)
	if slot0:getActivityInfo(slot1.activityId or slot0:getCurSeasonId()) then
		slot3:updateItems(slot1)
	end
end

function slot0.updateActivity104Info(slot0, slot1)
	if not slot0:getActivityInfo(slot1.activityId) then
		return
	end

	slot2:reset(slot1)
	slot2:setBattleFinishLayer(slot1.layer)

	slot0.settleType = slot1.settleType
	slot0.curBattleRetail = slot1.retail
end

function slot0.enterAct104Battle(slot0, slot1, slot2)
	slot0:setBattleFinishLayer(slot2)
	DungeonFightController.instance:enterSeasonFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
end

function slot0.onStartAct104BattleReply(slot0, slot1)
	slot0:setBattleFinishLayer(slot1.layer)
	DungeonFightController.instance:enterSeasonFight(DungeonConfig.instance:getEpisodeCO(slot1.episodeId).chapterId, slot1.episodeId)
end

function slot0.setBattleFinishLayer(slot0, slot1)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	slot3:setBattleFinishLayer(slot1)
end

function slot0.getBattleFinishLayer(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot2:getBattleFinishLayer()
end

function slot0.getAllEpisodeMO(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot2.episodes
end

function slot0.getAllRetailMo(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot2.retails
end

function slot0.getLastRetails(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot2:getLastRetails()
end

function slot0.getAllItemMo(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot2.activity104Items
end

function slot0.getItemEquipUid(slot0, slot1)
	if slot1 == 0 then
		return 0
	end

	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	for slot7, slot8 in pairs(slot3.activity104Items) do
		if slot8.itemId == slot1 then
			return slot8.uid
		end
	end

	return 0
end

function slot0.getItemIdByUid(slot0, slot1)
	if slot1 == "0" then
		return 0
	end

	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	for slot7, slot8 in pairs(slot3.activity104Items) do
		if slot8.uid == slot1 then
			return slot8.itemId
		end
	end

	return 0
end

function slot0.getAllSpecialMo(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot2.specials
end

function slot0.getSeasonAllHeroGroup(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot2.heroGroupSnapshot
end

function slot0.isSeasonGMChapter(slot0, slot1)
	return (slot1 or DungeonModel.instance.curSendChapterId) == 9991
end

function slot0.isSeasonChapter(slot0)
	slot1 = slot0:getCurSeasonId()

	if not DungeonModel.instance.curSendEpisodeId or slot2 == 0 then
		return false
	end

	if DungeonConfig.instance:getEpisodeCO(slot2) and slot0:isSeasonEpisodeType(slot3.type) then
		return true
	end

	return false
end

function slot0.getEpisodeState(slot0, slot1)
	return slot0:getAllEpisodeMO()[slot1] and slot2[slot1].state or 0
end

function slot0.getCurSeasonId(slot0)
	return Activity104Enum.CurSeasonId
end

function slot0.isSeasonDataReady(slot0)
	return slot0:getActivityInfo(slot0:getCurSeasonId(), true) ~= nil
end

function slot0.getSeasonCurSnapshotSubId(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot2.heroGroupSnapshotSubId
end

function slot0.setSeasonCurSnapshotSubId(slot0, slot1, slot2)
	slot2 = slot2 or 1

	if not slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		return
	end

	slot3.heroGroupSnapshotSubId = slot2

	HeroSingleGroupModel.instance:setSingleGroup(slot0:getSnapshotHeroGroupBySubId(slot2))

	for slot9 = 1, #HeroSingleGroupModel.instance:getList() do
		slot5[slot9]:setAid(slot4.aidDict and slot4.aidDict[slot9])

		if slot4.trialDict and slot4.trialDict[slot9] then
			slot5[slot9]:setTrial(unpack(slot4.trialDict[slot9]))
		else
			slot5[slot9]:setTrial()
		end
	end
end

function slot0.getSnapshotHeroGroupBySubId(slot0, slot1)
	slot2 = slot0:getCurSeasonId()
	slot1 = slot1 or slot0:getSeasonCurSnapshotSubId(slot2)

	if not slot0:getActivityInfo(slot2) then
		return
	end

	return slot3:getSnapshotHeroGroupBySubId(slot1)
end

function slot0.setSnapshotByFightGroup(slot0, slot1, slot2, slot3)
	if not slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		return
	end

	if not slot4.heroGroupSnapshot[slot2] then
		slot4.heroGroupSnapshot[slot2] = {}
	end

	slot4.heroGroupSnapshot[slot2].heroList = {}

	for slot9, slot10 in ipairs(slot3.fightGroup.heroList) do
		table.insert(slot5.heroList, slot10)
	end

	for slot9, slot10 in ipairs(slot3.fightGroup.subHeroList) do
		table.insert(slot5.heroList, slot10)
	end

	slot5.clothId = slot3.fightGroup.clothId
	slot5.equips = {}

	for slot9, slot10 in ipairs(slot3.fightGroup.equips) do
		if slot5.equips[slot9 - 1] == nil then
			slot5.equips[slot9 - 1] = HeroGroupEquipMO.New()
		end

		slot5.equips[slot9 - 1]:init({
			index = slot9 - 1,
			equipUid = slot10.equipUid
		})
	end

	slot5.activity104Equips = {}

	for slot9, slot10 in ipairs(slot3.fightGroup.activity104Equips) do
		if slot5.activity104Equips[slot9 - 1] == nil then
			slot5.activity104Equips[slot9 - 1] = HeroGroupActivity104EquipMo.New()
		end

		slot5.activity104Equips[slot9 - 1]:init({
			index = slot9 - 1,
			equipUid = slot10.equipUid
		})
	end

	slot5:clearAidHero()
end

function slot0.getAllHeroGroupSnapshot(slot0, slot1)
	if not slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		return
	end

	return slot2.heroGroupSnapshot
end

function slot0.replaceHeroList(slot0, slot1, slot2, slot3)
	slot1 = slot1 or slot0:getCurSeasonId()
	slot2 = slot2 or slot0:getSeasonCurSnapshotSubId(slot1)

	if not slot0:getActivityInfo(slot1) then
		return
	end

	slot4.heroGroupSnapshot[slot2].heroList = slot3
end

function slot0.resetSnapshotHeroGroupEquip(slot0, slot1, slot2, slot3, slot4)
	slot1 = slot1 or slot0:getCurSeasonId()
	slot2 = slot2 or slot0:getSeasonCurSnapshotSubId(slot1)

	if not slot0:getActivityInfo(slot1) then
		return
	end

	for slot9, slot10 in pairs(slot5.heroGroupSnapshot[slot2].equips) do
		if slot10.index == slot3 then
			slot10.equipUid = slot4
		end
	end
end

function slot0.resetSnapshotHeroGroupHero(slot0, slot1, slot2, slot3, slot4)
	slot1 = slot1 or slot0:getCurSeasonId()
	slot2 = slot2 or slot0:getSeasonCurSnapshotSubId(slot1)

	if not slot0:getActivityInfo(slot1) then
		return
	end

	slot5.heroGroupSnapshot[slot2].heroList[slot3] = slot4
end

function slot0.getAct104CurLayer(slot0, slot1)
	if not slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) or not slot2.episodes then
		return 0, 1
	end

	slot4 = 1

	for slot8, slot9 in pairs(slot2.episodes) do
		if 1 <= slot9.layer and slot9.state == 1 then
			slot3 = SeasonConfig.instance:getSeasonEpisodeCo(slot1, slot9.layer + 1) and slot9.layer + 1 or slot9.layer
			slot4 = slot9.layer + 1
		end
	end

	return slot3, slot4
end

function slot0.isLayerPassed(slot0, slot1, slot2)
	if not slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) or not slot3.episodes then
		return false
	end

	for slot7, slot8 in pairs(slot3.episodes) do
		if slot8.layer == slot2 then
			return slot8.state == 1
		end
	end

	return false
end

function slot0.getAct104CurStage(slot0, slot1, slot2)
	return SeasonConfig.instance:getSeasonEpisodeCo(slot1 or slot0:getCurSeasonId(), slot2 or slot0:getAct104CurLayer()) and slot3.stage or 0
end

function slot0.getMaxLayer(slot0, slot1)
	if slot0:getAct104CurLayer(slot1 or slot0:getCurSeasonId()) <= 20 then
		return 20
	end

	for slot8, slot9 in pairs(SeasonConfig.instance:getSeasonEpisodeCos(slot1)) do
		if 0 < slot9.layer then
			slot4 = slot9.layer
		end
	end

	return slot4
end

function slot0.isSpecialOpen(slot0, slot1)
	if not slot0:isEnterSpecial(slot1 or slot0:getCurSeasonId()) then
		return false
	end

	if (SeasonConfig.instance:getSeasonConstCo(slot1, Activity104Enum.ConstEnum.SpecialOpenLayer) and slot3.value1) < slot0:getAct104CurLayer() then
		return true
	end

	return false
end

function slot0.isEnterSpecial(slot0, slot1)
	slot1 = slot1 or slot0:getCurSeasonId()

	if (SeasonConfig.instance:getSeasonConstCo(slot1, Activity104Enum.ConstEnum.SpecialOpenDayCount) and slot3.value1 - 1) * 86400 + ActivityModel.instance:getActStartTime(slot1) / 1000 <= ServerTime.now() then
		return true
	end

	return false
end

function slot0.isSeasonSlotUnlock(slot0, slot1, slot2, slot3)
	slot1 = slot1 or slot0:getCurSeasonId()
	slot2 = slot2 or slot0:getSeasonCurSnapshotSubId(slot1)

	if not slot0:getActivityInfo(slot1) then
		return
	end

	for slot9, slot10 in pairs(slot4.unlockEquipIndexs) do
		if slot10 ~= 9 and slot10 >= 4 * slot3 then
			return true
		end
	end

	return false
end

function slot0.isSeasonPosUnlock(slot0, slot1, slot2, slot3, slot4)
	slot1 = slot1 or slot0:getCurSeasonId()
	slot2 = slot2 or slot0:getSeasonCurSnapshotSubId(slot1)

	if not slot0:getActivityInfo(slot1) then
		return
	end

	for slot11, slot12 in pairs(slot5.unlockEquipIndexs) do
		if slot12 == (slot4 == 4 and 9 or slot4 + 1 + 4 * (slot3 - 1)) then
			return true
		end
	end

	return false
end

function slot0.isSeasonLayerSlotUnlock(slot0, slot1, slot2, slot3, slot4)
	slot2 = slot2 or slot0:getSeasonCurSnapshotSubId(slot1 or slot0:getCurSeasonId())
	slot5 = {}

	if slot3 > 1 then
		for slot9 = 2, slot3 do
			for slot15, slot16 in pairs(string.splitToNumber(SeasonConfig.instance:getSeasonEpisodeCo(slot0:getCurSeasonId(), slot9 - 1).unlockEquipIndex, "#")) do
				table.insert(slot5, slot16)
			end
		end
	end

	for slot9, slot10 in pairs(slot5) do
		if slot10 ~= 9 and slot10 >= 4 * slot4 then
			return true
		end
	end

	return false
end

function slot0.isSeasonLayerPosUnlock(slot0, slot1, slot2, slot3, slot4, slot5)
	slot2 = slot2 or slot0:getSeasonCurSnapshotSubId(slot1 or slot0:getCurSeasonId())
	slot6 = {}

	if slot3 > 1 then
		for slot10 = 2, slot3 do
			for slot16, slot17 in pairs(string.splitToNumber(SeasonConfig.instance:getSeasonEpisodeCo(slot0:getCurSeasonId(), slot10 - 1).unlockEquipIndex, "#")) do
				table.insert(slot6, slot17)
			end
		end
	end

	for slot11, slot12 in pairs(slot6) do
		if slot12 == (slot5 == 4 and 9 or slot5 + 1 + 4 * (slot4 - 1)) then
			return true
		end
	end

	return false
end

function slot0.getSeasonHeroGroupEquipId(slot0, slot1, slot2, slot3, slot4)
	if not slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		return 0
	end

	if slot5:getSnapshotHeroGroupBySubId(slot2) and slot6.activity104Equips[slot4] then
		slot7 = slot6.activity104Equips[slot4].equipUid[slot3]

		return slot0:getItemIdByUid(slot7), slot7
	end

	return 0
end

function slot0.getAct104Retails(slot0, slot1)
	if not slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		return
	end

	return slot2.retails
end

function slot0.replaceAct104Retails(slot0, slot1)
	if not slot0:getActivityInfo(slot1.actId or slot0:getCurSeasonId()) then
		return
	end

	slot3:replaceRetails(slot1.retails)

	slot3.retailStage = slot1.retailStage
end

function slot0.getRetailStage(slot0, slot1)
	if not slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		return
	end

	if slot2.retailStage == 0 then
		slot2.retailStage = slot0:getAct104CurStage(slot1)
	end

	return slot2.retailStage
end

function slot0.getRetailEpisodeTag(slot0, slot1)
	slot2 = ""

	for slot8, slot9 in pairs(SeasonConfig.instance:getSeasonRetailCos(slot0:getCurSeasonId())) do
		for slot15 = 1, #string.splitToNumber(slot9.retailEpisodeIdPool, "#") do
			if slot10[slot15] == slot1 then
				return string.split(slot9.enemyTag, "#")[slot15] or ""
			end
		end
	end

	return slot2
end

function slot0.getEpisodeRetail(slot0, slot1)
	if slot0:getActivityInfo(slot0:getCurSeasonId()) then
		for slot7, slot8 in pairs(slot3.retails) do
			if slot8.id == slot1 then
				return slot8
			end
		end
	end

	return {}
end

function slot0.isLastDay(slot0, slot1)
	return ActivityModel.instance:getRemainTime(slot1 or slot0:getCurSeasonId()) < 86400
end

function slot0.isAllSpecialLayerFinished(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) or not slot2.specials then
		return true
	end

	slot3 = slot0:getMaxSpecialLayer()

	for slot7, slot8 in pairs(slot2.specials) do
		if slot8.state == 0 then
			return false
		end
	end

	return true
end

function slot0.getAct104SpecialInitLayer(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) or not slot2.specials then
		return 0
	end

	if not next(slot2.specials) then
		return 1
	end

	for slot8, slot9 in pairs(slot2.specials) do
		if slot9.state == 0 then
			slot4 = math.min(slot9.layer, slot0:getMaxSpecialLayer())
		end
	end

	return slot4
end

function slot0.getMaxSpecialLayer(slot0)
	for slot6, slot7 in pairs(SeasonConfig.instance:getSeasonSpecialCos(slot0:getCurSeasonId())) do
		if 0 < slot7.layer then
			slot2 = slot7.layer
		end
	end

	return slot2
end

function slot0.isSpecialLayerPassed(slot0, slot1)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) or not slot3.specials then
		return false
	end

	for slot7, slot8 in pairs(slot3.specials) do
		if slot8.layer == slot1 then
			return slot8.state == 1
		end
	end

	return false
end

function slot0.isNewStage(slot0)
	slot1 = slot0:getAct104CurStage()

	if not SeasonConfig.instance:getSeasonEpisodeCo(slot0:getCurSeasonId(), slot0:getAct104CurLayer() - 1) then
		return false
	end

	return slot1 ~= slot3.stage
end

function slot0.isNextLayerNewStage(slot0, slot1)
	slot4 = SeasonConfig.instance:getSeasonEpisodeCo(slot0:getCurSeasonId(), slot1) and slot3.stage or 0

	if not SeasonConfig.instance:getSeasonEpisodeCo(slot0:getCurSeasonId(), slot1 + 1) then
		return false
	end

	return slot4 ~= slot5.stage
end

function slot0.isEpisodeAdvance(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1).type ~= DungeonEnum.EpisodeType.SeasonRetail then
		return false
	end

	for slot7, slot8 in pairs(slot0:getAct104Retails()) do
		if slot8.id == slot1 and slot8.advancedId ~= 0 and slot8.advancedRare ~= 0 then
			return true
		end
	end

	return false
end

function slot0.onReceiveGetUnlockActivity104EquipIdsReply(slot0, slot1)
	slot0:getActivityInfo(slot1.activityId):setUnlockActivity104EquipIds(slot1.unlockActivity104EquipIds)
end

function slot0.isNew104Equip(slot0, slot1)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return not slot2.unlockActivity104EquipIds[slot1]
end

function slot0.markActivityStory(slot0, slot1)
	if slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		slot2:markStory(true)
	end
end

function slot0.markEpisodeAfterStory(slot0, slot1, slot2)
	if slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		slot3:markEpisodeAfterStory(slot2)
	end
end

function slot0.isReadActivity104Story(slot0, slot1)
	return slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) and slot2.readActivity104Story
end

function slot0.isEpisodeAfterStory(slot0, slot1, slot2)
	if not slot0:getAllEpisodeMO(slot1) then
		return
	end

	return slot3[slot2] and slot3[slot2].readAfterStory
end

function slot0.canPlayStageLevelup(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 ~= 1 then
		return
	end

	if slot2 ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if slot3 then
		return
	end

	if slot0:isEpisodeAfterStory(slot4 or slot0:getCurSeasonId(), slot5) then
		return
	end

	if not slot0:isNextLayerNewStage(slot5) then
		return
	end

	return SeasonConfig.instance:getSeasonEpisodeCo(slot4, slot5 + 1) and slot6.stage
end

function slot0.canMarkFightAfterStory(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 ~= 1 then
		return
	end

	if slot2 ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if slot3 or not slot5 then
		return
	end

	if slot0:isEpisodeAfterStory(slot4 or slot0:getCurSeasonId(), slot5) then
		return
	end

	return true
end

function slot0.getOptionalAct104Equips(slot0, slot1)
	slot2 = {}

	if slot0:getActivityInfo(slot1 or slot0:getCurSeasonId()) then
		for slot7, slot8 in pairs(slot3.activity104Items) do
			if SeasonConfig.instance:getSeasonEquipCo(slot8.itemId) and slot9.isOptional == 1 then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

function slot0.addCardGetData(slot0, slot1)
	slot3 = SeasonViewHelper.getViewName(slot0:getCurSeasonId(), Activity104Enum.ViewName.CelebrityCardGetlView)

	for slot7 = 1, PopupController.instance._popupList:getSize() do
		if PopupController.instance._popupList._dataList[slot7][2] == slot3 then
			slot8 = PopupController.instance._popupList._dataList[slot7][3].data

			tabletool.addValues(slot8, slot1)

			PopupController.instance._popupList._dataList[slot7][3] = {
				is_item_id = true,
				data = slot8
			}

			return
		end
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, slot3, {
		is_item_id = true,
		data = slot1
	})
end

function slot0.setMakertLayerMark(slot0, slot1, slot2)
	slot1 = slot1 or slot0:getCurSeasonId()
	slot5 = {
		[slot11[1]] = slot11[2]
	}

	for slot9, slot10 in ipairs(string.split(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), ""), "|")) do
		if string.splitToNumber(slot10, "#") and slot11[1] then
			-- Nothing
		end
	end

	if not slot5[slot1] or slot5[slot1] < slot2 then
		slot5[slot1] = slot2
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		table.insert(slot6, string.format("%s#%s", slot10, slot11))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), table.concat(slot6, "|"))
end

function slot0.isCanPlayMakertLayerAnim(slot0, slot1, slot2)
	if not slot1 and not slot0:getCurSeasonId() or not slot2 then
		return
	end

	for slot8, slot9 in ipairs(string.split(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), ""), "|")) do
		if string.splitToNumber(slot9, "#") and slot10[1] == slot1 then
			return slot10[2] < slot2
		end
	end

	return true
end

function slot0.setGroupCardUnlockTweenPos(slot0, slot1, slot2)
	slot1 = slot1 or slot0:getCurSeasonId()

	for slot9, slot10 in ipairs(string.split(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), ""), "|")) do
		if string.splitToNumber(slot10, "#") and slot11[1] then
			if #slot11 > 1 then
				for slot15 = 2, #slot11 do
					slot5[slot11[1]][slot11[slot15]] = 1
				end
			end
		end
	end

	if not ({
		[slot11[1]] = {}
	})[slot1] then
		slot5[slot1] = {}
	end

	slot5[slot1][slot2] = 1
	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		slot12 = {
			slot10
		}

		for slot16, slot17 in pairs(slot11) do
			table.insert(slot12, slot16)
		end

		table.insert(slot6, table.concat(slot12, "#"))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), table.concat(slot6, "|"))
end

function slot0.isContainGroupCardUnlockTweenPos(slot0, slot1, slot2, slot3)
	if not SeasonConfig.instance:getSeasonEpisodeCo(slot1 or slot0:getCurSeasonId(), slot2) then
		return true
	end

	if not tabletool.indexOf(string.splitToNumber(slot4.unlockEquipIndex, "#"), slot3) then
		return true
	end

	for slot11, slot12 in ipairs(string.split(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), ""), "|")) do
		if string.splitToNumber(slot12, "#") and slot13[1] == slot1 then
			if #slot13 > 1 then
				for slot17 = 2, #slot13 do
					if slot13[slot17] == slot3 then
						return true
					end
				end
			end

			break
		end
	end

	return false
end

function slot0.caleStageEquipRareWeight(slot0, slot1)
	slot6 = 0
	slot8 = {}

	for slot12, slot13 in ipairs(string.split(SeasonConfig.instance:getSeasonRetailCo(slot0:getCurSeasonId(), slot1 or slot0:getAct104CurStage()).equipRareWeight, "|")) do
		if string.splitToNumber(slot13, "#") then
			slot5 = slot14[2] + 0

			if 0 < slot14[1] then
				slot7 = slot14[1]
				slot6 = slot14[2]
			end
		end
	end

	if slot5 == 0 then
		slot5 = 1
	end

	slot9 = 0

	for slot14, slot15 in pairs(SeasonConfig.instance:getSeasonOptionalEquipCos()) do
		if slot15.rare == slot7 then
			slot9 = slot15.equipId

			break
		end
	end

	return slot6 / slot5, slot7, slot9
end

function slot0.getStageEpisodeList(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot8, slot9 in pairs(SeasonConfig.instance:getSeasonEpisodeCos(slot0:getCurSeasonId())) do
			if slot9.stage == slot1 then
				table.insert(slot2, slot9)
			end
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0.layer < slot1.layer
		end)
	end

	return slot2
end

function slot0.getItemCount(slot0, slot1, slot2)
	if not slot0:getActivityInfo(slot2 or slot0:getCurSeasonId()) then
		return
	end

	return slot3:getItemCount(slot1)
end

function slot0.isSeasonEpisodeType(slot0, slot1)
	return slot1 == DungeonEnum.EpisodeType.Season or slot1 == DungeonEnum.EpisodeType.SeasonRetail or slot1 == DungeonEnum.EpisodeType.SeasonSpecial or slot1 == DungeonEnum.EpisodeType.SeasonTrial
end

function slot0.getRealHeroGroupBySubId(slot0, slot1)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	return slot3:getRealHeroGroupBySubId(slot1)
end

function slot0.getFightCardDataList(slot0)
	slot1 = FightModel.instance:getFightParam()

	return Activity104EquipItemListModel.instance:fiterFightCardDataList(slot1.activity104Equips, slot1.trialHeroList)
end

function slot0.buildHeroGroup(slot0)
	if not slot0:getActivityInfo(slot0:getCurSeasonId()) then
		return
	end

	slot2:buildHeroGroup()
end

function slot0.MarkPopSummary(slot0, slot1)
	if not slot0:getActivityInfo(slot1) then
		return
	end

	slot2:setIsPopSummary(false)
end

function slot0.getIsPopSummary(slot0, slot1)
	if not slot0:getActivityInfo(slot1) then
		return
	end

	return slot2:getIsPopSummary()
end

function slot0.getLastMaxLayer(slot0, slot1)
	if not slot0:getActivityInfo(slot1) then
		return
	end

	return slot2:getLastMaxLayer()
end

function slot0.getTrialId(slot0, slot1)
	if not slot0:getActivityInfo(slot1) then
		return
	end

	return slot2:getTrialId()
end

function slot0.getSeasonTrialPrefsKey(slot0)
	return string.format("%s_%s_%s", PlayerPrefsKey.SeasonHeroGroupTrial, PlayerModel.instance:getMyUserId(), slot0:getCurSeasonId())
end

slot0.instance = slot0.New()

return slot0
