module("modules.logic.versionactivity2_4.music.controller.VersionActivity2_4MultiTouchController", package.seeall)

local var_0_0 = class("VersionActivity2_4MultiTouchController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.isMobilePlayer()
	return BootNativeUtil.isMobilePlayer()
end

function var_0_0.addTouch(arg_6_0, arg_6_1)
	if not var_0_0.isMobilePlayer() then
		return
	end

	if arg_6_0._touchList then
		table.insert(arg_6_0._touchList, arg_6_1)
	else
		logError("addTouch touchList is nil")
	end
end

function var_0_0.removeTouch(arg_7_0, arg_7_1)
	if not var_0_0.isMobilePlayer() then
		return
	end

	if arg_7_0._touchList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._touchList) do
			if iter_7_1 == arg_7_1 then
				table.remove(arg_7_0._touchList, iter_7_0)

				break
			end
		end
	end
end

function var_0_0.startMultiTouch(arg_8_0, arg_8_1)
	if not var_0_0.isMobilePlayer() then
		return
	end

	arg_8_0._touchList = {}
	arg_8_0._touchCount = 5
	arg_8_0._viewName = arg_8_1

	TaskDispatcher.cancelTask(arg_8_0._frameHandler, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._frameHandler, arg_8_0, 0)
end

function var_0_0._frameHandler(arg_9_0)
	if not arg_9_0._touchList then
		return
	end

	local var_9_0 = true
	local var_9_1 = UnityEngine.Input.touchCount
	local var_9_2 = math.min(var_9_1, arg_9_0._touchCount)

	for iter_9_0 = 1, var_9_2 do
		local var_9_3 = iter_9_0 - 1
		local var_9_4 = UnityEngine.Input.GetTouch(var_9_3)

		if var_9_4.phase == TouchPhase.Began then
			if var_9_0 and not ViewHelper.instance:checkViewOnTheTop(arg_9_0._viewName) then
				return
			end

			var_9_0 = false

			local var_9_5 = var_9_4.position

			arg_9_0:_checkTouch(var_9_5)
		end
	end
end

function var_0_0._checkTouch(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._touchList) do
		if iter_10_1:canTouch() and var_0_0.isTouchOverGo(iter_10_1.go, arg_10_1) then
			iter_10_1:touchDown()

			break
		end
	end
end

function var_0_0.isTouchOverGo(arg_11_0, arg_11_1)
	if not arg_11_0 or not arg_11_1 then
		return false
	end

	local var_11_0 = arg_11_0.transform
	local var_11_1 = recthelper.getWidth(var_11_0)
	local var_11_2 = recthelper.getHeight(var_11_0)
	local var_11_3 = recthelper.screenPosToAnchorPos(arg_11_1, var_11_0)
	local var_11_4 = var_11_0.pivot

	if var_11_3.x >= -var_11_1 * var_11_4.x and var_11_3.x <= var_11_1 * (1 - var_11_4.x) and var_11_3.y <= var_11_2 * var_11_4.x and var_11_3.y >= -var_11_2 * (1 - var_11_4.x) then
		return true
	end

	return false
end

function var_0_0.endMultiTouch(arg_12_0)
	if not var_0_0.isMobilePlayer() then
		return
	end

	TaskDispatcher.cancelTask(arg_12_0._frameHandler, arg_12_0)

	arg_12_0._touchList = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
