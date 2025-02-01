module("modules.logic.dungeon.view.rolestory.RoleStoryActivityMainViewContainer", package.seeall)

slot0 = class("RoleStoryActivityMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.actView = RoleStoryActivityView.New()
	slot0.challengeView = RoleStoryActivityChallengeView.New()
	slot0.mainView = RoleStoryActivityMainView.New()

	table.insert(slot1, RoleStoryActivityBgView.New())
	table.insert(slot1, RoleStoryItemRewardView.New())
	table.insert(slot1, slot0.mainView)
	table.insert(slot1, slot0.actView)
	table.insert(slot1, slot0.challengeView)
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonsView:setOverrideClose(slot0.overrideClose, slot0)

		return {
			slot0._navigateButtonsView
		}
	end

	slot0.currencyView = CurrencyView.New({
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		}
	})
	slot0.currencyView.foreHideBtn = true

	return {
		slot0.currencyView
	}
end

function slot0.refreshCurrency(slot0, slot1)
	slot0.currencyView:setCurrencyType(slot1)
end

function slot0.overrideClose(slot0)
	if not slot0.mainView._showActView then
		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeMainViewShow, true)

		return
	end

	ViewMgr.instance:closeView(slot0.viewName, nil, true)
end

function slot0.onContainerClose(slot0)
	if slot0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	if not gohelper.isNil(slot0:__getAnimatorPlayer()) then
		slot4:Play(slot1, slot2, slot3)
	end
end

function slot0.playOpenTransition(slot0)
	if slot0.mainView._showActView then
		-- Nothing
	else
		slot1.anim = "challenge"
		slot1.duration = 0.6
	end

	uv0.super.playOpenTransition(slot0, {
		anim = "open",
		duration = 0.67
	})
end

function slot0._setVisible(slot0, slot1)
	uv0.super._setVisible(slot0, slot1)

	if slot0.mainView then
		slot0.mainView:onSetVisible()
	end
end

function slot0.getVisible(slot0)
	return slot0._isVisible
end

return slot0
