module("modules.logic.social.view.InformPlayerTipViewContainer", package.seeall)

local var_0_0 = class("InformPlayerTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "scroll_inform"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "scroll_inform/Viewport/#go_informContent/#go_informItem"
	var_1_0.cellClass = ReportTypeItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 280
	var_1_0.cellHeight = 40
	var_1_0.cellSpaceH = 37
	var_1_0.cellSpaceV = 33
	var_1_0.startSpace = 0

	return {
		InformPlayerTipView.New(),
		LuaListScrollView.New(ReportTypeListModel.instance, var_1_0)
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
