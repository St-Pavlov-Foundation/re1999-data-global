module("modules.logic.playercard.model.PlayerCardMO", package.seeall)

slot0 = pureTable("PlayerCardMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.userId = slot1
end

function slot0.updateInfo(slot0, slot1, slot2)
	slot0.playerInfo = slot2

	slot0:updateProgressSetting(slot1.progressSetting)
	slot0:updateBaseInfoSetting(slot1.baseSetting)
	slot0:updateHeroCover(slot1.heroCover)
	slot0:updateThemeId(slot1.themeId)
	slot0:updateCritter(slot1.critter)

	slot0.showAchievement = slot1.showAchievement
	slot0.roomCollection = slot1.roomCollection
	slot0.layerId = slot1.layerId
	slot0.weekwalkDeepLayerId = slot1.weekwalkDeepLayerId
	slot0.exploreCollection = slot1.exploreCollection
	slot0.rougeDifficulty = slot1.rougeDifficulty
	slot0.act128SSSCount = slot1.act128SSSCount
	slot0.achievementCount = slot1.achievementCount
	slot0.assistTimes = slot1.assistTimes
	slot0.heroCoverTimes = slot1.heroCoverTimes
	slot0.maxFaithHeroCount = slot1.maxFaithHeroCount
	slot0.totalCostPower = slot1.totalCostPower
	slot0.skinCount = slot1.skinCount
	slot0.towerLayer = slot1.towerLayer
	slot0.towerBossPassCount = slot1.towerBossPassCount
	slot0.maxLevelHero = slot1.heroMaxLevelCount
end

function slot0.updateThemeId(slot0, slot1)
	slot0.themeId = slot1
end

function slot0.updateProgressSetting(slot0, slot1)
	slot0.progressSettings = slot1
	slot0.progressSettingsDict = GameUtil.splitString2(slot1, true)

	slot0:setEmptyPosList()
end

function slot0.updateBaseInfoSetting(slot0, slot1)
	slot0.baseInfoSettings = slot1
	slot0.baseInfoSettingsDict = GameUtil.splitString2(slot1, true)

	slot0:setEmptyBaseInfoPosList()
end

function slot0.updateCritter(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")
	slot5 = slot2[3]
	slot0.critterUid = slot2[1]
	slot0.critterId = slot2[2]

	if not slot0.critterId then
		return
	end

	if slot5 == 1 then
		slot0.critterSkinId = CritterConfig.instance:getCritterMutateSkin(tonumber(slot0.critterId))
	else
		slot0.critterSkinId = CritterConfig.instance:getCritterNormalSkin(tonumber(slot0.critterId))
	end
end

function slot0.updateAchievement(slot0, slot1)
	slot0.showAchievement = slot1
end

function slot0.getShowAchievement(slot0)
	return slot0.showAchievement
end

function slot0.getSelectCritterUid(slot0)
	return slot0.critterUid
end

function slot0.setSelectCritterUid(slot0, slot1)
	slot0.critterUid = slot1
end

function slot0.updateHeroCover(slot0, slot1)
	slot0.heroCover = slot1
end

function slot0.getPlayerInfo(slot0)
	if not slot0.playerInfo and slot0:isSelf() then
		slot1 = PlayerModel.instance:getPlayinfo()
	end

	return slot1
end

function slot0.isSelf(slot0)
	return PlayerModel.instance:isPlayerSelf(slot0.userId)
end

function slot0.setSetting(slot0, slot1)
	return string.splitToNumber(slot1, "#")
end

function slot0.getProgressSetting(slot0)
	return slot0.progressSettingsDict
end

function slot0.setEmptyBaseInfoPosList(slot0)
	slot0.emptyBaseInfoPosList = {
		false,
		true,
		true,
		true
	}

	if slot0.baseInfoSettingsDict and #slot0.baseInfoSettingsDict > 0 then
		for slot4 = 1, 4 do
			for slot8, slot9 in ipairs(slot0.baseInfoSettingsDict) do
				if slot9[1] == slot4 then
					slot0.emptyBaseInfoPosList[slot4] = false
				end
			end
		end
	end
end

function slot0.getEmptyBaseInfoPosList(slot0)
	return slot0.emptyBaseInfoPosList
end

function slot0.setEmptyPosList(slot0)
	slot0.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if slot0.progressSettingsDict and #slot0.progressSettingsDict > 0 then
		for slot4 = 1, 5 do
			for slot8, slot9 in ipairs(slot0.progressSettingsDict) do
				if slot9[1] == slot4 then
					slot0.emptyPosList[slot4] = false
				end
			end
		end
	end
end

function slot0.getEmptyPosList(slot0)
	return slot0.emptyPosList
end

function slot0.setEmptyPosList(slot0)
	slot0.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if slot0.progressSettingsDict and #slot0.progressSettingsDict > 0 then
		for slot4 = 1, 5 do
			for slot8, slot9 in ipairs(slot0.progressSettingsDict) do
				if slot9[1] == slot4 then
					slot0.emptyPosList[slot4] = false
				end
			end
		end
	end
end

function slot0.getEmptyPosList(slot0)
	return slot0.emptyPosList
end

function slot0.getBaseInfoSetting(slot0)
	return slot0.baseInfoSettingsDict
end

function slot0.getCritter(slot0)
	return slot0.critterId, slot0.critterSkinId
end

function slot0.getMainHero(slot0, slot1)
	slot3 = string.splitToNumber(slot0.heroCover, "#")
	slot5 = slot3[2]
	slot6 = slot3[3] ~= 0

	if slot3[1] == -1 then
		if slot1 or not slot0._tempHeroId or not slot0._tempSkinId then
			slot8 = HeroModel.instance:getList()

			if slot8[math.random(#slot8)] then
				slot10 = {
					slot9.config.skinId
				}

				for slot14, slot15 in ipairs(slot9.skinInfoList) do
					table.insert(slot10, slot15.skin)
				end

				slot0._tempHeroId = slot9.heroId
				slot0._tempSkinId = slot10[math.random(#slot10)]
			end
		end

		return slot0._tempHeroId, slot0._tempSkinId, true, slot6
	else
		if not slot4 or slot4 == 0 or not HeroConfig.instance:getHeroCO(slot4) then
			slot4 = slot0:getDefaultHeroId()
			slot5 = nil
		end

		if (not slot5 or slot5 == 0) and slot4 and slot4 ~= 0 then
			slot5 = HeroConfig.instance:getHeroCO(slot4) and slot8.skinId
		end

		slot0._tempHeroId = slot4
		slot0._tempSkinId = slot5
	end

	return slot4, slot5, slot7, slot6
end

function slot0.getDefaultHeroId(slot0)
	if slot0:isSelf() then
		return CharacterSwitchListModel.instance:getMainHero()
	else
		return 3028
	end
end

function slot0.getThemeId(slot0)
	return slot0.themeId
end

function slot0.getProgressByIndex(slot0, slot1)
	if slot1 == PlayerCardEnum.LeftContent.RougeDifficulty then
		if slot0.rougeDifficulty > 0 then
			return RougeConfig1.instance:getDifficultyCOTitle(slot0.rougeDifficulty)
		else
			return -1
		end
	elseif slot1 == PlayerCardEnum.LeftContent.WeekWalkDeep then
		if slot0.weekwalkDeepLayerId > 0 and WeekWalkConfig.instance:getMapConfig(slot0.weekwalkDeepLayerId) and slot2.sceneId and lua_weekwalk_scene.configDict[slot2.sceneId] and slot3.typeName and slot3.name then
			return slot3.typeName .. slot3.name
		end

		return -1
	elseif slot1 == PlayerCardEnum.LeftContent.RoomCollection then
		return slot0.roomCollection
	elseif slot1 == PlayerCardEnum.LeftContent.ExploreCollection then
		return slot0.exploreCollection
	elseif slot1 == PlayerCardEnum.LeftContent.Act148SSSCount then
		if slot0.act128SSSCount > 0 then
			return luaLang("playercard_act128SSSCount") .. slot0.act128SSSCount
		else
			return -1
		end
	elseif slot1 == PlayerCardEnum.LeftContent.TowerLayer then
		if slot0.towerLayer > 0 then
			slot3 = string.splitToNumber(TowerConfig.instance:getPermanentEpisodeCo(slot0.towerLayer).episodeIds, "|")

			return DungeonConfig.instance:getEpisodeCO(slot3[#slot3]).name
		end

		return -1
	elseif slot1 == PlayerCardEnum.LeftContent.TowerBossPassCount then
		if slot0.towerBossPassCount > 0 then
			return luaLang("playercard_towerbosspasscount") .. slot0.towerBossPassCount
		else
			return -1
		end
	end
end

function slot0.getBaseInfoByIndex(slot0, slot1, slot2)
	if not slot0:getPlayerInfo() then
		return
	end

	if slot1 == PlayerCardEnum.RightContent.LoginDay then
		if slot2 then
			return slot3.totalLoginDays, luaLang("time_day")
		else
			return slot3.totalLoginDays .. luaLang("time_day")
		end
	elseif slot1 == PlayerCardEnum.RightContent.HeroCount then
		return slot0:getHeroCount()
	elseif slot1 == PlayerCardEnum.RightContent.CreatTime then
		return TimeUtil.timestampToString3(ServerTime.timeInLocal(slot3.registerTime / 1000))
	elseif slot1 == PlayerCardEnum.RightContent.AssitCount then
		return slot0.assistTimes or 0
	elseif slot1 == PlayerCardEnum.RightContent.CompleteConfidence then
		return slot0.maxFaithHeroCount or 0
	elseif slot1 == PlayerCardEnum.RightContent.MaxLevelHero then
		return slot0.maxLevelHero or 0
	elseif slot1 == PlayerCardEnum.RightContent.SkinCount then
		return slot0.skinCount or 0
	elseif slot1 == PlayerCardEnum.RightContent.TotalCostPower then
		if slot2 then
			return slot0.totalCostPower or 0, luaLang("NewPlayerCardView_activity_only")
		else
			return string.format(luaLang("NewPlayerCardView_activity"), slot4)
		end
	elseif slot1 == PlayerCardEnum.RightContent.HeroCoverTimes then
		if slot2 then
			return slot0.heroCoverTimes or 0, luaLang("NewPlayerCardView_times_only")
		else
			return string.format(luaLang("NewPlayerCardView_times"), slot4)
		end
	end
end

function slot0.getHeroCount(slot0)
	if not slot0:getPlayerInfo() then
		return
	end

	return slot1.heroRareNNCount + slot1.heroRareNCount + slot1.heroRareRCount + slot1.heroRareSRCount + slot1.heroRareSSRCount
end

function slot0.getHeroRarePercent(slot0)
	if not slot0:getPlayerInfo() then
		return nil
	end

	slot3 = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	slot4 = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	slot5 = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	slot6 = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)

	return math.min(HeroConfig.instance:getAnyOnlineRareCharacterCount(1) > 0 and slot1.heroRareNNCount / slot2 or 1, 1), math.min(slot3 > 0 and slot1.heroRareNCount / slot3 or 1, 1), math.min(slot4 > 0 and slot1.heroRareRCount / slot4 or 1, 1), math.min(slot5 > 0 and slot1.heroRareSRCount / slot5 or 1, 1), math.min(slot6 > 0 and slot1.heroRareSSRCount / slot6 or 1, 1)
end

return slot0
