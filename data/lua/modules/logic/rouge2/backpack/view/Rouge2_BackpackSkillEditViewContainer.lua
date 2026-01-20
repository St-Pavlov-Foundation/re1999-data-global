-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillEditViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillEditViewContainer", package.seeall)

local Rouge2_BackpackSkillEditViewContainer = class("Rouge2_BackpackSkillEditViewContainer", BaseViewContainer)

function Rouge2_BackpackSkillEditViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BackpackSkillEditView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

return Rouge2_BackpackSkillEditViewContainer
