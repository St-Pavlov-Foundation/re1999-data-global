module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaHunterEntity", package.seeall)

local var_0_0 = class("TianShiNaNaHunterEntity", TianShiNaNaUnitEntityBase)

function var_0_0.updateMo(arg_1_0, arg_1_1)
	local var_1_0 = string.splitToNumber(arg_1_1.co.specialData, "#")

	arg_1_0._range = var_1_0 and var_1_0[1] or 0

	var_0_0.super.updateMo(arg_1_0, arg_1_1)
end

function var_0_0.onResLoaded(arg_2_0)
	local var_2_0 = gohelper.findChild(arg_2_0._resGo, "vx_warn")

	gohelper.setActive(var_2_0, true)

	if var_2_0 then
		arg_2_0._rootAnim = var_2_0:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_2_0:checkActive()
end

function var_0_0.addEventListeners(arg_3_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.CubePointUpdate, arg_3_0.checkActive, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.CubePointUpdate, arg_4_0.checkActive, arg_4_0)
end

function var_0_0.willActive(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(TianShiNaNaModel.instance.curPointList) do
		if TianShiNaNaHelper.getMinDis(iter_5_1.x, iter_5_1.y, arg_5_0._unitMo.x, arg_5_0._unitMo.y) <= arg_5_0._range then
			return true
		end
	end

	return false
end

function var_0_0.checkActive(arg_6_0)
	if not arg_6_0._rootAnim then
		return
	end

	local var_6_0 = arg_6_0._unitMo.isActive or arg_6_0:willActive()

	if var_6_0 == arg_6_0._isActive then
		return
	end

	arg_6_0._isActive = var_6_0

	if var_6_0 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_warn)
		arg_6_0._rootAnim:Play("warn_red", 0, 0)
	else
		arg_6_0._rootAnim:Play("warn_open", 0, 0)
	end
end

return var_0_0
