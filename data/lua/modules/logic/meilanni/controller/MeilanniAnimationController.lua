module("modules.logic.meilanni.controller.MeilanniAnimationController", package.seeall)

local var_0_0 = class("MeilanniAnimationController", BaseController)

var_0_0.historyLayer = 1
var_0_0.excludeRulesLayer = 2
var_0_0.epilogueLayer = 3
var_0_0.changeMapLayer = 4
var_0_0.changeWeatherLayer = 5
var_0_0.showElementsLayer = 6
var_0_0.prefaceLayer = 7
var_0_0.enemyLayer = 8
var_0_0.endLayer = 9
var_0_0.maxLayer = 9

function var_0_0.onInit(arg_1_0)
	arg_1_0._isPlaying = nil
	arg_1_0._isPlayingDialogItemList = nil
	arg_1_0._delayCallList = {}
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._isPlaying = nil
	arg_4_0._isPlayingDialogItemList = nil
	arg_4_0._delayCallList = {}
end

function var_0_0.startDialogListAnim(arg_5_0)
	arg_5_0._isPlayingDialogItemList = true
end

function var_0_0.endDialogListAnim(arg_6_0)
	arg_6_0._isPlayingDialogItemList = nil
end

function var_0_0.isPlayingDialogListAnim(arg_7_0)
	return arg_7_0._isPlayingDialogItemList
end

function var_0_0.addDelayCall(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if not arg_8_0._isPlaying then
		arg_8_1(arg_8_2, arg_8_3)

		return
	end

	local var_8_0 = {
		arg_8_1,
		arg_8_2,
		arg_8_3,
		arg_8_4
	}
	local var_8_1 = arg_8_0._delayCallList[arg_8_5] or {}

	arg_8_0._delayCallList[arg_8_5] = var_8_1

	table.insert(var_8_1, var_8_0)
end

function var_0_0.startAnimation(arg_9_0)
	arg_9_0._isPlaying = true

	TaskDispatcher.runRepeat(arg_9_0._frame, arg_9_0, 0)
	arg_9_0:dispatchEvent(MeilanniEvent.dialogListAnimChange, arg_9_0._isPlaying)
end

function var_0_0._frame(arg_10_0)
	if arg_10_0._isPlayingDialogItemList or ViewMgr.instance:isOpen(ViewName.MeilanniBossInfoView) then
		return
	end

	local var_10_0 = arg_10_0:_getFirstCall()

	if not var_10_0 then
		return
	end

	if not var_10_0._startTime then
		var_10_0._startTime = Time.realtimeSinceStartup

		return
	end

	local var_10_1 = var_10_0[1]
	local var_10_2 = var_10_0[2]
	local var_10_3 = var_10_0[3]

	if (var_10_0[4] or 0) <= Time.realtimeSinceStartup - var_10_0._startTime then
		local var_10_4 = arg_10_0:_getFirstCall(true)

		var_10_1(var_10_2, var_10_3)
	end
end

function var_0_0._getFirstCall(arg_11_0, arg_11_1)
	for iter_11_0 = 1, var_0_0.maxLayer do
		local var_11_0 = arg_11_0._delayCallList[iter_11_0]

		if var_11_0 and #var_11_0 > 0 then
			if arg_11_1 then
				return table.remove(var_11_0, 1)
			else
				return var_11_0[1]
			end
		end
	end

	return nil
end

function var_0_0.endAnimation(arg_12_0, arg_12_1)
	arg_12_0:addDelayCall(arg_12_0._endAnimation, arg_12_0, nil, nil, arg_12_1)
end

function var_0_0._endAnimation(arg_13_0)
	arg_13_0._isPlaying = false

	TaskDispatcher.cancelTask(arg_13_0._frame, arg_13_0)
	arg_13_0:dispatchEvent(MeilanniEvent.dialogListAnimChange, arg_13_0._isPlaying)
end

function var_0_0.isPlaying(arg_14_0)
	return arg_14_0._isPlaying
end

function var_0_0.close(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._frame, arg_15_0)
	arg_15_0:reInit()
end

var_0_0.instance = var_0_0.New()

return var_0_0
