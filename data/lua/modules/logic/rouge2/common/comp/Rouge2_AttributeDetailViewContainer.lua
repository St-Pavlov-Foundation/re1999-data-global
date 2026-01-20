-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailViewContainer.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailViewContainer", package.seeall)

local Rouge2_AttributeDetailViewContainer = class("Rouge2_AttributeDetailViewContainer", BaseViewContainer)

function Rouge2_AttributeDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_AttributeDetailView.New())
	table.insert(views, Rouge2_AttributeDetailTipsView.New())

	return views
end

return Rouge2_AttributeDetailViewContainer
