-- chunkname: @modules/logic/character/view/destiny/CharacterDestinySlotViewContainer.lua

module("modules.logic.character.view.destiny.CharacterDestinySlotViewContainer", package.seeall)

local CharacterDestinySlotViewContainer = class("CharacterDestinySlotViewContainer", BaseViewContainer)

function CharacterDestinySlotViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterDestinySlotView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CharacterDestinySlotViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function CharacterDestinySlotViewContainer:setCurDestinySlot(destinySlot)
	self._destinySlot = destinySlot
end

function CharacterDestinySlotViewContainer:playCloseTransition()
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	local isUnlock = self._destinySlot and self._destinySlot:isUnlockSlot()
	local animName = isUnlock and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock

	animatorPlayer:Play(animName, self.onCloseAnimDone, self)
end

function CharacterDestinySlotViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()

	self._destinySlot = nil
end

return CharacterDestinySlotViewContainer
