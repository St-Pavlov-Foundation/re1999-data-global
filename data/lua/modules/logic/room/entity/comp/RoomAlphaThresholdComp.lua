module("modules.logic.room.entity.comp.RoomAlphaThresholdComp", package.seeall)

local var_0_0 = class("RoomAlphaThresholdComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKey = RoomEnum.EffectKey.BuildingGOKey
	arg_1_0.__willDestroy = false
	arg_1_0._tweenAlphaParams = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.setEffectKey(arg_3_0, arg_3_1)
	arg_3_0._effectKey = arg_3_1
end

function var_0_0.tweenAlphaThreshold(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	if arg_4_0.__willDestroy then
		return
	end

	arg_4_0._tweenAlphaParams.hasWaitRun = true
	arg_4_0._tweenAlphaParams.form = arg_4_1
	arg_4_0._tweenAlphaParams.to = arg_4_2
	arg_4_0._tweenAlphaParams.duration = arg_4_3
	arg_4_0._finishCb = arg_4_4
	arg_4_0._finishCbObj = arg_4_5
	arg_4_0._scene = GameSceneMgr.instance:getCurScene()

	arg_4_0:_runTweenAlpha()
end

function var_0_0._runTweenAlpha(arg_5_0)
	if arg_5_0._tweenAlphaParams.hasWaitRun then
		arg_5_0._tweenAlphaParams.hasWaitRun = false

		arg_5_0:_killTweenAlpha()

		if arg_5_0.entity.effect:isHasEffectGOByKey(arg_5_0._effectKey) then
			arg_5_0._tweenAlphaId = arg_5_0._scene.tween:tweenFloat(0, 1, arg_5_0._tweenAlphaParams.duration, arg_5_0._frameAlphaCallback, arg_5_0._finishAlphaTween, arg_5_0, arg_5_0._tweenAlphaParams)
		end
	end
end

function var_0_0._killTweenAlpha(arg_6_0)
	if arg_6_0._tweenAlphaId then
		if arg_6_0._scene and arg_6_0._scene.tween then
			arg_6_0._scene.tween:killById(arg_6_0._tweenAlphaId)
		end

		arg_6_0._tweenAlphaId = nil
	end
end

function var_0_0._frameAlphaCallback(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2.form + (arg_7_2.to - arg_7_2.form) * arg_7_1

	arg_7_0.entity.effect:setMPB(arg_7_0._effectKey, false, var_7_0 > 0.01, var_7_0)
end

function var_0_0._finishAlphaTween(arg_8_0)
	if arg_8_0.__willDestroy or not arg_8_0._finishCb then
		return
	end

	arg_8_0._tweenAlphaId = nil

	arg_8_0._finishCb(arg_8_0._finishCbObj)

	arg_8_0._finishCb = nil
	arg_8_0._finishCbObj = nil
end

function var_0_0.beforeDestroy(arg_9_0)
	arg_9_0.__willDestroy = true

	arg_9_0:_killTweenAlpha()

	arg_9_0._finishCb = nil
	arg_9_0._finishCbObj = nil
end

function var_0_0.onEffectReturn(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._tweenAlphaId and arg_10_1 == arg_10_0._effectKey then
		arg_10_0.entity.effect:setMPB(arg_10_0._effectKey, false, false, 0)
	end
end

return var_0_0
