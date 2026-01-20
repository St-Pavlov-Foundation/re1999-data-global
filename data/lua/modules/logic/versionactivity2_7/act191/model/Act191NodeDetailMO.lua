-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191NodeDetailMO.lua

module("modules.logic.versionactivity2_7.act191.model.Act191NodeDetailMO", package.seeall)

local Act191NodeDetailMO = pureTable("Act191NodeDetailMO")

function Act191NodeDetailMO:init(str)
	local tbl = cjson.decode(str)

	self.type = tbl.type
	self.shopId = tbl.shopId
	self.shopFreshNum = tbl.shopFreshNum
	self.shopPosMap = tbl.shopPosMap
	self.boughtSet = tbl.boughtSet
	self.enhanceList = tbl.enhanceList
	self.enhanceNumList = tbl.enhanceNumList
	self.eventId = tbl.eventId
	self.fightEventId = tbl.fightEventId

	if tbl.matchInfo then
		self.matchInfo = Act191MatchMO.New()

		self.matchInfo:init(tbl.matchInfo)
	end

	self.replaceNum = tbl.replaceNum
	self.changeItemList = tbl.changeItemList
end

return Act191NodeDetailMO
