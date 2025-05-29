module("modules.logic.versionactivity2_6.dicehero.controller.effect.DiceHeroDamageWork", package.seeall)

local var_0_0 = class("DiceHeroDamageWork", DiceHeroBaseEffectWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = DiceHeroFightModel.instance:getGameData()

	arg_1_0._isFromCard = arg_1_0._effectMo.parent.isByCard
	arg_1_0._isByHero = var_1_0.allyHero.uid == arg_1_0._effectMo.fromId

	local var_1_1 = DiceHeroHelper.instance:getEntity(arg_1_0._effectMo.fromId)
	local var_1_2 = DiceHeroHelper.instance:getEntity(arg_1_0._effectMo.targetId)

	arg_1_0._targetPos = var_1_2:getPos()
	arg_1_0._targetItem = var_1_2

	if arg_1_0._isByHero and arg_1_0._isFromCard and string.nilorempty(arg_1_0._effectMo.extraData) then
		local var_1_3 = DiceHeroHelper.instance:getCard(tonumber(arg_1_0._effectMo.parent.reasonId))

		arg_1_0._effectItem = DiceHeroHelper.instance:doEffect(2, var_1_3:getPos(), arg_1_0._targetPos)
	else
		arg_1_0._effectItem = DiceHeroHelper.instance:doEffect(arg_1_0._isByHero and 2 or 3, var_1_1:getPos(), arg_1_0._targetPos)
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shot)
	TaskDispatcher.runDelay(arg_1_0._delayShowDamage, arg_1_0, 0.5)
end

function var_0_0._delayShowDamage(arg_2_0)
	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.OnDamage, arg_2_0._isByHero)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_shotimp)
	arg_2_0._targetItem:showEffect(4)
	TaskDispatcher.runDelay(arg_2_0._delayShowNum, arg_2_0, 0.5)
	TaskDispatcher.runDelay(arg_2_0._delayFinish, arg_2_0, 1)
end

function var_0_0._delayShowNum(arg_3_0)
	arg_3_0._effectItem:initData(1, arg_3_0._targetPos, nil, arg_3_0._effectMo.effectNum)
end

function var_0_0._delayFinish(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0._effectItem then
		DiceHeroHelper.instance:returnEffectItemToPool(arg_5_0._effectItem)

		arg_5_0._effectItem = nil
	end

	TaskDispatcher.cancelTask(arg_5_0._delayShowDamage, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayShowNum, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayFinish, arg_5_0)
end

return var_0_0
