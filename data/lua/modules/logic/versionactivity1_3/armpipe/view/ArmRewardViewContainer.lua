module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardViewContainer", package.seeall)

slot0 = class("ArmRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Root/#scroll_TaskList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = ArmRewardViewTaskItem.prefabPath
	slot2.cellClass = ArmRewardViewTaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 824
	slot2.cellHeight = 158
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	for slot7 = 1, 10 do
	end

	table.insert(slot1, LuaListScrollViewWithAnimator.New(Activity124RewardListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.06 + 0.3
	}))
	table.insert(slot1, ArmRewardView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return slot0
