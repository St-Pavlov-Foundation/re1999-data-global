module("modules.logic.versionactivity1_5.act142.view.Activity142TaskViewContainer", package.seeall)

slot0 = class("Activity142TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_TaskList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = Activity142TaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.cellWidth = 1160
	slot2.cellHeight = 165

	for slot7 = 1, 10 do
	end

	table.insert(slot1, LuaListScrollViewWithAnimator.New(Activity142TaskListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.06
	}))
	table.insert(slot1, Activity142TaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
