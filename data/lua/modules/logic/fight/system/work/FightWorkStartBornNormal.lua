module("modules.logic.fight.system.work.FightWorkStartBornNormal", package.seeall)

local var_0_0 = class("FightWorkStartBornNormal", BaseWork)
local var_0_1 = {
	[FightEnum.EntitySide.MySide] = 0.7,
	[FightEnum.EntitySide.EnemySide] = 0.5
}
local var_0_2 = 0.5
local var_0_3 = {
	{
		0,
		var_0_2,
		"_BloomFactor",
		"float",
		"0",
		"1",
		false
	}
}
local var_0_4 = 0.1
local var_0_5 = 1.5

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entity = arg_1_1
	arg_1_0._needPlayBornAnim = arg_1_2
	arg_1_0._animDone = false
	arg_1_0._effectDone = false
	arg_1_0.dontDealBuff = nil
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBornNormal, arg_2_0._entity.id)

	if arg_2_0._entity.isSub then
		arg_2_0._effectDone = true

		arg_2_0._entity:setAlpha(1, 0)
		arg_2_0:_playBornAnim()

		return
	end

	if arg_2_0._needPlayBornAnim and arg_2_0._entity.spine:hasAnimation(SpineAnimState.born) then
		arg_2_0:_setSkinSpineActionLock(true)
		arg_2_0._entity.spine:getSkeletonAnim():SetMixDuration(0)
		arg_2_0._entity.spine:play(SpineAnimState.born, false, true)
		TaskDispatcher.runDelay(function()
			arg_2_0._entity.spine:setFreeze(true)
		end, nil, 0.001)
	end

	arg_2_0:_playEffect()
	arg_2_0._entity:setAlpha(0, 0)

	local var_2_0 = arg_2_0._entity.spine and arg_2_0._entity.spine:getPPEffectMask()

	if var_2_0 then
		var_2_0.enabled = false
	end

	if arg_2_0._entity.nameUI then
		arg_2_0._entity.nameUI:setActive(false)
	end

	local var_2_1 = var_0_1[arg_2_0._entity:getSide()] / FightModel.instance:getSpeed()

	if var_2_1 and var_2_1 > 0 then
		TaskDispatcher.runDelay(arg_2_0._startFadeIn, arg_2_0, var_2_1)
	else
		arg_2_0:_startFadeIn()
	end
end

function var_0_0._playEffect(arg_4_0)
	local var_4_0 = FightPreloadEffectWork.buff_chuchang
	local var_4_1
	local var_4_2 = var_0_5
	local var_4_3 = arg_4_0._entity:getMO()

	if var_4_3 then
		local var_4_4 = lua_fight_debut_show.configDict[var_4_3.skin]

		if var_4_4 then
			var_4_0 = nil

			if not string.nilorempty(var_4_4.effect) then
				var_4_0 = var_4_4.effect
				var_4_1 = var_4_4.effectHangPoint
				var_4_2 = var_4_4.effectTime / 1000
			end

			if var_4_4.audioId ~= 0 then
				AudioMgr.instance:trigger(var_4_4.audioId)
			end
		end
	end

	if var_4_0 then
		arg_4_0._effectWrap = arg_4_0._entity.effect:addHangEffect(var_4_0, var_4_1)

		arg_4_0._effectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(arg_4_0._entity.id, arg_4_0._effectWrap)
		TaskDispatcher.runDelay(arg_4_0._onEffectDone, arg_4_0, var_4_2 / FightModel.instance:getSpeed())
	else
		arg_4_0:_onEffectDone()
	end
end

function var_0_0._onEffectDone(arg_5_0)
	arg_5_0._effectDone = true

	arg_5_0:_checkDone()
end

function var_0_0._checkDone(arg_6_0)
	if arg_6_0._effectDone and arg_6_0._animDone then
		if arg_6_0._entity.nameUI then
			arg_6_0._entity.nameUI:setActive(true)
		end

		local var_6_0 = arg_6_0._entity.spine and arg_6_0._entity.spine:getPPEffectMask()

		if var_6_0 then
			var_6_0.enabled = true
		end

		if not arg_6_0.dontDealBuff and arg_6_0._entity.buff then
			arg_6_0._entity.buff:dealStartBuff()
		end

		arg_6_0:onDone(true)
	end
end

