-- chunkname: @modules/logic/survival/model/SurvivalDifficultyModel.lua

module("modules.logic.survival.model.SurvivalDifficultyModel", package.seeall)

local SurvivalDifficultyModel = class("SurvivalDifficultyModel", ListScrollModel)

function SurvivalDifficultyModel:refreshDifficulty()
	self.customDifficulty = self:loadCustomHard()
	self._customDifficultyDict = {}

	for i, v in ipairs(self.customDifficulty) do
		self._customDifficultyDict[v] = true
	end

	self.difficultyList = self:getDifficultyList()
	self.customDifficultyList = self:getCustomDifficultyList()
	self.customSelectIndex = 1

	local difficultyIndex = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SurvivalHardSelect, 1)

	difficultyIndex = math.min(#self.difficultyList, difficultyIndex)
	self.difficultyIndex = difficultyIndex
end

function SurvivalDifficultyModel:getDifficultyId()
	local diff = self.difficultyList[self.difficultyIndex]

	return diff and diff.id or 0
end

function SurvivalDifficultyModel:getCustomDifficulty()
	return self.customDifficulty
end

function SurvivalDifficultyModel:hasSelectCustomDifficulty()
	local list = self:getCustomDifficulty()

	return next(list) ~= nil
end

function SurvivalDifficultyModel:isCustomDifficulty()
	local difficultyId = self:getDifficultyId()

	return difficultyId == SurvivalConst.CustomDifficulty
end

function SurvivalDifficultyModel:changeDifficultyIndex(value)
	local animName
	local lastIsCustom = self:isCustomDifficulty()

	self.difficultyIndex = self.difficultyIndex + value

	if self.difficultyIndex < 1 then
		self.difficultyIndex = #self.difficultyList
	end

	if self.difficultyIndex > #self.difficultyList then
		self.difficultyIndex = 1
	end

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SurvivalHardSelect, self.difficultyIndex)

	local curIsCustom = self:isCustomDifficulty()

	if lastIsCustom and not curIsCustom then
		animName = "panel_out"
	elseif not lastIsCustom and curIsCustom then
		animName = "panel_in"
	elseif not lastIsCustom and not curIsCustom then
		animName = value > 0 and "switch_right" or "switch_left"
	end

	return animName
end

function SurvivalDifficultyModel:getArrowStatus()
	local left = self.difficultyIndex > 1
	local right = self.difficultyIndex < #self.difficultyList

	return left, right
end

function SurvivalDifficultyModel:getDifficultyList()
	local info = SurvivalModel.instance:getOutSideInfo()
	local list = {}

	for i, v in ipairs(lua_survival_hardness_mod.configList) do
		if v.optional == 1 and info:isUnlockDifficultyMod(v.id) then
			table.insert(list, v)
		end
	end

	table.sort(list, SortUtil.keyLower("id"))

	return list
end

function SurvivalDifficultyModel:getCustomDifficultyList()
	local list = {}

	for i, v in ipairs(lua_survival_hardness.configList) do
		if v.optional == 1 then
			if not list[v.type] then
				list[v.type] = {}
			end

			if not list[v.type][v.subtype] then
				list[v.type][v.subtype] = {}
			end

			table.insert(list[v.type][v.subtype], v)
		end
	end

	for type, typeList in pairs(list) do
		for subType, subList in pairs(typeList) do
			local levelMap = {}

			for _, config in ipairs(subList) do
				if levelMap[config.level] then
					logError(string.format("有相同等级的配置, type:%s subType:%s level:%s id:%s %s", type, subType, config.level, levelMap[config.level].id, config.id))
				end

				levelMap[config.level] = config
			end

			local newSubList = {}

			for level = 1, 5 do
				table.insert(newSubList, levelMap[level] or {})
			end

			typeList[subType] = newSubList
		end
	end

	return list
end

function SurvivalDifficultyModel:getDifficultyAssess()
	local list = self:getList()
	local assess = 0

	for _, v in pairs(list) do
		local hardId = v.hardId

		if hardId then
			local hardConfig = lua_survival_hardness.configDict[hardId]

			assess = assess + hardConfig.scoreRate
		end
	end

	local ret = 1 + assess * 0.001

	return ret
end

function SurvivalDifficultyModel:getDifficultyShowList()
	local list = {}
	local diffConfig = lua_survival_hardness_mod.configDict[self:getDifficultyId()]
	local hardness = string.splitToNumber(diffConfig.hardness, "#")

	if hardness then
		for _, hardId in pairs(hardness) do
			table.insert(list, {
				hardId = hardId
			})
		end
	end

	if self:isCustomDifficulty() then
		local hardness = self:getCustomDifficulty()

		if hardness then
			for _, hardId in pairs(hardness) do
				table.insert(list, {
					hardId = hardId
				})
			end
		end
	end

	return list
end

