-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/config/V1a6_CachotScoreConfig.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotScoreConfig", package.seeall)

local V1a6_CachotScoreConfig = class("V1a6_CachotScoreConfig")

function V1a6_CachotScoreConfig:init(configTable)
	self._scroeConfigTable = configTable
end

function V1a6_CachotScoreConfig:getConfigList()
	return self._scroeConfigTable.configList
end

function V1a6_CachotScoreConfig:getStagePartRange(score)
	if self._scroeConfigTable.configDict then
		local nextScore, lastScore, lastPartId, nextPartId

		for id, v in pairs(self._scroeConfigTable.configDict) do
			if score <= v.score and (not nextScore or nextScore >= v.score) then
				nextScore = v.score
				nextPartId = id
			end

			if score > v.score and (not lastScore or lastScore < v.score) then
				lastScore = v.score
				lastPartId = id
			end
		end

		return lastPartId, nextPartId
	end
end

function V1a6_CachotScoreConfig:getStagePartConfig(id)
	local configDic = self._scroeConfigTable and self._scroeConfigTable.configDict

	if configDic then
		return configDic[id]
	end
end

function V1a6_CachotScoreConfig:getStagePartScore(id)
	local configDic = self._scroeConfigTable and self._scroeConfigTable.configDict

	if configDic and configDic[id] then
		return configDic[id].score
	end

	return 0
end

V1a6_CachotScoreConfig.instance = V1a6_CachotScoreConfig.New()

return V1a6_CachotScoreConfig
