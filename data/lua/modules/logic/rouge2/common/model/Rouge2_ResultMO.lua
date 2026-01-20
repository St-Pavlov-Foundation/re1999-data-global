-- chunkname: @modules/logic/rouge2/common/model/Rouge2_ResultMO.lua

module("modules.logic.rouge2.common.model.Rouge2_ResultMO", package.seeall)

local Rouge2_ResultMO = pureTable("Rouge2_ResultMO")

function Rouge2_ResultMO:init(info)
	self.endHeroId = info.endHeroId

	self:updateCheckEvent(info.checkStr)

	self.finishEventId = info.finishEventId
	self.gainCoin = tonumber(info.gainCoin)
	self.stepNum = tonumber(info.stepNum)
	self.badge2Score = GameUtil.splitString2(info.badge2Score, true)
	self.normalFight2Score = string.splitToNumber(info.normalFight2Score, "#")
	self.difficultFight2Score = string.splitToNumber(info.difficultFight2Score, "#")
	self.dangerousFight2Score = string.splitToNumber(info.dangerousFight2Score, "#")
	self.collection2Score = string.splitToNumber(info.collection2Score, "#")
	self.layer2Score = string.splitToNumber(info.layer2Score, "#")
	self.attrScore = string.splitToNumber(info.attr2Score, "#")
	self.scoreReward1 = tonumber(info.scoreReward1)
	self.scoreReward2 = tonumber(info.scoreReward2)
	self.beforeScore = tonumber(info.beforeScore)
	self.finalScore = tonumber(info.finalScore)

	self:updateReviewInfo(info.reviewInfo)

	self.gainMaterial = info.gainMaterial
	self.addCareerExp = info.addCareerExp
	self.addCurrency = info.addCurrency
end

function Rouge2_ResultMO:updateCheckEvent(checkStr)
	self.attributeCheckTotalCount = 0
	self.attributeCheckCountDic = {}
	self.attributeCheckMaxId = 0
	self.attributeCheckSuccessCount = 0

	if not string.nilorempty(checkStr) then
		local table = cjson.decode(checkStr)

		if table and next(table) then
			for attributeStr, checkParam in pairs(table) do
				local attributeId = tonumber(attributeStr)

				if attributeId then
					local attributeConfig = Rouge2_AttributeConfig.instance:getAttributeConfig(attributeId)

					if not attributeConfig then
						logError("肉鸽2 前端不存在的attributeConfigId :" .. tostring(attributeId))
					else
						for stateStr, count in pairs(checkParam) do
							local state = tonumber(stateStr)

							if state then
								self.attributeCheckTotalCount = self.attributeCheckTotalCount + count

								if state ~= Rouge2_OutsideEnum.AttributeCheckState.Fail then
									self.attributeCheckSuccessCount = self.attributeCheckSuccessCount + count
								end

								if not self.attributeCheckCountDic[attributeId] then
									self.attributeCheckCountDic[attributeId] = 0
								end

								self.attributeCheckCountDic[attributeId] = self.attributeCheckCountDic[attributeId] + count
							end
						end
					end
				end
			end
		end

		local maxCheckCount = 0
		local maxCheckAttrId = 0

		if next(self.attributeCheckCountDic) then
			for attributeId, checkCount in pairs(self.attributeCheckCountDic) do
				if maxCheckCount < checkCount then
					maxCheckAttrId = attributeId
					maxCheckCount = checkCount
				end
			end
		end

		self.attributeCheckMaxId = maxCheckAttrId
	end
end

function Rouge2_ResultMO:updateReviewInfo(reviewInfo)
	if not self.reviewInfo then
		self.reviewInfo = Rouge2_ReviewMO.New()
	end

	self.reviewInfo:init(reviewInfo)
end

function Rouge2_ResultMO:isSucceed()
	local endId = self.reviewInfo and self.reviewInfo.endId

	return endId and endId ~= 0
end

function Rouge2_ResultMO:getNormalFightCountAndScore()
	local count = self.normalFight2Score and self.normalFight2Score[1] or 0
	local score = self.normalFight2Score and self.normalFight2Score[2] or 0

	return count, score
end

function Rouge2_ResultMO:getDifficultFightCountAndScore()
	local count = self.difficultFight2Score and self.difficultFight2Score[1] or 0
	local score = self.difficultFight2Score and self.difficultFight2Score[2] or 0

	return count, score
end

function Rouge2_ResultMO:getDangerousFightCountAndScore()
	local count = self.dangerousFight2Score and self.dangerousFight2Score[1] or 0
	local score = self.dangerousFight2Score and self.dangerousFight2Score[2] or 0

	return count, score
end

function Rouge2_ResultMO:getCollectionCountAndScore()
	local count = self.collection2Score and self.collection2Score[1] or 0
	local score = self.collection2Score and self.collection2Score[2] or 0

	return count, score
end

function Rouge2_ResultMO:getLayerCountAndScore()
	local count = self.layer2Score and self.layer2Score[1] or 0
	local score = self.layer2Score and self.layer2Score[2] or 0

	return count, score
end

function Rouge2_ResultMO:getQuintupleCountAndScore()
	local count = self.attrScore and self.attrScore[1] or 0
	local score = self.attrScore and self.attrScore[2] or 0

	return count, score
end

return Rouge2_ResultMO
