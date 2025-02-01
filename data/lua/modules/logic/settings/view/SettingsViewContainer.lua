module("modules.logic.settings.view.SettingsViewContainer", package.seeall)

slot0 = class("SettingsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_category"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = SettingsCategoryListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 300
	slot1.cellHeight = 120
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0

	return {
		LuaListScrollView.New(SettingsCategoryListModel.instance, slot1),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_settingscontent"),
		SettingsView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			}, nil, slot0.clickClose, nil, , slot0)
		}
	elseif slot1 == 2 then
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

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.clickClose(slot0)
	ViewMgr.instance:openView(ViewName.MainThumbnailView)
end

return slot0
