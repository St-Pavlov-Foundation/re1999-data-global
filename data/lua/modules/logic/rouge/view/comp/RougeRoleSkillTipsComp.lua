module("modules.logic.rouge.view.comp.RougeRoleSkillTipsComp", package.seeall)

slot0 = class("RougeRoleSkillTipsComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._skillicon1 = slot0:_addSkillItem(gohelper.findChild(slot0._go, "skillicon1"), slot0._onSkill1Click, slot0)
	slot0._skillicon2 = slot0:_addSkillItem(gohelper.findChild(slot0._go, "skillicon2"), slot0._onSkill2Click, slot0)
	slot0._click = gohelper.findChildButtonWithAudio(slot0._go, "block")

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.setClickCallback(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._target = slot2
end

function slot0._onClick(slot0)
	if slot0._callback then
		slot0._callback(slot0._target)
	end
end

function slot0._onSkill1Click(slot0)
	slot0._displaySkillItemComp:refresh(slot0._skillicon1:getSkillCO())
	slot0:_setSkillIconSelected(true)
	RougeHeroGroupModel.instance:rougeSaveCurGroup()
end

function slot0._onSkill2Click(slot0)
	slot0._displaySkillItemComp:refresh(slot0._skillicon2:getSkillCO())
	slot0:_setSkillIconSelected(false)
	RougeHeroGroupModel.instance:rougeSaveCurGroup()
end

function slot0._setSkillIconSelected(slot0, slot1)
	slot0._skillicon1:setSelected(slot1)
	slot0._skillicon2:setSelected(not slot1)
end

function slot0._addSkillItem(slot0, slot1, slot2, slot3)
	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, RougeRoleSkillItemComp)

	slot4:setClickCallback(slot2, slot3)

	return slot4
end

function slot0.refresh(slot0, slot1, slot2)
	slot0._displaySkillItemComp = slot2

	for slot7, slot8 in pairs(slot1) do
		if lua_skill.configDict[slot8] then
			if slot0["_skillicon" .. slot7] then
				slot10:refresh(slot9)
				slot10:setSelected(slot2:getSkillCO() == slot9)
			else
				break
			end
		end
	end
end

function slot0.onDestroy(slot0)
	slot0._click:RemoveClickListener()
end

return slot0
