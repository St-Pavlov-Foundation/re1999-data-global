module("modules.logic.summon.view.SummonPoolHistoryViewContainer", package.seeall)

local var_0_0 = class("SummonPoolHistoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SummonPoolHistoryView.New())
	table.insert(var_1_0, arg_1_0:_createScrollView())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0._createScrollView(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "allbg/left/scroll_pooltype"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_3_0.prefabUrl = "allbg/left/pooltypeitem"
	var_3_0.cellClass = SummonPoolHistoryTypeItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 380
	var_3_0.cellHeight = 116
	var_3_0.cellSpaceH = 0
	var_3_0.cellSpaceV = 8
	var_3_0.startSpace = 0

	local var_3_1 = {}

	for iter_3_0 = 1, 10 do
		var_3_1[iter_3_0] = (iter_3_0 - 1) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(SummonPoolHistoryTypeListModel.instance, var_3_0, var_3_1)
end

return var_0_0
