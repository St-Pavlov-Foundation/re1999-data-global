module("modules.logic.fight.view.FightTechniqueViewContainer", package.seeall)

slot0 = class("FightTechniqueViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_lefttop"),
		FightTechniqueView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
