-- chunkname: @modules/logic/activity/view/show/ActivityGuestBindViewItem.lua

module("modules.logic.activity.view.show.ActivityGuestBindViewItem", package.seeall)

local ActivityGuestBindViewItem = class("ActivityGuestBindViewItem", ListScrollCellExtend)

function ActivityGuestBindViewItem:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityGuestBindViewItem:addEvents()
	return
end

function ActivityGuestBindViewItem:removeEvents()
	return
end

function ActivityGuestBindViewItem:_editableInitView()
	self._item = IconMgr.instance:getCommonPropItemIcon(self._goitem)
end

function ActivityGuestBindViewItem:_editableAddEvents()
	return
end

function ActivityGuestBindViewItem:_editableRemoveEvents()
	return
end

function ActivityGuestBindViewItem:onUpdateMO(mo)
	self._mo = mo

	self:_refresh()
end

function ActivityGuestBindViewItem:onSelect(isSelect)
	return
end

function ActivityGuestBindViewItem:onDestroyView()
	return
end

function ActivityGuestBindViewItem:_refresh()
	local mo = self._mo
	local itemCO = mo.itemCO

	self._item:setMOValue(itemCO[1], itemCO[2], itemCO[3], nil, true)
end

return ActivityGuestBindViewItem
