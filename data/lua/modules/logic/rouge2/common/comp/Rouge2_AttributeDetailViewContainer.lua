-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailViewContainer.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailViewContainer", package.seeall)

local Rouge2_AttributeDetailViewContainer = class("Rouge2_AttributeDetailViewContainer", BaseViewContainer)

function Rouge2_AttributeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_AttributeDetailBuffView.New())
	table.insert(views, Rouge2_AttributeDetailAttrView.New())
	table.insert(views, Rouge2_AttributeDetailView.New())

	return views
end

function Rouge2_AttributeDetailViewContainer:onContainerInit()
	self._attrInfoList = {}

	local careerId = self.viewParam and self.viewParam.careerId
	local attrInfoList = self.viewParam and self.viewParam.attrInfoList

	tabletool.addValues(self._attrInfoList, attrInfoList)
	table.sort(self._attrInfoList, function(aAttrInfo, bAttrInfo)
		local aSortIndex = Rouge2_CareerConfig.instance:getAttrSortIndex(careerId, aAttrInfo.attrId)
		local bSortIndex = Rouge2_CareerConfig.instance:getAttrSortIndex(careerId, bAttrInfo.attrId)

		return aSortIndex < bSortIndex
	end)
end

function Rouge2_AttributeDetailViewContainer:getAttrInfoList()
	return self._attrInfoList
end

function Rouge2_AttributeDetailViewContainer:getAttrInfoByIndex(index)
	return self._attrInfoList and self._attrInfoList[index]
end

return Rouge2_AttributeDetailViewContainer
