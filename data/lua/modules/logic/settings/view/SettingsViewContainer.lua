module("modules.logic.settings.view.SettingsViewContainer", package.seeall)

local var_0_0 = class("SettingsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_category"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = SettingsCategoryListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 300
	var_1_0.cellHeight = 120
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0

	return {
		LuaListScrollView.New(SettingsCategoryListModel.instance, var_1_0),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_settingscontent"),
		SettingsView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			}, nil, arg_2_0.clickClose, nil, nil, arg_2_0)
		}
	elseif arg_2_1 == 2 then
		return {
			SettingsKeyMapView.New(),
			SettingsAccountView.New(),
			SettingsGraphicsView.New(),
			SettingsSoundView.New(),
			SettingsPushView.New(),
			SettingsLanguageView.New(),
			SettingsGameView.New()
		}
	end
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_3_1)
end

function var_0_0.clickClose(arg_4_0)
	ViewMgr.instance:openView(ViewName.MainThumbnailView)
end

return var_0_0
