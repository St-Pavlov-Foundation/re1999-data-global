module("modules.logic.currency.view.PowerActChangeViewContainer", package.seeall)

slot0 = class("PowerActChangeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PowerActChangeView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_righttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		CurrencyView.New({
			CurrencyEnum.CurrencyType.Power,
			{
				isCurrencySprite = true,
				type = MaterialEnum.MaterialType.PowerPotion,
				id = MaterialEnum.PowerId.ActPowerId
			}
		})
	}
end

return slot0
