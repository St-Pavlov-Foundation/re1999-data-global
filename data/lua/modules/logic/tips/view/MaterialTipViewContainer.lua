-- chunkname: @modules/logic/tips/view/MaterialTipViewContainer.lua

module("modules.logic.tips.view.MaterialTipViewContainer", package.seeall)

local MaterialTipViewContainer = class("MaterialTipViewContainer", BaseViewContainer)

function MaterialTipViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_include/#scroll_product"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = IconMgrConfig.UrlItemIcon
	scrollParam.cellClass = CommonItemIcon
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 250
	scrollParam.cellHeight = 250
	scrollParam.cellSpaceH = -46.5

	return {
		MaterialTipView.New(),
		LuaListScrollView.New(MaterialTipListModel.instance, scrollParam),
		TabViewGroup.New(1, "righttop")
	}
end

function MaterialTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function MaterialTipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

function MaterialTipViewContainer:refreshCurrencyView(currency)
	self._currencyView:setCurrencyType(currency)

	self._currencyView.foreHideBtn = true
end

return MaterialTipViewContainer
