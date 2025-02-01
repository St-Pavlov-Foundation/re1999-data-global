module("modules.logic.versionactivity1_5.act142.view.Activity142StoryViewContainer", package.seeall)

slot0 = class("Activity142StoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#simage_blackbg/#scroll_storylist"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#simage_blackbg/#go_storyitem"
	slot2.cellClass = Activity142StoryItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.cellWidth = 690
	slot2.cellHeight = 750
	slot2.cellSpaceH = 178

	table.insert(slot1, LuaListScrollView.New(Activity142StoryListModel.instance, slot2))
	table.insert(slot1, Activity142StoryView.New())

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
