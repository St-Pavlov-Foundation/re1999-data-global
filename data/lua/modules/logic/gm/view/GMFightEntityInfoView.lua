module("modules.logic.gm.view.GMFightEntityInfoView", package.seeall)

local var_0_0 = class("GMFightEntityInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.name_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/name/input")
	arg_1_0.id_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/id/input")
	arg_1_0.uid_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/uid/input")
	arg_1_0.hp_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/hp/input")
	arg_1_0.hp_max = gohelper.findChildText(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/hp/max")
	arg_1_0.expoint_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/expoint/input")
	arg_1_0.expoint_max = gohelper.findChildText(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/expoint/max")
	arg_1_0.expoint_go = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/expoint")
	arg_1_0.power_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/power/input")
	arg_1_0.power_max = gohelper.findChildText(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/power/max")
	arg_1_0.power_go = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/power")
	arg_1_0.stress_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/stress/input")
	arg_1_0.stress_max = gohelper.findChildText(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/stress/max")
	arg_1_0.stress_go = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/stress")
	arg_1_0.assistBoss_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/assistboss/input")
	arg_1_0.assistBoss_max = gohelper.findChildText(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/assistboss/max")
	arg_1_0.assistBoss_go = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/assistboss")
	arg_1_0.emitterEnergy_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/emitterenergy/input")
	arg_1_0.emitterEnergy_go = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/emitterenergy")
	arg_1_0._icon = gohelper.findChildSingleImage(arg_1_0.viewGO, "info/image")
	arg_1_0._imgIcon = gohelper.findChildImage(arg_1_0.viewGO, "info/image")
	arg_1_0._imgCareer = gohelper.findChildImage(arg_1_0.viewGO, "info/image/career")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(GMController.instance, GMFightEntityView.Evt_SelectHero, arg_2_0._onSelectHero, arg_2_0)
	arg_2_0.hp_input:AddOnEndEdit(arg_2_0._onEndEditHp, arg_2_0)
	arg_2_0.expoint_input:AddOnEndEdit(arg_2_0._onEndEditExpoint, arg_2_0)
	arg_2_0.power_input:AddOnEndEdit(arg_2_0._onEndEditPower, arg_2_0)
	arg_2_0.stress_input:AddOnEndEdit(arg_2_0._onEndEditStress, arg_2_0)
	arg_2_0.assistBoss_input:AddOnEndEdit(arg_2_0._onEndEditAssistBoss, arg_2_0)
	arg_2_0.emitterEnergy_input:AddOnEndEdit(arg_2_0._onEndEditEmitterEnergy, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(GMController.instance, GMFightEntityView.Evt_SelectHero, arg_3_0._onSelectHero, arg_3_0)
	arg_3_0.hp_input:RemoveOnEndEdit()
	arg_3_0.expoint_input:RemoveOnEndEdit()
	arg_3_0.power_input:RemoveOnEndEdit()
	arg_3_0.stress_input:RemoveOnEndEdit()
	arg_3_0.assistBoss_input:RemoveOnEndEdit()
	arg_3_0.emitterEnergy_input:RemoveOnEndEdit()
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0.onClose(arg_5_0)
	return
end

function var_0_0._onSelectHero(arg_6_0, arg_6_1)
	arg_6_0._entityMO = arg_6_1

	arg_6_0.name_input:SetText(arg_6_1:getEntityName())
	arg_6_0.id_input:SetText(tostring(arg_6_1.modelId))
	arg_6_0.uid_input:SetText(tostring(arg_6_1.id))
	arg_6_0.hp_input:SetText(tostring(arg_6_1.currentHp))

	arg_6_0.hp_max.text = "/" .. tostring(arg_6_1.attrMO.hp)

	local var_6_0 = arg_6_1:isAssistBoss()

	gohelper.setActive(arg_6_0.expoint_go, not var_6_0)

	if not var_6_0 then
		arg_6_0.expoint_input:SetText(tostring(arg_6_1.exPoint))

		arg_6_0.expoint_max.text = "/" .. tostring(arg_6_1:getMaxExPoint())
	end

	local var_6_1 = arg_6_1:getPowerInfo(FightEnum.PowerType.Power)

	if var_6_1 then
		arg_6_0.power_input:SetText(tostring(var_6_1.num))

		arg_6_0.power_max.text = "/" .. tostring(var_6_1.max)
	end

	gohelper.setActive(arg_6_0.power_go, var_6_1)

	local var_6_2 = arg_6_1:getPowerInfo(FightEnum.PowerType.Stress)

	if var_6_2 then
		arg_6_0.stress_input:SetText(tostring(var_6_2.num))

		arg_6_0.stress_max.text = "/" .. tostring(var_6_2.max)
	end

	gohelper.setActive(arg_6_0.stress_go, arg_6_1:hasStress())

	if var_6_0 then
		local var_6_3 = arg_6_1:getPowerInfo(FightEnum.PowerType.AssistBoss)

		arg_6_0.assistBoss_input:SetText(tostring(var_6_3.num))

		arg_6_0.assistBoss_max.text = "/" .. tostring(var_6_3.max)
	end

	gohelper.setActive(arg_6_0.assistBoss_go, var_6_0)

	local var_6_4 = arg_6_1:isASFDEmitter()

	if var_6_4 then
		-- block empty
	end

	gohelper.setActive(arg_6_0.emitterEnergy_go, var_6_4)
	arg_6_0._icon:UnLoadImage()

	if not arg_6_1:isMonster() or not lua_monster.configDict[arg_6_1.modelId] then
		local var_6_5 = lua_character.configDict[arg_6_1.modelId]
	end

	local var_6_6 = FightConfig.instance:getSkinCO(arg_6_1.originSkin)

	if arg_6_1:isCharacter() then
		local var_6_7 = ResUrl.getHeadIconSmall(var_6_6.retangleIcon)

		arg_6_0._icon:LoadImage(var_6_7)
	elseif arg_6_1:isMonster() then
		gohelper.getSingleImage(arg_6_0._imgIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_6_6.headIcon))

		arg_6_0._imgIcon.enabled = true
	end

	local var_6_8 = arg_6_1:getCareer()

	if var_6_8 ~= 0 then
		UISpriteSetMgr.instance:setEnemyInfoSprite(arg_6_0._imgCareer, "sxy_" .. tostring(var_6_8))
	end
end

function var_0_0._onEndEditHp(arg_7_0, arg_7_1)
	local var_7_0 = GMFightEntityModel.instance.entityMO
	local var_7_1 = tonumber(arg_7_1)

	if var_7_1 then
		local var_7_2 = var_7_0.currentHp
		local var_7_3 = var_7_0.attrMO.hp
		local var_7_4 = Mathf.Clamp(var_7_1, 0, var_7_3)

		if var_7_1 ~= var_7_4 then
			arg_7_0.hp_input:SetTextWithoutNotify(tostring(var_7_4))
		end

		var_7_0.currentHp = var_7_4

		local var_7_5 = FightLocalDataMgr.instance:getEntityById(var_7_0.id)

		if var_7_5 then
			var_7_5.currentHp = var_7_4
		end

		FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, var_7_0.id, var_7_2, var_7_4)
		GMRpc.instance:sendGMRequest(string.format("fightChangeLife %s %d", var_7_0.id, var_7_4))
	end
end

function var_0_0._onEndEditExpoint(arg_8_0, arg_8_1)
	local var_8_0 = GMFightEntityModel.instance.entityMO
	local var_8_1 = tonumber(arg_8_1)

	if var_8_1 then
		local var_8_2 = var_8_0:getMaxExPoint()
		local var_8_3 = Mathf.Clamp(var_8_1, 0, var_8_2)

		if var_8_1 ~= var_8_3 then
			arg_8_0.expoint_input:SetTextWithoutNotify(tostring(var_8_3))
		end

		local var_8_4 = var_8_0.exPoint

		var_8_0.exPoint = var_8_3

		local var_8_5 = FightLocalDataMgr.instance:getEntityById(var_8_0.id)

		if var_8_5 then
			var_8_5.exPoint = var_8_3
		end

		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, var_8_0.id, var_8_4, var_8_0.exPoint)
		GMRpc.instance:sendGMRequest(string.format("fightChangeExPoint %s %d", var_8_0.id, var_8_3))
	end
end

function var_0_0._onEndEditPower(arg_9_0, arg_9_1)
	local var_9_0 = GMFightEntityModel.instance.entityMO
	local var_9_1 = tonumber(arg_9_1)

	if var_9_1 then
		local var_9_2 = var_9_0:getPowerInfo(FightEnum.PowerType.Power)
		local var_9_3 = var_9_2 and var_9_2.num or 0
		local var_9_4 = var_9_2 and var_9_2.max or 0
		local var_9_5 = Mathf.Clamp(var_9_1, 0, var_9_4)

		if var_9_1 ~= var_9_5 then
			arg_9_0.power_input:SetTextWithoutNotify(tostring(var_9_5))
		end

		var_9_2.num = var_9_5

		local var_9_6 = FightLocalDataMgr.instance:getEntityById(var_9_0.id)

		if var_9_6 then
			local var_9_7 = var_9_6:getPowerInfo(FightEnum.PowerType.Power)

			if var_9_7 then
				var_9_7.num = var_9_5
			end
		end

		FightController.instance:dispatchEvent(FightEvent.PowerChange, var_9_0.id, FightEnum.PowerType.Power, var_9_3, var_9_5)
		GMRpc.instance:sendGMRequest(string.format("fightChangePower %s %s %d", var_9_0.id, FightEnum.PowerType.Power, var_9_5))
	end
end

function var_0_0._onEndEditStress(arg_10_0, arg_10_1)
	local var_10_0 = GMFightEntityModel.instance.entityMO

	if not var_10_0:hasStress() then
		return
	end

	local var_10_1 = tonumber(arg_10_1)

	if var_10_1 then
		local var_10_2 = var_10_0:getPowerInfo(FightEnum.PowerType.Stress)
		local var_10_3 = var_10_2 and var_10_2.num or 0
		local var_10_4 = var_10_2 and var_10_2.max or 0
		local var_10_5 = Mathf.Clamp(var_10_1, 0, var_10_4)

		if var_10_1 ~= var_10_5 then
			arg_10_0.stress_input:SetTextWithoutNotify(tostring(var_10_5))
		end

		var_10_2.num = var_10_5

		local var_10_6 = FightLocalDataMgr.instance:getEntityById(var_10_0.id)

		if var_10_6 then
			local var_10_7 = var_10_6:getPowerInfo(FightEnum.PowerType.Stress)

			if var_10_7 then
				var_10_7.num = var_10_5
			end
		end

		FightController.instance:dispatchEvent(FightEvent.PowerChange, var_10_0.id, FightEnum.PowerType.Stress, var_10_3, var_10_5)
		GMRpc.instance:sendGMRequest(string.format("fightChangePower %s %s %d", var_10_0.id, FightEnum.PowerType.Stress, var_10_5))
	end
end

function var_0_0._onEndEditAssistBoss(arg_11_0, arg_11_1)
	local var_11_0 = GMFightEntityModel.instance.entityMO

	if not var_11_0:isAssistBoss() then
		return
	end

	local var_11_1 = tonumber(arg_11_1)

	if var_11_1 then
		local var_11_2 = var_11_0:getPowerInfo(FightEnum.PowerType.AssistBoss)
		local var_11_3 = var_11_2 and var_11_2.num or 0
		local var_11_4 = var_11_2 and var_11_2.max or 0
		local var_11_5 = Mathf.Clamp(var_11_1, 0, var_11_4)

		if var_11_1 ~= var_11_5 then
			arg_11_0.assistBoss_input:SetTextWithoutNotify(tostring(var_11_5))
		end

		var_11_2.num = var_11_5

		local var_11_6 = FightLocalDataMgr.instance:getEntityById(var_11_0.id)

		if var_11_6 then
			local var_11_7 = var_11_6:getPowerInfo(FightEnum.PowerType.AssistBoss)

			if var_11_7 then
				var_11_7.num = var_11_5
			end
		end

		FightController.instance:dispatchEvent(FightEvent.PowerChange, var_11_0.id, FightEnum.PowerType.AssistBoss, var_11_3, var_11_5)
		GMRpc.instance:sendGMRequest(string.format("fightChangePower %s %s %d", var_11_0.id, FightEnum.PowerType.AssistBoss, var_11_5))
	end
end

function var_0_0._onEndEditEmitterEnergy(arg_12_0, arg_12_1)
	local var_12_0 = GMFightEntityModel.instance.entityMO

	if not var_12_0:isASFDEmitter() then
		return
	end

	local var_12_1 = tonumber(arg_12_1)

	if not var_12_1 then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fightChangeEmitterEnergy %s %d", var_12_0.id, var_12_1))
	FightDataHelper.ASFDDataMgr:changeEmitterEnergy(FightEnum.EntitySide.MySide, var_12_1)
end

return var_0_0
