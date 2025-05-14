module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_5DispatchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "container/left/#go_herocontainer/#scroll_hero"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "container/left/#go_herocontainer/#scroll_hero/Viewport/Content/#go_heroitem"
	var_1_0.cellClass = VersionActivity1_5DispatchHeroItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 154
	var_1_0.cellHeight = 164
	var_1_0.cellSpaceH = 25
	var_1_0.cellSpaceV = 25

	return {
		VersionActivity1_5DispatchView.New(),
		LuaListScrollView.New(VersionActivity1_5HeroListModel.instance, var_1_0)
	}
end

function var_0_0.onContainerInit(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function var_0_0.onContainerCloseFinish(arg_3_0)
	VersionActivity1_5HeroListModel.instance:clear()
end

return var_0_0
