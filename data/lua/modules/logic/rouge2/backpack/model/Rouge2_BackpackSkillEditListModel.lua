-- chunkname: @modules/logic/rouge2/backpack/model/Rouge2_BackpackSkillEditListModel.lua

module("modules.logic.rouge2.backpack.model.Rouge2_BackpackSkillEditListModel", package.seeall)

local Rouge2_BackpackSkillEditListModel = class("Rouge2_BackpackSkillEditListModel", MultiSortListScrollModel)

function Rouge2_BackpackSkillEditListModel:initSort()
	Rouge2_BackpackSkillEditListModel.super.initSort(self)

	self._isUseBXS = Rouge2_Model.instance:isUseBXSCareer()

	self:addSortType(Rouge2_Enum.BackpackSkillSortType.GetTime, self._sortGetTime)
	self:addSortType(Rouge2_Enum.BackpackSkillSortType.AssembleCost, self._sortAssembleCost)
	self:addOtherSort(self._sortFirst, self._sortDefault)

	self._isDrag = false
	self._dragEndTime = nil
end

function Rouge2_BackpackSkillEditListModel:initList()
	local skills = Rouge2_BackpackModel.instance:getAllNotUseActiveSkillList()

	self._skillMoList = {}
	self._uid2SkillMoMap = {}

	if skills then
		for _, skillMo in ipairs(skills) do
			table.insert(self._skillMoList, skillMo)

			self._uid2SkillMoMap[skillMo:getUid()] = skillMo
		end
	end

	self:setSortList(self._skillMoList)
end

function Rouge2_BackpackSkillEditListModel._sortFirst(aSkillMo, bSkillMo)
	local isABlock = Rouge2_BackpackSkillEditListModel.instance:isAttrBlockInBXS(aSkillMo:getAttrTag())
	local isBBlock = Rouge2_BackpackSkillEditListModel.instance:isAttrBlockInBXS(bSkillMo:getAttrTag())

	if isABlock ~= isBBlock then
		return not isABlock
	end
end

function Rouge2_BackpackSkillEditListModel._sortDefault(aSkillMo, bSkillMo, ascending, instance)
	local aItemId = aSkillMo:getItemId()
	local bItemId = bSkillMo:getItemId()

	if aItemId ~= bItemId then
		return aItemId < bItemId
	end

	return aSkillMo:getUid() < bSkillMo:getUid()
end

function Rouge2_BackpackSkillEditListModel._sortGetTime(aSkillMo, bSkillMo, ascending, instance)
	local aUid = aSkillMo:getUid()
	local bUid = bSkillMo:getUid()

	if aUid ~= bUid then
		if ascending then
			return aUid < bUid
		else
			return bUid < aUid
		end
	end
end

function Rouge2_BackpackSkillEditListModel._sortAssembleCost(aSkillMo, bSkillMo, ascending, instance)
	local aItemId = aSkillMo:getItemId()
	local bItemId = bSkillMo:getItemId()
	local aSkillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(aItemId)
	local bSkillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(bItemId)
	local aAssembleCost = aSkillCo and aSkillCo.assembleCost or 0
	local bAssembleCost = bSkillCo and bSkillCo.assembleCost or 0

	if aAssembleCost ~= bAssembleCost then
		if ascending then
			return aAssembleCost < bAssembleCost
		else
			return bAssembleCost < aAssembleCost
		end
	end
end

function Rouge2_BackpackSkillEditListModel:onSelectUseSkillIndex(index)
	if self._selectUseSkillIndex == index then
		return
	end

	self._selectUseSkillIndex = index

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectActiveSkillHole, index)

	if self._isUseBXS then
		local bxsAttrId = Rouge2_MapConfig.instance:getBXSAttrId(self._selectUseSkillIndex)

		if self._bxsAttrId ~= bxsAttrId then
			self._bxsAttrId = bxsAttrId

			self:setSortList(self._skillMoList)
		end
	end
end

function Rouge2_BackpackSkillEditListModel:getSelectUseSkillIndex()
	return self._selectUseSkillIndex
end

function Rouge2_BackpackSkillEditListModel:getMo(uid)
	return self._uid2SkillMoMap and self._uid2SkillMoMap[uid]
end

function Rouge2_BackpackSkillEditListModel:getCurBXSAttrId()
	return self._bxsAttrId
end

function Rouge2_BackpackSkillEditListModel:isAttrBlockInBXS(careerId)
	return self._isUseBXS and self._bxsAttrId ~= tonumber(careerId)
end

function Rouge2_BackpackSkillEditListModel:isDraging()
	return self._isDrag
end

function Rouge2_BackpackSkillEditListModel:setIsDraging(isDrag)
	self._isDrag = isDrag

	if not self._isDrag then
		self._dragEndTime = UnityEngine.Time.frameCount
	end
end

function Rouge2_BackpackSkillEditListModel:getLastEndDragTime()
	return self._dragEndTime or 0
end

Rouge2_BackpackSkillEditListModel.instance = Rouge2_BackpackSkillEditListModel.New()

return Rouge2_BackpackSkillEditListModel
