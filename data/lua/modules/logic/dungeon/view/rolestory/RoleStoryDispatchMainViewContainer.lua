module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchMainViewContainer", package.seeall)

slot0 = class("RoleStoryDispatchMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoleStoryItemRewardView.New())
	table.insert(slot1, RoleStoryDispatchMainView.New())
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

		return {
			slot0._navigateButtonsView
		}
	end

	slot0.currencyView = CurrencyView.New({
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		},
		CurrencyEnum.CurrencyType.RoleStory
	})
	slot0.currencyView.foreHideBtn = true

	return {
		slot0.currencyView
	}
end

function slot0.refreshCurrency(slot0, slot1)
	slot0.currencyView:setCurrencyType(slot1)
end

function slot0.onContainerClose(slot0)
	if slot0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

return slot0
