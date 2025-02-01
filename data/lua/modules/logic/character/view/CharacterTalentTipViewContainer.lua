module("modules.logic.character.view.CharacterTalentTipViewContainer", package.seeall)

slot0 = class("CharacterTalentTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterTalentTipView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
