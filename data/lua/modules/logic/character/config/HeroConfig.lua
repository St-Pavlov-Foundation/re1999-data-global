-- chunkname: @modules/logic/character/config/HeroConfig.lua

module("modules.logic.character.config.HeroConfig", package.seeall)

local HeroConfig = class("HeroConfig", BaseConfig)

function HeroConfig:ctor()
	self.heroConfig = nil
	self.attributeConfig = nil
	self.battleTagConfig = nil
	self.friendLessConfig = nil
	self.talent_cube_attr_config = nil
	self.maxFaith = 0
end

function HeroConfig:reqConfigNames()
	return {
		"character",
		"character_attribute",
		"character_battle_tag",
		"friendless",
		"talent_cube_attr",
		"hero_trial",
		"hero_trial_attr",
		"hero_group_type",
		"character_limited",
		"character_rank_replace"
	}
end

function HeroConfig:onConfigLoaded(configName, configTable)
	if configName == "character" then
		self.heroConfig = configTable
	elseif configName == "character_attribute" then
		self.attributeConfig = configTable

		self:processAttrConfig()
	elseif configName == "character_battle_tag" then
		self.battleTagConfig = configTable
	elseif configName == "friendless" then
		self.friendLessConfig = configTable

		for index = 1, #self.friendLessConfig.configDict do
			self.maxFaith = self.maxFaith + self.friendLessConfig.configDict[index].friendliness
		end
	elseif configName == "talent_cube_attr" then
		self.talent_cube_attr_config = configTable
	elseif configName == "hero_group_type" then
		self.heroGroupTypeDict = {}

		for _, v in pairs(configTable.configList) do
			local arr = string.splitToNumber(v.chapterIds, "#") or {}

			for _, chapterId in pairs(arr) do
				self.heroGroupTypeDict[chapterId] = v
			end
		end
	elseif configName == "hero_trial" then
		self.heroTrialConfig = configTable.configDict
	elseif configName == "character_rank_replace" then
		self.heroRankReplaceConfig = configTable.configDict
	end
end

function HeroConfig:getTrial104Equip(slot, trialId, template)
	template = template or 0

	local trialCo = self.heroTrialConfig[trialId] and self.heroTrialConfig[trialId][template]

	if trialCo then
		return trialCo["act104EquipId" .. tostring(slot)]
	end
end

function HeroConfig:getHeroCO(id)
	return self.heroConfig.configDict[id]
end

function HeroConfig:getHeroGroupTypeCo(chapterId)
	if not chapterId then
		return
	end

	return self.heroGroupTypeDict[chapterId] or lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Activity]
end

function HeroConfig:getHeroAttributesCO()
	return self.attributeConfig.configDict
end

function HeroConfig:getHeroAttributeCO(id)
	return self.attributeConfig.configDict[id]
end

function HeroConfig:getBattleTagConfigCO(id)
	return self.battleTagConfig.configDict[id]
end

function HeroConfig:getTalentCubeAttrConfig(id, level)
	return self.talent_cube_attr_config.configDict[id][level]
end

function HeroConfig:getTalentCubeMaxLevel(id)
	if not self.max_talent_level_dic then
		self.max_talent_level_dic = {}
	end

	if self.max_talent_level_dic[id] then
		return self.max_talent_level_dic[id]
	end

	local level = 0

	for k, v in pairs(self.talent_cube_attr_config.configDict[id]) do
		if level <= v.level then
			level = v.level
		end
	end

	self.max_talent_level_dic[id] = level

	return level
end

function HeroConfig:getAnyRareCharacterCount(rare)
	local heros = self.heroConfig.configDict
	local count = 0

	for _, v in pairs(heros) do
		if v.rare == rare then
			count = count + 1
		end
	end

	return count
end

function HeroConfig:getAnyOnlineRareCharacterCount(rare, stat)
	local count = 0
	local allStat = CharacterEnum.StatType.All

	stat = stat or CharacterEnum.StatType.Normal

	for _, v in pairs(self.heroConfig.configDict) do
		if v.rare == rare and (stat == allStat or v.stat == stat) then
			if v.isOnline == "1" then
				count = count + 1
			elseif v.isOnline ~= "0" and TimeUtil.stringToTimestamp(v.isOnline) < ServerTime.now() then
				count = count + 1
			end
		end
	end

	return count
end

function HeroConfig:getFaithPercent(faith)
	if faith >= self.maxFaith then
		return {
			1,
			0
		}
	end

	local tempFaith = 0
	local percent = 0
	local nextFaith = 0

	for index = 1, #self.friendLessConfig.configDict do
		tempFaith = tempFaith + self.friendLessConfig.configDict[index].friendliness

		if faith <= tempFaith then
			if tempFaith == faith then
				percent = self.friendLessConfig.configDict[index].percentage
				nextFaith = self.friendLessConfig.configDict[index + 1].friendliness

				break
			end

			percent = self.friendLessConfig.configDict[index - 1].percentage
			nextFaith = tempFaith - faith

			break
		end
	end

	return {
		percent / 100,
		nextFaith
	}
end

function HeroConfig:getMaxRank(rare)
	if rare <= 3 then
		return 2
	else
		return 3
	end
end

