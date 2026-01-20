-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinQuestMapMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinQuestMapMO", package.seeall)

local AssassinQuestMapMO = class("AssassinQuestMapMO")

function AssassinQuestMapMO:ctor(mapId)
	self.id = mapId

	self:clearQuestData()
end

function AssassinQuestMapMO:clearQuestData()
	self._finishQuestDict = {}
	self._unlockQuestDict = {}
end

function AssassinQuestMapMO:unlockQuest(questId)
	self._unlockQuestDict[questId] = true
end

function AssassinQuestMapMO:finishQuest(questId)
	self._finishQuestDict[questId] = true
	self._unlockQuestDict[questId] = nil
end

function AssassinQuestMapMO:getStatus()
	local progress = self:getProgress()
	local status = AssassinEnum.MapStatus.Unlocked

	if progress >= AssassinEnum.Const.MapQuestMaxProgress then
		status = AssassinEnum.MapStatus.Finished
	end

	return status
end

function AssassinQuestMapMO:getProgress()
	local allQuestCount = 0
	local allQuest = AssassinConfig.instance:getQuestListInMap(self.id)

	if allQuest then
		allQuestCount = #allQuest
	end

	local finishQuestCount = 0

	for _, _ in pairs(self._finishQuestDict) do
		finishQuestCount = finishQuestCount + 1
	end

	local progress = Mathf.Clamp(finishQuestCount / allQuestCount, 0, 1)

	return tonumber(string.format("%.2f", progress))
end

function AssassinQuestMapMO:getFinishQuestCount(targetQuestType)
	local result = 0

	for questId, _ in pairs(self._finishQuestDict) do
		local questType = AssassinConfig.instance:getQuestType(questId)

		if not targetQuestType or targetQuestType == questType then
			result = result + 1
		end
	end

	return result
end

function AssassinQuestMapMO:getAllUnlockQuestCount(targetQuestType)
	local result = self:getFinishQuestCount(targetQuestType)

	for questId, _ in pairs(self._unlockQuestDict) do
		local questType = AssassinConfig.instance:getQuestType(questId)

		if not targetQuestType or targetQuestType == questType then
			result = result + 1
		end
	end

	return result
end

function AssassinQuestMapMO:getMapUnlockQuestIdList()
	local result = {}

	for questId, _ in pairs(self._unlockQuestDict) do
		result[#result + 1] = questId
	end

	return result
end

function AssassinQuestMapMO:getMapFinishQuestIdList()
	local result = {}

	for questId, _ in pairs(self._finishQuestDict) do
		result[#result + 1] = questId
	end

	return result
end

function AssassinQuestMapMO:isUnlockQuest(questId)
	return self._unlockQuestDict[questId] and true or false
end

function AssassinQuestMapMO:isFinishQuest(questId)
	return self._finishQuestDict[questId] and true or false
end

return AssassinQuestMapMO
