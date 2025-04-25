module("modules.logic.gm.view.GMFightEntityBuffItem", package.seeall)

slot0 = class("GMFightEntityBuffItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._id = gohelper.findChildTextMeshInputField(slot1, "id")
	slot0._name = gohelper.findChildText(slot1, "name")
	slot0._type = gohelper.findChildText(slot1, "type")
	slot0._set = gohelper.findChildText(slot1, "set")
	slot0._duration = gohelper.findChildTextMeshInputField(slot1, "duration")
	slot0._count = gohelper.findChildTextMeshInputField(slot1, "count")
	slot0._layer = gohelper.findChildTextMeshInputField(slot1, "layer")
	slot0._btnDel = gohelper.findChildButtonWithAudio(slot1, "btnDel")
end

function slot0.addEventListeners(slot0)
	slot0._btnDel:AddClickListener(slot0._onClickDel, slot0)
	slot0._duration:AddOnEndEdit(slot0._onAddEditDuration, slot0)
	slot0._count:AddOnEndEdit(slot0._onAddEditCount, slot0)
	slot0._layer:AddOnEndEdit(slot0._onAddEditLayer, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnDel:RemoveClickListener()
	slot0._duration:RemoveOnEndEdit()
	slot0._count:RemoveOnEndEdit()
	slot0._layer:RemoveOnEndEdit()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot3 = lua_skill_buff.configDict[slot0._mo.buffId] and lua_skill_bufftype.configDict[slot2.typeId]

	slot0._id:SetText(tostring(slot0._mo.buffId))

	slot0._name.text = slot2 and slot2.name or ""
	slot0._type.text = slot2 and tostring(slot2.typeId) or ""
	slot0._set.text = slot3 and tostring(slot3.type) or ""

	slot0._duration:SetText(tostring(slot0._mo.duration) or "")
	slot0._count:SetText(tostring(slot0._mo.count) or "")
	slot0._layer:SetText(tostring(slot0._mo.layer) or "")
end

function slot0._onClickDel(slot0)
	if lua_skill_buff.configDict[slot0._mo.buffId] then
		GameFacade.showToast(ToastEnum.IconId, "del buff " .. slot1.name)
	else
		GameFacade.showToast(ToastEnum.IconId, "buff config not exist")
	end

	slot2 = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightDelBuff %s %s", tostring(slot2.id), tostring(slot0._mo.uid)))
	slot2:delBuff(slot0._mo.uid)

	if FightHelper.getEntity(slot2.id) and slot3.buff then
		slot3.buff:delBuff(slot0._mo.uid)
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot2.id, FightEnum.EffectType.BUFFDEL, slot0._mo.buffId, slot0._mo.uid, 0)
	FightRpc.instance:sendEntityInfoRequest(slot2.id)
end

function slot0._onAddEditDuration(slot0, slot1)
	if tonumber(slot1) and (slot2 == -1 or slot2 > 0) then
		slot3 = GMFightEntityModel.instance.entityMO
		slot0._mo.duration = slot2

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", slot3.id, slot0._mo.id, slot0._mo.count, slot2, slot0._mo.layer))
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot3.id, FightEnum.EffectType.BUFFUPDATE, slot0._mo.buffId, slot0._mo.uid, 0)
	else
		slot0._duration:SetText(tostring(slot0._mo.duration) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

function slot0._onAddEditCount(slot0, slot1)
	if tonumber(slot1) and slot2 > 0 then
		slot3 = GMFightEntityModel.instance.entityMO
		slot0._mo.count = slot2

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", slot3.id, slot0._mo.id, slot2, slot0._mo.duration, slot0._mo.layer))
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot3.id, FightEnum.EffectType.BUFFUPDATE, slot0._mo.buffId, slot0._mo.uid, 0)
	else
		slot0._count:SetText(tostring(slot0._mo.count) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

function slot0._onAddEditLayer(slot0, slot1)
	if tonumber(slot1) and slot2 > 0 then
		slot3 = GMFightEntityModel.instance.entityMO
		slot0._mo.layer = slot2

		GMRpc.instance:sendGMRequest(string.format("fightChangeBuff %s %s %d %d %d", slot3.id, slot0._mo.id, slot0._mo.count, slot0._mo.duration, slot2))
		FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot3.id, FightEnum.EffectType.BUFFUPDATE, slot0._mo.buffId, slot0._mo.uid, 0)
	else
		slot0._layer:SetText(tostring(slot0._mo.layer) or "")
		GameFacade.showToast(ToastEnum.IconId, "修正数值错误")
	end
end

return slot0
