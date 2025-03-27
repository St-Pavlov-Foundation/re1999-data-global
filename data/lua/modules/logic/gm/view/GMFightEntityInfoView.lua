module("modules.logic.gm.view.GMFightEntityInfoView", package.seeall)

slot0 = class("GMFightEntityInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0.name_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/name/input")
	slot0.id_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/id/input")
	slot0.uid_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/uid/input")
	slot0.hp_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/hp/input")
	slot0.hp_max = gohelper.findChildText(slot0.viewGO, "info/Scroll View/Viewport/Content/hp/max")
	slot0.expoint_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/power/expoint/input")
	slot0.expoint_max = gohelper.findChildText(slot0.viewGO, "info/Scroll View/Viewport/Content/power/expoint/max")
	slot0.expoint_go = gohelper.findChild(slot0.viewGO, "info/Scroll View/Viewport/Content/power/expoint")
	slot0.power_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/power/power/input")
	slot0.power_max = gohelper.findChildText(slot0.viewGO, "info/Scroll View/Viewport/Content/power/power/max")
	slot0.power_go = gohelper.findChild(slot0.viewGO, "info/Scroll View/Viewport/Content/power/power")
	slot0.stress_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/power/stress/input")
	slot0.stress_max = gohelper.findChildText(slot0.viewGO, "info/Scroll View/Viewport/Content/power/stress/max")
	slot0.stress_go = gohelper.findChild(slot0.viewGO, "info/Scroll View/Viewport/Content/power/stress")
	slot0.assistBoss_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/power/assistboss/input")
	slot0.assistBoss_max = gohelper.findChildText(slot0.viewGO, "info/Scroll View/Viewport/Content/power/assistboss/max")
	slot0.assistBoss_go = gohelper.findChild(slot0.viewGO, "info/Scroll View/Viewport/Content/power/assistboss")
	slot0.emitterEnergy_input = gohelper.findChildTextMeshInputField(slot0.viewGO, "info/Scroll View/Viewport/Content/power/emitterenergy/input")
	slot0.emitterEnergy_go = gohelper.findChild(slot0.viewGO, "info/Scroll View/Viewport/Content/power/emitterenergy")
	slot0._icon = gohelper.findChildSingleImage(slot0.viewGO, "info/image")
	slot0._imgIcon = gohelper.findChildImage(slot0.viewGO, "info/image")
	slot0._imgCareer = gohelper.findChildImage(slot0.viewGO, "info/image/career")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(GMController.instance, GMFightEntityView.Evt_SelectHero, slot0._onSelectHero, slot0)
	slot0.hp_input:AddOnEndEdit(slot0._onEndEditHp, slot0)
	slot0.expoint_input:AddOnEndEdit(slot0._onEndEditExpoint, slot0)
	slot0.power_input:AddOnEndEdit(slot0._onEndEditPower, slot0)
	slot0.stress_input:AddOnEndEdit(slot0._onEndEditStress, slot0)
	slot0.assistBoss_input:AddOnEndEdit(slot0._onEndEditAssistBoss, slot0)
	slot0.emitterEnergy_input:AddOnEndEdit(slot0._onEndEditEmitterEnergy, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(GMController.instance, GMFightEntityView.Evt_SelectHero, slot0._onSelectHero, slot0)
	slot0.hp_input:RemoveOnEndEdit()
	slot0.expoint_input:RemoveOnEndEdit()
	slot0.power_input:RemoveOnEndEdit()
	slot0.stress_input:RemoveOnEndEdit()
	slot0.assistBoss_input:RemoveOnEndEdit()
	slot0.emitterEnergy_input:RemoveOnEndEdit()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0._onSelectHero(slot0, slot1)
	slot0._entityMO = slot1

	slot0.name_input:SetText(slot1:getEntityName())
	slot0.id_input:SetText(tostring(slot1.modelId))
	slot0.uid_input:SetText(tostring(slot1.id))
	slot0.hp_input:SetText(tostring(slot1.currentHp))

	slot0.hp_max.text = "/" .. tostring(slot1.attrMO.hp)
	slot2 = slot1:isAssistBoss()

	gohelper.setActive(slot0.expoint_go, not slot2)

	if not slot2 then
		slot0.expoint_input:SetText(tostring(slot1.exPoint))

		slot0.expoint_max.text = "/" .. tostring(slot1:getMaxExPoint())
	end

	if slot1:getPowerInfo(FightEnum.PowerType.Power) then
		slot0.power_input:SetText(tostring(slot3.num))

		slot0.power_max.text = "/" .. tostring(slot3.max)
	end

	gohelper.setActive(slot0.power_go, slot3)

	if slot1:getPowerInfo(FightEnum.PowerType.Stress) then
		slot0.stress_input:SetText(tostring(slot4.num))

		slot0.stress_max.text = "/" .. tostring(slot4.max)
	end

	gohelper.setActive(slot0.stress_go, slot1:hasStress())

	if slot2 then
		slot5 = slot1:getPowerInfo(FightEnum.PowerType.AssistBoss)

		slot0.assistBoss_input:SetText(tostring(slot5.num))

		slot0.assistBoss_max.text = "/" .. tostring(slot5.max)
	end

	gohelper.setActive(slot0.assistBoss_go, slot2)

	if slot1:isASFDEmitter() then
		-- Nothing
	end

	gohelper.setActive(slot0.emitterEnergy_go, slot5)
	slot0._icon:UnLoadImage()

	slot6 = slot1:isMonster() and lua_monster.configDict[slot1.modelId] or lua_character.configDict[slot1.modelId]

	if slot1:isCharacter() then
		slot0._icon:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot1.originSkin).retangleIcon))
	elseif slot1:isMonster() then
		gohelper.getSingleImage(slot0._imgIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(slot7.headIcon))

		slot0._imgIcon.enabled = true
	end

	if slot1:getCareer() ~= 0 then
		UISpriteSetMgr.instance:setEnemyInfoSprite(slot0._imgCareer, "sxy_" .. tostring(slot8))
	end
