-- chunkname: @modules/logic/survival/view/survivalsimplelistcomp/SurvivalSimpleListItem.lua

module("modules.logic.survival.view.survivalsimplelistcomp.SurvivalSimpleListItem", package.seeall)

local SurvivalSimpleListItem = class("SurvivalSimpleListItem", LuaCompBase)

function SurvivalSimpleListItem:ctor(viewContainer)
	self.viewContainer = viewContainer
end

function SurvivalSimpleListItem:init(viewGO)
	self.viewGO = viewGO

	self:onInit(viewGO)
end

function SurvivalSimpleListItem:addEventListeners()
	return
end

function SurvivalSimpleListItem:removeEventListeners()
	return
end

function SurvivalSimpleListItem:showItem(data, index, isSelect)
	self.data = data
	self.index = index
	self.isSelect = isSelect

	self:onItemShow(data)
end

function SurvivalSimpleListItem:hideItem()
	self:onItemHide()
end

function SurvivalSimpleListItem:setSelect(isSelect)
	self.isSelect = isSelect

	self:onSelectChange(isSelect)
end

function SurvivalSimpleListItem:getItemAnimators()
	if self._animators == nil then
		local animator = gohelper.findComponentAnim(self.viewGO)

		self._animators = {
			animator
		}
	end

	return self._animators
end

function SurvivalSimpleListItem:onInit(viewGO)
	return
end

function SurvivalSimpleListItem:onItemShow(data)
	return
end

function SurvivalSimpleListItem:onItemHide()
	return
end

function SurvivalSimpleListItem:onSelectChange(isSelect)
	return
end

return SurvivalSimpleListItem
