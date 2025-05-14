module("modules.logic.settings.view.SettingsVoicePackageViewContainer", package.seeall)

local var_0_0 = class("SettingsVoicePackageViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "view/#scroll_content"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = SettingsVoicePackageListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1430
	var_1_1.cellHeight = 90
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 2
	var_1_1.startSpace = 0
	var_1_1.sortMode = ScrollEnum.ScrollSortDown

	table.insert(var_1_0, LuaListScrollView.New(SettingsVoicePackageListModel.instance, var_1_1))
	table.insert(var_1_0, SettingsVoicePackageView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
