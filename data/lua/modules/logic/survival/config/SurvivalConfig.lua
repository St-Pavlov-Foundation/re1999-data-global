-- chunkname: @modules/logic/survival/config/SurvivalConfig.lua

module("modules.logic.survival.config.SurvivalConfig", package.seeall)

local SurvivalConfig = class("SurvivalConfig", BaseConfig)

function SurvivalConfig:onInit()
	self._allMapCo = {}
	self._allShelterCo = {}
	self.attrNameToId = {}
	self.npcIdToItemCo = {}
	self._npcConfigTags = {}
	self._npcConfigShowTags = {}
end

function SurvivalConfig:reInit()
	return
end

function SurvivalConfig:reqConfigNames()
	return {
		"survival_behavior",
		"survival_booster",
		"survival_building",
		"survival_equip_effect",
		"survival_const",
		"survival_map_group",
		"survival_shelter_intrude_fight",
		"survival_decree",
		"survival_equip",
		"survival_equip_found",
		"survival_equip_slot",
		"survival_fight",
		"survival_fight_level",
		"survival_found",
		"survival_hardness",
		"survival_hardness_mod",
		"survival_item",
		"survival_maintask",
		"survival_talent",
		"survival_map_group_mapping",
		"survival_mission",
		"survival_normaltask",
		"survival_npc",
		"survival_recruitment",
		"survival_report",
		"survival_search",
		"survival_shelter",
		"survival_shelter_invasion",
		"survival_shelter_invasion_fight",
		"survival_shelter_invasion_scheme",
		"survival_shelter_monster_act",
		"survival_storytask",
		"survival_subtask",
		"survival_tag",
		"survival_tag_type",
		"survival_talk",
		"survival_tree_desc",
		"survival_attr",
		"survival_shelter_intrude_scheme",
		"survival_recruit",
		"survival_reward",
		"survival_shop_item",
		"survival_end",
		"survival_equip_score",
		"survival_block",
		"survival_reputation",
		"survival_disaster",
		"survival_rain",
		"survival_maptarget",
		"survival_shop",
		"survival_shop_type"
	}
end

function SurvivalConfig:onConfigLoaded(configName, configTable)
	if configName == "survival_attr" then
		for _, v in ipairs(configTable.configList) do
			self.attrNameToId[v.flag] = v.id
		end
	elseif configName == "survival_item" then
		for _, v in ipairs(configTable.configList) do
			if v.type == SurvivalEnum.ItemType.NPC then
				local npcId = tonumber(v.effect) or 0

				self.npcIdToItemCo[npcId] = v
			end
		end
	elseif configName == "survival_fight" and isDebugBuild then
		for k, v in pairs(configTable.configList) do
			local battleCo = lua_battle.configDict[v.battleId]

			if not battleCo then
				logError("战斗ID不存在" .. tostring(v.battleId))
			elseif not string.nilorempty(battleCo.trialHeros) then
				logError("探索内战斗配置了试用角色 " .. v.id .. " >> " .. v.battleId)
			end
		end
	end
end

function SurvivalConfig:getBuildingConfig(buildingId, buildingLevel, notError)
	local dict = lua_survival_building.configDict[buildingId]
	local config = dict and dict[buildingLevel]

	if not config and not notError then
		logError(string.format("SurvivalConfig BuildingConfig is nil, buildingId:%s, buildingLevel:%s", buildingId, buildingLevel))
	end

	return config
end

function SurvivalConfig:getBuildingConfigByType(buildType)
	for _, v in ipairs(lua_survival_building.configList) do
		if v.type == buildType then
			return v
		end
	end
end

function SurvivalConfig:getMapConfig(mapId)
	if not self._allMapCo[mapId] then
		local data = addGlobalModule("modules.configs.survival.lua_survival_map_" .. tostring(mapId), "lua_survival_map_" .. tostring(mapId))
		local mapCo = SurvivalMapCo.New()

		mapCo:init(data)

		self._allMapCo[mapId] = mapCo
	end

	return self._allMapCo[mapId]
