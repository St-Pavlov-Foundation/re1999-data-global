module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintViewContainer", package.seeall)

slot0 = class("VersionActivity1_8FactoryBlueprintViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_8FactoryBlueprintView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif slot1 == 2 then
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.V1a8FactoryPart
		})
		slot0._currencyView.foreHideBtn = true

		return {
			slot0._currencyView
		}
	end
end

function slot0.setCurrencyType(slot0, slot1)
	if not slot0._currencyView then
		return
	end

	slot0._currencyView:setCurrencyType(slot1)
end

return slot0
