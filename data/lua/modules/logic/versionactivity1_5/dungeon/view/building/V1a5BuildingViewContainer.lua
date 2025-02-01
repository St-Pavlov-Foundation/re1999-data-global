module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingViewContainer", package.seeall)

slot0 = class("V1a5BuildingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a5BuildingView.New(),
		TabViewGroup.New(1, "#go_BackBtns"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot2:setHelpId(HelpEnum.HelpId.Dungeon1_5BuildingHelp)

		return {
			slot2
		}
	elseif slot1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.V1a5DungeonBuild
			})
		}
	end
end

function slot0.playOpenTransition(slot0)
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("v1a5_buildingview_open", slot0.onPlayOpenTransitionFinish, slot0)
end

return slot0
