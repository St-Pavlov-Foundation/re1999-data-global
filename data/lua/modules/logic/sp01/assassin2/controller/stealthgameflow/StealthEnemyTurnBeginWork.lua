module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyTurnBeginWork", package.seeall)

local var_0_0 = class("StealthEnemyTurnBeginWork", BaseWork)
local var_0_1 = 0.24

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = true
	local var_1_1 = AssassinStealthGameModel.instance:getMapId()

	if var_1_1 == AssassinEnum.StealthConst.FirstStealthMap then
		local var_1_2 = AssassinConfig.instance:getStealthMapForbidScaleGuide(var_1_1)

		if var_1_2 then
			var_1_0 = GuideModel.instance:isGuideFinish(var_1_2)
		end
	end

	if var_1_0 then
		AssassinStealthGameController.instance:selectHero()
	end

	if AssassinStealthGameModel.instance:getHasEnemyOperation() then
		AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TweenStealthMapPos, {
			scale = AssassinEnum.StealthConst.MinMapScale
		}, true)
		TaskDispatcher.cancelTask(arg_1_0._tweenMapFinished, arg_1_0)
		TaskDispatcher.runDelay(arg_1_0._tweenMapFinished, arg_1_0, AssassinEnum.StealthConst.MapTweenPosTime + var_0_1)
	else
		TaskDispatcher.runDelay(arg_1_0._tweenMapFinished, arg_1_0, AssassinEnum.StealthConst.EnemyTurnWaitTime)
	end
end

function var_0_0._tweenMapFinished(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._tweenMapFinished, arg_3_0)
end

return var_0_0
