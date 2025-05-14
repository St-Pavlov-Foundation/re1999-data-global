module("modules.logic.versionactivity1_5.aizila.view.AiZiLaTaskViewContainer", package.seeall)

local var_0_0 = class("AiZiLaTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_TaskList"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = AiZiLaTaskItem.prefabPath
	var_1_1.cellClass = AiZiLaTaskItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV

	table.insert(var_1_0, LuaMixScrollView.New(AiZiLaTaskListModel.instance, var_1_1))
	table.insert(var_1_0, AiZiLaTaskView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

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
