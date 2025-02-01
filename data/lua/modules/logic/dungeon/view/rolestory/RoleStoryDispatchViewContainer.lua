module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchViewContainer", package.seeall)

slot0 = class("RoleStoryDispatchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoleStoryDispatchNormalView.New())
	table.insert(slot1, RoleStoryDispatchStoryView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				true
			}, 1820001)
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

return slot0
