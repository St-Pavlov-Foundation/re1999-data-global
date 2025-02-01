module("modules.logic.fight.view.preview.SkillEditorAutoPlaySkillSelectItem", package.seeall)

slot0 = class("SkillEditorAutoPlaySkillSelectItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._text = gohelper.findChildText(slot1, "Text")
	slot0._click = gohelper.findChildButtonWithAudio(slot1, "imgRemove")
	slot0._btnUseSkin = gohelper.findChildButtonWithAudio(slot1, "btn_skin")
	slot0._goNoUseImg = gohelper.findChild(slot1, "btn_skin/nouse")
	slot0._goUseImg = gohelper.findChild(slot1, "btn_skin/use")

	gohelper.setActive(slot1, true)
	gohelper.setActive(slot0._goNoUseImg, true)
	gohelper.setActive(slot0._goUseImg, false)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
	slot0._btnUseSkin:AddClickListener(slot0._openSelectScroll, slot0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._SelectAutoPlaySkin, slot0._selectSkin, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	slot0._btnUseSkin:RemoveClickListener()
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._SelectAutoPlaySkin, slot0._selectSkin, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot1.co

	if slot1.type == SkillEditorMgr.SelectType.Hero then
		slot0._text.text = slot2.skinId .. (slot2.name and "\n" .. slot2.name or "")
	elseif slot1.type == SkillEditorMgr.SelectType.Monster then
		slot4 = FightConfig.instance:getSkinCO(slot2.skinId) and slot3.name or nil

		if not slot3 then
			logError("皮肤表找不到id,怪物模型id：", slot2.skinId)
		end

		slot0._text.text = slot2.skinId .. (slot4 and "\n" .. slot4 or "")
	elseif slot1.type == SkillEditorMgr.SelectType.Group then
		slot3 = string.splitToNumber(slot2.monster, "#")
		slot4 = lua_monster.configDict[slot3[1]]

		for slot8 = 2, #slot3 do
			if tabletool.indexOf(string.splitToNumber(slot2.bossId, "#"), slot3[slot8]) then
				slot4 = lua_monster.configDict[slot3[slot8]]

				break
			end
		end

		slot0._text.text = slot2.id .. (slot4 and slot4.name and "\n" .. slot4.name or "")
	else
		slot0._text.text = slot2.id .. (slot2.name and "\n" .. slot2.name or "")
	end
end

function slot0._openSelectScroll(slot0)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._OpenAutoPlaySkin, slot0._mo)
end

function slot0._selectSkin(slot0, slot1)
	if slot0._mo.co.id == slot1.roleid then
		slot2 = slot0._mo.skinId ~= slot1.skinid

		gohelper.setActive(slot0._goNoUseImg, not slot2)
		gohelper.setActive(slot0._goUseImg, slot2)

		if slot2 then
			slot0._mo.skinId = slot1.skinid
		else
			slot0._mo.skinId = slot0._mo.co.skinId
		end

		SkillEditorToolAutoPlaySkillSelectModel.instance:addAt(slot0._mo, slot0._index)
	end
end

function slot0._onClickThis(slot0)
	SkillEditorToolAutoPlaySkillSelectModel.instance:removeAt(slot0._index)
end

return slot0
