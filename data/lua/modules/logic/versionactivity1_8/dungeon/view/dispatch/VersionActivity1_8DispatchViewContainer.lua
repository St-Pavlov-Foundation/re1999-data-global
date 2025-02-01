module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchViewContainer", package.seeall)

slot0 = class("VersionActivity1_8DispatchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "container/left/#go_herocontainer/#scroll_hero"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "container/left/#go_herocontainer/#scroll_hero/Viewport/Content/#go_heroitem"
	slot1.cellClass = VersionActivity1_8DispatchHeroItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 4
	slot1.cellWidth = 185
	slot1.cellHeight = 164
	slot1.cellSpaceV = 25
	slot1.startSpace = 26
	slot1.endSpace = 26

	return {
		VersionActivity1_8DispatchView.New(),
		LuaListScrollView.New(DispatchHeroListModel.instance, slot1)
	}
end

function slot0.onContainerInit(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function slot0.onContainerCloseFinish(slot0)
	DispatchHeroListModel.instance:clear()
end

return slot0
