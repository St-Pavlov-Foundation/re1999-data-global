module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroUpdateBuffWork", package.seeall)

local var_0_0 = class("DiceHeroUpdateBuffWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._effectMo.targetId
	local var_1_1 = DiceHeroHelper.instance:getEntity(var_1_0)
	local var_1_2 = 0

	if not var_1_1 then
		logError("找不到实体" .. var_1_0)
	else
		local var_1_3 = var_1_1:getHeroMo()
		local var_1_4 = arg_1_0._effectMo.buff.co.visible == 1 and var_1_3:isAddLayer(arg_1_0._effectMo.buff)

		var_1_1:addOrUpdateBuff(arg_1_0._effectMo.buff)

		if var_1_4 then
			if arg_1_0._effectMo.buff.co.tag == 1 then
				AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_buff)
				var_1_1:showEffect(1)
			else
				AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_debuff)
				var_1_1:showEffect(2)
			end

			var_1_2 = 0.5
		end
	end

	if var_1_2 > 0 then
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, var_1_2)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

return var_0_0
