module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroChangeShieldWork", package.seeall)

local var_0_0 = class("DiceHeroChangeShieldWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._effectMo.targetId
	local var_1_1 = DiceHeroHelper.instance:getEntity(var_1_0)

	if not var_1_1 then
		logError("找不到实体" .. var_1_0)
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._targetEntity = var_1_1
	arg_1_0._isFromCard = arg_1_0._effectMo.parent.isByCard
	arg_1_0._targetPos = arg_1_0._targetEntity:getPos(1)

	if arg_1_0._isFromCard and string.nilorempty(arg_1_0._effectMo.extraData) and arg_1_0._effectMo.effectNum > 0 then
		local var_1_2 = DiceHeroHelper.instance:getCard(tonumber(arg_1_0._effectMo.parent.reasonId))

		arg_1_0._effectItem = DiceHeroHelper.instance:doEffect(6, var_1_2:getPos(), arg_1_0._targetPos)

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
		TaskDispatcher.runDelay(arg_1_0.showEffectNum, arg_1_0, 0.5)
	else
		arg_1_0:showEffectNum()
	end
end

function var_0_0.showEffectNum(arg_2_0)
	arg_2_0._targetEntity:addShield(arg_2_0._effectMo.effectNum)

	if arg_2_0._effectMo.effectNum > 0 then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_defense)
		arg_2_0._targetEntity:showEffect(3)

		if arg_2_0._effectItem then
			arg_2_0._effectItem:initData(4, arg_2_0._targetPos, nil, string.format("%+d", arg_2_0._effectMo.effectNum))
		else
			arg_2_0._effectItem = DiceHeroHelper.instance:doEffect(4, arg_2_0._targetPos, nil, string.format("%+d", arg_2_0._effectMo.effectNum))
		end

		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 1)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	arg_4_0._targetEntity = nil

	if arg_4_0._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(arg_4_0._effectItem)

		arg_4_0._effectItem = nil
	end

	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.showEffectNum, arg_4_0)
end

return var_0_0
