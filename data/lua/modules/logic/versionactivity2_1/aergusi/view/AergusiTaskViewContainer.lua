module("modules.logic.versionactivity2_1.aergusi.view.AergusiTaskViewContainer", package.seeall)

slot0 = class("AergusiTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_TaskList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = AergusiTaskItem.prefabPath
	slot2.cellClass = AergusiTaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1160
	slot2.cellHeight = 165
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	for slot7 = 1, 10 do
	end

	table.insert(slot1, LuaListScrollViewWithAnimator.New(AergusiTaskListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.06
	}))
	table.insert(slot1, AergusiTaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return slot0
