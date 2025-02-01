module("modules.logic.rouge.view.comp.RougeRoleSkillItemComp", package.seeall)

slot0 = class("RougeRoleSkillItemComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._assitSkillIcon = gohelper.findChildSingleImage(slot0._go, "imgIcon")
	slot0._assitSkillTagIcon = gohelper.findChildSingleImage(slot0._go, "tag/tagIcon")
	slot0._click = gohelper.findChildButtonWithAudio(slot0._go, "bg")

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.setClickCallback(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._target = slot2
end

function slot0.setHeroId(slot0, slot1)
	slot0._heroId = slot1
end

function slot0._onClick(slot0)
	if slot0._callback then
		slot0._callback(slot0._target)
	end
end

function slot0.setSelected(slot0, slot1)
	slot0._frameGo = slot0._frameGo or gohelper.findChild(slot0._go, "selectframe")

	slot0._frameGo:SetActive(slot1)
end

function slot0.getSkillCO(slot0)
	return slot0._skillCO
end

function slot0.refresh(slot0, slot1)
	slot0._skillCO = slot1

	slot0._assitSkillIcon:LoadImage(ResUrl.getSkillIcon(slot1.icon))
	slot0._assitSkillTagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot1.showTag))

	if slot0._heroId then
		RougeModel.instance:getTeamInfo():setSupportSkill(slot0._heroId, slot1.id)
	end
end

function slot0.onDestroy(slot0)
	slot0._click:RemoveClickListener()
end

return slot0
