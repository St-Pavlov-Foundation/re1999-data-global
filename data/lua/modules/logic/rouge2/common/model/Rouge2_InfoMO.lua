-- chunkname: @modules/logic/rouge2/common/model/Rouge2_InfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_InfoMO", package.seeall)

local Rouge2_InfoMO = pureTable("Rouge2_InfoMO")

function Rouge2_InfoMO:init(info)
	self.state = info.state
	self.difficulty = info.difficulty
	self.coin = info.coin
	self.endId = info.endId
	self.gameNum = info.gameNum

	self:updateLeaderInfo(info.leaderInfo)
	self:updateAttrGroupInfo(info.attrInfo)
	self:updateAlchemyInfo(info)
	Rouge2_BackpackModel.instance:updateBagInfo(info.bagInfo)
end

function Rouge2_InfoMO:isContinueLast()
	return self.state ~= RougeEnum.State.Empty and self.state ~= RougeEnum.State.isEnd
end

function Rouge2_InfoMO:getLeaderInfo()
	return self._leaderInfo
end

function Rouge2_InfoMO:updateLeaderInfo(leaderInfo)
	if not self._leaderInfo then
		self._leaderInfo = Rouge2_LeaderInfoMO.New()
	end

	self._leaderInfo:init(leaderInfo)
end

function Rouge2_InfoMO:updateAttrGroupInfo(attrGroupInfo)
	if not self._attrGroupInfo then
		self._attrGroupInfo = Rouge2_AttrGroupMO.New()
	end

	self._attrGroupInfo:init(attrGroupInfo)
end

function Rouge2_InfoMO:updateAlchemyInfo(rougeInfo)
	if not rougeInfo:HasField("alchemyInfo") then
		self._alchemyInfo = nil

		return
	end

	if not self._alchemyInfo then
		self._alchemyInfo = Rouge2_GameCurAlchemyInfoMO.New()
	end

	self._alchemyInfo:init(rougeInfo.alchemyInfo)
end

function Rouge2_InfoMO:updateAttrInfoList(updates)
	if self._attrGroupInfo then
		self._attrGroupInfo:updateAttrInfoList(updates)
	end
end

function Rouge2_InfoMO:getAttrGroupInfo()
	return self._attrGroupInfo
end

function Rouge2_InfoMO:getUpdateAttrMap()
	return self._attrGroupInfo and self._attrGroupInfo:getUpdateAttrMap()
end

function Rouge2_InfoMO:clearUpdateAttrMap()
	return self._attrGroupInfo and self._attrGroupInfo:clearUpdateAttrMap()
end

function Rouge2_InfoMO:getCurAlchemyInfo()
	return self._alchemyInfo
end

return Rouge2_InfoMO
