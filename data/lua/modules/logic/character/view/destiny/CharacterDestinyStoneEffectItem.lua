module("modules.logic.character.view.destiny.CharacterDestinyStoneEffectItem", package.seeall)

slot0 = class("CharacterDestinyStoneEffectItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_unlock")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_unlock/#txt_desc")
	slot0._gounlocktip = gohelper.findChild(slot0.viewGO, "#go_unlocktip")
	slot0._txtunlocktips = gohelper.findChildText(slot0.viewGO, "#go_unlocktip/#txt_unlocktips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()

	slot0._unlockInfoItems = slot0:getUserDataTb_()
	slot0._lockInfoItems = slot0:getUserDataTb_()

	gohelper.setActive(slot0.viewGO, true)
	gohelper.setActive(slot0._gounlock, false)
	gohelper.setActive(slot0._gounlocktip, false)
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0.onUpdateMo(slot0, slot1)
	if slot1.curUseStoneId == 0 then
		return
	end

	slot2 = slot1.rank
	slot0._mo = slot1

	if CharacterDestinyConfig.instance:getDestinyFacetCo(slot1.curUseStoneId) then
		for slot7, slot8 in ipairs(slot3) do
			slot9 = slot8.level <= slot2 and slot0:_getUnlockItem(slot7) or slot0:_getLockItem(slot7)
			slot9.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(slot9.txt.gameObject, SkillDescComp)

			slot9.skillDesc:updateInfo(slot9.txt, slot8.desc, slot1.heroId)
			slot9.skillDesc:setTipParam(0, Vector2(380, 100))
			gohelper.setSibling(slot9.go, slot7)
		end

		for slot7, slot8 in pairs(slot0._unlockInfoItems) do
			gohelper.setActive(slot8.go, slot7 <= slot2)
		end

		for slot7, slot8 in pairs(slot0._lockInfoItems) do
			gohelper.setActive(slot8.go, slot2 < slot7 and slot7 <= #slot3)
		end
	end
end

function slot0._getUnlockItem(slot0, slot1)
	if not slot0._unlockInfoItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gounlock, "unlock" .. slot1)
		slot2.go = slot3
		slot2.txt = gohelper.findChildText(slot3, "#txt_desc")
		slot0._unlockInfoItems[slot1] = slot2
	end

	return slot2
end

function slot0._getLockItem(slot0, slot1)
	if not slot0._lockInfoItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gounlocktip, "lock" .. slot1)
		slot2.go = slot3
		slot2.txt = gohelper.findChildText(slot3, "#txt_unlocktips")
		slot0._lockInfoItems[slot1] = slot2
	end

	return slot2
end

return slot0
