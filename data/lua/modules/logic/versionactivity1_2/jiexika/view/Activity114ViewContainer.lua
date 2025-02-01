module("modules.logic.versionactivity1_2.jiexika.view.Activity114ViewContainer", package.seeall)

slot0 = class("Activity114ViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._nowTabIndex = slot0.viewParam and type(slot0.viewParam) == "table" and slot0.viewParam.defaultTabIds and slot0.viewParam.defaultTabIds[2] or 1
	slot0._activity114Live2dView = Activity114Live2dView.New()

	return {
		slot0._activity114Live2dView,
		Activity114View.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_content")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			true,
			true
		}, 167)

		slot2:setOverrideClose(slot0.onClickClose, slot0)

		return {
			slot2
		}
	elseif slot1 == 2 then
		return {
			Activity114EnterView.New(),
			Activity114TaskView.New(),
			Activity114MainView.New()
		}
	end
end

function slot0.onContainerInit(slot0)
	Activity114Model.instance:beginStat()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.JieXiKa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.JieXiKa
	})
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_open)
end

function slot0.onClickClose(slot0)
	if slot0._nowTabIndex ~= Activity114Enum.TabIndex.EnterView then
		slot0:switchTab(Activity114Enum.TabIndex.EnterView)
	else
		slot0:closeThis()
	end
end

function slot0.onContainerClose(slot0)
	Activity114Model.instance:endStat()
end

function slot0.getActivity114Live2d(slot0)
	return slot0._activity114Live2dView:getUISpine()
end

function slot0.switchTab(slot0, slot1)
	slot0._nowTabIndex = slot1

	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1, slot0._nowTabIndex)
end

function slot0.playOpenTransition(slot0)
	slot1 = nil

	if slot0._nowTabIndex ~= Activity114Enum.TabIndex.EnterView then
		if slot0._nowTabIndex == Activity114Enum.TabIndex.MainView then
			-- Nothing
		elseif slot0._nowTabIndex == Activity114Enum.TabIndex.MainView then
			slot1.anim = "quest_open"
		end
	end

	uv0.super.playOpenTransition(slot0, {
		anim = "start_open"
	})
end

function slot0.onPlayCloseTransitionFinish(slot0)
	if slot0.openViewName then
		ViewMgr.instance:openView(slot0.openViewName)

		slot0.openViewName = nil

		TaskDispatcher.cancelTask(slot0.onPlayCloseTransitionFinish, slot0)
		slot0:_cancelBlock()
	else
		uv0.super.onPlayCloseTransitionFinish(slot0)
	end
end

return slot0
