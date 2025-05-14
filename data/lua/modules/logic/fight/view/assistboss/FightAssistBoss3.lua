module("modules.logic.fight.view.assistboss.FightAssistBoss3", package.seeall)

local var_0_0 = class("FightAssistBoss3", FightAssistBossBase)

function var_0_0.setPrefabPath(arg_1_0)
	arg_1_0.prefabPath = "ui/viewres/assistboss/boss3.prefab"
end

function var_0_0.initView(arg_2_0)
	var_0_0.super.initView(arg_2_0)

	arg_2_0.goStage1 = gohelper.findChild(arg_2_0.viewGo, "head/stage1")
	arg_2_0.goStage2 = gohelper.findChild(arg_2_0.viewGo, "head/stage2")
	arg_2_0.goStage3 = gohelper.findChild(arg_2_0.viewGo, "head/stage3")
	arg_2_0.stageList = arg_2_0:getUserDataTb_()
	arg_2_0.stageList[1] = arg_2_0.goStage1
	arg_2_0.stageList[2] = arg_2_0.goStage2
	arg_2_0.stageList[3] = arg_2_0.goStage3
	arg_2_0.goEnergy3 = gohelper.findChild(arg_2_0.viewGo, "energy_3")
	arg_2_0.goEnergy4 = gohelper.findChild(arg_2_0.viewGo, "energy_4")
	arg_2_0.imageEnergy3 = gohelper.findChildImage(arg_2_0.viewGo, "energy_3/go_energy")
	arg_2_0.imageEnergy4 = gohelper.findChildImage(arg_2_0.viewGo, "energy_4/go_energy")
end

function var_0_0.addEvents(arg_3_0)
	var_0_0.super.addEvents(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSwitchAssistBossSkill, arg_3_0.onSwitchAssistBossSkill, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSwitchAssistBossSpine, arg_3_0.onSwitchAssistBossSpine, arg_3_0)
end

function var_0_0.refreshUI(arg_4_0)
	var_0_0.super.refreshUI(arg_4_0)
	arg_4_0:refreshEnergyType()
end

function var_0_0.refreshEnergyType(arg_5_0)
	local var_5_0 = #FightDataHelper.paTaMgr:getBossSkillInfoList()

	gohelper.setActive(arg_5_0.goEnergy3, var_5_0 == 3)
	gohelper.setActive(arg_5_0.goEnergy4, var_5_0 == 4)
end

function var_0_0.onSwitchAssistBossSkill(arg_6_0)
	arg_6_0:refreshEnergyType()
	arg_6_0:refreshPower()
	arg_6_0:refreshCD()
end

var_0_0.StageThresholdValue1 = 25
var_0_0.StageThresholdValue2 = 50
var_0_0.StageThresholdValue3 = 100

function var_0_0.refreshPower(arg_7_0)
	var_0_0.super.refreshPower(arg_7_0)

	local var_7_0 = FightDataHelper.paTaMgr:getBossSkillInfoList()
	local var_7_1 = var_7_0 and #var_7_0
	local var_7_2 = arg_7_0.imageEnergy3

	if var_7_1 == 4 then
		var_7_2 = arg_7_0.imageEnergy4
	end

	local var_7_3, var_7_4 = FightDataHelper.paTaMgr:getAssistBossPower()

	arg_7_0:setFillAmount(var_7_2, var_7_3 / var_7_4)

	local var_7_5 = 0
	local var_7_6 = var_7_3 < var_0_0.StageThresholdValue1 and 0 or var_7_3 < var_0_0.StageThresholdValue2 and 1 or var_7_3 < var_0_0.StageThresholdValue3 and 2 or 3

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.stageList) do
		gohelper.setActive(iter_7_1, iter_7_0 == var_7_6)
	end
end

function var_0_0.onSwitchAssistBossSpine(arg_8_0)
	arg_8_0:refreshHeadImage()
end

return var_0_0
