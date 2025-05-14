module("modules.logic.versionactivity1_5.act142.view.Activity142StoryViewContainer", package.seeall)

local var_0_0 = class("Activity142StoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#simage_blackbg/#scroll_storylist"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#simage_blackbg/#go_storyitem"
	var_1_1.cellClass = Activity142StoryItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.cellWidth = 690
	var_1_1.cellHeight = 750
	var_1_1.cellSpaceH = 178

	table.insert(var_1_0, LuaListScrollView.New(Activity142StoryListModel.instance, var_1_1))
	table.insert(var_1_0, Activity142StoryView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return var_0_0
