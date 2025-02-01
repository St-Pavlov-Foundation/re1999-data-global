module("modules.logic.fight.view.FightFloatItem", package.seeall)

slot0 = class("FightFloatItem")

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.entityId = nil
	slot0.type = slot1
	slot0._typeGO = slot2
	slot0._typeRectTr = slot2.transform
	slot0._halfRandomXRange = slot3 / 2
	slot0._txtNum = gohelper.findChildText(slot2, "x/txtNum")
	slot0._csGoActivator = slot0._typeGO:GetComponent(typeof(ZProj.GoActivator))
	slot0._effectTimeScale = gohelper.onceAddComponent(slot0._typeGO, typeof(ZProj.EffectTimeScale))

	gohelper.setActive(slot0._typeGO, false)

	slot0._floatFunc = uv0.FloatFunc[slot1]
	slot0._floatEndFunc = uv0.FloatEndFunc[slot1]
end

function slot0.getGO(slot0)
	return slot0._typeGO
end

function slot0.startFloat(slot0, slot1, slot2, slot3)
	slot0.startTime = Time.time
	slot0.entityId = slot1

	gohelper.setActive(slot0._typeGO, true)

	if slot0._txtNum then
		if slot0.type == FightEnum.FloatType.crit_heal or slot0.type == FightEnum.FloatType.heal then
			slot4 = "+" .. tostring(slot2)
		end

		slot0._txtNum.text = slot4
	end

	if slot0._floatFunc then
		slot0:_floatFunc(slot2, slot3)
	end

	if slot0.type == FightEnum.FloatType.equipeffect and slot0.can_not_play_equip_effect then
		slot0:_onFinish()

		return
	end

	if slot0._csGoActivator then
		slot0._csGoActivator:AddFinishCallback(slot0._onFinish, slot0)
		slot0._csGoActivator:Play()
	else
		logWarn("no activator in fight float assset, type = " .. slot0.type)
		slot0:_onFinish()
	end

	if slot0._effectTimeScale then
		slot0._effectTimeScale:SetTimeScale(FightModel.instance:getUISpeed())
	end
end

function slot0.setPos(slot0, slot1, slot2)
	slot0.startX = slot1
	slot0.startY = slot2

	recthelper.setAnchor(slot0._typeRectTr, slot1, slot2)
end

function slot0.tweenPosY(slot0, slot1)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	if slot0.equip_single_img then
		slot0:setPos(0, 150)

		return
	end

	slot0._tweenId = ZProj.TweenHelper.DOAnchorPosY(slot0._typeRectTr, slot1, 0.15 / FightModel.instance:getUISpeed())
end

function slot0.stopFloat(slot0)
	slot0:_onFinish()
end

function slot0._onFinish(slot0)
	if slot0._csGoActivator then
		slot0._csGoActivator:RemoveFinishCallback()
	end

	if slot0._floatEndFunc then
		slot0:_floatEndFunc()
	end

	FightFloatMgr.instance:floatEnd(slot0)

	slot0.entityId = nil
end

function slot0.reset(slot0)
	gohelper.setActive(slot0._typeGO, false)
end

function slot0.onDestroy(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._csGoActivator then
		slot0._csGoActivator:Stop()
		slot0._csGoActivator:RemoveFinishCallback()

		slot0._csGoActivator = nil
	end

	if slot0._effectTimeScale then
		slot0._effectTimeScale = nil
	end

	if slot0.equip_single_img then
		slot0.equip_single_img:UnLoadImage()
	end
end

function slot0._floatBuff(slot0, slot1, slot2)
	slot3 = gohelper.findChild(slot0._typeGO, "x/item1")

	gohelper.setActive(slot3, true)

	if slot3.transform.childCount < slot2 then
		logError("buff飘字类型找不到，或者预设中没有对应类型的样式：", slot2)

		return
	end

	for slot8 = 1, slot4 do
		slot9 = slot2 == slot8

		gohelper.setActive(slot3.transform:Find("type_" .. slot8).gameObject, slot9)

		if slot9 then
			gohelper.findChildText(slot10, "txtNum").text = slot1
		end
	end
end

function slot0.hideEquipFloat(slot0)
	if slot0.type == FightEnum.FloatType.equipeffect then
		gohelper.setActive(slot0._typeGO, false)
	end
end

function slot0._floatEquipEffect(slot0, slot1, slot2)
	if FightHelper.getEntity(slot0.entityId) and slot3.marked_alpha == 0 then
		slot0:hideEquipFloat()

		slot0.can_not_play_equip_effect = true

		return
	end

	slot0.can_not_play_equip_effect = false
	slot0.equip_single_img = slot0.equip_single_img or gohelper.findChildSingleImage(slot0._typeGO, "ani/simage_equipicon")

	slot0._typeGO.transform:Find("ani"):GetComponent(typeof(ZProj.MaterialPropsCtrl)).mas:Clear()

	for slot9 = 0, slot4.childCount - 1 do
		slot10 = slot4:GetChild(slot9):GetComponent(gohelper.Type_Image)
		slot10.material = UnityEngine.Object.Instantiate(slot10.material)

		slot5.mas:Add(slot10.material)
	end

	slot0.equip_single_img:LoadImage(ResUrl.getFightEquipFloatIcon("xinxiang" .. slot2.id))
end

function slot0._floatTotal(slot0, slot1, slot2)
	gohelper.setActive(gohelper.findChild(slot0._typeGO, "x"), FightHelper.getEntity(slot2.fromId) and FightHelper.getEntity(slot2.defenderId))

	if slot3 and slot4 then
		slot7 = slot4:getMO()
		slot8 = slot3:getMO() and slot6:getCO()
		slot9 = slot7 and slot7:getCO()
		slot12 = FightConfig.instance:getRestrain(slot8 and slot8.career or 0, slot9 and slot9.career or 0) or 1000
		slot13 = nil
		slot13 = slot12 == 1000 and 3 or slot12 > 1000 and 1 or 2

		for slot17 = 1, 3 do
			gohelper.setActive(gohelper.findChildText(slot0._typeGO, "x/txtNum" .. slot17).gameObject, slot17 == slot13)

			if slot17 == slot13 then
				slot18.text = slot1
			end
		end
	end
end

function slot0._floatStress(slot0, slot1, slot2)
	slot3 = gohelper.findChild(slot0._typeGO, "x/item1")

	gohelper.setActive(slot3, true)

	if slot3.transform.childCount < slot2 then
		logError("压力飘字类型找不到，或者预设中没有对应类型的样式：", slot2)

		return
	end

	for slot8 = 1, slot4 do
		slot9 = slot2 == slot8

		gohelper.setActive(slot3.transform:Find("type_" .. slot8).gameObject, slot9)

		if slot9 then
			gohelper.findChildText(slot10, "txtNum").text = slot1
		end
	end
end

function slot0._floatBuffEnd(slot0)
end

slot0.FloatFunc = {
	[FightEnum.FloatType.buff] = slot0._floatBuff,
	[FightEnum.FloatType.equipeffect] = slot0._floatEquipEffect,
	[FightEnum.FloatType.total] = slot0._floatTotal,
	[FightEnum.FloatType.total_origin] = slot0._floatTotal,
	[FightEnum.FloatType.stress] = slot0._floatStress
}
slot0.FloatEndFunc = {
	[FightEnum.FloatType.buff] = slot0._floatBuffEnd
}

return slot0
