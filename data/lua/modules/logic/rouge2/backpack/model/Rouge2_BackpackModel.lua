-- chunkname: @modules/logic/rouge2/backpack/model/Rouge2_BackpackModel.lua

module("modules.logic.rouge2.backpack.model.Rouge2_BackpackModel", package.seeall)

local Rouge2_BackpackModel = class("Rouge2_BackpackModel", BaseModel)

function Rouge2_BackpackModel:onInit()
	self._bagInfo = nil
end

function Rouge2_BackpackModel:reInit()
	self:onInit()
end

function Rouge2_BackpackModel:isActiveSkillInUse(skillUid)
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()

	return leaderInfo and leaderInfo:isActiveSkillInUse(skillUid)
end

function Rouge2_BackpackModel:isActiveSkillIndexInUse(index)
	local skillMo = self:index2UseActiveSkill(index)

	return skillMo and skillMo ~= nil
end

function Rouge2_BackpackModel:index2UseActiveSkill(index)
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()
	local skillUid = leaderInfo and leaderInfo:getEquipActiveSkill(index)

	if skillUid and skillUid ~= Rouge2_Enum.EmptyActiveSkill then
		return self:getItem(skillUid)
	end
end

function Rouge2_BackpackModel:uid2UseActiveSkillIndex(skillUid)
	if not self:isActiveSkillInUse(skillUid) then
		return
	end

	for i = 1, Rouge2_Enum.MaxActiveSkillNum do
		local skillMo = self:index2UseActiveSkill(i)

		if skillMo and skillMo:getUid() == skillUid then
			return i
		end
	end
end

function Rouge2_BackpackModel:getAllNotUseActiveSkillList()
	local notUseSkillList = {}
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()
	local allSkillList = self:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if allSkillList then
		for _, skillMo in ipairs(allSkillList) do
			if not leaderInfo:isActiveSkillInUse(skillMo:getUid()) then
				table.insert(notUseSkillList, skillMo)
			end
		end
	end

	return notUseSkillList
end

function Rouge2_BackpackModel:hasAnyNotUseActiveSkill()
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()
	local allSkillList = self:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if allSkillList then
		for _, skillMo in ipairs(allSkillList) do
			if not leaderInfo:isActiveSkillInUse(skillMo:getUid()) then
				return true
			end
		end
	end
end

function Rouge2_BackpackModel:getUseActiveSkillAssembleCost()
	local allCost = 0

	for i = 1, Rouge2_Enum.MaxActiveSkillNum do
		local skillMo = self:index2UseActiveSkill(i)

		if skillMo ~= nil then
			local skillId = skillMo:getItemId()
			local skillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(skillId)
			local assembleCost = skillCo and skillCo.assembleCost or 0

			allCost = allCost + assembleCost
		end
	end

	return allCost
end

function Rouge2_BackpackModel:updateBagInfo(bagInfo)
	if not self._bagInfo then
		self._bagInfo = Rouge2_BagInfoMO.New()
	end

	self._bagInfo:init(bagInfo)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onUpdateBagInfo)
end

function Rouge2_BackpackModel:updateItems(itemInfoList)
	local bagInfo = self:getBagInfo()

	if bagInfo then
		bagInfo:updateItems(itemInfoList)
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onUpdateBagInfo)
end

function Rouge2_BackpackModel:removeItems(itemInfoList)
	local bagInfo = self:getBagInfo()

	if bagInfo then
		bagInfo:removeItems(itemInfoList)
	end
end

function Rouge2_BackpackModel:getBagInfo()
	return self._bagInfo
end

function Rouge2_BackpackModel:getSubBag(bagType)
	local bagInfo = self:getBagInfo()

	return bagInfo and bagInfo:getBag(bagType)
end

function Rouge2_BackpackModel:getItemList(bagType)
	local bagMo = self:getSubBag(bagType)

	return bagMo and bagMo:getItemList()
end

function Rouge2_BackpackModel:getItemListByItemId(itemId)
	local bagType = Rouge2_BackpackHelper.itemId2BagType(itemId)
	local bagMo = self:getSubBag(bagType)

	return bagMo and bagMo:getItemListByItemId(itemId)
end

function Rouge2_BackpackModel:getFilterItemList(bagType, filterTypeMap)
	local itemList = self:getItemList(bagType)

	return Rouge2_BackpackHelper.filterItemList(itemList, filterTypeMap)
end

function Rouge2_BackpackModel:getItem(uid)
	local bagType = Rouge2_BackpackHelper.uid2BagType(uid)
	local bagMo = self:getSubBag(bagType)

	return bagMo and bagMo:getItem(uid)
end

function Rouge2_BackpackModel:getNotUniqueCollectionNum()
	local allMoList = self:getItemList(Rouge2_Enum.BagType.Relics)
	local num = 0

	if allMoList then
		for _, relicsMo in ipairs(allMoList) do
			if not Rouge2_CollectionHelper.isUniqueCollection(relicsMo.itemId) then
				num = num + 1
			end
		end
	end

	return num
end

function Rouge2_BackpackModel:getCurBoxPoint()
	local leaderInfo = Rouge2_Model.instance:getLeaderInfo()
	local consumeAttrNum = leaderInfo and leaderInfo.consumeAttrNum or 0
	local boxAttrId = tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.BXSBoxCountAttrId].value)
	local attrValue = Rouge2_Model.instance:getAttrValue(boxAttrId)

	return attrValue - consumeAttrNum
end

Rouge2_BackpackModel.instance = Rouge2_BackpackModel.New()

return Rouge2_BackpackModel
