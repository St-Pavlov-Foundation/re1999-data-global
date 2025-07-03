module("modules.logic.tips.view.stress.FightFocusStressComp", package.seeall)

local var_0_0 = class("FightFocusStressComp", FightFocusStressCompBase)

function var_0_0.getUiType(arg_1_0)
	return FightNameUIStressMgr.UiType.Normal
end

function var_0_0.initUI(arg_2_0)
	arg_2_0.stressText = gohelper.findChildText(arg_2_0.instanceGo, "#txt_stress")
	arg_2_0.goBlue = gohelper.findChild(arg_2_0.instanceGo, "blue")
	arg_2_0.goRed = gohelper.findChild(arg_2_0.instanceGo, "red")
	arg_2_0.goBroken = gohelper.findChild(arg_2_0.instanceGo, "broken")
	arg_2_0.goStaunch = gohelper.findChild(arg_2_0.instanceGo, "staunch")
	arg_2_0.click = gohelper.findChildClickWithDefaultAudio(arg_2_0.instanceGo, "#go_clickarea")

	arg_2_0.click:AddClickListener(arg_2_0.onClickStress, arg_2_0)
	arg_2_0:resetGo()

	arg_2_0.statusDict = arg_2_0:getUserDataTb_()
	arg_2_0.statusDict[FightEnum.Status.Positive] = arg_2_0.goBlue
	arg_2_0.statusDict[FightEnum.Status.Negative] = arg_2_0.goRed
end

function var_0_0.resetGo(arg_3_0)
	gohelper.setActive(arg_3_0.goBlue, false)
	gohelper.setActive(arg_3_0.goRed, false)
	gohelper.setActive(arg_3_0.goBroken, false)
	gohelper.setActive(arg_3_0.goStaunch, false)
end

function var_0_0.onClickStress(arg_4_0)
	if not arg_4_0.entityMo then
		return
	end

	if arg_4_0.entityMo.side == FightEnum.EntitySide.MySide then
		StressTipController.instance:openHeroStressTip(arg_4_0.entityMo:getCO())
	else
		StressTipController.instance:openMonsterStressTip(arg_4_0.entityMo:getCO())
	end
end

function var_0_0.refreshStress(arg_5_0, arg_5_1)
	if not arg_5_0.loaded then
		arg_5_0.cacheEntityMo = arg_5_1

		return
	end

	if not arg_5_1 then
		arg_5_0:hide()

		return
	end

	if not arg_5_1:hasStress() then
		arg_5_0:hide()

		return
	end

	arg_5_0:show()
	arg_5_0:resetGo()

	arg_5_0.entityMo = arg_5_1

	local var_5_0 = arg_5_1:getPowerInfo(FightEnum.PowerType.Stress)
	local var_5_1 = var_5_0 and var_5_0.num or 0

	arg_5_0.stressText.text = var_5_1
	arg_5_0.status = FightHelper.getStressStatus(var_5_1)

	local var_5_2 = arg_5_0.status and arg_5_0.statusDict[arg_5_0.status]

	gohelper.setActive(var_5_2, true)
end

function var_0_0.destroy(arg_6_0)
	arg_6_0.click:RemoveClickListener()

	arg_6_0.click = nil

	var_0_0.super.destroy(arg_6_0)
end

return var_0_0
