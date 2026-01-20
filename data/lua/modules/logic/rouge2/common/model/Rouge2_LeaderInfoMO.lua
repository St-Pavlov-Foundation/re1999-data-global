-- chunkname: @modules/logic/rouge2/common/model/Rouge2_LeaderInfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_LeaderInfoMO", package.seeall)

local Rouge2_LeaderInfoMO = pureTable("Rouge2_LeaderInfoMO")

function Rouge2_LeaderInfoMO:init(info)
	self.mainCareerId = info.mainCareerId
	self.careerId = info.careerId
	self.revivalCoin = info.revivalCoin
	self.equipActiveSkill = info.equipActiveSkill
	self.equipActiveSkillMap = Rouge2_BuffHelper.listToMap(info.equipActiveSkill)
	self.isTransfer = self.mainCareerId ~= self.careerId
	self.careerCo = self.careerId ~= 0 and Rouge2_CareerConfig.instance:getCareerConfig(self.careerId)
	self.consumeAttrNum = info.consumeAttrNum or 0
end

function Rouge2_LeaderInfoMO:getMainCareerId()
	return self.mainCareerId
end

function Rouge2_LeaderInfoMO:getCareerId()
	return self.careerId
end

function Rouge2_LeaderInfoMO:getCareerConfig()
	return self.careerCo
end

function Rouge2_LeaderInfoMO:getRevivalCoin()
	return self.revivalCoin
end

function Rouge2_LeaderInfoMO:updateRevivalCoin(revivalCoin)
	self.revivalCoin = revivalCoin or 0
end

function Rouge2_LeaderInfoMO:getEquipActiveSkillMap()
	return self.equipActiveSkillMap
end

function Rouge2_LeaderInfoMO:getEquipActiveSkill(index)
	return self.equipActiveSkill and self.equipActiveSkill[index] or 0
end

function Rouge2_LeaderInfoMO:isActiveSkillInUse(skillUid)
	return self.equipActiveSkillMap and self.equipActiveSkillMap[skillUid] ~= nil
end

function Rouge2_LeaderInfoMO:getConsumeAttrNum()
	return self.consumeAttrNum
end

return Rouge2_LeaderInfoMO
