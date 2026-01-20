-- chunkname: @modules/logic/rouge2/start/config/Rouge2_Config.lua

module("modules.logic.rouge2.start.config.Rouge2_Config", package.seeall)

local Rouge2_Config = class("Rouge2_Config", BaseConfig)
local kHelpPageResPathFmt = "ui/viewres/fight/fight_rouge2/fight_rouge2_techniqueviewguid_overseas_%s_%s.prefab"

function Rouge2_Config:getHelpPageResUrl(mainTitleId, subTitleId)
	return string.format(kHelpPageResPathFmt, tostring(mainTitleId), tostring(subTitleId))
end

function Rouge2_Config:getHelpPageResPathList()
	local res = {}
	local techniqueIdList = Rouge2_Config.instance:getTechniqueIdList()

	for _, techniqueId in ipairs(techniqueIdList) do
		local cfg = self:getStealthTechniqueCfg(techniqueId)
		local mainTitleId = cfg.mainTitleId
		local subTitleId = cfg.subTitleId

		if mainTitleId ~= 0 and subTitleId ~= 0 then
			table.insert(res, self:getHelpPageResUrl(mainTitleId, subTitleId))
		end
	end

	return res
end

function Rouge2_Config:getStealthTechniqueMainSubId(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId)

	if not cfg then
		return 0, 0
	end

	return cfg.mainTitleId, cfg.subTitleId
end

function Rouge2_Config:onInit()
	return
end

function Rouge2_Config:reqConfigNames()
	return {
		"rouge2_const",
		"rouge2_difficulty",
		"rouge2_result",
		"rouge2_badge",
		"rouge2_ending",
		"rouge2_technique"
	}
end

function Rouge2_Config:onConfigLoaded(configName, configTable)
	if configName == "rouge2_const" then
		self._constConfig = configTable
	elseif configName == "rouge2_difficulty" then
		self.difficultyConfig = configTable

		self:_onLoadDifficultyConfig(configTable)
	elseif configName == "rouge2_layer_difficulty" then
		self._layerDifficultyConfig = configTable
	elseif configName == "rouge2_result" then
		self._resultConfig = configTable
	elseif configName == "rouge2_badge" then
		self._badgeConfig = configTable
	elseif configName == "rouge2_ending" then
		self._endingConfig = configTable
	elseif configName == "rouge2_technique" then
		self.techniqueConfig = configTable
	end
end

function Rouge2_Config:getUnlockId()
	return OpenEnum.UnlockFunc.Rouge2
end

function Rouge2_Config:getActId()
	return ActivityEnum.Activity.V3a2_Rouge
end

function Rouge2_Config:_onLoadDifficultyConfig(configTable)
	self._preDifficulty2CoDict = {}

	for _, difficultyCo in ipairs(configTable.configList) do
		local preDifficulty = difficultyCo.preDifficulty

		self._preDifficulty2CoDict[preDifficulty] = self.difficultyConfig.configDict[preDifficulty] or nil
	end
end

function Rouge2_Config:getDifficultyCoList()
	return self.difficultyConfig.configList
end

function Rouge2_Config:getDifficultyCoById(difficultyId)
	if not self.difficultyConfig or not self.difficultyConfig.configDict then
		return nil
	end

	return self.difficultyConfig.configDict[difficultyId]
end

function Rouge2_Config:getConstCoById(constId)
	if not self._constConfig or not self._constConfig.configDict then
		return nil
	end

	return self._constConfig.configDict[constId]
end

function Rouge2_Config:getEndingCO(endingId)
	local endCo = self._endingConfig.configDict[endingId]

	if not endCo then
		logError("rouge end config not exist, endId : " .. tostring(endingId))

		return
	end

	return endCo
end

function Rouge2_Config:getRougeBadgeCO(badgeId)
	return self._badgeConfig.configDict[badgeId]
end

function Rouge2_Config:getAchievementJumpId()
	local jumpId = tonumber(self:getConstCoById(Rouge2_Enum.ConstId.AchievementJumpId).value)

	return jumpId
end

function Rouge2_Config:getStealthTechniqueCfg(techniqueId)
	local cfg = self.techniqueConfig.configDict[techniqueId]

	if not cfg then
		logError(" rouge2 technique config not exist : " .. tostring(techniqueId))

		cfg = self.techniqueConfig.configList[1]
	end

	return cfg
end

function Rouge2_Config:getStealthTechniqueMainTitleId(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId)

	return cfg and cfg.mainTitleId
end

function Rouge2_Config:getStealthTechniqueSubTitleId(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId)

	return cfg and cfg.subTitleId
end

function Rouge2_Config:getStealthTechniqueMainTitle(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId)

	return cfg and cfg.mainTitle
end

function Rouge2_Config:getStealthTechniqueSubTitle(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId)

	return cfg and cfg.subTitle
end

function Rouge2_Config:getStealthTechniquePicture(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId)

	return cfg and cfg.picture
end

function Rouge2_Config:getStealthTechniqueContent(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId)

	return cfg and cfg.content
end

function Rouge2_Config:getStealthTechniquePos(techniqueId)
	local cfg = self:getStealthTechniqueCfg(techniqueId)

	return cfg and cfg.pos
end

function Rouge2_Config:getTechniqueIdList()
	local result = {}

	for _, cfg in ipairs(self.techniqueConfig.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

Rouge2_Config.instance = Rouge2_Config.New()

return Rouge2_Config
