module("modules.logic.survival.controller.work.SurvivalUnitMoveWork", package.seeall)

local var_0_0 = class("SurvivalUnitMoveWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if arg_1_0.context.fastExecute then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = SurvivalMapHelper.instance:getEntity(arg_1_0._stepMo.id)

	if var_1_0 then
		if arg_1_0._stepMo.id == 0 then
			local var_1_1 = arg_1_0._stepMo.paramInt[1] or 0

			if var_1_1 ~= SurvivalEnum.PlayerMoveReason.Normal then
				SurvivalMapModel.instance:setMoveToTarget(nil)
			end

			ViewMgr.instance:closeView(ViewName.SurvivalMapEventView)

			if var_1_1 == SurvivalEnum.PlayerMoveReason.Transfer then
				var_1_0:transferTo(arg_1_0._stepMo.position, arg_1_0._stepMo.dir, arg_1_0._onMoveFinish, arg_1_0)

				arg_1_1.tryTrigger = true
			elseif var_1_1 == SurvivalEnum.PlayerMoveReason.Fly then
				var_1_0:flyTo(arg_1_0._stepMo.position, arg_1_0._stepMo.dir, arg_1_0._onMoveFinish, arg_1_0)

				arg_1_1.tryTrigger = true
			else
				var_1_0:moveTo(arg_1_0._stepMo.position, arg_1_0._stepMo.dir, arg_1_0._onMoveFinish, arg_1_0)
			end
		elseif ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
			ViewName.SurvivalToastView,
			ViewName.GuideView,
			ViewName.GuideView2,
			ViewName.GuideStepEditor
		}) then
			var_1_0:moveTo(arg_1_0._stepMo.position, arg_1_0._stepMo.dir, arg_1_0._onMoveFinish, arg_1_0)
		else
			var_1_0:moveTo(arg_1_0._stepMo.position, arg_1_0._stepMo.dir)
			arg_1_0:onDone(true)
		end
	else
		logError("找不到对应实体" .. arg_1_0._stepMo.id)
		arg_1_0:onDone(true)
	end
end

function var_0_0._onMoveFinish(arg_2_0)
	arg_2_0:onDone(true)
end

return var_0_0
