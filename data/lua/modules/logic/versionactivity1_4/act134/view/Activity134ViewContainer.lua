module("modules.logic.versionactivity1_4.act134.view.Activity134ViewContainer", package.seeall)

slot0 = class("Activity134ViewContainer", BaseViewContainer)
slot1 = 1
slot2 = 2

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity134View.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == uv1 then
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.Act134Clue
		})

		return {
			slot0._currencyView
		}
	end
end

return slot0
