-- chunkname: @modules/logic/minors/view/DateOfBirthSelectionViewItem.lua

module("modules.logic.minors.view.DateOfBirthSelectionViewItem", package.seeall)

local DateOfBirthSelectionViewItem = class("DateOfBirthSelectionViewItem", ListScrollCellExtend)

function DateOfBirthSelectionViewItem:onInitView()
	self._dropdown = gohelper.findChildDropdown(self.viewGO, "")
	self._arrowTran = gohelper.findChild(self.viewGO, "arrow").transform
	self._dropdownClick = gohelper.getClick(self.viewGO, "")
end

function DateOfBirthSelectionViewItem:addEvents()
	self._dropdownClick:AddClickListener(self._onDropdownClick, self)
	self._dropdown:AddOnValueChanged(self._onDropDownValueChange, self)
end

function DateOfBirthSelectionViewItem:removeEvents()
	self._dropdown:RemoveOnValueChanged()
	self._dropdownClick:RemoveClickListener()
end

function DateOfBirthSelectionViewItem:onUpdateMO(mo)
	self._mo = mo

	self:_refresh()
end

function DateOfBirthSelectionViewItem:onDestroyView()
	return
end

function DateOfBirthSelectionViewItem:_onDropDownValueChange()
	local mo = self._mo
	local parent = mo._parent
	local type = mo.type
	local newDropDownIndex = self._dropdown:GetValue()
	local last = parent:getDropDownSelectedIndex(type)

	if last ~= newDropDownIndex then
		parent:onClickDropDownOption(type, newDropDownIndex)
	end
end

function DateOfBirthSelectionViewItem:_refresh()
	self._dropdown:ClearOptions()

	self._options = self:_getOptions()

	self._dropdown:AddOptions(self._options)
	self._dropdown:SetValue(self:_getSelectedIndex())
end

function DateOfBirthSelectionViewItem:_getOptions()
	local mo = self._mo
	local type = mo.type
	local parent = mo._parent

	return parent:getDropDownOption(type)
end

function DateOfBirthSelectionViewItem:_getSelectedIndex()
	local mo = self._mo
	local type = mo.type
	local parent = mo._parent

	return parent:getDropDownSelectedIndex(type)
end

local ScrollRect = UnityEngine.UI.ScrollRect
local kScrollRectGapV = 12
local kItemHeight = 73
local kViewportMaxCount = 5
local kStep = kScrollRectGapV + kItemHeight

function DateOfBirthSelectionViewItem:_onDropdownClick()
	local dropdownIndex = self._dropdown:GetValue()
	local dropDownTemplate = gohelper.findChild(self.viewGO, "Dropdown List")

	if not dropDownTemplate then
		return
	end

	local scrollRect = dropDownTemplate:GetComponent(typeof(ScrollRect))

	if not scrollRect then
		return
	end

	local contentTran = scrollRect.content

	if not contentTran then
		return
	end

	local maxCount = self._options and #self._options or 0
	local y = dropdownIndex * kStep
	local maxY = math.max(0, (maxCount - kViewportMaxCount) * kStep)

	recthelper.setAnchorY(contentTran, math.min(maxY, y))
end

return DateOfBirthSelectionViewItem
