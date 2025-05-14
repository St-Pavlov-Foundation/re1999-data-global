module("modules.logic.fight.view.assistboss.FightAssistBoss1", package.seeall)

local var_0_0 = class("FightAssistBoss1", FightAssistBossBase)

function var_0_0.setPrefabPath(arg_1_0)
	arg_1_0.prefabPath = "ui/viewres/assistboss/boss1.prefab"
end

function var_0_0.initView(arg_2_0)
	var_0_0.super.initView(arg_2_0)

	arg_2_0.energyImage = gohelper.findChildImage(arg_2_0.viewGo, "head/energy")
	arg_2_0.goEffect1 = gohelper.findChild(arg_2_0.viewGo, "head/dec2")
	arg_2_0.goEffect2 = gohelper.findChild(arg_2_0.viewGo, "head/vx_eff")
end

function var_0_0.refreshPower(arg_3_0)
	var_0_0.super.refreshPower(arg_3_0)

	local var_3_0, var_3_1 = FightDataHelper.paTaMgr:getAssistBossPower()

	arg_3_0:setFillAmount(arg_3_0.energyImage, var_3_0 / var_3_1)
	arg_3_0:refreshEffect()
end

function var_0_0.refreshCD(arg_4_0)
	var_0_0.super.refreshCD(arg_4_0)
	arg_4_0:refreshEffect()
end

function var_0_0.refreshEffect(arg_5_0)
	local var_5_0 = true

	if not FightDataHelper.paTaMgr:getCurUseSkillInfo() then
		local var_5_1 = false

		gohelper.setActive(arg_5_0.goEffect1, var_5_1)
		gohelper.setActive(arg_5_0.goEffect2, var_5_1)

		return
	end

	local var_5_2 = not arg_5_0:checkInCd()

	gohelper.setActive(arg_5_0.goEffect1, var_5_2)
	gohelper.setActive(arg_5_0.goEffect2, var_5_2)
end

return var_0_0
