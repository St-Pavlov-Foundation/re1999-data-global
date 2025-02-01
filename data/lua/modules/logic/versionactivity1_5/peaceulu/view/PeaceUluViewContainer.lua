module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluViewContainer", package.seeall)

slot0 = class("PeaceUluViewContainer", BaseViewContainer)
slot1 = 1
slot2 = 2

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.peaceUluView = PeaceUluView.New()
	slot0.navigatetionview = TabViewGroup.New(1, "#go_topleft")
	slot0.tabgroupviews = TabViewGroup.New(2, "#go_content")

	table.insert(slot1, slot0.peaceUluView)
	table.insert(slot1, slot0.navigatetionview)
	table.insert(slot1, slot0.tabgroupviews)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonView:setCloseCheck(slot0.defaultOverrideCloseCheck, slot0)

		return {
			slot0._navigateButtonView
		}
	end

	if slot1 == uv1 then
		return {
			PeaceUluMainView.New(),
			PeaceUluGameView.New(),
			PeaceUluResultView.New()
		}
	end
end

function slot0.getNavigateButtonView(slot0)
	return slot0._navigateButtonView
end

function slot0.defaultOverrideCloseCheck(slot0)
	if slot0.tabgroupviews:getCurTabId() ~= PeaceUluEnum.TabIndex.Main then
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Main)
	else
		slot0._navigateButtonView:_reallyClose()
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.PeaceUlu
	})
end

return slot0
