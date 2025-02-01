module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioViewContainer", package.seeall)

slot0 = class("VersionActivity1_3RadioViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "Middle/FMSlider/#scroll_FMChannelList"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content/#go_radiochannelitem"
	slot1.cellClass = VersionActivity1_3RadioChannelItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 100
	slot1.cellHeight = 100
	slot1.cellSpaceH = 0
	slot1.startSpace = 210
	slot1.endSpace = 210
	slot0._channelScrollView = LuaListScrollView.New(V1A3_RadioChannelListModel.instance, slot1)

	return {
		VersionActivity1_3RadioView.New(),
		slot0._channelScrollView
	}
end

return slot0
