module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreViewContainer", package.seeall)

slot0 = class("VersionActivity1_2StoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_2StoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
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
	end

	if slot1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.LvHuEMen
			})
		}
	end
end

return slot0
