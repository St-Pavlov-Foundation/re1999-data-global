module("modules.logic.fight.entity.comp.FightNameUIExPointItem", package.seeall)

slot0 = class("FightNameUIExPointItem", FightNameUIExPointBaseItem)

function slot0.GetExPointItem(slot0)
	slot1 = uv0.New()

	slot1:init(slot0)

	return slot1
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.goFull2 = gohelper.findChild(slot0.exPointGo, "full2")
	slot0.imageFull2 = slot0.goFull2:GetComponent(gohelper.Type_Image)
end

function slot0.resetToEmpty(slot0)
	uv0.super.resetToEmpty(slot0)
	gohelper.setActive(slot0.goFull2, false)

	slot0.imageFull2.color = Color.white
end

function slot0.directSetStoredState(slot0, slot1)
	uv0.super.directSetStoredState(slot0)
	gohelper.setActive(slot0.goFull2, true)
end

function slot0.switchToStoredState(slot0, slot1)
	uv0.super.switchToStoredState(slot0)
	gohelper.setActive(slot0.goFull2, true)
end

return slot0
