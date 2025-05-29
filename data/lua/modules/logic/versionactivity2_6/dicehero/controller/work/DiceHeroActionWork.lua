module("modules.logic.versionactivity2_6.dicehero.controller.work.DiceHeroActionWork", package.seeall)

local var_0_0 = class("DiceHeroActionWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._stepMo = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_0._stepMo.actionType == 1 and arg_2_0._stepMo.isByCard then
		DiceHeroHelper.instance:getCard(tonumber(arg_2_0._stepMo.reasonId)):doHitAnim()
	else
		local var_2_0 = DiceHeroHelper.instance:getEntity(arg_2_0._stepMo.fromId)

		if var_2_0 then
			var_2_0:playHitAnim()
		end
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardrelease)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 1)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
end

return var_0_0
