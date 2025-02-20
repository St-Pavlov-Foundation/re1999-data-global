module("modules.logic.character.view.destiny.CharacterDestinyStoneViewContainer", package.seeall)

slot0 = class("CharacterDestinyStoneViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._stoneView = CharacterDestinyStoneView.New()

	table.insert(slot1, slot0._stoneView)
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0.overrideCloseFunc, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.setOpenUnlockStoneView(slot0, slot1)
	slot0._openUnlockStoneView = slot1
end

function slot0.overrideCloseFunc(slot0)
	if slot0._openUnlockStoneView then
		slot0._stoneView:closeUnlockStoneView()
	else
		slot0:closeThis()
	end
end

function slot0.playCloseTransition(slot0)
	slot0._stoneView:playRootOpenCloseAnim(false, slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	slot0:onPlayCloseTransitionFinish()
end

return slot0
