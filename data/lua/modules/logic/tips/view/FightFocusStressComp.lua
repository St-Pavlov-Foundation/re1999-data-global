module("modules.logic.tips.view.FightFocusStressComp", package.seeall)

local var_0_0 = class("FightFocusStressComp", UserDataDispose)

var_0_0.PrefabPath = FightNameUIStressMgr.PrefabPath

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.goStress = arg_1_1

	arg_1_0:loadPrefab()
end

function var_0_0.loadPrefab(arg_2_0)
	arg_2_0.loader = PrefabInstantiate.Create(arg_2_0.goStress)

	arg_2_0.loader:startLoad(var_0_0.PrefabPath, arg_2_0.onLoadFinish, arg_2_0)
end

function var_0_0.onLoadFinish(arg_3_0)
	arg_3_0.instanceGo = arg_3_0.loader:getInstGO()

	arg_3_0:initUI()

	arg_3_0.loaded = true

	arg_3_0:refreshStress(arg_3_0.cacheEntityMo)

	arg_3_0.cacheEntityMo = nil
end

function var_0_0.initUI(arg_4_0)
	arg_4_0.stressText = gohelper.findChildText(arg_4_0.instanceGo, "#txt_stress")
	arg_4_0.goBlue = gohelper.findChild(arg_4_0.instanceGo, "blue")
	arg_4_0.goRed = gohelper.findChild(arg_4_0.instanceGo, "red")
	arg_4_0.goBroken = gohelper.findChild(arg_4_0.instanceGo, "broken")
	arg_4_0.goStaunch = gohelper.findChild(arg_4_0.instanceGo, "staunch")
	arg_4_0.click = gohelper.findChildClickWithDefaultAudio(arg_4_0.instanceGo, "#go_clickarea")

	arg_4_0.click:AddClickListener(arg_4_0.onClickStress, arg_4_0)
	arg_4_0:resetGo()

	arg_4_0.statusDict = arg_4_0:getUserDataTb_()
	arg_4_0.statusDict[FightEnum.Status.Positive] = arg_4_0.goBlue
	arg_4_0.statusDict[FightEnum.Status.Negative] = arg_4_0.goRed
end

function var_0_0.show(arg_5_0)
	gohelper.setActive(arg_5_0.instanceGo, true)
end

function var_0_0.hide(arg_6_0)
	gohelper.setActive(arg_6_0.instanceGo, false)
end

function var_0_0.resetGo(arg_7_0)
	gohelper.setActive(arg_7_0.goBlue, false)
	gohelper.setActive(arg_7_0.goRed, false)
	gohelper.setActive(arg_7_0.goBroken, false)
	gohelper.setActive(arg_7_0.goStaunch, false)
end

function var_0_0.onClickStress(arg_8_0)
	if not arg_8_0.entityMo then
		return
	end

	if arg_8_0.entityMo.side == FightEnum.EntitySide.MySide then
		StressTipController.instance:openHeroStressTip(arg_8_0.entityMo:getCO())
	else
		StressTipController.instance:openMonsterStressTip(arg_8_0.entityMo:getCO())
	end
end

function var_0_0.refreshStress(arg_9_0, arg_9_1)
	if not arg_9_0.loaded then
		arg_9_0.cacheEntityMo = arg_9_1

		return
	end

	if not arg_9_1 then
		arg_9_0:hide()

		return
	end

	if not arg_9_1:hasStress() then
		arg_9_0:hide()

		return
	end

	arg_9_0:show()
	arg_9_0:resetGo()

	arg_9_0.entityMo = arg_9_1

	local var_9_0 = arg_9_1:getPowerInfo(FightEnum.PowerType.Stress)
	local var_9_1 = var_9_0 and var_9_0.num or 0

	arg_9_0.stressText.text = var_9_1
	arg_9_0.status = FightHelper.getStressStatus(var_9_1)

	local var_9_2 = arg_9_0.status and arg_9_0.statusDict[arg_9_0.status]

	gohelper.setActive(var_9_2, true)
end

function var_0_0.destroy(arg_10_0)
	arg_10_0.click:RemoveClickListener()

	arg_10_0.click = nil

	arg_10_0.loader:dispose()

	arg_10_0.loader = nil

	arg_10_0:__onDispose()
end

return var_0_0
