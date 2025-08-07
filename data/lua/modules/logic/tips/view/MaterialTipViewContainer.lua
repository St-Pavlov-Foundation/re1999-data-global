module("modules.logic.tips.view.MaterialTipViewContainer", package.seeall)

local var_0_0 = class("MaterialTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_include/#scroll_product"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = IconMgrConfig.UrlItemIcon
	var_1_0.cellClass = CommonItemIcon
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 250
	var_1_0.cellHeight = 250
	var_1_0.cellSpaceH = -46.5

	return {
		MaterialTipView.New(),
		LuaListScrollView.New(MaterialTipListModel.instance, var_1_0)
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
