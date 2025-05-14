module("modules.logic.scene.room.comp.RoomSceneTweenComp", package.seeall)

local var_0_0 = class("RoomSceneTweenComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._initialized = false
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._tweenId = 0
	arg_2_0._tweenParamDict = {}
	arg_2_0._toDeleteTweenIdDict = {}

	TaskDispatcher.runRepeat(arg_2_0._onUpdate, arg_2_0, 0)

	arg_2_0._initialized = true
end

function var_0_0.getTweenId(arg_3_0)
	arg_3_0._tweenId = arg_3_0._tweenId + 1

	return arg_3_0._tweenId
end

function var_0_0.tweenFloat(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
	local var_4_0 = arg_4_0:getTweenId()
	local var_4_1 = {
		time = 0,
		from = arg_4_1,
		to = arg_4_2,
		duration = arg_4_3,
		frameCallback = arg_4_4,
		finishCallback = arg_4_5,
		target = arg_4_6,
		object = arg_4_7,
		ease = arg_4_8
	}

	arg_4_0._tweenParamDict[var_4_0] = var_4_1

	return var_4_0
end

function var_0_0.killById(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_0._toDeleteTweenIdDict[arg_5_1] = true
end

function var_0_0._onUpdate(arg_6_0)
	if not arg_6_0._tweenParamDict or not arg_6_0._initialized then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0._tweenParamDict) do
		if not arg_6_0._toDeleteTweenIdDict[iter_6_0] then
			iter_6_1.time = iter_6_1.time + Time.deltaTime

			if iter_6_1.time > iter_6_1.duration then
				arg_6_0._toDeleteTweenIdDict[iter_6_0] = true

				if iter_6_1.finishCallback then
					if iter_6_1.target then
						iter_6_1.finishCallback(iter_6_1.target, iter_6_1.object)
					else
						iter_6_1.finishCallback(iter_6_1.object)
					end
				end
			elseif iter_6_1.frameCallback then
				local var_6_0 = arg_6_0:getFloat(iter_6_1.from, iter_6_1.to, iter_6_1.duration, iter_6_1.time, iter_6_1.ease)

				if iter_6_1.target then
					iter_6_1.frameCallback(iter_6_1.target, var_6_0, iter_6_1.object)
				else
					iter_6_1.frameCallback(var_6_0, iter_6_1.object)
				end
			end
		end
	end

	local var_6_1 = false

	for iter_6_2, iter_6_3 in pairs(arg_6_0._toDeleteTweenIdDict) do
		arg_6_0._tweenParamDict[iter_6_2] = nil
		var_6_1 = true
	end

	if var_6_1 then
		arg_6_0._toDeleteTweenIdDict = {}
	end
end

function var_0_0.getFloat(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	if arg_7_4 < 0 then
		return arg_7_1
	elseif arg_7_3 < arg_7_4 then
		return arg_7_2
	end

	if arg_7_5 then
		return LuaTween.tween(arg_7_4, arg_7_1, arg_7_2 - arg_7_1, arg_7_3, arg_7_5)
	else
		local var_7_0 = arg_7_4 / arg_7_3

		return arg_7_1 * (1 - var_7_0) + arg_7_2 * var_7_0
	end
end

function var_0_0.onSceneClose(arg_8_0)
	arg_8_0._initialized = false

	TaskDispatcher.cancelTask(arg_8_0._onUpdate, arg_8_0)

	arg_8_0._tweenId = 0
	arg_8_0._tweenParamDict = {}
	arg_8_0._toDeleteTweenIdDict = {}
	arg_8_0._initialized = false
end

return var_0_0
