module("modules.logic.fight.view.preview.SkillEditorHeroSelectItem", package.seeall)

slot0 = class("SkillEditorHeroSelectItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._text = gohelper.findChildText(slot1, "Text")
	slot0._text1 = gohelper.findChildText(slot1, "imgSelect/Text")
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot1)
	slot0._selectGO = gohelper.findChild(slot1, "imgSelect")
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

	if SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Hero or SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.SubHero then
		slot0._text.text = slot2.skinId .. (slot2.name and "\n" .. slot2.name or "")
		slot0._text1.text = slot2.skinId .. (slot2.name and "\n" .. slot2.name or "")
	elseif SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Monster then
		slot4 = FightConfig.instance:getSkinCO(slot2.skinId) and slot3.name or nil

		if not slot3 then
			logError("皮肤表找不到id,怪物模型id：", slot2.skinId)
		end

		slot0._text.text = slot2.skinId .. (slot4 and "\n" .. slot4 or "")
		slot0._text1.text = slot2.skinId .. (slot4 and "\n" .. slot4 or "")
	elseif SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Group then
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

	slot3 = SkillEditorHeroSelectModel.instance.stancePosId
	slot4, slot5 = SkillEditorMgr.instance:getTypeInfo(SkillEditorHeroSelectModel.instance.side)
	slot6 = slot0._mo.co
	slot7 = slot0._mo.co.id

	if SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Group then
		slot5.ids = {}
		slot5.skinIds = {}
		slot5.groupId = slot7

		for slot13, slot14 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot7].monster, "#")) do
			if lua_monster.configDict[slot14] then
				if not FightConfig.instance:getSkinCO(slot15.skinId) or string.nilorempty(slot16.spine) then
					GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, slot6.skinId or slot6.id)

					return
				end

				table.insert(slot5.ids, slot14)
				table.insert(slot5.skinIds, slot15.skinId)
			end
		end

		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectStance, slot2, slot8.stanceId, false)
	elseif slot1 == SkillEditorMgr.SelectType.SubHero then
		SkillEditorMgr.instance:addSubHero(slot0._mo.co.id, slot0._mo.co.skinId)

		return
	else
		slot8 = slot5.ids[1]

		if not FightConfig.instance:getSkinCO((slot1 == SkillEditorMgr.SelectType.Hero and slot0._mo.co or lua_monster.configDict[slot7]).skinId) or string.nilorempty(slot10.spine) then
			GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, slot9.skinId or slot9.id)

			return
		end

		if slot3 then
			slot5.ids[slot3] = slot7
			slot5.skinIds[slot3] = slot9.skinId
		else
			for slot14, slot15 in ipairs(slot5.ids) do
				if slot15 == slot8 or slot4 ~= slot1 then
					slot5.ids[slot14] = slot7
					slot5.skinIds[slot14] = slot9.skinId
				end
			end
		end

		slot5.groupId = nil
	end

	SkillEditorMgr.instance:setTypeInfo(slot2, slot1, slot5.ids, slot5.skinIds, slot5.groupId)
	SkillEditorMgr.instance:refreshInfo(slot2)
	SkillEditorMgr.instance:rebuildEntitys(slot2)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, slot2)
end

return slot0
