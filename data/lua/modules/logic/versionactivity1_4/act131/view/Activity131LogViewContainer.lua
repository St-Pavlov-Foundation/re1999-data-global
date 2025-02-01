module("modules.logic.versionactivity1_4.act131.view.Activity131LogViewContainer", package.seeall)

slot0 = class("Activity131LogViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "#scroll_log"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = Activity131LogItem
	slot2.scrollDir = ScrollEnum.ScrollDirV

	table.insert(slot1, LuaMixScrollView.New(Activity131LogListModel.instance, slot2))
	table.insert(slot1, Activity131LogView.New())

	return slot1
end

return slot0
