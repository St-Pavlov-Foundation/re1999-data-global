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
	arg_1_0.emitterEnergy_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/emitterenergy/input")
	arg_1_0.emitterEnergy_go = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/emitterenergy")
	arg_1_0.shield_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/shield/input")
	arg_1_0.bloodPool_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/bloodpool/input")
	arg_1_0.bloodPool_max = gohelper.findChildText(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/bloodpool/max")
	arg_1_0.bloodPool_go = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/bloodpool")
	arg_1_0.health_input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/health/input")
	arg_1_0.health_max = gohelper.findChildText(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/health/max")
	arg_1_0.health_go = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/power/health")
	arg_1_0._icon = gohelper.findChildSingleImage(arg_1_0.viewGO, "info/image")
	arg_1_0._imgIcon = gohelper.findChildImage(arg_1_0.viewGO, "info/image")
	arg_1_0._imgCareer = gohelper.findChildImage(arg_1_0.viewGO, "info/image/career")
	arg_1_0.powerItem = gohelper.findChild(arg_1_0.viewGO, "info/Scroll View/Viewport/Content/new_power/power_item")

	gohelper.setActive(arg_1_0.powerItem, false)

	arg_1_0.powerItemList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(GMController.instance, GMFightEntityView.Evt_SelectHero, arg_2_0._onSelectHero, arg_2_0)
	arg_2_0.hp_input:AddOnEndEdit(arg_2_0._onEndEditHp, arg_2_0)
	arg_2_0.expoint_input:AddOnEndEdit(arg_2_0._onEndEditExpoint, arg_2_0)
	arg_2_0.emitterEnergy_input:AddOnEndEdit(arg_2_0._onEndEditEmitterEnergy, arg_2_0)
	arg_2_0.bloodPool_input:AddOnEndEdit(arg_2_0._onEndEditBloodPool, arg_2_0)
	arg_2_0.health_input:AddOnEndEdit(arg_2_0._onEndEditHealth, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(GMController.instance, GMFightEntityView.Evt_SelectHero, arg_3_0._onSelectHero, arg_3_0)
	arg_3_0.hp_input:RemoveOnEndEdit()
	arg_3_0.expoint_input:RemoveOnEndEdit()
	arg_3_0.emitterEnergy_input:RemoveOnEndEdit()
	arg_3_0.bloodPool_input:RemoveOnEndEdit()
	arg_3_0.health_input:RemoveOnEndEdit()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.powerItemList) do
		iter_3_1.input:RemoveOnEndEdit()
	end
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

	local var_6_0 = true

	if arg_6_1:isAssistBoss() then
		var_6_0 = false
	end

	if arg_6_1:isAct191Boss() then
		var_6_0 = false
	end

	gohelper.setActive(arg_6_0.expoint_go, var_6_0)

	if var_6_0 then
		arg_6_0.expoint_input:SetText(tostring(arg_6_1.exPoint))

		arg_6_0.expoint_max.text = "/" .. tostring(arg_6_1:getMaxExPoint())
	end

	local var_6_1 = arg_6_1:isASFDEmitter()

	gohelper.setActive(arg_6_0.emitterEnergy_go, var_6_1)

	local var_6_2 = FightEnum.TeamType.MySide
	local var_6_3 = FightDataHelper.getBloodPool(var_6_2)
	local var_6_4 = arg_6_0._entityMO.id == FightEntityScene.MySideId and var_6_3

	if var_6_4 then
		arg_6_0.bloodPool_input:SetText(var_6_3.value)

		arg_6_0.bloodPool_max.text = "/" .. tostring(var_6_3.max)
	end

	gohelper.setActive(arg_6_0.bloodPool_go, var_6_4)

	local var_6_5 = FightHelper.getSurvivalEntityHealth(arg_6_1.id)
	local var_6_6 = var_6_5 ~= nil

	gohelper.setActive(arg_6_0.health_go, var_6_6)

	if var_6_6 then
		arg_6_0.health_input:SetText(var_6_5)

		arg_6_0.health_max.text = "/" .. tostring(FightHelper.getSurvivalMaxHealth())
	end

	arg_6_0.shield_input:SetText(arg_6_1.shieldValue)
	arg_6_0._icon:UnLoadImage()

	if not arg_6_1:isMonster() or not lua_monster.configDict[arg_6_1.modelId] then
		local var_6_7 = lua_character.configDict[arg_6_1.modelId]
	end

	local var_6_8 = FightConfig.instance:getSkinCO(arg_6_1.originSkin)

	if arg_6_1:isCharacter() then
		local var_6_9 = ResUrl.getHeadIconSmall(var_6_8.retangleIcon)

		arg_6_0._icon:LoadImage(var_6_9)
	elseif arg_6_1:isMonster() then
		gohelper.getSingleImage(arg_6_0._imgIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_6_8.headIcon))

		arg_6_0._imgIcon.enabled = true
	end

	local var_6_10 = arg_6_1:getCareer()

	if var_6_10 ~= 0 then
		UISpriteSetMgr.instance:setEnemyInfoSprite(arg_6_0._imgCareer, "sxy_" .. tostring(var_6_10))
	end

	arg_6_0:refreshPowerList(arg_6_1)
end

var_0_0.PowerId2Name = {
	[FightEnum.PowerType.Power] = "灵光",
	[FightEnum.PowerType.Energy] = "BOSS能量",
	[FightEnum.PowerType.Stress] = "压力",
	[FightEnum.PowerType.AssistBoss] = "量普",
	[FightEnum.PowerType.PlayerFinisherSkill] = "主角终结技",
	[FightEnum.PowerType.Alert] = "警戒值",
	[FightEnum.PowerType.Act191Boss] = "斗蛐蛐",
	[FightEnum.PowerType.SurvivalDot] = "探索dot流派"
}
var_0_0.PowerItemInputWidth = 50

function var_0_0.initPowerOnEndEditHandleDict(arg_7_0)
	if not var_0_0.PowerId2OnEndEditFuncDict then
		var_0_0.PowerId2OnEndEditFuncDict = {
			[FightEnum.PowerType.Power] = arg_7_0._onEndEditPower,
			[FightEnum.PowerType.Alert] = arg_7_0._onEndEditAlert,
			[FightEnum.PowerType.Stress] = arg_7_0._onEndEditStress,
			[FightEnum.PowerType.AssistBoss] = arg_7_0._onEndEditAssistBoss,
			[FightEnum.PowerType.SurvivalDot] = arg_7_0._onEndEditSurvivalDot
		}
	end
end

function var_0_0.refreshPowerList(arg_8_0, arg_8_1)
	arg_8_0:initPowerOnEndEditHandleDict()

	arg_8_0.powerId2PowerItemDict = arg_8_0.powerId2PowerItemDict or {}

	tabletool.clear(arg_8_0.powerId2PowerItemDict)

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(FightEnum.PowerType) do
		local var_8_1 = arg_8_1:getPowerInfo(iter_8_1)

		if var_8_1 then
			var_8_0 = var_8_0 + 1

			local var_8_2 = arg_8_0.powerItemList[var_8_0]

			if not var_8_2 then
				var_8_2 = arg_8_0:getUserDataTb_()
				var_8_2.go = gohelper.cloneInPlace(arg_8_0.powerItem)
				var_8_2.rectGo = var_8_2.go:GetComponent(gohelper.Type_RectTransform)
				var_8_2.txtLabel = gohelper.findChildText(var_8_2.go, "label")
				var_8_2.rectLabel = var_8_2.txtLabel:GetComponent(gohelper.Type_RectTransform)
				var_8_2.input = gohelper.findChildTextMeshInputField(var_8_2.go, "input")
				var_8_2.rectInput = var_8_2.input:GetComponent(gohelper.Type_RectTransform)
				var_8_2.txtMax = gohelper.findChildText(var_8_2.go, "max")
				var_8_2.rectMax = var_8_2.txtMax:GetComponent(gohelper.Type_RectTransform)

				table.insert(arg_8_0.powerItemList, var_8_2)
			end

			var_8_2.input:RemoveOnEndEdit()

			local var_8_3 = var_0_0.PowerId2OnEndEditFuncDict[iter_8_1]

			if var_8_3 then
				var_8_2.input:AddOnEndEdit(var_8_3, arg_8_0)
			end

			gohelper.setActive(var_8_2.go, true)

			var_8_2.txtLabel.text = arg_8_0.PowerId2Name[iter_8_1] or iter_8_0

			var_8_2.input:SetTextWithoutNotify(tostring(var_8_1.num))

			var_8_2.txtMax.text = "/" .. tostring(var_8_1.max)

			local var_8_4 = GameUtil.getTextRenderSize(var_8_2.txtLabel)
			local var_8_5 = GameUtil.getTextRenderSize(var_8_2.txtMax)

			recthelper.setAnchorX(var_8_2.rectInput, var_8_4)
			recthelper.setAnchorX(var_8_2.rectMax, var_8_4 + arg_8_0.PowerItemInputWidth)

			local var_8_6 = var_8_4 + arg_8_0.PowerItemInputWidth + var_8_5

			recthelper.setWidth(var_8_2.rectGo, var_8_6)

			arg_8_0.powerId2PowerItemDict[iter_8_1] = var_8_2
		end
	end

	for iter_8_2 = var_8_0 + 1, #arg_8_0.powerItemList do
		local var_8_7 = arg_8_0.powerItemList[iter_8_2]

		if var_8_7 then
			gohelper.setActive(var_8_7.go, false)
		end
	end
end

function var_0_0._onEndEditHp(arg_9_0, arg_9_1)
	local var_9_0 = GMFightEntityModel.instance.entityMO
	local var_9_1 = tonumber(arg_9_1)

	if var_9_1 then
		local var_9_2 = var_9_0.currentHp
		local var_9_3 = var_9_0.attrMO.hp
		local var_9_4 = Mathf.Clamp(var_9_1, 0, var_9_3)

		if var_9_1 ~= var_9_4 then
			arg_9_0.hp_input:SetTextWithoutNotify(tostring(var_9_4))
		end

		var_9_0.currentHp = var_9_4

		local var_9_5 = FightLocalDataMgr.instance:getEntityById(var_9_0.id)

		if var_9_5 then
			var_9_5.currentHp = var_9_4
		end

		FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, var_9_0.id, var_9_2, var_9_4)
		GMRpc.instance:sendGMRequest(string.format("fightChangeLife %s %d", var_9_0.id, var_9_4))
	end
