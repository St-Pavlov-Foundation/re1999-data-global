-- chunkname: @modules/logic/playercard/model/PlayerCardMO.lua

module("modules.logic.playercard.model.PlayerCardMO", package.seeall)

local PlayerCardMO = pureTable("PlayerCardMO")

function PlayerCardMO:init(userId)
	self.id = userId
	self.userId = userId
end

function PlayerCardMO:updateInfo(cardInfo, playerInfo)
	self.playerInfo = playerInfo

	self:updateProgressSetting(cardInfo.progressSetting)
	self:updateBaseInfoSetting(cardInfo.baseSetting)
	self:updateHeroCover(cardInfo.heroCover)
	self:updateThemeId(cardInfo.themeId)
	self:updateCritter(cardInfo.critter)

	self.showAchievement = cardInfo.showAchievement
	self.roomCollection = cardInfo.roomCollection
	self.layerId = cardInfo.layerId
	self.weekwalkDeepLayerId = cardInfo.weekwalkDeepLayerId
	self.exploreCollection = cardInfo.exploreCollection
	self.rougeDifficulty = cardInfo.rougeDifficulty
	self.act128SSSCount = cardInfo.act128SSSCount
	self.achievementCount = cardInfo.achievementCount
	self.assistTimes = cardInfo.assistTimes
	self.heroCoverTimes = cardInfo.heroCoverTimes
	self.maxFaithHeroCount = cardInfo.maxFaithHeroCount
	self.totalCostPower = cardInfo.totalCostPower
	self.skinCount = cardInfo.skinCount
	self.towerLayer = cardInfo.towerLayer
	self.towerBossPassCount = cardInfo.towerBossPassCount
	self.maxLevelHero = cardInfo.heroMaxLevelCount
	self.weekwalkVer2PlatinumCup = cardInfo.weekwalkVer2PlatinumCup
	self.towerLayerMetre = cardInfo.towerLayerMetre
	self.act128Level = cardInfo.act128Level

	self:setHeroCount(cardInfo.heroCount)
end

function PlayerCardMO:setHeroCount(heroCount)
	self._allHeroCount = heroCount
end

function PlayerCardMO:updateThemeId(themeId)
	self.themeId = themeId
end

function PlayerCardMO:updateProgressSetting(setting)
	self.progressSettings = setting
	self.progressSettingsDict = GameUtil.splitString2(setting, true)

	self:setEmptyPosList()
end

function PlayerCardMO:updateBaseInfoSetting(setting)
	self.baseInfoSettings = setting
	self.baseInfoSettingsDict = GameUtil.splitString2(setting, true)

	self:setEmptyBaseInfoPosList()
end

function PlayerCardMO:updateCritter(critter)
	local str = string.splitToNumber(critter, "#")
	local critterUid, critterId, isMute = str[1], str[2], str[3]

	self.critterUid = critterUid
	self.critterId = critterId

	if not self.critterId then
		return
	end

	if isMute == 1 then
		self.critterSkinId = CritterConfig.instance:getCritterMutateSkin(tonumber(self.critterId))
	else
		self.critterSkinId = CritterConfig.instance:getCritterNormalSkin(tonumber(self.critterId))
	end
end

function PlayerCardMO:updateAchievement(showAchievement)
	self.showAchievement = showAchievement
end

function PlayerCardMO:getShowAchievement()
	return self.showAchievement
end

function PlayerCardMO:getSelectCritterUid()
	return self.critterUid
end

function PlayerCardMO:setSelectCritterUid(uid)
	self.critterUid = uid
end

function PlayerCardMO:updateHeroCover(heroCover)
	self.heroCover = heroCover
end

function PlayerCardMO:getPlayerInfo()
	local info = self.playerInfo

	if not info and self:isSelf() then
		info = PlayerModel.instance:getPlayinfo()
	end

	return info
end

function PlayerCardMO:isSelf()
	return PlayerModel.instance:isPlayerSelf(self.userId)
end

function PlayerCardMO:setSetting(setting)
	local moList = string.splitToNumber(setting, "#")

	return moList
end

function PlayerCardMO:getProgressSetting()
	return self.progressSettingsDict
end

function PlayerCardMO:setEmptyBaseInfoPosList()
	self.emptyBaseInfoPosList = {
		false,
		true,
		true,
		true
	}

	if self.baseInfoSettingsDict and #self.baseInfoSettingsDict > 0 then
		for i = 1, 4 do
			for _, mo in ipairs(self.baseInfoSettingsDict) do
				if mo[1] == i then
					self.emptyBaseInfoPosList[i] = false
				end
			end
		end
	end
