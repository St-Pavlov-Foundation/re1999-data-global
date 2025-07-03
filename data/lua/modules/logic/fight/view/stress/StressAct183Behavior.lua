module("modules.logic.fight.view.stress.StressAct183Behavior", package.seeall)

local var_0_0 = class("StressAct183Behavior", StressBehaviorBase)

var_0_0.StressThreshold = 49

function var_0_0.initUI(arg_1_0)
	arg_1_0.stressText = gohelper.findChildText(arg_1_0.instanceGo, "#txt_stress")
	arg_1_0.goYellow = gohelper.findChild(arg_1_0.instanceGo, "yellow")
	arg_1_0.goBroken = gohelper.findChild(arg_1_0.instanceGo, "broken")
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.instanceGo, "#go_clickarea")

	arg_1_0.click:AddClickListener(arg_1_0.onClickStress, arg_1_0)
end

function var_0_0.onClickStress(arg_2_0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	local var_2_0 = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183]

	if var_2_0 then
		local var_2_1 = var_2_0.stressIdentity[arg_2_0.entityId]

		if var_2_1 then
			StressTipController.instance:openAct183StressTip(var_2_1)

			return
		end
	end

	local var_2_2 = arg_2_0.entity:getMO():getCO()
	local var_2_3 = var_2_2 and lua_monster_skill_template.configDict[var_2_2.skillTemplate]
	local var_2_4 = var_2_3 and var_2_3.identity

	if not var_2_4 then
		return
	end

	StressTipController.instance:openAct183StressTip({
		var_2_4
	})
end

function var_0_0.refreshUI(arg_3_0)
	local var_3_0 = arg_3_0:getCurStress()

	arg_3_0.stressText.text = var_3_0

	arg_3_0:updateStatus()
end

function var_0_0.updateStatus(arg_4_0)
	local var_4_0 = arg_4_0:getCurStress()

	gohelper.setActive(arg_4_0.goYellow, var_4_0 <= arg_4_0.StressThreshold)
	gohelper.setActive(arg_4_0.goBroken, var_4_0 > arg_4_0.StressThreshold)
end

function var_0_0.resetGo(arg_5_0)
	gohelper.setActive(arg_5_0.goYellow, false)
	gohelper.setActive(arg_5_0.goBroken, false)
end

function var_0_0.onPowerChange(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0.entityId ~= arg_6_1 then
		return
	end

	if FightEnum.PowerType.Stress ~= arg_6_2 then
		return
	end

	if arg_6_3 == arg_6_4 then
		return
	end

	arg_6_0:refreshUI()
end

function var_0_0.beforeDestroy(arg_7_0)
	arg_7_0.click:RemoveClickListener()

	arg_7_0.click = nil

	arg_7_0:__onDispose()
end

return var_0_0
