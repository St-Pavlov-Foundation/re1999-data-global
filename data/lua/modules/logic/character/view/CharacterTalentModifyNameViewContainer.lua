module("modules.logic.character.view.CharacterTalentModifyNameViewContainer", package.seeall)

slot0 = class("CharacterTalentModifyNameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterTalentModifyNameView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

return slot0
