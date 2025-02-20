module("modules.logic.fight.view.preview.SkillEditorSkillSelectView", package.seeall)

slot0 = class("SkillEditorSkillSelectView")

function slot0.ctor(slot0)
	slot0._curSkillId = nil
	slot0._attackerId = nil
	slot0._entityMO = nil
	slot0._clickMask = nil
	slot0._skillIds = {}
	slot0._skillItemGOs = {}
end

function slot0.init(slot0, slot1)
	slot0._selectSkillGO = gohelper.findChild(slot1, "btnSelectSkill")
	slot0._txtSelect = gohelper.findChildText(slot1, "btnSelectSkill/Text")
	slot0._skillsGO = gohelper.findChild(slot1, "selectSkills")
	slot0._skillItemPrefab = gohelper.findChild(slot1, "selectSkills/skill")
	slot0._clickMask = gohelper.findChildClick(slot1, "selectSkills/ClickMask")

	slot0._clickMask:AddClickListener(slot0._onClickMask, slot0)
	gohelper.setActive(slot0._skillItemPrefab, false)
end

function slot0.dispose(slot0)
	slot0._clickMask:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0._skillItemGOs) do
		SLFramework.UGUI.UIClickListener.Get(slot5):RemoveClickListener()
	end
end

function slot0.show(slot0)
	gohelper.setActive(slot0._skillsGO, true)
	slot0:_updateSelect()
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._skillsGO, false)
end

function slot0.getSelectSkillId(slot0)
	return slot0._curSkillId
end

function slot0.setAttacker(slot0, slot1)
	slot0._attackerId = slot1
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._attackerId)
	slot0._skillIds = {}

	if FightDataHelper.entityMgr:getById(slot0._attackerId) then
		if slot2.modelId ~= slot0._entityMO.modelId then
			slot0._curSkillId = nil
		end
	else
		slot0._curSkillId = nil
	end

	for slot7, slot8 in ipairs(slot0:_getEntitySkillCOList(slot0._entityMO)) do
		slot9 = slot8.id
		slot10 = FightConfig.instance:getSkinSkillTimeline(slot0._entityMO.skin, slot9)

		table.insert(slot0._skillIds, slot9)

		if not slot0._curSkillId then
			slot0._curSkillId = slot9
			SkillEditorView.selectSkillId[slot1] = slot0._curSkillId
		end

		if not slot0._skillItemGOs[slot7] then
			table.insert(slot0._skillItemGOs, gohelper.clone(slot0._skillItemPrefab, slot0._skillsGO, "skill" .. slot7))
		end

		SLFramework.UGUI.UIClickListener.Get(slot11):AddClickListener(slot0._onClickSkillItem, slot0, slot9)
		gohelper.setActive(slot11, true)

		slot13 = string.split(slot10, "_")
		gohelper.findChildText(slot11, "Text").text = slot9 .. "\n" .. slot8.name .. "\n" .. slot13[#slot13] .. (slot0:_getStrengthenTag(slot0._entityMO.modelId, slot9) or "")
	end

	for slot7 = #slot3 + 1, #slot0._skillItemGOs do
		gohelper.setActive(slot0._skillItemGOs[slot7], false)
	end

	slot0:_updateSelect()
end

slot1 = {
	"skillGroup1",
	"skillGroup2",
	"skillEx",
	"passiveSkill"
}

function slot0._getStrengthenTag(slot0, slot1, slot2)
	if lua_skill_ex_level.configDict[slot1] then
		for slot7, slot8 in pairs(slot3) do
			for slot12, slot13 in ipairs(uv0) do
				if tabletool.indexOf(string.splitToNumber(slot8[slot13], "|"), slot2) then
					return "塑造" .. slot8.skillLevel
				end
			end
		end
	end
end

function slot0._getEntitySkillCOList(slot0, slot1)
	slot2 = {
		[slot9.skillEffect] = true
	}

	for slot7, slot8 in ipairs(slot1.skillIds) do
		if lua_skill.configDict[slot8] and not string.nilorempty(FightConfig.instance:getSkinSkillTimeline(slot1.skin, slot8)) then
			table.insert({}, slot9)
		end
	end

	for slot8, slot9 in ipairs(lua_skill.configList) do
		if string.find(tostring(slot9.id), tostring(slot1.modelId)) == 1 and not string.nilorempty(slot9.timeline) and not slot2[slot9.skillEffect] then
			slot2[slot9.skillEffect] = true

			table.insert(slot3, slot9)
		end
	end

	return slot3
end

function slot0._onClickMask(slot0)
	gohelper.setActive(slot0._skillsGO, false)
end

function slot0._onClickSkillItem(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.hide, slot0)
	TaskDispatcher.runDelay(slot0.hide, slot0, 0.2)

	slot0._curSkillId = slot1
	SkillEditorView.selectSkillId[slot0._attackerId] = slot0._curSkillId

	slot0:_updateSelect()
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectSkill, slot0._entityMO, slot1)
end

function slot0._updateSelect(slot0)
	for slot4, slot5 in ipairs(slot0._skillIds) do
		if slot0._skillItemGOs[slot4] then
			gohelper.setActive(gohelper.findChild(slot6, "imgSelect"), slot5 == slot0._curSkillId)
		end
	end

	if lua_skill.configDict[slot0._curSkillId] then
		slot3 = string.split(FightConfig.instance:getSkinSkillTimeline(slot0._entityMO.skin, slot0._curSkillId), "_")
		slot0._txtSelect.text = slot0._curSkillId .. "\n" .. slot1.name .. "\n" .. slot3[#slot3]
	else
		slot0._txtSelect.text = "None"
	end
end

return slot0
