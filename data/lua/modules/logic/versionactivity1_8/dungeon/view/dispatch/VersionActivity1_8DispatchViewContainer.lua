module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_8DispatchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "container/left/#go_herocontainer/#scroll_hero"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "container/left/#go_herocontainer/#scroll_hero/Viewport/Content/#go_heroitem"
	var_1_0.cellClass = VersionActivity1_8DispatchHeroItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 185
	var_1_0.cellHeight = 164
	var_1_0.cellSpaceV = 25
	var_1_0.startSpace = 26
	var_1_0.endSpace = 26

	return {
		VersionActivity1_8DispatchView.New(),
		LuaListScrollView.New(DispatchHeroListModel.instance, var_1_0)
	}
end

function var_0_0.onContainerInit(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function var_0_0.onContainerCloseFinish(arg_3_0)
	DispatchHeroListModel.instance:clear()
end

return var_0_0
