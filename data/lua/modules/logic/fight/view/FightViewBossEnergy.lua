module("modules.logic.fight.view.FightViewBossEnergy", package.seeall)

local var_0_0 = class("FightViewBossEnergy", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0._bossEntityMO = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._imghpbar = gohelper.findChildImage(arg_2_0.viewGO, "image_hpbarbg/image_hpbarfg")
	arg_2_0._imgSignEnergyContainer = gohelper.findChild(arg_2_0.viewGO, "image_hpbarbg/divide")
	arg_2_0._imgSignEnergyItem = gohelper.findChild(arg_2_0.viewGO, "image_hpbarbg/divide/#go_divide1")
	arg_2_0._txtnum = gohelper.findChildTextMesh(arg_2_0.viewGO, "image_hpbarbg/#txt_num")
	arg_2_0._gomax = gohelper.findChild(arg_2_0.viewGO, "image_hpbarbg/max")
	arg_2_0._gobreak = gohelper.findChild(arg_2_0.viewGO, "image_hpbarbg/breakthrough")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:com_registFightEvent(FightEvent.PowerChange, arg_3_0._onPowerChange)
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._gobreak, false)

	local var_5_0 = arg_5_0._bossEntityMO:getCO()
	local var_5_1 = {}

	if not string.nilorempty(var_5_0.energySign) then
		var_5_1 = string.splitToNumber(var_5_0.energySign, "#")
	end

	gohelper.CreateObjList(arg_5_0, arg_5_0._bossEnergySignShow, var_5_1, arg_5_0._imgSignEnergyContainer, arg_5_0._imgSignEnergyItem)

	local var_5_2 = arg_5_0._bossEntityMO:getPowerInfo(FightEnum.PowerType.Energy)

	arg_5_0:_setValue(var_5_2.num / 1000, false)
end

function var_0_0._bossEnergySignShow(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	recthelper.setAnchorX(arg_6_1.transform, arg_6_2 / 1000 * recthelper.getWidth(arg_6_1.transform.parent.parent))
end

function var_0_0._onPowerChange(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0._bossEntityMO.id == arg_7_1 and FightEnum.PowerType.Energy == arg_7_2 and arg_7_3 ~= arg_7_4 then
		arg_7_0:_setValue(arg_7_4 / 1000, true)
	end
end

function var_0_0._setValue(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 then
		ZProj.TweenHelper.KillByObj(arg_8_0._imghpbar)
		ZProj.TweenHelper.DOFillAmount(arg_8_0._imghpbar, arg_8_1, 0.2)
	else
		arg_8_0._imghpbar.fillAmount = arg_8_1
	end

	arg_8_0._txtnum.text = string.format("%s%%", math.floor(arg_8_1 * 1000) / 10)

	gohelper.setActive(arg_8_0._gomax, arg_8_1 == 1)
	gohelper.setActive(arg_8_0._gobreak, arg_8_1 > 1)
end

return var_0_0
