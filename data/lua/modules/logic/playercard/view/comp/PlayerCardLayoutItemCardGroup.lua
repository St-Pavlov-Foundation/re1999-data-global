module("modules.logic.playercard.view.comp.PlayerCardLayoutItemCardGroup", package.seeall)

slot0 = class("PlayerCardLayoutItemCardGroup", PlayerCardLayoutItem)
slot0.TweenDuration = 0.16

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.frameSingle = gohelper.findChild(slot1, "frame_single")
	slot0.goSelectSingle = gohelper.findChild(slot1, "card/select_single")

	gohelper.setActive(slot0.frame, false)
	gohelper.setActive(slot0.goSelect, false)
	gohelper.setActive(slot0.frameSingle, false)
	gohelper.setActive(slot0.goSelectSingle, false)
end

function slot0.setEditMode(slot0, slot1)
	if slot0.cardComp:isSingle() then
		gohelper.setActive(slot0.frame, false)
		gohelper.setActive(slot0.goSelect, false)
		gohelper.setActive(slot0.frameSingle, slot1)
		gohelper.setActive(slot0.goSelectSingle, slot1)
	else
		gohelper.setActive(slot0.frame, slot1)
		gohelper.setActive(slot0.goSelect, slot1)
		gohelper.setActive(slot0.frameSingle, false)
		gohelper.setActive(slot0.goSelectSingle, false)
	end

	recthelper.setHeight(slot0.go.transform, slot2 and 137 or 274)

	if slot1 then
		slot0.animCard:Play("wiggle")
	end
end

return slot0
