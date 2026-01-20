-- chunkname: @modules/logic/versionactivity1_7/marcus/model/ActMarcusModel.lua

module("modules.logic.versionactivity1_7.marcus.model.ActMarcusModel", package.seeall)

local ActMarcusModel = class("ActMarcusModel", BaseModel)

function ActMarcusModel:onInit()
	self:reInit()
end

function ActMarcusModel:reInit()
	self.newFinishStoryLvlId = nil
	self.newFinishFightLvlId = nil
	self.lvlDataDic = nil
end

function ActMarcusModel:initData()
	local actId = VersionActivity1_7Enum.ActivityId.Marcus

	if not self.lvlDataDic then
		self.lvlDataDic = {}

		local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(actId)

		for _, storyConfig in ipairs(storyConfigList) do
			local dungeonMO = DungeonModel.instance:getEpisodeInfo(storyConfig.id)
			local _isUnlock = DungeonModel.instance:isUnlock(storyConfig)
			local lvlData = {
				config = storyConfig,
				isUnlock = _isUnlock,
				star = dungeonMO and dungeonMO.star or 0
			}

			self.lvlDataDic[storyConfig.id] = lvlData
		end

		local fightConfigList = RoleActivityConfig.instance:getBattleLevelList(actId)

		for _, fightConfig in ipairs(fightConfigList) do
			local dungeonMO = DungeonModel.instance:getEpisodeInfo(fightConfig.id)
			local _isUnlock = DungeonModel.instance:isUnlock(fightConfig)
			local lvlData = {
				config = fightConfig,
				isUnlock = _isUnlock,
				star = dungeonMO and dungeonMO.star or 0
			}

			self.lvlDataDic[fightConfig.id] = lvlData
		end
	end

	if not self.storyChapteId or not self.fightChapterId then
		local enterConfig = RoleActivityConfig.instance:getActivityEnterInfo(actId)

		self.storyChapteId = enterConfig.storyGroupId
		self.fightChapterId = enterConfig.episodeGroupId
	end
end

function ActMarcusModel:updateData()
	for id, lvlData in pairs(self.lvlDataDic) do
		local dungeonMO = DungeonModel.instance:getEpisodeInfo(id)

		lvlData.isUnlock = DungeonModel.instance:isUnlock(lvlData.config)
		lvlData.star = dungeonMO and dungeonMO.star or 0
	end
end

function ActMarcusModel:isLevelUnlock(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].isUnlock
end

function ActMarcusModel:isLevelPass(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].star > 0
end

function ActMarcusModel:checkFinishLevel(episodeId, star)
	if not self.lvlDataDic then
		return
	end

	local lvlData = self.lvlDataDic[episodeId]

	if lvlData and lvlData.star == 0 and star > 0 then
		local chapterId = lvlData.config.chapterId

		if chapterId == self.storyChapteId then
			self.newFinishStoryLvlId = episodeId
		elseif chapterId == self.fightChapterId then
			self.newFinishFightLvlId = episodeId
		end
	end
end

function ActMarcusModel:getNewFinishStoryLvl()
	return self.newFinishStoryLvlId
end

function ActMarcusModel:clearNewFinishStoryLvl()
	self.newFinishStoryLvlId = nil
end

function ActMarcusModel:getNewFinishFightLvl()
	return self.newFinishFightLvlId
end

function ActMarcusModel:clearNewFinishFightLvl()
	self.newFinishFightLvlId = nil
end

function ActMarcusModel:setFirstEnter()
	self.firstEnter = true
end

function ActMarcusModel:getFirstEnter()
	return self.firstEnter
end

function ActMarcusModel:clearFirstEnter()
	self.firstEnter = nil
end

function ActMarcusModel:setEnterFightIndex(index)
	self.recordFightIndex = index
end

function ActMarcusModel:getEnterFightIndex()
	local fightIndex = self.recordFightIndex

	self.recordFightIndex = nil

	return fightIndex
end

ActMarcusModel.instance = ActMarcusModel.New()

return ActMarcusModel
