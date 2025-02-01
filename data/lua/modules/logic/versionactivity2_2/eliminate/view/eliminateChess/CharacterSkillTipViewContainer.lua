module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.CharacterSkillTipViewContainer", package.seeall)

slot0 = class("CharacterSkillTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterSkillTipView.New())

	return slot1
end

return slot0
