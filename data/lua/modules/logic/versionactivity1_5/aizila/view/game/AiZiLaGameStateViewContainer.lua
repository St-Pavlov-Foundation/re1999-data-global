module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateViewContainer", package.seeall)

slot0 = class("AiZiLaGameStateViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._gameStateView = AiZiLaGameStateView.New()

	table.insert(slot1, slot0._gameStateView)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

return slot0