end

function PlayerCardMO:getEmptyBaseInfoPosList()
	return self.emptyBaseInfoPosList
end

function PlayerCardMO:setEmptyPosList()
	self.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if self.progressSettingsDict and #self.progressSettingsDict > 0 then
		for i = 1, 5 do
			for _, mo in ipairs(self.progressSettingsDict) do
				if mo[1] == i then
					self.emptyPosList[i] = false
				end
			end
		end
	end
end

function PlayerCardMO:getEmptyPosList()
	return self.emptyPosList
end

function PlayerCardMO:setEmptyPosList()
	self.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if self.progressSettingsDict and #self.progressSettingsDict > 0 then
		for i = 1, 5 do
			for _, mo in ipairs(self.progressSettingsDict) do
				if mo[1] == i then
					self.emptyPosList[i] = false
				end
			end
		end
	end
end

function PlayerCardMO:getEmptyPosList()
	return self.emptyPosList
end

function PlayerCardMO:getBaseInfoSetting()
	return self.baseInfoSettingsDict
end

function PlayerCardMO:getCritter()
	return self.critterId, self.critterSkinId
end

function PlayerCardMO:getMainHero(random)
	local mainHeroParam = self.heroCover
	local mainHeros = string.splitToNumber(mainHeroParam, "#")
	local heroId = mainHeros[1]
	local skinId = mainHeros[2]
	local isL2d = mainHeros[3] ~= 0
	local isRandom = heroId == -1

	if isRandom then
		if random or not self._tempHeroId or not self._tempSkinId then
			local heroList = HeroModel.instance:getList()
			local heroMO = heroList[math.random(#heroList)]

			if heroMO then
				local skinList = {
					heroMO.config.skinId
				}

				for _, skinInfo in ipairs(heroMO.skinInfoList) do
					table.insert(skinList, skinInfo.skin)
				end

				self._tempHeroId = heroMO.heroId
				self._tempSkinId = skinList[math.random(#skinList)]
			end
		end

		return self._tempHeroId, self._tempSkinId, true, isL2d
	else
		if not heroId or heroId == 0 or not HeroConfig.instance:getHeroCO(heroId) then
			heroId = self:getDefaultHeroId()
			skinId = nil
		end

		if (not skinId or skinId == 0) and heroId and heroId ~= 0 then
			local config = HeroConfig.instance:getHeroCO(heroId)

			skinId = config and config.skinId
		end

		self._tempHeroId = heroId
		self._tempSkinId = skinId
	end

	return heroId, skinId, isRandom, isL2d
end

function PlayerCardMO:getDefaultHeroId()
	if self:isSelf() then
		return CharacterSwitchListModel.instance:getMainHero()
	else
		local defaultHeroId = 3028

		return defaultHeroId
	end
end

function PlayerCardMO:getThemeId()
	local themeId = self.themeId

	return themeId
end

function PlayerCardMO:getProgressByIndex(index)
	if index == PlayerCardEnum.LeftContent.RougeDifficulty then
		if self.rougeDifficulty > 0 then
			return RougeConfig1.instance:getDifficultyCOTitle(self.rougeDifficulty)
		else
			return -1
		end
	elseif index == PlayerCardEnum.LeftContent.WeekWalkDeep then
		if self.weekwalkDeepLayerId > 0 then
			local mapco = WeekWalkConfig.instance:getMapConfig(self.weekwalkDeepLayerId)

			if mapco and mapco.sceneId then
				local co = lua_weekwalk_scene.configDict[mapco.sceneId]

				if co and co.typeName and co.name then
					return co.typeName .. co.name
				end
			end
		end

		return -1
	elseif index == PlayerCardEnum.LeftContent.RoomCollection then
		return self.roomCollection
	elseif index == PlayerCardEnum.LeftContent.ExploreCollection then
		return self.exploreCollection
	elseif index == PlayerCardEnum.LeftContent.Act148SSSCount then
		if self.act128SSSCount > 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_act128SSSCount"), self.act128SSSCount)
		else
			return -1
		end
	elseif index == PlayerCardEnum.LeftContent.TowerLayer then
		if self.towerLayer > 0 then
			if self.towerLayerMetre <= 500 then
				local towerco = TowerConfig.instance:getPermanentEpisodeCo(self.towerLayer)
				local temp = string.splitToNumber(towerco.episodeIds, "|")
				local curMaxPassEpisodeId = temp[#temp]
				local episodeConfig = DungeonConfig.instance:getEpisodeCO(curMaxPassEpisodeId)

				return episodeConfig.name
			else
				local co = TowerConfig.instance:getTowerPermanentTimeCo(PlayerCardEnum.TowerMaxStageId)
				local name = co and co.name
				local txt = name .. self.towerLayerMetre .. "M"

				return txt
			end
		end

		return -1
	elseif index == PlayerCardEnum.LeftContent.TowerBossPassCount then
		if self.towerBossPassCount > 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_towerbosspasscount"), self.towerBossPassCount)
		else
			return -1
		end
	elseif index == PlayerCardEnum.LeftContent.WeekwalkVer2PlatinumCup then
		if self.weekwalkVer2PlatinumCup >= 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_weekwalkVer2PlatinumCup"), self.weekwalkVer2PlatinumCup)
		else
			return -1
		end
	elseif index == PlayerCardEnum.LeftContent.Act128Level then
		if self.act128Level >= 0 then
			return luaLang("playercard_Act128Level") .. self.act128Level
		else
			return -1
		end
	end
end

function PlayerCardMO:getBaseInfoByIndex(index, returndesc)
	local info = self:getPlayerInfo()

	if not info then
		return
	end

	if index == PlayerCardEnum.RightContent.LoginDay then
		if returndesc then
			return info.totalLoginDays, luaLang("time_day")
		else
			local str = luaLang("time_day")

			return info.totalLoginDays .. str
		end
	elseif index == PlayerCardEnum.RightContent.HeroCount then
		return self:getHeroCount()
	elseif index == PlayerCardEnum.RightContent.CreatTime then
		local time = TimeUtil.timestampToString3(ServerTime.timeInLocal(info.registerTime / 1000))

		return time
	elseif index == PlayerCardEnum.RightContent.AssitCount then
		return self.assistTimes or 0
	elseif index == PlayerCardEnum.RightContent.CompleteConfidence then
		return self.maxFaithHeroCount or 0
	elseif index == PlayerCardEnum.RightContent.MaxLevelHero then
		return self.maxLevelHero or 0
	elseif index == PlayerCardEnum.RightContent.SkinCount then
		return self.skinCount or 0
	elseif index == PlayerCardEnum.RightContent.TotalCostPower then
		local count = self.totalCostPower or 0

		if returndesc then
			return count, luaLang("NewPlayerCardView_activity_only")
		else
			return string.format(luaLang("NewPlayerCardView_activity"), count)
		end
	elseif index == PlayerCardEnum.RightContent.HeroCoverTimes then
		local count = self.heroCoverTimes or 0

		if returndesc then
			return count, luaLang("NewPlayerCardView_times_only")
		else
			return string.format(luaLang("NewPlayerCardView_times"), count)
		end
	end
end

function PlayerCardMO:getHeroCount()
	return self._allHeroCount or 0
end

function PlayerCardMO:getTowerLayerMetre()
	return self.towerLayerMetre or 0
end

function PlayerCardMO:getHeroRarePercent()
	local info = self:getPlayerInfo()

	if not info then
		return nil
	end

	local AllRareNNHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(1)
	local AllRareNHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	local AllRareRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	local AllRareSRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	local AllRareSSRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)
	local heroRareNNPercent = math.min(AllRareNNHeroCount > 0 and info.heroRareNNCount / AllRareNNHeroCount or 1, 1)
	local heroRareNPercent = math.min(AllRareNHeroCount > 0 and info.heroRareNCount / AllRareNHeroCount or 1, 1)
	local heroRareRPercent = math.min(AllRareRHeroCount > 0 and info.heroRareRCount / AllRareRHeroCount or 1, 1)
	local heroRareSRPercent = math.min(AllRareSRHeroCount > 0 and info.heroRareSRCount / AllRareSRHeroCount or 1, 1)
	local heroRareSSRPercent = math.min(AllRareSSRHeroCount > 0 and info.heroRareSSRCount / AllRareSSRHeroCount or 1, 1)

	return heroRareNNPercent, heroRareNPercent, heroRareRPercent, heroRareSRPercent, heroRareSSRPercent
end

return PlayerCardMO
