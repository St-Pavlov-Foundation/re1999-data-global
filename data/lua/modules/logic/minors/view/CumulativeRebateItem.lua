-- chunkname: @modules/logic/minors/view/CumulativeRebateItem.lua

module("modules.logic.minors.view.CumulativeRebateItem", package.seeall)

local CumulativeRebateItem = class("CumulativeRebateItem", RougeSimpleItemBase)

function CumulativeRebateItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CumulativeRebateItem:addEvents()
	return
end

function CumulativeRebateItem:removeEvents()
	return
end

function CumulativeRebateItem.s_create(Self, srcGo, baseViewContainer)
	local item = CumulativeRebateItem.New({
		parent = Self,
		baseViewContainer = baseViewContainer
	})

	item:init(srcGo)
	item:setActive(false)

	return item
end

function CumulativeRebateItem.s_createByView(Self, srcGo)
	local item = CumulativeRebateItem.s_create(Self, srcGo, Self.viewContainer)

	return item
end

function CumulativeRebateItem.s_createByListScrollCellExtend(Self, srcGo)
	local scrollView = Self._view
	local item = CumulativeRebateItem.s_create(Self, srcGo, scrollView and scrollView.viewContainer or Self.viewContainer)

	return item
end

function CumulativeRebateItem:ctor(...)
	CumulativeRebateItem.super.ctor(self, ...)
end

function CumulativeRebateItem:onDestroyView()
	CumulativeRebateItem.super.onDestroyView(self)
end

function CumulativeRebateItem:_editableInitView()
	CumulativeRebateItem.super._editableInitView(self)

	self._num = gohelper.findChildText(self.viewGO, "bg/#num")
	self._num.text = ""
end

function CumulativeRebateItem:_editableAddEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function CumulativeRebateItem:_editableRemoveEvents()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function CumulativeRebateItem:_onRefreshActivityState(actId)
	if actId ~= self:_actId() then
		return
	end

	self:refresh()
end

function CumulativeRebateItem:_actId()
	return ActivityEnum.Activity.V3a7_Act236
end

function CumulativeRebateItem:setData(mo)
	CumulativeRebateItem.super.setData(self, mo)

	if mo and mo.lua_store_charge_goods_id and self:_isActOpen() then
		local t = self:_calcScore(mo.quantity)

		self._num.text = self:_calcScore(mo.quantity)

		self:setActive(true)
	else
		self:setActive(false)
	end
end

function CumulativeRebateItem:_isActOpen()
	return ActivityType101Model.instance:isOpen(self:_actId())
end

function CumulativeRebateItem:_getChargeGoodsConfig()
	return StoreConfig.instance:getChargeGoodsConfig(self._mo.lua_store_charge_goods_id)
end

function CumulativeRebateItem:_lua_activity236_control()
	return lua_activity236_control.configDict[self:_actId()]
end

function CumulativeRebateItem:_convRate()
	local CO = self:_lua_activity236_control()
	local strList = string.split(CO.conversionRate, "#")

	return strList and tonumber(strList[2]) or 0
end

function CumulativeRebateItem:_calcScore(quantity)
	quantity = quantity or 1

	local CO = self:_getChargeGoodsConfig()
	local price = CO.pricezh
	local convRate = self:_convRate()
	local score = math.ceil(price * quantity * convRate / 1000)

	return score
end

return CumulativeRebateItem
