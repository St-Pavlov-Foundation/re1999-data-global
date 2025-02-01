module("modules.logic.season.view1_4.Season1_4StoreViewContainer", package.seeall)

slot0 = class("Season1_4StoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season1_4StoreView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_righttop"))

	return slot1
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
	end

	if slot1 == 2 then
		slot3 = CurrencyView.New({
			Activity104Enum.StoreUTTU[Activity104Model.instance:getCurSeasonId()]
		})
		slot3.foreHideBtn = true

		return {
			slot3
		}
	end
end

function slot0._closeCallback(slot0)
	slot0:closeThis()
end

function slot0._homeCallback(slot0)
	slot0:closeThis()
end

return slot0
