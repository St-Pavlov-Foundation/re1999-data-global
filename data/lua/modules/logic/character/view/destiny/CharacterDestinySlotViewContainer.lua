module("modules.logic.character.view.destiny.CharacterDestinySlotViewContainer", package.seeall)

slot0 = class("CharacterDestinySlotViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterDestinySlotView.New())
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

		return {
			slot0.navigateView
		}
	end
end

function slot0.setCurDestinySlot(slot0, slot1)
	slot0._destinySlot = slot1
end

function slot0.playCloseTransition(slot0)
	ZProj.ProjAnimatorPlayer.Get(slot0.viewGO):Play(slot0._destinySlot and slot0._destinySlot:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock, slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	slot0:onPlayCloseTransitionFinish()

	slot0._destinySlot = nil
end

return slot0
