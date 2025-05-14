module("framework.core.taskdispatcher.TaskItem", package.seeall)

local var_0_0 = class("TaskItem")

var_0_0.IsIOSPlayer = SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer
var_0_0.frameCount = 0
var_0_0._itemPool = nil

local var_0_1 = __G__TRACKBACK__
local var_0_2 = xpcall

function var_0_0.createPool()
	var_0_0._itemPool = LuaObjPool.New(32, var_0_0._poolNew, var_0_0._poolRelease, var_0_0._poolReset)

	return var_0_0._itemPool
end

function var_0_0._poolNew()
	return var_0_0.New()
end

function var_0_0._poolRelease(arg_3_0)
	arg_3_0:release()
end

function var_0_0._poolReset(arg_4_0)
	arg_4_0:reset()
end

function var_0_0.reset(arg_5_0)
	arg_5_0.interval = 0
	arg_5_0.addFrame = 0
	arg_5_0.timeCount = 0

	arg_5_0:setCb(nil, nil)

	arg_5_0.repeatCount = 0
	arg_5_0.isLoop = false
	arg_5_0.hasInvoked = false
	arg_5_0.status = TaskDispatcher.Idle
end

function var_0_0.ctor(arg_6_0)
	arg_6_0:reset()
end

function var_0_0.release(arg_7_0)
	arg_7_0:reset()
end

function var_0_0.setCb(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.callback = arg_8_1
	arg_8_0.cbObj = arg_8_2
end

function var_0_0.update(arg_9_0, arg_9_1)
	if arg_9_0.status == TaskDispatcher.ToDelete then
		arg_9_0.repeatCount = 0

		return false
	end

	arg_9_0.hasInvoked = false

	if arg_9_0.addFrame >= var_0_0.frameCount then
		return arg_9_0.hasInvoked
	end

	arg_9_0.timeCount = arg_9_0.timeCount + arg_9_1

	if arg_9_0.timeCount < arg_9_0.interval then
		return arg_9_0.hasInvoked
	end

	arg_9_0.hasInvoked = true
	arg_9_0.timeCount = arg_9_0.timeCount - arg_9_0.interval

	if arg_9_0.cbObj then
		var_0_2(arg_9_0.callback, var_0_1, arg_9_0.cbObj)
	else
		var_0_2(arg_9_0.callback, var_0_1)
	end

	arg_9_0.repeatCount = arg_9_0.repeatCount - 1

	return arg_9_0.hasInvoked
end

function var_0_0.logStr(arg_10_0)
	return "callback = " .. tostring(arg_10_0.callback) .. " cbObj = " .. tostring(arg_10_0.cbObj) .. " interval = " .. arg_10_0.interval .. " addFrame = " .. arg_10_0.addFrame .. " timeCount = " .. arg_10_0.timeCount .. " repeatCount = " .. arg_10_0.repeatCount .. " isLoop = " .. tostring(arg_10_0.isLoop) .. " hasInvoked = " .. tostring(arg_10_0.hasInvoked) .. " status = " .. arg_10_0.status
end

return var_0_0