end

function var_0_0._onEndEditExpoint(arg_10_0, arg_10_1)
	local var_10_0 = GMFightEntityModel.instance.entityMO
	local var_10_1 = tonumber(arg_10_1)

	if var_10_1 then
		local var_10_2 = var_10_0:getMaxExPoint()
		local var_10_3 = Mathf.Clamp(var_10_1, 0, var_10_2)

		if var_10_1 ~= var_10_3 then
			arg_10_0.expoint_input:SetTextWithoutNotify(tostring(var_10_3))
		end

		local var_10_4 = var_10_0.exPoint

		var_10_0.exPoint = var_10_3

		local var_10_5 = FightLocalDataMgr.instance:getEntityById(var_10_0.id)

		if var_10_5 then
			var_10_5.exPoint = var_10_3
		end

		FightController.instance:dispatchEvent(FightEvent.UpdateExPoint, var_10_0.id, var_10_4, var_10_0.exPoint)
		GMRpc.instance:sendGMRequest(string.format("fightChangeExPoint %s %d", var_10_0.id, var_10_3))
	end
end

function var_0_0._onEndEditPower(arg_11_0, arg_11_1)
	arg_11_0:onEndEditPower(FightEnum.PowerType.Power, arg_11_1)
end

function var_0_0._onEndEditAlert(arg_12_0, arg_12_1)
	arg_12_0:onEndEditPower(FightEnum.PowerType.Alert, arg_12_1)
