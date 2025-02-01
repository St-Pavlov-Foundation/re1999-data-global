module("modules.logic.fight.view.preview.SkillEditorAutoPlaySkillItem", package.seeall)

slot0 = class("SkillEditorAutoPlaySkillItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._text = gohelper.findChildText(slot1, "Text")
	slot0._text1 = gohelper.findChildText(slot1, "imgSelect/Text")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot1)
	slot0._selectGO = gohelper.findChild(slot1, "imgSelect")

	gohelper.setActive(slot1, true)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot1.co

	if slot1.type == SkillEditorMgr.SelectType.Hero or SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.SubHero then
		slot0._text.text = slot2.skinId .. (slot2.name and "\n" .. slot2.name or "")
		slot0._text1.text = slot2.skinId .. (slot2.name and "\n" .. slot2.name or "")
	elseif slot1.type == SkillEditorMgr.SelectType.Monster then
		slot4 = FightConfig.instance:getSkinCO(slot2.skinId) and slot3.name or nil

		if not slot3 then
			logError("皮肤表找不到id,怪物模型id：", slot2.skinId)
		end

		slot0._text.text = slot2.skinId .. (slot4 and "\n" .. slot4 or "")
		slot0._text1.text = slot2.skinId .. (slot4 and "\n" .. slot4 or "")
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
		slot0._text1.text = slot2.id .. (slot4 and slot4.name and "\n" .. slot4.name or "")
	else
		slot0._text.text = slot2.id .. (slot2.name and "\n" .. slot2.name or "")
		slot0._text1.text = slot2.id .. (slot2.name and "\n" .. slot2.name or "")
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._selectGO, slot1)
end

function slot0._onClickThis(slot0)
	slot0._view:selectCell(slot0._mo.id, true)
	SkillEditorToolAutoPlaySkillSelectModel.instance:addAtLast(slot0._mo)
end

return slot0
