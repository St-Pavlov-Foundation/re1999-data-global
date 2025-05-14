module("modules.logic.task.view.TaskViewContainer", package.seeall)

local var_0_0 = class("TaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_container"),
		TaskView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigationView
		}
	elseif arg_2_1 == 2 then
		return {
			TaskNoviceView.New(),
			TaskDailyView.New(),
			TaskWeeklyView.New()
		}
	end
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_3_1)
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Mission_close)
end

return var_0_0
