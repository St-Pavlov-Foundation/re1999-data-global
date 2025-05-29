module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroEffectItem", package.seeall)

local var_0_0 = class("DiceHeroEffectItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._trans = arg_1_1.transform
	arg_1_0._godamage = gohelper.findChild(arg_1_1, "damage")
	arg_1_0._txtdamage = gohelper.findChildText(arg_1_1, "damage/x/txtNum")
	arg_1_0._goshield = gohelper.findChild(arg_1_1, "shield")
	arg_1_0._txtshield = gohelper.findChildText(arg_1_1, "shield/x/txtNum")
	arg_1_0._gohero = gohelper.findChild(arg_1_1, "#go_hpFlyItem_hero")
	arg_1_0._goenemy = gohelper.findChild(arg_1_1, "#go_hpFlyItem_enemy")
	arg_1_0._goeffectenergy = gohelper.findChild(arg_1_1, "#go_hpFlyItem_energy")
	arg_1_0._goeffectshield = gohelper.findChild(arg_1_1, "#go_hpFlyItem_shield")
end

function var_0_0.initData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	ZProj.TweenHelper.KillByObj(arg_2_0._trans)
	gohelper.setActive(arg_2_0._godamage, arg_2_1 == 1)
	gohelper.setActive(arg_2_0._gohero, arg_2_1 == 2)
	gohelper.setActive(arg_2_0._goenemy, arg_2_1 == 3)
	gohelper.setActive(arg_2_0._goshield, arg_2_1 == 4)
	gohelper.setActive(arg_2_0._goeffectenergy, arg_2_1 == 5)
	gohelper.setActive(arg_2_0._goeffectshield, arg_2_1 == 6)
	transformhelper.setPos(arg_2_0._trans, arg_2_2.x, arg_2_2.y, arg_2_2.z)

	if arg_2_1 == 1 then
		arg_2_0._txtdamage.text = arg_2_4

		transformhelper.setLocalRotation(arg_2_0._trans, 0, 0, 0)
	elseif arg_2_1 == 4 then
		arg_2_0._txtshield.text = arg_2_4

		transformhelper.setLocalRotation(arg_2_0._trans, 0, 0, 0)
	else
		local var_2_0 = arg_2_0._trans.parent:InverseTransformPoint(arg_2_3)

		ZProj.TweenHelper.DOLocalMove(arg_2_0._trans, var_2_0.x, var_2_0.y, var_2_0.z, 0.5)

		local var_2_1 = math.deg(math.atan2(arg_2_3.y - arg_2_2.y, arg_2_3.x - arg_2_2.x)) + 180

		transformhelper.setLocalRotation(arg_2_0._trans, 0, 0, var_2_1)
	end
end

return var_0_0
