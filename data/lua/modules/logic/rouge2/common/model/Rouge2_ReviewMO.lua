-- chunkname: @modules/logic/rouge2/common/model/Rouge2_ReviewMO.lua

module("modules.logic.rouge2.common.model.Rouge2_ReviewMO", package.seeall)

local Rouge2_ReviewMO = pureTable("Rouge2_ReviewMO")

function Rouge2_ReviewMO:init(info)
	self.playerName = info.playerName
	self.playerLevel = info.playerLevel
	self.portrait = info.portrait
	self.finishTime = info.finishTime
	self.difficulty = info.difficulty
	self.mainCareer = info.mainCareer
	self.curCareer = info.curCareer
	self.collectionNum = info.collectionNum
	self.gainCoin = info.gainCoin
	self.leaderAttrInfo = info.leaderAttrInfo
	self.endId = info.endId
	self.drugId = info.drugId
	self.collectionBag = info.collectionBag
	self.middleLayerId = info.middleLayerId
	self.layerId = info.layerId
	self.endHeroId = info.endHeroId
end

function Rouge2_ReviewMO:getTeamInfo()
	return self.endHeroId
end

function Rouge2_ReviewMO:getCollections()
	return self.collectionBag
end

function Rouge2_ReviewMO:isSucceed()
	return self.endId and self.endId ~= 0
end

function Rouge2_ReviewMO:isInMiddleLayer()
	return self.middleLayerId ~= 0
end

return Rouge2_ReviewMO