function var_0_0._startFadeIn(arg_7_0)
	arg_7_0._entity:setAlpha(1, var_0_4 / FightModel.instance:getSpeed())
	TaskDispatcher.runDelay(arg_7_0._playBornAnim, arg_7_0, var_0_4 / FightModel.instance:getSpeed())

	arg_7_0._startTime = Time.time

	local var_7_0 = arg_7_0._entity.spine:getPPEffectMask()

	arg_7_0._spineMat = arg_7_0._entity.spineRenderer:getReplaceMat()

	for iter_7_0, iter_7_1 in ipairs(var_0_3) do
		local var_7_1 = iter_7_1[4]
		local var_7_2 = iter_7_1[5]
		local var_7_3 = iter_7_1[6]

		iter_7_1.startValue = MaterialUtil.getPropValueFromStr(var_7_1, var_7_2)
		iter_7_1.endValue = MaterialUtil.getPropValueFromStr(var_7_1, var_7_3)
	end

	TaskDispatcher.runRepeat(arg_7_0._onFrameMaterialProperty, arg_7_0, 0.01)
end

function var_0_0._onFrameMaterialProperty(arg_8_0)
	local var_8_0 = FightModel.instance:getSpeed() or 1
	local var_8_1 = arg_8_0._entity.spineRenderer:getReplaceMat()
	local var_8_2 = Time.time - arg_8_0._startTime

	for iter_8_0, iter_8_1 in ipairs(var_0_3) do
		local var_8_3 = iter_8_1[1]
		local var_8_4 = iter_8_1[2] / var_8_0

		if var_8_2 >= var_8_3 * 0.95 and var_8_2 <= var_8_4 * 1.05 then
			local var_8_5 = iter_8_1[3]
			local var_8_6 = iter_8_1[4]
			local var_8_7 = iter_8_1[7]
			local var_8_8 = Mathf.Clamp01((var_8_2 - var_8_3) / (var_8_4 - var_8_3))

			iter_8_1.frameValue = MaterialUtil.getLerpValue(var_8_6, iter_8_1.startValue, iter_8_1.endValue, var_8_8, iter_8_1.frameValue)

			local var_8_9 = arg_8_0._spineMat

			if var_8_9 then
				MaterialUtil.setPropValue(var_8_9, var_8_5, var_8_6, iter_8_1.frameValue)
			end
		end
	end

	if var_8_2 > var_0_2 / var_8_0 then
		TaskDispatcher.cancelTask(arg_8_0._onFrameMaterialProperty, arg_8_0)
	end
end

function var_0_0._setSkinSpineActionLock(arg_9_0, arg_9_1)
	if arg_9_0._entity and arg_9_0._entity.skinSpineAction then
		arg_9_0._entity.skinSpineAction.lock = arg_9_1
	end
end

function var_0_0._playBornAnim(arg_10_0)
	if arg_10_0._needPlayBornAnim and arg_10_0._entity.spine:hasAnimation(SpineAnimState.born) then
		arg_10_0:_setSkinSpineActionLock(false)
		arg_10_0._entity.spine:setFreeze(false)
		arg_10_0._entity.spine:addAnimEventCallback(arg_10_0._onAnimEvent, arg_10_0)
		arg_10_0._entity.spine:play(SpineAnimState.born, false, true)
	else
		arg_10_0._animDone = true

		arg_10_0:_checkDone()
	end
end

function var_0_0._onAnimEvent(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == SpineAnimEvent.ActionComplete then
		arg_11_0._entity.spine:getSkeletonAnim():ClearMixDuration()
		arg_11_0._entity.spine:removeAnimEventCallback(arg_11_0._onAnimEvent, arg_11_0)
		arg_11_0._entity:resetAnimState()

		arg_11_0._animDone = true

		arg_11_0:_checkDone()
	end
end

function var_0_0.clearWork(arg_12_0)
	arg_12_0:_setSkinSpineActionLock(false)
	TaskDispatcher.cancelTask(arg_12_0._startFadeIn, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._playBornAnim, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onEffectDone, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onFrameMaterialProperty, arg_12_0)

	if arg_12_0._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_12_0._entity.id, arg_12_0._effectWrap)
		arg_12_0._entity.effect:removeEffect(arg_12_0._effectWrap)

		arg_12_0._effectWrap = nil
	end

	if arg_12_0._entity and arg_12_0._entity.spine:getSkeletonAnim() then
		arg_12_0._entity.spine:setFreeze(false)
		arg_12_0._entity.spine:getSkeletonAnim():ClearMixDuration()
		arg_12_0._entity.spine:removeAnimEventCallback(arg_12_0._onAnimEvent, arg_12_0)
	end

	arg_12_0._spineMat = nil
end

return var_0_0
