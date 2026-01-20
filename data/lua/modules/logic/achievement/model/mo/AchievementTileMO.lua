-- chunkname: @modules/logic/achievement/model/mo/AchievementTileMO.lua

module("modules.logic.achievement.model.mo.AchievementTileMO", package.seeall)

local AchievementTileMO = pureTable("AchievementTileMO")

function AchievementTileMO:init(achievementCfgs, groupId, isGroupTop)
	self.achievementCfgs = achievementCfgs
	self.groupId = groupId
	self.count = achievementCfgs and #achievementCfgs or 0
	self.isGroupTop = isGroupTop
	self.isFold = false
	self.firstAchievementCo = achievementCfgs and achievementCfgs[1]
end

function AchievementTileMO:getLineHeightFunction(filterType, isFold)
	if isFold then
		if self.isGroupTop then
			return AchievementEnum.SpGroupTitleBarHeight
		else
			return 0
		end
	elseif self.groupId == 0 then
		return AchievementEnum.MainTileLineItemHeight
	else
		if AchievementUtils.isGamePlayGroup(self.firstAchievementCo.id) then
			local headerHeight = self.isGroupTop and AchievementEnum.SpGroupTitleBarHeight or 0

			return headerHeight + AchievementEnum.MainTileLineItemHeight
		end

		return AchievementEnum.MainTileGroupItemHeight
	end
end

function AchievementTileMO:getAchievementType()
	local isGroup = self.groupId and self.groupId ~= 0

	return isGroup and AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single
end

function AchievementTileMO:isAchievementMatch(achievementType, dataId)
	local isMatch = false

	if achievementType == AchievementEnum.AchievementType.Single then
		if self.achievementCfgs then
			for _, achievementCfg in ipairs(self.achievementCfgs) do
				if achievementCfg.id == dataId then
					isMatch = true

					break
				end
			end
		end
	else
		isMatch = dataId == self.groupId
	end

	return isMatch
end

function AchievementTileMO:overrideLineHeight(cellHeight)
	self._cellHeight = cellHeight
end

function AchievementTileMO:clearOverrideLineHeight()
	self._cellHeight = nil
end

function AchievementTileMO:getLineHeight(filterType, isFold)
	if self._cellHeight then
		return self._cellHeight
	end

	local lineHeight = self:getLineHeightFunction(filterType, isFold)

	return lineHeight
end

function AchievementTileMO:setIsFold(isFold)
	self.isFold = isFold
end

function AchievementTileMO:getIsFold()
	return self.isFold
end

function AchievementTileMO:getGroupId()
	return self.groupId
end

return AchievementTileMO
