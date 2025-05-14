module("modules.logic.room.view.RoomInformPlayerViewContainer", package.seeall)

local var_0_0 = class("RoomInformPlayerViewContainer", BaseViewContainer)
local var_0_1 = {
	[LangSettings.zh] = {
		cellSpaceH = 37,
		cellWidth = 280,
		lineCount = 4
	},
	[LangSettings.jp] = {
		cellSpaceH = 37,
		cellWidth = 390,
		lineCount = 3
	},
	[LangSettings.en] = {
		cellSpaceH = 60,
		cellWidth = 380,
		lineCount = 3
	}
}

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = var_0_1[GameConfig:GetCurLangType()] or var_0_1[LangSettings.zh]
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "object/scroll_inform"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "object/scroll_inform/Viewport/#go_informContent/#go_informItem"
	var_1_1.cellClass = RoomInformReportTypeItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = var_1_0.lineCount
	var_1_1.cellWidth = var_1_0.cellWidth
	var_1_1.cellHeight = 40
	var_1_1.cellSpaceH = var_1_0.cellSpaceH
	var_1_1.cellSpaceV = 33
	var_1_1.startSpace = 0

	return {
		CommonViewFrame.New(),
		RoomInformPlayerView.New(),
		LuaListScrollView.New(RoomReportTypeListModel.instance, var_1_1)
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_3_0:closeThis()
end

return var_0_0
