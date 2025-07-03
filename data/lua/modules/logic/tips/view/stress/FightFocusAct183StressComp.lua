module("modules.logic.tips.view.stress.FightFocusAct183StressComp", package.seeall)

local var_0_0 = class("FightFocusAct183StressComp", FightFocusStressCompBase)

var_0_0.PrefabPath = FightNameUIStressMgr.PrefabPath

function var_0_0.getUiType(arg_1_0)
	return FightNameUIStressMgr.UiType.Act183
end

function var_0_0.initUI(arg_2_0)
	arg_2_0.stressText = gohelper.findChildText(arg_2_0.instanceGo, "#txt_stress")
	arg_2_0.goYellow = gohelper.findChild(arg_2_0.instanceGo, "yellow")
	arg_2_0.goBroken = gohelper.findChild(arg_2_0.instanceGo, "broken")
	arg_2_0.click = gohelper.findChildClickWithDefaultAudio(arg_2_0.instanceGo, "#go_clickarea")

	arg_2_0.click:AddClickListener(arg_2_0.onClickStress, arg_2_0)
end

function var_0_0.onClickStress(arg_3_0)
	if not arg_3_0.entityMo then
		return
	end

	local var_3_0 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183]

	if var_3_0 then
		local var_3_1 = var_3_0.stressIdentity[arg_3_0.entityMo.id]

		if var_3_1 then
			StressTipController.instance:openAct183StressTip(var_3_1)

			return
		end
	end

	local var_3_2 = arg_3_0.entityMo:getCO()
	local var_3_3 = var_3_2 and lua_monster_skill_template.configDict[var_3_2.skillTemplate]
	local var_3_4 = var_3_3 and var_3_3.identity

	if not var_3_4 then
		return
	end

	StressTipController.instance:openAct183StressTip({
		var_3_4
	})
end

function var_0_0.refreshStress(arg_4_0, arg_4_1)
	if not arg_4_0.loaded then
		arg_4_0.cacheEntityMo = arg_4_1

		return
	end

	if not arg_4_1 then
		arg_4_0:hide()

		return
	end

	if not arg_4_1:hasStress() then
		arg_4_0:hide()

		return
	end

	arg_4_0:show()

	arg_4_0.entityMo = arg_4_1

	local var_4_0 = arg_4_1:getPowerInfo(FightEnum.PowerType.Stress)
	local var_4_1 = var_4_0 and var_4_0.num or 0

	arg_4_0.stressText.text = var_4_1

	gohelper.setActive(arg_4_0.goYellow, var_4_1 <= StressAct183Behavior.StressThreshold)
	gohelper.setActive(arg_4_0.goBroken, var_4_1 > StressAct183Behavior.StressThreshold)
end

function var_0_0.destroy(arg_5_0)
	arg_5_0.click:RemoveClickListener()

	arg_5_0.click = nil

	var_0_0.super.destroy(arg_5_0)
end

return var_0_0
