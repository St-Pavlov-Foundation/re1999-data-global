-- chunkname: @modules/logic/versionactivity1_6/getian/model/ActGeTianModel.lua

module("modules.logic.versionactivity1_6.getian.model.ActGeTianModel", package.seeall)

local ActGeTianModel = class("ActGeTianModel", BaseModel)

function ActGeTianModel:onInit()
	self:reInit()
end

function ActGeTianModel:reInit()
	self.newFinishStoryLvlId = nil
	self.newFinishFightLvlId = nil
	self.lvlDataDic = nil
end

function ActGeTianModel:initData()
	if not self.lvlDataDic then
		self.lvlDataDic = {}

		local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(ActGeTianEnum.ActivityId)

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

		local fightConfigList = RoleActivityConfig.instance:getBattleLevelList(ActGeTianEnum.ActivityId)

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
		local enterConfig = RoleActivityConfig.instance:getActivityEnterInfo(ActGeTianEnum.ActivityId)

		self.storyChapteId = enterConfig.storyGroupId
		self.fightChapterId = enterConfig.episodeGroupId
	end
end

function ActGeTianModel:updateData()
	for id, lvlData in pairs(self.lvlDataDic) do
		local dungeonMO = DungeonModel.instance:getEpisodeInfo(id)

		lvlData.isUnlock = DungeonModel.instance:isUnlock(lvlData.config)
		lvlData.star = dungeonMO and dungeonMO.star or 0
	end
end

function ActGeTianModel:isLevelUnlock(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].isUnlock
end

function ActGeTianModel:isLevelPass(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].star > 0
end

function ActGeTianModel:checkFinishLevel(episodeId, star)
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

function ActGeTianModel:getNewFinishStoryLvl()
	return self.newFinishStoryLvlId
end

function ActGeTianModel:clearNewFinishStoryLvl()
	self.newFinishStoryLvlId = nil
end

function ActGeTianModel:getNewFinishFightLvl()
	return self.newFinishFightLvlId
end

function ActGeTianModel:clearNewFinishFightLvl()
	self.newFinishFightLvlId = nil
end

function ActGeTianModel:setFirstEnter()
	self.firstEnter = true
end

function ActGeTianModel:getFirstEnter()
	return self.firstEnter
end

function ActGeTianModel:clearFirstEnter()
	self.firstEnter = nil
end

function ActGeTianModel:setEnterFightIndex(index)
	self.recordFightIndex = index
end

function ActGeTianModel:getEnterFightIndex()
	local fightIndex = self.recordFightIndex

	self.recordFightIndex = nil

	return fightIndex
end

ActGeTianModel.instance = ActGeTianModel.New()

return ActGeTianModel
