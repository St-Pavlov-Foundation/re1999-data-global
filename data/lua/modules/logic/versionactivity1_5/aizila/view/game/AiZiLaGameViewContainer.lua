module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameViewContainer", package.seeall)

slot0 = class("AiZiLaGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._gameView = AiZiLaGameView.New()

	table.insert(slot1, slot0._gameView)
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0._navigateButtonsView:setOverrideClose(slot0._overrideCloseFunc, slot0)
		slot0._navigateButtonsView:setHelpId(HelpEnum.HelpId.Role1_5AiziLa)

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	if slot0._gameView:isLockOp() then
		return
	end

	AiZiLaGameController.instance:exitGame()
end

function slot0.needPlayRiseAnim(slot0)
	return slot0._gameView:needPlayRiseAnim()
end

function slot0.startViewOpenBlock(slot0)
end

return slot0
