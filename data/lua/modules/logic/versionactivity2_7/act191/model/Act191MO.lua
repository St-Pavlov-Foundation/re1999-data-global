-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191MO.lua

module("modules.logic.versionactivity2_7.act191.model.Act191MO", package.seeall)

local Act191MO = pureTable("Act191MO")

function Act191MO:ctor()
	self.triggerEffectPushList = {}
end

function Act191MO:initBadgeInfo(actId)
	self.badgeMoDic = {}
	self.badgeScoreChangeDic = {}

	local badgeCoDic = lua_activity191_badge.configDict[actId]

	if badgeCoDic then
		for id, badgeCo in pairs(badgeCoDic) do
			local badgeMo = Act191BadgeMO.New()

			badgeMo:init(badgeCo)

			self.badgeMoDic[id] = badgeMo
		end
	end
end

function Act191MO:init(info)
	for _, badgeInfo in ipairs(info.badgeInfoList) do
		self.badgeMoDic[badgeInfo.id]:update(badgeInfo)
	end

	self.gameInfo = Act191GameMO.New()

	self.gameInfo:init(info.gameInfo)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateBadgeMo)
end

function Act191MO:updateGameInfo(gameInfo)
	self.gameInfo:update(gameInfo)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateGameInfo)
end

function Act191MO:getGameInfo()
	return self.gameInfo
end

function Act191MO:triggerEffectPush(msg)
	self.triggerEffectPushList[#self.triggerEffectPushList + 1] = msg
end

function Act191MO:clearTriggerEffectPush()
	tabletool.clear(self.triggerEffectPushList)
end

function Act191MO:getGameEndInfo()
	return self.gameEndInfo
end

function Act191MO:setEnfInfo(endInfo)
	for _, badgeInfo in ipairs(endInfo.badgeInfoList) do
		local id = badgeInfo.id
		local badgeMO = self.badgeMoDic[id]

		self.badgeScoreChangeDic[id] = badgeInfo.count - badgeMO.count

		self.badgeMoDic[id]:update(badgeInfo)
	end

	self.gameEndInfo = endInfo

	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateBadgeMo)
end

function Act191MO:getBadgeScoreChangeDic()
	return self.badgeScoreChangeDic
end

function Act191MO:clearEndInfo()
	self.gameEndInfo = nil

	tabletool.clear(self.badgeScoreChangeDic)
	self:clearTriggerEffectPush()
end

function Act191MO:getBadgeMoList()
	local list = {}

	for _, badgeMo in pairs(self.badgeMoDic) do
		list[#list + 1] = badgeMo
	end

	table.sort(list, function(a, b)
		return a.id < b.id
	end)

	return list
end

return Act191MO
