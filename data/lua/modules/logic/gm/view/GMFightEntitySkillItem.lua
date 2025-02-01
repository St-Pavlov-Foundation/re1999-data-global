module("modules.logic.gm.view.GMFightEntitySkillItem", package.seeall)

slot0 = class("GMFightEntitySkillItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._id = gohelper.findChildTextMeshInputField(slot1, "id")
	slot0._name = gohelper.findChildTextMeshInputField(slot1, "name")
	slot0._level = gohelper.findChildText(slot1, "level")
	slot0._effect = gohelper.findChildTextMeshInputField(slot1, "effect")
	slot0._type = gohelper.findChildTextMeshInputField(slot1, "type")
	slot0._btnDel = gohelper.findChildButtonWithAudio(slot1, "btnDel")
end

function slot0.addEventListeners(slot0)
	slot0._btnDel:AddClickListener(slot0._onClickDel, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnDel:RemoveClickListener()
end

slot1 = {
	"现实创伤",
	"精神创伤",
	"减益",
	"增益",
	"反制",
	"治疗"
}

function slot0.onUpdateMO(slot0, slot1)
	slot0._skillCO = slot1
	slot2 = GMFightEntityModel.instance.entityMO

	gohelper.setActive(slot0._btnDel.gameObject, slot2:isPassiveSkill(slot0._skillCO.id))
	slot0._id:SetText(tostring(slot0._skillCO.id))
	slot0._name:SetText(slot0._skillCO.name)

	if slot2:isPassiveSkill(slot0._skillCO.id) then
		slot0._level.text = "被动"
	elseif slot2:isUniqueSkill(slot0._skillCO.id) then
		slot0._level.text = "大招"
	else
		slot0._level.text = slot2:getSkillLv(slot0._skillCO.id)
	end

	slot0._effect:SetText(tostring(slot0._skillCO.skillEffect))
	slot0._type:SetText(uv0[slot0._skillCO.effectTag] or "无")
end

function slot0._onClickDel(slot0)
	GameFacade.showToast(ToastEnum.IconId, "del skill " .. slot0._skillCO.name)

	slot1 = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightDelPassiveSkill %s %s", tostring(slot1.id), tostring(slot0._skillCO.id)))
	slot1:removePassiveSkill(slot0._skillCO.id)
	GMFightEntityModel.instance:setEntityMO(slot1)
end

return slot0
