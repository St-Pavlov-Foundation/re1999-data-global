-- chunkname: @modules/logic/versionactivity2_3/dudugu/model/ActDuDuGuModel.lua

module("modules.logic.versionactivity2_3.dudugu.model.ActDuDuGuModel", package.seeall)

local ActDuDuGuModel = class("ActDuDuGuModel", BaseModel)

function ActDuDuGuModel:onInit()
	self:reInit()
end

function ActDuDuGuModel:reInit()
	self._curLvIndex = 0
end

function ActDuDuGuModel:setCurLvIndex(index)
	self._curLvIndex = index
end

function ActDuDuGuModel:getCurLvIndex()
	return self._curLvIndex or 0
end

function ActDuDuGuModel:initData(actId)
	RoleActivityModel.instance:initData(actId)
end

function ActDuDuGuModel:updateData(actId)
	RoleActivityModel.instance:updateData(actId)
end

function ActDuDuGuModel:isLevelUnlock(actId, episodeId)
	local isUnlock = RoleActivityModel.instance:isLevelUnlock(actId, episodeId)

	return isUnlock
end

function ActDuDuGuModel:isLevelPass(actId, episodeId)
	local isPass = RoleActivityModel.instance:isLevelPass(actId, episodeId)

	return isPass
end

function ActDuDuGuModel:getNewFinishStoryLvl()
	local actId = VersionActivity2_3Enum.ActivityId.DuDuGu
	local episodeCos = RoleActivityConfig.instance:getStoryLevelList(actId)
	local episodeId = episodeCos[self._curLvIndex].id

	if not episodeId or episodeId <= 0 then
		return
	end

	local nextEpisode = self._curLvIndex + 1 <= #episodeCos and episodeCos[self._curLvIndex + 1].id or 0

	if nextEpisode > 0 then
		local isPass = self:isLevelPass(actId, episodeId)
		local storyFinished = true
		local storyId = episodeCos[self._curLvIndex].afterStory

		if storyId > 0 then
			storyFinished = StoryModel.instance:isStoryFinished(storyId)
		end

		local isUnlock = self:isLevelUnlock(actId, nextEpisode)

		if isPass and not isUnlock and storyFinished then
			self.newFinishStoryLvlId = episodeId

			return self.newFinishStoryLvlId
		end
	end

	self.newFinishStoryLvlId = RoleActivityModel.instance:getNewFinishStoryLvl()

	return self.newFinishStoryLvlId
end

function ActDuDuGuModel:clearNewFinishStoryLvl()
	RoleActivityModel.instance:clearNewFinishStoryLvl()

	return self.newFinishStoryLvlId
end

ActDuDuGuModel.instance = ActDuDuGuModel.New()

return ActDuDuGuModel