end

function SurvivalConfig:getCurShelterMapId()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local mapId = weekInfo and weekInfo.shelterMapId or 10001

	if mapId == 0 then
		mapId = 10001
	end

	return mapId
end

function SurvivalConfig:getShelterMapCo(id)
	local mapId = id or self:getCurShelterMapId()

	if not self._allShelterCo[mapId] then
		local data = addGlobalModule("modules.configs.survival.lua_survival_shelter_building_" .. tostring(mapId), "lua_survival_shelter_building_" .. tostring(mapId))

		self._allShelterCo[mapId] = SurvivalShelterMapCo.New()

		self._allShelterCo[mapId]:init(data)
	end

	return self._allShelterCo[mapId]
end

function SurvivalConfig:getConstValue(id)
	local constCo = lua_survival_const.configDict[id]

	if not constCo then
		return "", ""
	end

	return constCo.value, constCo.value2
end

function SurvivalConfig:getHighValueUnitSubTypes()
	if not self._highValueUnitSubType then
		local str = self:getConstValue(SurvivalEnum.ConstId.ShowEffectUnitSubTypes)

		self._highValueUnitSubType = string.splitToNumber(str, "#") or {}
	end

	return self._highValueUnitSubType
end

function SurvivalConfig:getTaskCo(moduleId, taskId)
	local taskCo

	if moduleId == SurvivalEnum.TaskModule.MainTask then
		taskCo = lua_survival_maintask.configDict[taskId]
	elseif moduleId == SurvivalEnum.TaskModule.SubTask then
		taskCo = lua_survival_subtask.configDict[taskId]
	elseif moduleId == SurvivalEnum.TaskModule.StoryTask then
		taskCo = lua_survival_storytask.configDict[taskId]
	elseif moduleId == SurvivalEnum.TaskModule.NormalTask then
		taskCo = lua_survival_normaltask.configDict[taskId]
	elseif moduleId == SurvivalEnum.TaskModule.MapMainTarget then
		taskCo = lua_survival_maptarget.configDict[taskId]
	end

	if not taskCo then
		logError(string.format("SurvivalConfig:getTaskCo taskCo is nil, moduleId:%s, taskId:%s", moduleId, taskId))
	end

	return taskCo
end

function SurvivalConfig:getShelterCfg()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local shelterMapId = weekInfo.shelterMapId

	return lua_survival_shelter.configDict[shelterMapId]
end

function SurvivalConfig:getShelterPlayerInitPos(shelterMapId)
	local config = lua_survival_shelter.configDict[shelterMapId]

	return config and config.position
end

function SurvivalConfig:getShelterIntrudeSchemeConfig(id)
	if id == nil then
		logError("SurvivalConfig:getShelterIntrudeSchemeConfig id is nil")
	end

	local config = lua_survival_shelter_intrude_scheme.configDict[id]

	if config == nil then
		logError("SurvivalConfig:getShelterIntrudeSchemeConfig config is nil, id:" .. tostring(id))
	end

	return config
end

function SurvivalConfig:getNpcConfigTag(npcId)
	if not self._npcConfigTags[npcId] then
		local npcCo = self:getNpcConfig(npcId)

		if npcCo == nil then
			return {}, {}
		end

		local tag = npcCo.tag
		local tags = string.splitToNumber(tag, "#") or {}

		self._npcConfigTags[npcId] = tags

		local showTags = {}

		for _, v in ipairs(tags) do
			local tagCo = lua_survival_tag.configDict[v]
			local hiddenStr = tagCo and tagCo.beHidden
			local isHide = false

			if not string.nilorempty(hiddenStr) then
				local arr = string.splitToNumber(hiddenStr, "#")

				for _, vv in ipairs(arr) do
					if tabletool.indexOf(tags, vv) then
						isHide = true

						break
					end
				end
			end

			if not isHide then
				table.insert(showTags, v)
			end
		end

		self._npcConfigShowTags[npcId] = showTags
	end

	return self._npcConfigTags[npcId], self._npcConfigShowTags[npcId]