function SurvivalDifficultyModel:refreshDifficultyShowList()
	local list = self:getDifficultyShowList()
	local filterList = self:filterSameTypeHard(list, true)
	local dataList = {}

	for _, v in ipairs(filterList) do
		local hardConfig = lua_survival_hardness.configDict[v.hardId]

		if hardConfig.isShow == 0 then
			table.insert(dataList, v)
		end
	end

	local listCount = #dataList

	if listCount < 4 then
		for i = listCount + 1, 4 do
			table.insert(dataList, {})
		end
	end

	self:setList(dataList)
end

function SurvivalDifficultyModel:filterSameTypeHard(list)
	local dataList = {}
	local typeSubtypeMap = {}

	for i, v in ipairs(list) do
		local hardId = v.hardId

		if hardId then
			local hardConfig = lua_survival_hardness.configDict[hardId]

			if hardConfig then
				local key = string.format("%s_%s", hardConfig.type, hardConfig.subtype)

				if typeSubtypeMap[key] then
					local existingConfig = lua_survival_hardness.configDict[typeSubtypeMap[key].hardId]

					if hardConfig.level > existingConfig.level then
						typeSubtypeMap[key] = v
					end
				else
					typeSubtypeMap[key] = v
				end
			end
		end
	end

	for i, v in ipairs(list) do
		local hardId = v.hardId

		if hardId then
			local hardConfig = lua_survival_hardness.configDict[hardId]

			if hardConfig then
				local key = string.format("%s_%s", hardConfig.type, hardConfig.subtype)

				if typeSubtypeMap[key] and typeSubtypeMap[key].hardId == hardId then
					table.insert(dataList, v)
				end
			end
		end
	end

	return dataList
end

function SurvivalDifficultyModel:sendDifficultyChoose(callback, callbackobj)
	local difficultyId = self:getDifficultyId()

	if self:isCustomDifficulty() then
		local list = self:getDifficultyShowList()
		local dataList = self:filterSameTypeHard(list)
		local hardness = {}

		if dataList then
			local diffConfig = lua_survival_hardness_mod.configDict[self:getDifficultyId()]
			local hardIds = string.splitToNumber(diffConfig.hardness, "#")

			for _, v in pairs(dataList) do
				local hardId = v.hardId

				if hardId then
					local hardConfig = lua_survival_hardness.configDict[hardId]

					if hardConfig and hardConfig.optional == 1 and not tabletool.indexOf(hardIds, hardId) then
						table.insert(hardness, hardId)
					end
				end
			end
		end

		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(difficultyId, hardness, callback, callbackobj)
	else
		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(difficultyId, nil, callback, callbackobj)
	end
end

function SurvivalDifficultyModel:setCustomSelectIndex(index)
	if self.customSelectIndex == index then
		return
	end

	self.customSelectIndex = index

	return true
end

function SurvivalDifficultyModel:getCustomSelectIndex()
	return self.customSelectIndex
end

function SurvivalDifficultyModel:getCustomDifficultyAssess(index)
	local assess = 0
	local hardness = self:getCustomDifficulty()

	if hardness then
		for _, hardId in pairs(hardness) do
			local config = lua_survival_hardness.configDict[hardId]

			if config and config.type == index then
				assess = assess + config.level
			end
		end
	end

	return assess
end

function SurvivalDifficultyModel:isSelectCustomDifficulty(hardId)
	return self._customDifficultyDict[hardId] ~= nil
end

function SurvivalDifficultyModel:selectCustomDifficulty(hardId)
	local curConfig = lua_survival_hardness.configDict[hardId]
	local removeIndex, removeHard

	for i, v in ipairs(self.customDifficulty) do
		if v ~= hardId then
			local config = lua_survival_hardness.configDict[v]

			if curConfig.type == config.type and curConfig.subtype == config.subtype then
				removeIndex = i
				removeHard = v

				break
			end
		end
	end

	if removeIndex then
		self._customDifficultyDict[removeHard] = nil

		table.remove(self.customDifficulty, removeIndex)
	end

	if self:isSelectCustomDifficulty(hardId) then
		self._customDifficultyDict[hardId] = nil

		tabletool.removeValue(self.customDifficulty, hardId)
	else
		self._customDifficultyDict[hardId] = true

		table.insert(self.customDifficulty, hardId)
	end

	self:saveCustomHard()

	return true
end

function SurvivalDifficultyModel:saveCustomHard()
	local list = self:getCustomDifficulty()
	local key = string.format("%s_SurvivalCustomDifficulty", PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, table.concat(list, "#"))
end

function SurvivalDifficultyModel:loadCustomHard()
	local key = string.format("%s_SurvivalCustomDifficulty", PlayerModel.instance:getPlayinfo().userId)
	local localPos = PlayerPrefsHelper.getString(key)
	local hardList = {}

	if not string.nilorempty(localPos) then
		local info = SurvivalModel.instance:getOutSideInfo()
		local list = string.splitToNumber(localPos, "#")

		for _, hardId in ipairs(list) do
			local config = lua_survival_hardness.configDict[hardId]

			if config and config.optional == 1 and info:isUnlockDifficulty(hardId) then
				table.insert(hardList, hardId)
			end
		end
	end

	return hardList
end

SurvivalDifficultyModel.instance = SurvivalDifficultyModel.New()

return SurvivalDifficultyModel
