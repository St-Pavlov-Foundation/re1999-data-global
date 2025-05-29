module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangePowerWork", package.seeall)

local var_0_0 = class("DiceHeroChangePowerWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._effectMo.targetId
	local var_1_1 = DiceHeroHelper.instance:getEntity(var_1_0)

	if not var_1_1 then
		logError("找不到实体" .. var_1_0)

		return
	end

	arg_1_0._targetEntity = var_1_1
	arg_1_0._isFromCard = arg_1_0._effectMo.parent.isByCard
	arg_1_0._targetPos = arg_1_0._targetEntity:getPos(2)

	if arg_1_0._isFromCard and string.nilorempty(arg_1_0._effectMo.extraData) and arg_1_0._effectMo.effectNum > 0 then
		local var_1_2 = DiceHeroHelper.instance:getCard(tonumber(arg_1_0._effectMo.parent.reasonId))

		arg_1_0._effectItem = DiceHeroHelper.instance:doEffect(5, var_1_2:getPos(), arg_1_0._targetPos)

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
		TaskDispatcher.runDelay(arg_1_0.addPower, arg_1_0, 0.5)
	else
		arg_1_0:addPower()
	end
end

function var_0_0.addPower(arg_2_0)
	arg_2_0._targetEntity:addPower(arg_2_0._effectMo.effectNum)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(arg_3_0._effectItem)

		arg_3_0._effectItem = nil
	end

	TaskDispatcher.cancelTask(arg_3_0.addPower, arg_3_0)
end

return var_0_0
