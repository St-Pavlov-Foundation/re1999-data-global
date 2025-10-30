module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.entity.MaLiAnNaSoliderHeroEntity", package.seeall)

local var_0_0 = class("MaLiAnNaSoliderHeroEntity", MaLiAnNaSoliderEntity)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._hpGo = gohelper.findChild(arg_1_1, "hp")
	arg_1_0._hpGoTr = arg_1_0._hpGo.transform
	arg_1_0._txtHp = gohelper.findChildText(arg_1_1, "hp/#txt_hp")
end

function var_0_0.initSoliderInfo(arg_2_0, arg_2_1)
	var_0_0.super.initSoliderInfo(arg_2_0, arg_2_1)
	gohelper.setActive()
end

function var_0_0.setHide(arg_3_0, arg_3_1)
	if not var_0_0.super.setHide(arg_3_0, arg_3_1) then
		return
	end

	if gohelper.isNil(arg_3_0._hpGo) then
		return false
	end

	gohelper.setActive(arg_3_0._hpGo, arg_3_1)

	return true
end

function var_0_0.onUpdate(arg_4_0)
	if var_0_0.super.onUpdate(arg_4_0) then
		local var_4_0 = arg_4_0._soliderMo:getHp()

		if arg_4_0._lastHp == nil or arg_4_0._lastHp ~= var_4_0 then
			arg_4_0._txtHp.text = arg_4_0._soliderMo:getHp()
			arg_4_0._lastHp = var_4_0
		end
	end
end

function var_0_0._onResLoadEnd(arg_5_0)
	var_0_0.super._onResLoadEnd(arg_5_0)

	local var_5_0 = gohelper.findChild(arg_5_0.goSpine, "mountroot/mounthead").transform
	local var_5_1, var_5_2, var_5_3 = transformhelper.getLocalPos(var_5_0)

	if var_5_2 <= 0 then
		return
	end

	local var_5_4 = arg_5_0._tr:InverseTransformPoint(var_5_0.position)
	local var_5_5, var_5_6, var_5_7 = var_5_4.x, var_5_4.y, var_5_4.z
	local var_5_8 = var_5_6 + 40

	transformhelper.setLocalPos(arg_5_0._hpGoTr, var_5_5, var_5_8, var_5_7)
end

function var_0_0.getSpineLocalPos(arg_6_0)
	return 0, 8, 0
end

return var_0_0
