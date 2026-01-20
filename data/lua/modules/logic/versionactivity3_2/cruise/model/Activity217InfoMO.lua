-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity217InfoMO.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity217InfoMO", package.seeall)

local Activity217InfoMO = pureTable("Activity217InfoMO")

function Activity217InfoMO:ctor()
	self.expEpisodeCount = 0
	self.coinEpisodeCount = 0
end

function Activity217InfoMO:init(info)
	self.expEpisodeCount = info.expEpisodeCount
	self.coinEpisodeCount = info.coinEpisodeCount
end

function Activity217InfoMO:updateInfo(info)
	self.expEpisodeCount = info.expEpisodeCount
	self.coinEpisodeCount = info.coinEpisodeCount
end

function Activity217InfoMO:updateExpEpisodeCount(count)
	self.expEpisodeCount = count
end

function Activity217InfoMO:updateCoinEpisodeCount(count)
	self.coinEpisodeCount = count
end

return Activity217InfoMO
