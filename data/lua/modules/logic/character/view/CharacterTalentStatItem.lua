module("modules.logic.character.view.CharacterTalentStatItem", package.seeall)

slot0 = class("CharacterTalentStatItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "slot/#go_normal")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "slot/#image_icon")
	slot0._imageglow = gohelper.findChildImage(slot0.viewGO, "slot/#image_glow")
	slot0._gohot = gohelper.findChild(slot0.viewGO, "slot/#go_hot")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._imagepercent = gohelper.findChildImage(slot0.viewGO, "#image_percent")
	slot0._txtpercent = gohelper.findChildText(slot0.viewGO, "#txt_percent")

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
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
end

function slot0.onRefreshMo(slot0, slot1)
	slot2, slot3 = slot1:getStyleTagIcon()
	slot0._txtname.text, slot5 = slot1:getStyleTag()

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._imageicon, slot3, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._imageglow, slot2, true)

	slot6 = slot1:getUnlockPercent() * 0.01
	slot0._txtpercent.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), string.format("%.1f", slot6))
	slot0._imagepercent.fillAmount = slot6 * 0.01

	gohelper.setActive(slot0._gohot, slot1:isHotUnlock())

	slot8 = CharacterTalentStyleEnum.StatType[slot1:isHotUnlock() and 1 or 2]
	slot0._imagepercent.color = GameUtil.parseColor(slot8.ProgressColor)
	slot0._txtpercent.color = GameUtil.parseColor(slot8.TxtColor)
end

return slot0
