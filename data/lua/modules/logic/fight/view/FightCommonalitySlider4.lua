module("modules.logic.fight.view.FightCommonalitySlider4", package.seeall)

local var_0_0 = class("FightCommonalitySlider4", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.normal = gohelper.findChild(arg_1_0.viewGO, "normal")
	arg_1_0.boss = gohelper.findChild(arg_1_0.viewGO, "boss")
	arg_1_0.lowRoot = gohelper.findChild(arg_1_0.viewGO, "boss/unreleased_low")
	arg_1_0.highRoot = gohelper.findChild(arg_1_0.viewGO, "boss/unreleased_high")
	arg_1_0.text = gohelper.findChildText(arg_1_0.viewGO, "boss/#txt_time")
	arg_1_0.ani = gohelper.onceAddComponent(arg_1_0.boss, typeof(UnityEngine.Animator))
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_click")

	gohelper.setActive(arg_1_0.normal, false)
	gohelper.setActive(arg_1_0.boss, true)
end

function var_0_0.onConstructor(arg_2_0, arg_2_1)
	arg_2_0.fightRoot = arg_2_1
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:_refreshData()
	arg_3_0:com_registMsg(FightMsgId.FightProgressValueChange, arg_3_0._refreshData)
	arg_3_0:com_registMsg(FightMsgId.FightMaxProgressValueChange, arg_3_0._refreshData)
	arg_3_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_3_0._refreshData)
	arg_3_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_3_0.onSkillPlayStart)
	arg_3_0:com_registFightEvent(FightEvent.OnInvokeSkill, arg_3_0.onInvokeSkill)
	arg_3_0:com_registClick(arg_3_0.click, arg_3_0.onClick)
end

function var_0_0._refreshData(arg_4_0)
	local var_4_0 = FightDataHelper.fieldMgr.progress
	local var_4_1 = FightDataHelper.fieldMgr.progressMax - var_4_0

	arg_4_0.text.text = var_4_1

	if arg_4_0.lastValue ~= var_4_1 then
		arg_4_0.ani:Play("refresh", 0, 0)
		AudioMgr.instance:trigger(20280007)
	end

	if arg_4_0.lastValue == 0 and var_4_1 > 0 then
		arg_4_0.text.text = 0
	end

	arg_4_0.lastValue = var_4_1

	arg_4_0:switchHighLow()
end

function var_0_0.switchHighLow(arg_5_0)
	local var_5_0 = false
	local var_5_1 = FightDataHelper.entityMgr:getMyVertin()

	if var_5_1 then
		local var_5_2 = var_5_1:getBuffDic()

		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			if iter_5_1.buffId == 110500302 then
				var_5_0 = true

				break
			end
		end
	end

	gohelper.setActive(arg_5_0.lowRoot, not var_5_0)
	gohelper.setActive(arg_5_0.highRoot, var_5_0)
end

function var_0_0.onSkillPlayStart(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4 == "610408_fengxue" then
		arg_6_0.ani:Play("play", 0, 0)
		arg_6_0:_refreshData()
	end

	if arg_6_2 == 110240103 or arg_6_2 == 110240104 then
		arg_6_0:switchHighLow()
	end
end

function var_0_0.onInvokeSkill(arg_7_0, arg_7_1)
	if arg_7_1.skillId == 110240103 or arg_7_1.skillId == 110240104 then
		arg_7_0:switchHighLow()
	end
end

function var_0_0.onClick(arg_8_0)
	local var_8_0 = lua_skill.configDict[FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressSkill]]

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0.name
	local var_8_2 = FightConfig.instance:getSkillEffectDesc(nil, var_8_0)
	local var_8_3 = recthelper.uiPosToScreenPos(arg_8_0.viewGO.transform)

	FightCommonTipController.instance:openCommonView(var_8_1, var_8_2, var_8_3, nil, nil, -150, -50)
end

function var_0_0.onClose(arg_9_0)
	return
end

return var_0_0
