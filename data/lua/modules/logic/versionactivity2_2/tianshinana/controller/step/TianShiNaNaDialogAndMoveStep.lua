module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDialogAndMoveStep", package.seeall)

local var_0_0 = class("TianShiNaNaDialogAndMoveStep", TianShiNaNaDialogStep)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if arg_1_0._data.isMonsterMove == 1 then
		return arg_1_0:beginPlayDialog()
	end

	local var_1_0 = TianShiNaNaModel.instance:getHeroMo()

	if not var_1_0 then
		logError("对话时，角色不存在")

		return arg_1_0:onDone(true)
	end

	local var_1_1 = TianShiNaNaEntityMgr.instance:getEntity(var_1_0.co.id)

	arg_1_0._targetEntity = TianShiNaNaEntityMgr.instance:getEntity(arg_1_0._data.interactId)

	if not var_1_1 then
		logError("对话时，角色不存在")

		return arg_1_0:onDone(true)
	end

	if not arg_1_0._targetEntity then
		logError("对话时，目标不存在")

		return arg_1_0:onDone(true)
	end

	return var_1_1:moveToHalf(arg_1_0._targetEntity._unitMo.x, arg_1_0._targetEntity._unitMo.y, arg_1_0._onEndMove, arg_1_0)
end

function var_0_0._onEndMove(arg_2_0)
	local var_2_0 = TianShiNaNaModel.instance:getHeroMo()

	arg_2_0._targetEntity:changeDir(var_2_0.x, var_2_0.y)
	arg_2_0:beginPlayDialog()
end

return var_0_0
