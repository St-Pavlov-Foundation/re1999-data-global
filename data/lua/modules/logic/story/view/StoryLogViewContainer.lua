module("modules.logic.story.view.StoryLogViewContainer", package.seeall)

slot0 = class("StoryLogViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "#scroll_log"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = StoryLogItem
	slot2.scrollDir = ScrollEnum.ScrollDirV

	table.insert(slot1, LuaMixScrollView.New(StoryLogListModel.instance, slot2))
	table.insert(slot1, StoryLogView.New())

	return slot1
end

return slot0