function HeroConfig:getLevelUpItems(heroId, fromLevel, toLevel)
	local items = {}
	local heroConfig = self:getHeroCO(heroId)

	for level = fromLevel + 1, toLevel do
		local cosumeConfig = SkillConfig.instance:getcosumeCO(level, heroConfig.rare)
		local cosume = cosumeConfig.cosume
		local params = string.split(cosume, "|")

		for i = 1, #params do
			local param = string.split(params[i], "#")

			if not items[i] then
				local item = {}

				item.type = tonumber(param[1])
				item.id = tonumber(param[2])
				item.quantity = tonumber(param[3])
				item.name = ""
				items[i] = item
			else
				items[i].quantity = items[i].quantity + tonumber(param[3])
			end
		end
	end

	return items
end

function HeroConfig:getShowLevel(level)
	if not self._rankMaxLevels then
		local rankLevelParam = CommonConfig.instance:getConstStr(ConstEnum.RankMaxLevel)

		self._rankMaxLevels = string.splitToNumber(rankLevelParam, "#")
	end

	local one

	for i = #self._rankMaxLevels, 1, -1 do
		one = self._rankMaxLevels[i]

		if one < level then
			return level - one, i + 1
		end
	end

	return level, 1
end

function HeroConfig:getCommonLevelDisplay(level)
	local showLevel, rank = self:getShowLevel(level)

	if rank == 1 then
		return string.format(luaLang("rank_level_display1"), showLevel)
	elseif rank == 2 then
		return string.format(luaLang("rank_level_display2"), showLevel)
	elseif rank == 3 then
		return string.format(luaLang("rank_level_display3"), showLevel)
	elseif rank == 4 then
		return string.format(luaLang("rank_level_display4"), showLevel)
	else
		return string.format(luaLang("rank_level_display1"), showLevel)
	end
end

function HeroConfig:getLevelDisplayVariant(level)
	if level == 0 then
		return luaLang("hero_display_level0_variant")
	end

	local showLevel, rank = self:getShowLevel(level)

	if rank == 1 then
		return string.format(luaLang("rank_level_display1"), showLevel)
	elseif rank == 2 then
		return string.format(luaLang("rank_level_display2"), showLevel)
	elseif rank == 3 then
		return string.format(luaLang("rank_level_display3"), showLevel)
	elseif rank == 4 then
		return string.format(luaLang("rank_level_display4"), showLevel)
	else
		return string.format(luaLang("rank_level_display1"), showLevel)
	end
end

function HeroConfig:processAttrConfig()
	self.attrConfigByAttrType = {}

	for k, v in pairs(self.attributeConfig.configDict) do
		self.attrConfigByAttrType[v.attrType] = v.id
	end

	self.attrConfigByAttrType.atk = 102
	self.attrConfigByAttrType.def = 103
	self.attrConfigByAttrType.mdef = 104
	self.attrConfigByAttrType.cri_dmg = 203
	self.attrConfigByAttrType.cri_def = 204
	self.attrConfigByAttrType.add_dmg = 205
	self.attrConfigByAttrType.drop_dmg = 206
end

function HeroConfig:getIDByAttrType(attr_type)
	return self.attrConfigByAttrType[attr_type]
end

function HeroConfig:getAttrTypeByID(id)
	return self.attributeConfig.configDict[id] and self.attributeConfig.configDict[id].attrType
end

function HeroConfig:talentGainTab2IDTab(gain_tab)
	local tab = {}

	for k, v in pairs(gain_tab) do
		local id = self:getIDByAttrType(k)

		tab[id] = {}
		tab[id].config_id = id
		tab[id].id = id
		tab[id].value = v.value
	end

	return tab
end

function HeroConfig:getHeroesList()
	local heroList = {}
	local allSplitCharacterIds = ResSplitConfig.instance:getAllCharacterIds()
	local isVerifing = VersionValidator.instance:isInReviewing()

	for _, heroCo in ipairs(self.heroConfig.configList) do
		if tonumber(heroCo.isOnline) == 1 and (isVerifing == false or allSplitCharacterIds[heroCo.id]) then
			table.insert(heroList, heroCo)
		end
	end

	return heroList
end

function HeroConfig:getHeroesByType(heroType)
	local heroList = {}
	local allSplitCharacterIds = ResSplitConfig.instance:getAllCharacterIds()
	local isVerifing = VersionValidator.instance:isInReviewing()

	for _, heroCo in ipairs(self.heroConfig.configList) do
		if tonumber(heroCo.isOnline) == 1 and heroCo.heroType == heroType and (isVerifing == false or allSplitCharacterIds[heroCo.id]) then
			table.insert(heroList, heroCo)
		end
	end

	return heroList
end

function HeroConfig.sortAttr(item1, item2)
	return HeroConfig.instance:getIDByAttrType(item1.key or item1.attrType) < HeroConfig.instance:getIDByAttrType(item2.key or item2.attrType)
end

local sortHeightForEquipView = {
	mdef = 4,
	def = 3,
	hp = 2,
	atk = 1
}

function HeroConfig.sortAttrForEquipView(item1, item2)
	return sortHeightForEquipView[item1.attrType] < sortHeightForEquipView[item2.attrType]
end

function HeroConfig:getHeroAttrRate(hero_id, arrtType)
	local lv_config = SkillConfig.instance:getherolevelCO(hero_id, 1)

	for i, v in ipairs(lua_character_grow.configList) do
		if lv_config[arrtType] < v[arrtType] then
			return v.id - 1 == 0 and 1 or v.id - 1
		end
	end

	return lua_character_grow.configList[#lua_character_grow.configList].id
end

function HeroConfig:getHeroRankReplaceConfig(heroId)
	return self.heroRankReplaceConfig[heroId]
end

HeroConfig.instance = HeroConfig.New()

return HeroConfig
