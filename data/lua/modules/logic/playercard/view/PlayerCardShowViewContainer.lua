module("modules.logic.playercard.view.PlayerCardShowViewContainer", package.seeall)

local var_0_0 = class("PlayerCardShowViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PlayerCardShowView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_card"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes.carditem
	var_1_1.cellClass = PlayerCardCardItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 482
	var_1_1.cellHeight = 186
	var_1_1.startSpace = 150
	arg_1_0._scrollView = LuaListScrollView.New(PlayerCardProgressModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0._scrollView)

	return var_1_0
end

return var_0_0
