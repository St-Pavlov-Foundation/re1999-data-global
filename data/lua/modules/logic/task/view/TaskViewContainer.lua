module("modules.logic.task.view.TaskViewContainer", package.seeall)

slot0 = class("TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_container"),
		TaskView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	elseif slot1 == 2 then
		return {
			TaskNoviceView.New(),
			TaskDailyView.New(),
			TaskWeeklyView.New()
		}
	end
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Mission_close)
end

return slot0
