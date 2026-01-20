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
		LuaListScrollView.New(MaterialTipListModel.instance, scrollParam)
	}
end

function MaterialTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return MaterialTipViewContainer