end

function slot0._onEndEditHp(slot0, slot1)
	slot2 = GMFightEntityModel.instance.entityMO

	if tonumber(slot1) then
		slot4 = slot2.currentHp

		if slot3 ~= Mathf.Clamp(slot3, 0, slot2.attrMO.hp) then
			slot0.hp_input:SetTextWithoutNotify(tostring(slot6))
		end

		slot2.currentHp = slot6

		if FightLocalDataMgr.instance:getEntityById(slot2.id) then
			slot7.currentHp = slot6
		end

		FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, slot2.id, slot4, slot6)
		GMRpc.instance:sendGMRequest(string.format("fightChangeLife %s %d", slot2.id, slot6))
	end
end

function slot0._onEndEditExpoint(slot0, slot1)
	slot2 = GMFightEntityModel.instance.entityMO

	if tonumber(slot1) then
		if slot3 ~= Mathf.Clamp(slot3, 0, slot2:getMaxExPoint()) then
			slot0.expoint_input:SetTextWithoutNotify(tostring(slot5))
		end

		slot6 = slot2.exPoint
		slot2.exPoint = slot5

		if FightLocalDataMgr.instance:getEntityById(slot2.id) then
			slot7.exPoint = slot5
		end

		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, slot2.id, slot6, slot2.exPoint)
		GMRpc.instance:sendGMRequest(string.format("fightChangeExPoint %s %d", slot2.id, slot5))
	end
end

function slot0._onEndEditPower(slot0, slot1)
	slot2 = GMFightEntityModel.instance.entityMO

	if tonumber(slot1) then
		slot5 = slot2:getPowerInfo(FightEnum.PowerType.Power) and slot4.num or 0

		if slot3 ~= Mathf.Clamp(slot3, 0, slot4 and slot4.max or 0) then
			slot0.power_input:SetTextWithoutNotify(tostring(slot7))
		end

		slot4.num = slot7

		if FightLocalDataMgr.instance:getEntityById(slot2.id) and slot8:getPowerInfo(FightEnum.PowerType.Power) then
			slot9.num = slot7
		end

		FightController.instance:dispatchEvent(FightEvent.PowerChange, slot2.id, FightEnum.PowerType.Power, slot5, slot7)
		GMRpc.instance:sendGMRequest(string.format("fightChangePower %s %s %d", slot2.id, FightEnum.PowerType.Power, slot7))
	end
end

function slot0._onEndEditStress(slot0, slot1)
	if not GMFightEntityModel.instance.entityMO:hasStress() then
		return
	end

	if tonumber(slot1) then
		slot5 = slot2:getPowerInfo(FightEnum.PowerType.Stress) and slot4.num or 0

		if slot3 ~= Mathf.Clamp(slot3, 0, slot4 and slot4.max or 0) then
			slot0.stress_input:SetTextWithoutNotify(tostring(slot7))
		end

		slot4.num = slot7

		if FightLocalDataMgr.instance:getEntityById(slot2.id) and slot8:getPowerInfo(FightEnum.PowerType.Stress) then
			slot9.num = slot7
		end

		FightController.instance:dispatchEvent(FightEvent.PowerChange, slot2.id, FightEnum.PowerType.Stress, slot5, slot7)
		GMRpc.instance:sendGMRequest(string.format("fightChangePower %s %s %d", slot2.id, FightEnum.PowerType.Stress, slot7))
	end
end

function slot0._onEndEditAssistBoss(slot0, slot1)
	if not GMFightEntityModel.instance.entityMO:isAssistBoss() then
		return
	end

	if tonumber(slot1) then
		slot5 = slot2:getPowerInfo(FightEnum.PowerType.AssistBoss) and slot4.num or 0

		if slot3 ~= Mathf.Clamp(slot3, 0, slot4 and slot4.max or 0) then
			slot0.assistBoss_input:SetTextWithoutNotify(tostring(slot7))
		end

		slot4.num = slot7

		if FightLocalDataMgr.instance:getEntityById(slot2.id) and slot8:getPowerInfo(FightEnum.PowerType.AssistBoss) then
			slot9.num = slot7
		end

		FightController.instance:dispatchEvent(FightEvent.PowerChange, slot2.id, FightEnum.PowerType.AssistBoss, slot5, slot7)
		GMRpc.instance:sendGMRequest(string.format("fightChangePower %s %s %d", slot2.id, FightEnum.PowerType.AssistBoss, slot7))
	end
end

function slot0._onEndEditEmitterEnergy(slot0, slot1)
	if not GMFightEntityModel.instance.entityMO:isASFDEmitter() then
		return
	end

	if not tonumber(slot1) then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fightChangeEmitterEnergy %s %d", slot2.id, slot3))
	FightDataHelper.ASFDDataMgr:changeEmitterEnergy(FightEnum.EntitySide.MySide, slot3)
end

return slot0
