module("modules.logic.survival.controller.work.SurvivalDecreeVoteNpcBubbleWork", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteNpcBubbleWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:initParam(arg_1_1)
end

function var_0_0.initParam(arg_2_0, arg_2_1)
	arg_2_0.bubbleList = arg_2_1.bubbleList or {}
	arg_2_0.startCallback = arg_2_1.startCallback
	arg_2_0.startCallbackObj = arg_2_1.startCallbackObj
end

function var_0_0.onStart(arg_3_0)
	if arg_3_0.startCallback then
		arg_3_0.startCallback(arg_3_0.startCallbackObj)
	end

	if arg_3_0.bubbleList then
		local var_3_0 = {}
		local var_3_1 = tabletool.copy(arg_3_0.bubbleList)

		while #var_3_1 > 0 do
			local var_3_2 = math.random(3, math.min(5, #var_3_1))
			local var_3_3 = {}

			for iter_3_0 = 1, var_3_2 do
				if #var_3_1 > 0 then
					local var_3_4 = math.random(1, #var_3_1)

					table.insert(var_3_3, var_3_1[var_3_4])
					table.remove(var_3_1, var_3_4)
				end
			end

			table.insert(var_3_0, var_3_3)
		end

		arg_3_0.groupedBubbles = var_3_0
		arg_3_0._animIndex = 0

		TaskDispatcher.runRepeat(arg_3_0._playItemOpenAnim, arg_3_0, 0.06, #arg_3_0.groupedBubbles)
	else
		arg_3_0:onPlayFinish()
	end
end

function var_0_0._playItemOpenAnim(arg_4_0)
	arg_4_0._animIndex = arg_4_0._animIndex + 1

	local var_4_0 = arg_4_0.groupedBubbles[arg_4_0._animIndex]

	if var_4_0 then
		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			gohelper.setActive(iter_4_1.go, true)
		end
	end

	if arg_4_0._animIndex >= #arg_4_0.groupedBubbles then
		TaskDispatcher.cancelTask(arg_4_0._playItemOpenAnim, arg_4_0)
		arg_4_0:onPlayFinish()
	end
end

function var_0_0.onPlayFinish(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._playItemOpenAnim, arg_6_0)
end

return var_0_0
