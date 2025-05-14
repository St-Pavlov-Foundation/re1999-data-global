module("modules.logic.room.entity.comp.RoomCrossloadComp", package.seeall)

local var_0_0 = class("RoomCrossloadComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._mo = arg_2_0.entity:getMO()
	arg_2_0._crossload = RoomBuildingEnum.Crossload[arg_2_0._mo.buildingId]
	arg_2_0._nextTime = 0
	arg_2_0._durtion = 5
	arg_2_0._isCanMove = true
	arg_2_0._defaultAnimTime = 2.1
	arg_2_0._animTime = 2.1

	arg_2_0:reset()
end

function var_0_0.getCurResId(arg_3_0)
	return arg_3_0._curResId
end

function var_0_0.getCanMove(arg_4_0)
	return arg_4_0._isCanMove
end

function var_0_0.reset(arg_5_0)
	arg_5_0._curResId = nil

	if arg_5_0:_canWork() then
		arg_5_0:_runDelayInitAnim(3)
	end
end

function var_0_0._canWork(arg_6_0)
	return RoomController.instance:isObMode() or RoomController.instance:isVisitMode()
end

function var_0_0.playAnim(arg_7_0, arg_7_1)
	if not arg_7_0:_canWork() then
		return
	end

	if arg_7_1 == arg_7_0._curResId then
		local var_7_0 = Time.time + arg_7_0._durtion

		if var_7_0 > arg_7_0._nextTime then
			arg_7_0._nextTime = var_7_0
		end

		return
	end

	if Time.time < arg_7_0._nextTime then
		return
	end

	arg_7_0:_playAnim(arg_7_1)
	arg_7_0:_runDelayInitAnim(arg_7_0._animTime + arg_7_0._durtion)
end

function var_0_0._runDelayInitAnim(arg_8_0, arg_8_1)
	TaskDispatcher.cancelTask(arg_8_0._playInitAnim, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._playInitAnim, arg_8_0, arg_8_1)
end

function var_0_0._playInitAnim(arg_9_0)
	local var_9_0 = arg_9_0:_getInitResId()

	if var_9_0 ~= arg_9_0._curResId then
		arg_9_0:_playAnim(var_9_0, arg_9_0._curResId == nil)
	end
end

function var_0_0._playAnim(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0, var_10_1, var_10_2 = arg_10_0:_findAninNameByResId(arg_10_1)

	if not var_10_0 then
		return
	end

	if arg_10_0:_getAnimator() then
		arg_10_0._isCanMove = arg_10_0._curResId == arg_10_1
		arg_10_0._curResId = arg_10_1
		arg_10_0._animTime = var_10_1 or arg_10_0._defineAnimTime

		arg_10_0._animator:Play(var_10_0, 0, arg_10_2 and 1 or 0)
		TaskDispatcher.cancelTask(arg_10_0._delayOpenOrClose, arg_10_0)
		TaskDispatcher.runDelay(arg_10_0._delayOpenOrClose, arg_10_0, arg_10_0._animTime)

		arg_10_0._nextTime = Time.time + arg_10_0._durtion

		if not arg_10_2 and var_10_2 and var_10_2 ~= 0 then
			arg_10_0.entity:playAudio(var_10_2, arg_10_0.go)
		end
	end
end

function var_0_0._delayOpenOrClose(arg_11_0)
	if not RoomCrossLoadController.instance:isLock() then
		RoomCrossLoadController.instance:updatePathGraphic(arg_11_0._mo.id)

		arg_11_0._isCanMove = true
	else
		arg_11_0._curResId = nil
	end
end

function var_0_0.addEventListeners(arg_12_0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, arg_12_0._onSwitchModel, arg_12_0)
end

function var_0_0.removeEventListeners(arg_13_0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, arg_13_0._onSwitchModel, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._playInitAnim, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._delayOpenOrClose, arg_13_0)
end

function var_0_0._onSwitchModel(arg_14_0)
	arg_14_0:reset()
end

function var_0_0._findAninNameByResId(arg_15_0, arg_15_1)
	if arg_15_0._crossload and arg_15_0._crossload.AnimStatus then
		local var_15_0 = arg_15_0._crossload.AnimStatus

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if iter_15_1.resId == arg_15_1 then
				return iter_15_1.animName, iter_15_1.animTime, iter_15_1.audioId
			end
		end
	end
end

function var_0_0._getInitResId(arg_16_0)
	if arg_16_0._crossload and arg_16_0._crossload.AnimStatus then
		return arg_16_0._crossload.AnimStatus[1].resId
	end
end

function var_0_0._getAnimator(arg_17_0)
	if not arg_17_0._animator then
		local var_17_0 = arg_17_0.entity:getBuildingGO()

		if var_17_0 then
			arg_17_0._animator = var_17_0:GetComponent(typeof(UnityEngine.Animator))
		end
	end

	return arg_17_0._animator
end

function var_0_0.beforeDestroy(arg_18_0)
	arg_18_0._animator = nil

	arg_18_0:removeEventListeners()
end

return var_0_0
