-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillEditScrollView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillEditScrollView", package.seeall)

local Rouge2_BackpackSkillEditScrollView = class("Rouge2_BackpackSkillEditScrollView", LuaListScrollView)

function Rouge2_BackpackSkillEditScrollView:ctor()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "SkilleditPanel/List/#scroll_List"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "SkilleditPanel/List/#scroll_List/Viewport/Content/#go_SkillItem"
	scrollParam.cellClass = Rouge2_BackpackSkillListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 920
	scrollParam.cellHeight = 250
	scrollParam.cellSpaceV = -4

	Rouge2_BackpackSkillEditScrollView.super.ctor(self, Rouge2_BackpackSkillEditListModel.instance, scrollParam)
end

function Rouge2_BackpackSkillEditScrollView:getRenderCellList()
	local renderCellMap = {}
	local skillNum = Rouge2_BackpackSkillEditListModel.instance:getCount()

	for i = 1, skillNum do
		local csIndex = i - 1
		local isVisible = self._csListScroll:IsVisual(csIndex)

		if isVisible then
			local cell = self._csListScroll:GetRenderCellRect(csIndex)

			renderCellMap[i] = cell
		end
	end

	return renderCellMap
end

function Rouge2_BackpackSkillEditScrollView:getDragSkillMo(position)
	local renderCellList = self:getRenderCellList()

	for index, cell in pairs(renderCellList) do
		local isDrag = recthelper.screenPosInRect(cell, nil, position.x, position.y)

		if isDrag then
			local skillMo = Rouge2_BackpackSkillEditListModel.instance:getByIndex(index)

			return skillMo
		end
	end
end

return Rouge2_BackpackSkillEditScrollView
