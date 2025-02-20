module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftRewardViewContainer", package.seeall)

slot0 = class("VersionActivity2_3NewCultivationGiftRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_reward"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#scroll_reward/viewport/content/#go_rewarditem"
	slot1.cellClass = VersionActivity2_3NewCultivationRewardItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 6
	slot1.cellWidth = 250
	slot1.cellHeight = 250
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 20
	slot1.endSpace = 10
	slot1.minUpdateCountInFrame = 100
	slot2 = {}

	table.insert(slot2, VersionActivity2_3NewCultivationGiftRewardView.New())
	table.insert(slot2, LuaListScrollView.New(VersionActivity2_3NewCultivationGiftRewardListModel.instance, slot1))

	return slot2
end

return slot0