end

function SurvivalConfig:getMonsterBuffConfigTag(monsterBuffId)
	return false
end

function SurvivalConfig:getDecreeCo(id)
	local config = lua_survival_decree.configDict[id]

	if config == nil then
		logError(string.format("decree config is nil id:%s", id))
	end

	return config
end

function SurvivalConfig:getTagCo(id)
	local config = lua_survival_tag.configDict[id]

	if config == nil then
		logError(string.format("tag config is nil id:%s", id))
	end

	return config
end

function SurvivalConfig:getSplitTag(tag)
	if string.nilorempty(tag) then
		return {}
	end

	local tags = string.splitToNumber(tag, "#")

	return tags
end

function SurvivalConfig:getRewardList()
	local list = {}

	for i, v in ipairs(lua_survival_reward.configList) do
		table.insert(list, v)
	end

	return list
end

function SurvivalConfig:saveLocalShelterEntityPosAndDir(shelterMapId, unitType, unitId, pos, dir)
	local key = self:getLocalShelterEntityPosKey(shelterMapId, unitType, unitId)

	PlayerPrefsHelper.setString(key, string.format("%s#%s#%s#%s", pos.q, pos.r, pos.s, dir))
end

function SurvivalConfig:getLocalShelterEntityPosAndDir(shelterMapId, unitType, unitId)
	local key = self:getLocalShelterEntityPosKey(shelterMapId, unitType, unitId)
	local localPos = PlayerPrefsHelper.getString(key)

	if string.nilorempty(localPos) then
		return
	end

	local posList = string.splitToNumber(localPos, "#")
	local pos = SurvivalHexNode.New(posList[1], posList[2], posList[3])
	local dir = posList[4] or SurvivalEnum.Dir.Right

	return pos, dir
end

