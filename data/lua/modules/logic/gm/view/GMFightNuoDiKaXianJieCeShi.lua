module("modules.logic.gm.view.GMFightNuoDiKaXianJieCeShi", package.seeall)

local var_0_0 = class("GMFightNuoDiKaXianJieCeShi", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnClose")
	arg_1_0.btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnStart")
	arg_1_0.intputTimeline = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "root/inputTimeline")
	arg_1_0.inputCount = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "root/inputCount")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_2_0.onSkillPlayFinish)
	arg_2_0:com_registClick(arg_2_0.btnClose, arg_2_0.closeThis)
	arg_2_0:com_registClick(arg_2_0.btnStart, arg_2_0.onClickStart)
	arg_2_0.intputTimeline:AddOnValueChanged(arg_2_0.onIntputTimelineChange, arg_2_0)
	arg_2_0.inputCount:AddOnValueChanged(arg_2_0.onInputCountChange, arg_2_0)
end

function var_0_0.onIntputTimelineChange(arg_3_0, arg_3_1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMNuoDiKaCeShiTimeline, arg_3_1)
end

function var_0_0.onInputCountChange(arg_4_0, arg_4_1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount, arg_4_1)
end

function var_0_0.onClickStart(arg_5_0)
	local var_5_0 = FightHelper.getEntity(SkillEditorMgr.instance.cur_select_entity_id)

	if not var_5_0 then
		return
	end

	local var_5_1 = FightStepData.New(FightDef_pb.FightStep())

	var_5_1.fromId = var_5_0.id
	var_5_1.toId = "0"
	var_5_1.actType = FightEnum.ActType.SKILL
	var_5_1.actId = 0

	local var_5_2 = var_5_0:getSide() == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local var_5_3 = FightDataHelper.entityMgr:getNormalList(var_5_2)

	if #var_5_3 > 0 then
		var_5_1.toId = var_5_3[1].id

		local var_5_4 = tonumber(arg_5_0.inputCount:GetText()) or 0

		for iter_5_0 = 1, var_5_4 do
			local var_5_5 = FightActEffectData.New(FightDef_pb.ActEffect())

			var_5_5.targetId = var_5_3[math.random(1, #var_5_3)].id
			var_5_5.effectType = FightEnum.EffectType.NUODIKARANDOMATTACK
			var_5_5.effectNum = 100
			var_5_5.effectNum1 = FightEnum.EffectType.DAMAGE
			var_5_5.reserveStr = "0#" .. var_5_4

			table.insert(var_5_1.actEffect, var_5_5)
		end

		for iter_5_1, iter_5_2 in ipairs(var_5_3) do
			local var_5_6 = FightActEffectData.New(FightDef_pb.ActEffect())

			var_5_6.targetId = iter_5_2.id
			var_5_6.effectType = FightEnum.EffectType.NUODIKATEAMATTACK
			var_5_6.effectNum = 200
			var_5_6.effectNum1 = FightEnum.EffectType.DAMAGE

			table.insert(var_5_1.actEffect, var_5_6)
		end
	end

	arg_5_0:com_sendFightEvent(FightEvent.SetGMViewVisible, false)

	arg_5_0.fightStepData = var_5_1

	var_5_0.skill:playTimeline(arg_5_0.intputTimeline:GetText(), var_5_1)
	gohelper.setActive(arg_5_0.viewGO, false)
end

function var_0_0.onSkillPlayFinish(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 == arg_6_0.fightStepData then
		arg_6_0:com_sendFightEvent(FightEvent.SetGMViewVisible, true)
		gohelper.setActive(arg_6_0.viewGO, true)
	end
end

function var_0_0.onOpen(arg_7_0)
	PlayerPrefsKey.GMNuoDiKaCeShiTimeline = "GMNuoDiKaCeShiTimeline"
	PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount = "GMNuoDiKaCeShiTimelineEffectCount"

	arg_7_0.intputTimeline:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMNuoDiKaCeShiTimeline))
	arg_7_0.inputCount:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount))
end

function var_0_0.onDestructor(arg_8_0)
	arg_8_0.intputTimeline:RemoveOnValueChanged()
	arg_8_0.inputCount:RemoveOnValueChanged()
end

return var_0_0
