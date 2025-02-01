module("modules.logic.settings.view.SettingsVoicePackageViewContainer", package.seeall)

slot0 = class("SettingsVoicePackageViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "view/#scroll_content"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = SettingsVoicePackageListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1430
	slot2.cellHeight = 90
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 2
	slot2.startSpace = 0
	slot2.sortMode = ScrollEnum.ScrollSortDown

	table.insert(slot1, LuaListScrollView.New(SettingsVoicePackageListModel.instance, slot2))
	table.insert(slot1, SettingsVoicePackageView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
