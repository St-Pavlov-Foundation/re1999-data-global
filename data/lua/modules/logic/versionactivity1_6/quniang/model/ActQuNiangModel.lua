-- chunkname: @modules/logic/versionactivity1_6/quniang/model/ActQuNiangModel.lua

module("modules.logic.versionactivity1_6.quniang.model.ActQuNiangModel", package.seeall)

local ActQuNiangModel = class("ActQuNiangModel", BaseModel)

function ActQuNiangModel:onInit()
	self:reInit()
end

function ActQuNiangModel:reInit()
	self.newFinishStoryLvlId = nil
	self.newFinishFightLvlId = nil
	self.lvlDataDic = nil
end

function ActQuNiangModel:initData()
	if not self.lvlDataDic then
		self.lvlDataDic = {}

		local storyConfigList = RoleActivityConfig.instance:getStoryLevelList(ActQuNiangEnum.ActivityId)

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

		local fightConfigList = RoleActivityConfig.instance:getBattleLevelList(ActQuNiangEnum.ActivityId)

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
		local enterConfig = RoleActivityConfig.instance:getActivityEnterInfo(ActQuNiangEnum.ActivityId)

		self.storyChapteId = enterConfig.storyGroupId
		self.fightChapterId = enterConfig.episodeGroupId
	end
end

function ActQuNiangModel:updateData()
	for id, lvlData in pairs(self.lvlDataDic) do
		local dungeonMO = DungeonModel.instance:getEpisodeInfo(id)

		lvlData.isUnlock = DungeonModel.instance:isUnlock(lvlData.config)
		lvlData.star = dungeonMO and dungeonMO.star or 0
	end
end

function ActQuNiangModel:isLevelUnlock(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].isUnlock
end

function ActQuNiangModel:isLevelPass(episodeId)
	if not self.lvlDataDic[episodeId] then
		logError(episodeId .. "data is null")

		return
	end

	return self.lvlDataDic[episodeId].star > 0
end

function ActQuNiangModel:checkFinishLevel(episodeId, star)
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

function ActQuNiangModel:getNewFinishStoryLvl()
	return self.newFinishStoryLvlId
end

function ActQuNiangModel:clearNewFinishStoryLvl()
	self.newFinishStoryLvlId = nil
end

function ActQuNiangModel:getNewFinishFightLvl()
	return self.newFinishFightLvlId
end

function ActQuNiangModel:clearNewFinishFightLvl()
	self.newFinishFightLvlId = nil
end

function ActQuNiangModel:setFirstEnter()
	self.firstEnter = true
end

function ActQuNiangModel:getFirstEnter()
	return self.firstEnter
end

function ActQuNiangModel:clearFirstEnter()
	self.firstEnter = nil
end

function ActQuNiangModel:setEnterFightIndex(index)
	self.recordFightIndex = index
end

function ActQuNiangModel:getEnterFightIndex()
	local fightIndex = self.recordFightIndex

	self.recordFightIndex = nil

	return fightIndex
end

ActQuNiangModel.instance = ActQuNiangModel.New()

return ActQuNiangModel
