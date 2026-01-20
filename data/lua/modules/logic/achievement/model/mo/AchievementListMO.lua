-- chunkname: @modules/logic/achievement/model/mo/AchievementListMO.lua

module("modules.logic.achievement.model.mo.AchievementListMO", package.seeall)

local AchievementListMO = pureTable("AchievementListMO")

function AchievementListMO:init(achievementId, isGroupTop)
	self.id = achievementId
	self.taskCfgs = AchievementConfig.instance:getTasksByAchievementId(achievementId)
	self.achievementCfg = AchievementConfig.instance:getAchievement(self.id)

	self:buildTaskStateMap()

	self.isFold = false
	self.isGroupTop = isGroupTop
end

function AchievementListMO:buildTaskStateMap()
	self._unlockTaskList = {}
	self._loackTaskList = {}

	if self.taskCfgs then
		for _, taskCfg in ipairs(self.taskCfgs) do
			local isTaskFinished = AchievementModel.instance:isAchievementTaskFinished(taskCfg.id)

			if isTaskFinished then
				table.insert(self._unlockTaskList, taskCfg)
			else
				table.insert(self._loackTaskList, taskCfg)
			end
		end
	end
end

function AchievementListMO:getTaskListBySearchFilterType(searchFilterType)
	searchFilterType = searchFilterType or AchievementEnum.SearchFilterType.All

	if searchFilterType == AchievementEnum.SearchFilterType.All then
		return self.taskCfgs
	elseif searchFilterType == AchievementEnum.SearchFilterType.Locked then
		return self._loackTaskList
	else
		return self._unlockTaskList
	end
end

function AchievementListMO:getTotalTaskConfigList()
	return self.taskCfgs
end

function AchievementListMO:getLockTaskList()
	return self._loackTaskList
end

function AchievementListMO:getUnlockTaskList()
	return self._unlockTaskList
end

function AchievementListMO:getFilterTaskList(sortType, searchFilterType)
	sortType = sortType or AchievementEnum.SortType.RareDown
	searchFilterType = searchFilterType or AchievementEnum.SearchFilterType.All

	local fitTaskList = self:getTaskListBySearchFilterType(searchFilterType)

	if fitTaskList then
		table.sort(fitTaskList, self.sortTaskFunction)
	end

	return fitTaskList
end

function AchievementListMO.sortTaskFunction(aTask, bTask)
	local isATaskFinished = AchievementModel.instance:isAchievementTaskFinished(aTask.id)
	local isBTaskFinished = AchievementModel.instance:isAchievementTaskFinished(bTask.id)

	return aTask.id < bTask.id
end

function AchievementListMO:isAchievementMatch(achievementType, dataId)
	local isMatch = false

	if achievementType == AchievementEnum.AchievementType.Single then
		isMatch = dataId == self.id
	else
		local achievementCfg = AchievementConfig.instance:getAchievement(self.id)

		isMatch = achievementCfg and achievementCfg.groupId ~= 0 and achievementCfg.groupId == dataId
	end

	return isMatch
end

function AchievementListMO:setIsFold(isFold)
	self.isFold = isFold
end

function AchievementListMO:getIsFold()
	return self.isFold
end

local singleAchievementTopHeight = 46
local groupAchievementTopHeight = 74
local singleTaskItemHeight = 206
local singleNamePlateItemHeight = 500
local singleNamePlateTaskItemHeight = 250

function AchievementListMO:getLineHeightFunction(filterType, isFold)
	local listItemHeight = 0
	local achievementType = self:getAchievementType()
	local isGroup = achievementType == AchievementEnum.AchievementType.Group

	if isFold then
		if isGroup then
			listItemHeight = self.isGroupTop and groupAchievementTopHeight or 0
		else
			listItemHeight = singleAchievementTopHeight
		end
	else
		local fitTaskList = self:getTaskListBySearchFilterType(filterType)
		local fitTaskCount = fitTaskList and #fitTaskList or 0
		local totalHeaderHeight = self.isGroupTop and groupAchievementTopHeight + singleAchievementTopHeight or singleAchievementTopHeight
		local isNamePlate = self.achievementCfg.category == AchievementEnum.Type.NamePlate
		local isNamePlateShowList = isNamePlate and AchievementMainListModel.instance:checkNamePlateShowList()

		if isNamePlate then
			if isNamePlateShowList then
				listItemHeight = singleNamePlateItemHeight
			else
				listItemHeight = fitTaskCount * singleNamePlateTaskItemHeight + totalHeaderHeight
			end
		else
			listItemHeight = fitTaskCount * singleTaskItemHeight + totalHeaderHeight
		end
	end

	return listItemHeight
end

function AchievementListMO:overrideLineHeight(cellHeight)
	self._cellHeight = cellHeight
end

function AchievementListMO:clearOverrideLineHeight()
	self._cellHeight = nil
end

function AchievementListMO:getLineHeight(filterType, isFold)
	local lineHeight = self:getLineHeightFunction(filterType, isFold)

	return lineHeight
end

function AchievementListMO:getAchievementType()
	if not self._achievementType then
		local achievementCfg = AchievementConfig.instance:getAchievement(self.id)
		local isGroup = achievementCfg and achievementCfg.groupId ~= 0

		self._achievementType = isGroup and AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single
	end

	return self._achievementType
end

function AchievementListMO:getGroupId()
	local achievementCfg = AchievementConfig.instance:getAchievement(self.id)
	local groupId = achievementCfg and achievementCfg.groupId

	return groupId
end

return AchievementListMO
