module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaMoveStep", package.seeall)

local var_0_0 = class("TianShiNaNaMoveStep", TianShiNaNaStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = TianShiNaNaEntityMgr.instance:getEntity(arg_1_0._data.id)

	if not var_1_0 then
		logError("步骤Move 找不到元件ID" .. arg_1_0._data.id)
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._isPlayer = TianShiNaNaModel.instance:getHeroMo().co.id == arg_1_0._data.id

	if arg_1_0._isPlayer then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_foot)
	end

	var_1_0:moveTo(arg_1_0._data.x, arg_1_0._data.y, arg_1_0._data.direction, arg_1_0._onMoveEnd, arg_1_0)
end

function var_0_0._onMoveEnd(arg_2_0)
	if arg_2_0._isPlayer then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.stop_ui_youyu_foot)
		TianShiNaNaEffectPool.instance:getFromPool(arg_2_0._data.x, arg_2_0._data.y, 1, 0, 0.4)
	end

	arg_2_0:onDone(true)
end

return var_0_0