function SurvivalConfig:getLocalShelterEntityPosKey(shelterMapId, unitType, unitId)
	local key = string.format("%s_shelter_entitypos_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, shelterMapId, unitType, unitId)

	return key
end

function SurvivalConfig:getNpcConfig(npcId, noError)
	local config = lua_survival_npc.configDict[npcId]

	if config == nil and not noError then
		logError(string.format("npc config is nil npcId:%s", npcId))
	end

	return config
end

function SurvivalConfig:getNpcRenown(npcId)
	if not self.npcRenown then
		self.npcRenown = {}
	end

	if not self.npcRenown[npcId] then
		local config = lua_survival_npc.configDict[npcId]

		if not string.nilorempty(config.renown) then
			self.npcRenown[npcId] = string.splitToNumber(config.renown, "#")
		end
	end

	return self.npcRenown[npcId]
end

function SurvivalConfig:getNpcReputationValue(npcId)
	local renown = self:getNpcRenown(npcId)
	local v = renown[2]
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	v = weekMo:getAttr(SurvivalEnum.AttrType.RenownChangeFix, v)

	return v
end

function SurvivalConfig:getReputationCfgById(id, level)
	local configDict = lua_survival_reputation.configDict

	return configDict[id][level]
end

function SurvivalConfig:getReputationCost(id, level)
	local configDict = lua_survival_reputation.configDict
	local cost = configDict[id][level + 1].cost

	return tonumber(cost)
end

function SurvivalConfig:getReputationMaxLevel(id)
	local configDict = lua_survival_reputation.configDict
	local t = configDict[id]
	local max = 0

	for i, v in pairs(t) do
		if max < i then
			max = i
		end
	end

	return max
end

function SurvivalConfig:getBuildReputationIcon(id, level)
	local configDict = lua_survival_reputation.configDict
	local cfg = configDict[id][level]

	return SurvivalUnitIconHelper.instance:getRelationIcon(cfg.type)
end

function SurvivalConfig:getShopFreeReward(id, level)
	if self.shopFreeReward == nil then
		self:_parsReputation()
	end

	return self.shopFreeReward[id][level]
end

function SurvivalConfig:_parsReputation()
	local configList = lua_survival_reputation.configList

	self.shopFreeReward = {}

	for i, cfg in ipairs(configList) do
		local reward = cfg.reward
		local itemStr = string.match(reward, "^item#(.+)$")

		if not string.nilorempty(itemStr) then
			local exchangeInfos = GameUtil.splitString2(itemStr, true, "&", ":")

			if self.shopFreeReward[cfg.id] == nil then
				self.shopFreeReward[cfg.id] = {}
			end

			self.shopFreeReward[cfg.id][cfg.lv] = exchangeInfos[1]
		end
	end
end

function SurvivalConfig:getReputationRedDotType(buildCfgId)
	if buildCfgId == 31011201 then
		return RedDotEnum.DotNode.SurvivalReputationShop_3119
	elseif buildCfgId == 31011202 then
		return RedDotEnum.DotNode.SurvivalReputationShop_3120
	elseif buildCfgId == 31011203 then
		return RedDotEnum.DotNode.SurvivalReputationShop_3121
	elseif buildCfgId == 31011204 then
		return RedDotEnum.DotNode.SurvivalReputationShop_3122
	end
end

function SurvivalConfig:getShopType(id)
	local shopCfg = lua_survival_shop.configDict[id]

	return shopCfg.type
end

function SurvivalConfig:getShopName(id)
	local shopCfg = lua_survival_shop.configDict[id]

	return shopCfg.name
end

function SurvivalConfig:getShopItemUnlock(id)
	if self.reputationShopItemUnlock == nil then
		self:_parseShopItem()
	end

	return self.reputationShopItemUnlock[id]
end

function SurvivalConfig:getShopItemsByLevel(reputationId, reputationLevel)
	if self.reputationShopLevelItems == nil then
		self:_parseShopItem()
	end

	return self.reputationShopLevelItems[reputationId][reputationLevel]
end

function SurvivalConfig:getReputationItemMaxLevel(reputationId)
	if self.reputationShopLevelItems == nil then
		self:_parseShopItem()
	end

	return #self.reputationShopLevelItems[reputationId]
end

function SurvivalConfig:_parseShopItem()
	self.reputationShopItemUnlock = {}
	self.reputationShopLevelItems = {}

	for i, cfg in ipairs(lua_survival_shop_item.configList) do
		if not string.nilorempty(cfg.unlock) then
			local info = string.split(cfg.unlock, "#")

			if info[1] == "reputation" then
				local id = tonumber(info[2])
				local level = tonumber(info[3])

				self.reputationShopItemUnlock[cfg.id] = {
					id = id,
					level = level
				}

				if self.reputationShopLevelItems[id] == nil then
					self.reputationShopLevelItems[id] = {}
				end

				if self.reputationShopLevelItems[id][level] == nil then
					self.reputationShopLevelItems[id][level] = {}
				end

				table.insert(self.reputationShopLevelItems[id][level], cfg)
			end
		end
	end
end

function SurvivalConfig:getShopTabConfigs()
	return lua_survival_shop_type.configList
end

function SurvivalConfig:getHardnessCfg()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local outSideInfo = SurvivalModel.instance:getOutSideInfo()
	local difficulty = weekInfo and weekInfo.difficulty or outSideInfo.currMod
	local config = lua_survival_hardness_mod.configDict[difficulty]

	return config
end

function SurvivalConfig:parseEquip()
	self.equipGroup = {}

	for i, v in ipairs(lua_survival_equip.configList) do
		local group = v.group

		if self.equipGroup[group] == nil then
			self.equipGroup[group] = {}
		end

		table.insert(self.equipGroup[group], v)
	end
end

function SurvivalConfig:getEquipByGroup(group)
	if self.equipGroup == nil then
		self:parseEquip()
	end

	return self.equipGroup[group]
end

SurvivalConfig.instance = SurvivalConfig.New()

return SurvivalConfig
