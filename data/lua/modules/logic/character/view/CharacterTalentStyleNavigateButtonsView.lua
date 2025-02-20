module("modules.logic.character.view.CharacterTalentStyleNavigateButtonsView", package.seeall)

slot0 = class("CharacterTalentStyleNavigateButtonsView", NavigateButtonsView)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._btnstat = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_stat")
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnstat:AddClickListener(slot0._btnstatOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnstat:RemoveClickListener()
end

function slot0._btnstatOnClick(slot0)
	if slot0._overrideStatFunc then
		slot0._overrideStatFunc(slot0._overrideStatObj)
	end
end

function slot0.setOverrideStat(slot0, slot1, slot2)
	slot0._overrideStatFunc = slot1
	slot0._overrideStatObj = slot2
end

function slot0.showStatBtn(slot0, slot1)
	if slot0._btnstat then
		gohelper.setActive(slot0._btnstat.gameObject, slot1)
	end
end

return slot0
