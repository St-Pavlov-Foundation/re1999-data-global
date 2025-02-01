module("modules.logic.dungeon.view.DungeonChapterMiniItem", package.seeall)

slot0 = class("DungeonChapterMiniItem", DungeonChapterItem)

function slot0._setLockStatus(slot0, slot1)
	uv0.super._setLockStatus(slot0, slot1)

	if not slot0._goSpecial then
		slot0._goSpecial = gohelper.findChild(slot0.viewGO, "anim/image_Special")
	end

	if not slot1 then
		slot2 = luaLang(DungeonEnum.SpecialMainPlot[slot0._mo.id])

		if not slot0._txtSpecial then
			slot0._txtSpecial = gohelper.findChildTextMesh(slot0.viewGO, "anim/image_Special/txt_Special")
		end

		slot0._txtSpecial.text = slot2
	end

	gohelper.setActive(slot0._goSpecial, not slot1)
end

function slot0._getInAnimName(slot0)
	return "dungeonchapterminiitem_in"
end

function slot0._getUnlockAnimName(slot0)
	return "dungeonchapterminiitem_unlock"
end

function slot0._getIdleAnimName(slot0)
	return "dungeonchapterminiitem_idle"
end

function slot0._getCloseAnimName(slot0)
	return "dungeonchapterminiitem_close"
end

return slot0