end

function var_0_0._onEndEditStress(arg_13_0, arg_13_1)
	arg_13_0:onEndEditPower(FightEnum.PowerType.Stress, arg_13_1)
end

function var_0_0._onEndEditAssistBoss(arg_14_0, arg_14_1)
	arg_14_0:onEndEditPower(FightEnum.PowerType.AssistBoss, arg_14_1)
end

function var_0_0._onEndEditSurvivalDot(arg_15_0, arg_15_1)
	arg_15_0:onEndEditPower(FightEnum.PowerType.SurvivalDot, arg_15_1)
end

function var_0_0.onEndEditPower(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = GMFightEntityModel.instance.entityMO
	local var_16_1 = tonumber(arg_16_2)

	if var_16_1 then
		local var_16_2 = var_16_0:getPowerInfo(arg_16_1)
		local var_16_3 = var_16_2 and var_16_2.num or 0
		local var_16_4 = var_16_2 and var_16_2.max or 0
		local var_16_5 = Mathf.Clamp(var_16_1, 0, var_16_4)

		if var_16_1 ~= var_16_5 then
			arg_16_0.powerId2PowerItemDict[arg_16_1].input:SetTextWithoutNotify(tostring(var_16_5))
		end

		var_16_2.num = var_16_5

		local var_16_6 = FightLocalDataMgr.instance:getEntityById(var_16_0.id)

		if var_16_6 then
			local var_16_7 = var_16_6:getPowerInfo(arg_16_1)

			if var_16_7 then
				var_16_7.num = var_16_5
			end
		end

		FightController.instance:dispatchEvent(FightEvent.PowerChange, var_16_0.id, arg_16_1, var_16_3, var_16_5)
		GMRpc.instance:sendGMRequest(string.format("fightChangePower %s %s %d", var_16_0.id, arg_16_1, var_16_5))
	end
end

function var_0_0._onEndEditEmitterEnergy(arg_17_0, arg_17_1)
	local var_17_0 = GMFightEntityModel.instance.entityMO

	if not var_17_0:isASFDEmitter() then
		return
	end

	local var_17_1 = tonumber(arg_17_1)

	if not var_17_1 then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fightChangeEmitterEnergy %s %d", var_17_0.id, var_17_1))
	FightDataHelper.ASFDDataMgr:changeEmitterEnergy(FightEnum.EntitySide.MySide, var_17_1)
end

function var_0_0._onEndEditBloodPool(arg_18_0, arg_18_1)
	local var_18_0 = tonumber(arg_18_1)

	if not var_18_0 then
		return
	end

	local var_18_1 = FightEnum.TeamType.MySide
	local var_18_2 = FightDataHelper.getBloodPool(var_18_1)
	local var_18_3 = var_18_2.max
	local var_18_4 = math.min(math.max(0, var_18_0), var_18_3)

	var_18_2.value = var_18_4

	GMRpc.instance:sendGMRequest(string.format("setBloodPoolValue %d", var_18_4))
	FightController.instance:dispatchEvent(FightEvent.BloodPool_ValueChange, var_18_1)
end

function var_0_0._onEndEditHealth(arg_19_0, arg_19_1)
	local var_19_0 = tonumber(arg_19_1)
end

return var_0_0
