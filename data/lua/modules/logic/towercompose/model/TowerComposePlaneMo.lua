-- chunkname: @modules/logic/towercompose/model/TowerComposePlaneMo.lua

module("modules.logic.towercompose.model.TowerComposePlaneMo", package.seeall)

local TowerComposePlaneMo = class("TowerComposePlaneMo", TowerComposePlaneMo)

function TowerComposePlaneMo:ctor(params)
	self.themeId = params.themeId
	self.level = 0
	self.modInfoMap = {}
	self.modeInfoList = {}
	self.hasFight = false
end

function TowerComposePlaneMo:updateInfo(info)
	self.planeId = info.planeId

	self:updateModsInfo(info.mods)

	self.level = info.level or 0
	self.hasFight = info.fight
end

function TowerComposePlaneMo:updateModsInfo(modsInfo)
	self:buildAllDefaultModInfoMap()

	for _, modInfo in ipairs(modsInfo) do
		self:buildDefaultModInfoMap(modInfo.type)

		for _, modSlotData in ipairs(modInfo.mods) do
			self.modInfoMap[modInfo.type][modSlotData.slot] = modSlotData.modId
		end
	end

	self:buildModInfoList()
end

function TowerComposePlaneMo:buildDefaultModInfoMap(modType)
	if not self.modInfoMap[modType] then
		self.modInfoMap[modType] = {}

		local slotNumMap = TowerComposeConfig.instance:getModSlotNumMap(self.themeId)
		local slotNum = slotNumMap[modType]

		for slotId = 1, slotNum do
			self.modInfoMap[modType][slotId] = 0
		end

		return true
	end

	return false
end

function TowerComposePlaneMo:buildAllDefaultModInfoMap()
	for modType = TowerComposeEnum.ModType.Body, TowerComposeEnum.ModType.Env do
		self:buildDefaultModInfoMap(modType)
	end
end

function TowerComposePlaneMo:buildModInfoList()
	self.modeInfoList = {}
	self.level = 0

	for modType, modTypeData in pairs(self.modInfoMap) do
		if not self.modeInfoList[modType] then
			self.modeInfoList[modType] = {}
		end

		for slot, modId in pairs(modTypeData) do
			local data = {}

			data.slot = slot
			data.modId = modId

			table.insert(self.modeInfoList[modType], data)

			if modId > 0 then
				local modConfig = TowerComposeConfig.instance:getComposeModConfig(modId)

				self.level = self.level + modConfig.level
			end
		end

		table.sort(self.modeInfoList[modType], function(a, b)
			return a.slot < b.slot
		end)
	end
end

function TowerComposePlaneMo:getEquipModId(modType, slot)
	return self.modInfoMap[modType] and self.modInfoMap[modType][slot] or 0
end

function TowerComposePlaneMo:setEquipModId(modType, slot, modId)
	self:buildDefaultModInfoMap(modType)

	self.modInfoMap[modType][slot] = modId

	self:buildModInfoList()
end

function TowerComposePlaneMo:getModInfoList(modType)
	local needBuild = self:buildDefaultModInfoMap(modType)

	if needBuild then
		self:buildModInfoList()
	end

	return self.modeInfoList[modType] or {}
end

function TowerComposePlaneMo:getAllModeInfoList()
	return self.modeInfoList
end

function TowerComposePlaneMo:getHaveModInfoList(modType)
	local modInfoList = self:getModInfoList(modType)
	local haveModInfoList = {}

	for index, modInfo in ipairs(modInfoList) do
		if modInfo.modId > 0 then
			table.insert(haveModInfoList, modInfo)
		end
	end

	return haveModInfoList
end

function TowerComposePlaneMo:dropAllSlotMod(modType)
	self:buildDefaultModInfoMap(modType)

	for slotId, modId in pairs(self.modInfoMap[modType]) do
		self.modInfoMap[modType][slotId] = 0
	end

	self:buildModInfoList()
end

return TowerComposePlaneMo
