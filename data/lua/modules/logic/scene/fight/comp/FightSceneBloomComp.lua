-- chunkname: @modules/logic/scene/fight/comp/FightSceneBloomComp.lua

module("modules.logic.scene.fight.comp.FightSceneBloomComp", package.seeall)

local FightSceneBloomComp = class("FightSceneBloomComp", BaseSceneComp)

FightSceneBloomComp.Bloom_invisible = "invisible"
FightSceneBloomComp.Bloom_mirror = "mirror"
FightSceneBloomComp.Bloom_useShadow = "useShadow"
FightSceneBloomComp.Bloom_mirrorNoise = "mirrorNoise"

local PPEffectMaskDict = {
	[FightSceneBloomComp.Bloom_invisible] = "useInvisible",
	[FightSceneBloomComp.Bloom_mirror] = "useMirror",
	[FightSceneBloomComp.Bloom_useShadow] = "useShadow"
}
local PPVolumeDict = {
	[FightSceneBloomComp.Bloom_invisible] = "characterInvisibleActive"
}

function FightSceneBloomComp:onInit()
	self:addConstEvents()
end

function FightSceneBloomComp:addConstEvents()
	self:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function FightSceneBloomComp:onSceneStart(sceneId, levelId)
	self._entityDict = {}
	self._scenePassDict = {}
	self._entityPassDict = {}

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
end

function FightSceneBloomComp:onSceneClose()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, self._onSkillPlayStart, self)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	if self._localBloomColor then
		PostProcessingMgr.instance:setLocalBloomColor(self._localBloomColor)

		self._localBloomColor = nil
	end

	self._entityDict = {}
	self._scenePassDict = {}
	self._entityPassDict = {}

	self:_checkCameraPPVolume()
	TaskDispatcher.cancelTask(self._delayAddEntityBloom, self)
end

function FightSceneBloomComp:_onLevelLoaded(levelId)
	local levelCO = lua_scene_level.configDict[levelId]

	if levelCO and levelCO.useBloom == 1 then
		if self._localBloomColor == nil then
			self._localBloomColor = PostProcessingMgr.instance:getLocalBloomColor()
		end

		PostProcessingMgr.instance:setLocalBloomColor(Color.New(levelCO.bloomR, levelCO.bloomG, levelCO.bloomB, levelCO.bloomA))
		PostProcessingMgr.instance:setFlickerSceneFactor(levelCO.flickerSceneFactor)
		PostProcessingMgr.instance:setLocalBloomActive(true)

		self._scenePassDict = {}

		if not string.nilorempty(levelCO.bloomEffect) then
			local passNames = string.split(levelCO.bloomEffect, "#")

			for _, name in ipairs(passNames) do
				self._scenePassDict[name] = true
			end
		end
	end

	for entity, _ in pairs(self._entityDict) do
		self:_checkEntityPPEffectMask(entity)
	end

	self:_checkCameraPPVolume()
end

function FightSceneBloomComp:addEntity(entity)
	self._delayAddEntitys = self._delayAddEntitys or {}

	table.insert(self._delayAddEntitys, entity)
	TaskDispatcher.cancelTask(self._delayAddEntityBloom, self)
	TaskDispatcher.runDelay(self._delayAddEntityBloom, self, 2)
end

function FightSceneBloomComp:_delayAddEntityBloom()
	for _, entity in ipairs(self._delayAddEntitys) do
		self._entityDict[entity] = true

		self:_checkEntityPPEffectMask(entity)
		self:_checkCameraPPVolume()
	end

	self._delayAddEntitys = nil
end

function FightSceneBloomComp:removeEntity(entity)
	self._entityDict[entity] = nil

	self:_checkEntityPPEffectMask(entity)
	self:_checkCameraPPVolume()
end

function FightSceneBloomComp:setSingleEntityPass(passName, enable, entity, sourceKey)
	local entitys = self._entityPassDict[passName]

	if not entitys then
		entitys = {}
		self._entityPassDict[passName] = entitys
	end

	local sourceKeyDict = entitys[entity]

	if not sourceKeyDict then
		sourceKeyDict = {}
		entitys[entity] = sourceKeyDict
	end

	sourceKeyDict[sourceKey] = enable and true or nil

	self:_checkEntityPPEffectMask(entity)
	self:_checkCameraPPVolume(passName)
end

function FightSceneBloomComp:_checkEntityPPEffectMask(entity)
	local ppEffectMask = entity.spine and entity.spine:getPPEffectMask()

	if not ppEffectMask then
		return
	end

	if not entity.spineRenderer then
		return
	end

	local replaceMat = entity.spineRenderer:getReplaceMat()

	if gohelper.isNil(replaceMat) then
		logError("FightSceneBloomComp.SetPassEnable mat=nil")

		return
	end

	for passName, passName4PPEffectMask in pairs(PPEffectMaskDict) do
		local enable = self._entityDict[entity] and self._scenePassDict[passName] or false

		if not enable then
			local entitys = self._entityPassDict[passName]

			if entitys then
				local sourceKeyDict = entitys[entity]

				if sourceKeyDict then
					for _, _ in pairs(sourceKeyDict) do
						enable = true

						break
					end
				end
			end
		end

		ppEffectMask:SetPassEnable(replaceMat, passName4PPEffectMask, enable)
	end
end

function FightSceneBloomComp:_checkCameraPPVolume(passName)
	if passName then
		if PPVolumeDict[passName] then
			self:_checkOneCameraPPVolume(passName)
		end
	else
		for passName, _ in pairs(PPVolumeDict) do
			self:_checkOneCameraPPVolume(passName)
		end
	end
end

function FightSceneBloomComp:_checkOneCameraPPVolume(passName)
	local isEnable = self._scenePassDict[passName]

	if not isEnable then
		local entitys = self._entityPassDict[passName]

		if entitys then
			for _, sourceKeyDict in pairs(entitys) do
				for _, _ in pairs(sourceKeyDict) do
					isEnable = true

					break
				end

				if isEnable then
					break
				end
			end
		end
	end

	local ppVolumeName = PPVolumeDict[passName]

	PostProcessingMgr.instance:setUnitPPValue(ppVolumeName, isEnable)
end

function FightSceneBloomComp:_onSkillPlayStart(entity, skillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(skillId) then
		local entityList = FightHelper.getSideEntitys(entityMO.side)

		for i, v in ipairs(entityList) do
			GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(FightSceneBloomComp.Bloom_invisible, false, v, "buff_bloom")
		end
	end
end

function FightSceneBloomComp:_onSkillPlayFinish(entity, skillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(skillId) then
		local entityList = FightHelper.getSideEntitys(entityMO.side)

		for i, v in ipairs(entityList) do
			if v.buff then
				v.buff:_udpateBuffVariant()
			end
		end
	end
end

return FightSceneBloomComp
