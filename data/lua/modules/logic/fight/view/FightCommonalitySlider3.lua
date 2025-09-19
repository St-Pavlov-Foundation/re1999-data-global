module("modules.logic.fight.view.FightCommonalitySlider3", package.seeall)

local var_0_0 = class("FightCommonalitySlider3", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.normal = gohelper.findChild(arg_1_0.viewGO, "normal")
	arg_1_0.boss = gohelper.findChild(arg_1_0.viewGO, "boss")
	arg_1_0.text = gohelper.findChildText(arg_1_0.viewGO, "normal/#txt_time")
	arg_1_0.ani = gohelper.onceAddComponent(arg_1_0.normal, typeof(UnityEngine.Animator))
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_click")

	gohelper.setActive(arg_1_0.normal, true)
	gohelper.setActive(arg_1_0.boss, false)
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
end

function var_0_0.onSkillPlayStart(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_4 == "buff_hanqiruti" then
		arg_5_0.ani:Play("play", 0, 0)
		arg_5_0:_refreshData()
	end
end

function var_0_0.onClick(arg_6_0)
	local var_6_0 = lua_skill.configDict[FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ProgressSkill]]

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.name
	local var_6_2 = FightConfig.instance:getSkillEffectDesc(nil, var_6_0)
	local var_6_3 = recthelper.uiPosToScreenPos(arg_6_0.viewGO.transform)

	FightCommonTipController.instance:openCommonView(var_6_1, var_6_2, var_6_3, nil, nil, -150, -50)
end

function var_0_0.onClose(arg_7_0)
	return
end

return var_0_0
