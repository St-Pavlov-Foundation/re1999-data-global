module("modules.logic.commandstation.view.CommandStationMapTimelineAnimView", package.seeall)

local var_0_0 = class("CommandStationMapTimelineAnimView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotimeGroup = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/#scroll_timeline/#go_Viewport/#go_timeGroup")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._isPlayingAnim = nil
end

function var_0_0._clearTimelineAnim(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._playItemOpen, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._playItemClose, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._startDelay, arg_3_0)
end

function var_0_0._checkAnimNotDone(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._isPlayingAnim then
		return true
	end

	arg_4_0._isPlayingAnim = true
	arg_4_0._isOpenTimelineAnim = arg_4_2

	UIBlockHelper.instance:startBlock("checkAnimNotDone", arg_4_1, arg_4_0.viewName)
	TaskDispatcher.cancelTask(arg_4_0._playAnimDone, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._playAnimDone, arg_4_0, arg_4_1)
end

function var_0_0._playAnimDone(arg_5_0)
	arg_5_0._isPlayingAnim = false

	CommandStationController.instance:dispatchEvent(CommandStationEvent.TimelineAnimDone, arg_5_0._isOpenTimelineAnim)
end

function var_0_0.openTimelineAnim(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_1 == 0 then
		return
	end

	if arg_6_0:_checkAnimNotDone(CommandStationEnum.TimelineOpenTime + #arg_6_1 * CommandStationEnum.TimeItemDelay + (arg_6_4 or 0), true) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline1)
	arg_6_0:_clearTimelineAnim()

	arg_6_0._itemPosMap = arg_6_1

	gohelper.setActive(arg_6_0._gotimeGroup, true)
	recthelper.setAnchorX(arg_6_0._gotimeGroup.transform, arg_6_2)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._itemPosMap) do
		local var_6_0 = iter_6_1.go
		local var_6_1 = iter_6_1.posX

		recthelper.setAnchorX(var_6_0.transform, var_6_1 - arg_6_3)
	end

	if arg_6_4 then
		TaskDispatcher.cancelTask(arg_6_0._startDelay, arg_6_0)
		TaskDispatcher.runDelay(arg_6_0._startDelay, arg_6_0, arg_6_4)
	else
		arg_6_0:_startDelay()
	end
end

function var_0_0._startDelay(arg_7_0)
	arg_7_0._curIndex = #arg_7_0._itemPosMap

	TaskDispatcher.runRepeat(arg_7_0._playItemOpen, arg_7_0, CommandStationEnum.TimeItemDelay)
end

function var_0_0._playItemOpen(arg_8_0)
	local var_8_0 = arg_8_0._itemPosMap[arg_8_0._curIndex]

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0.go
	local var_8_2 = var_8_0.posX

	if var_8_0.tweenId then
		ZProj.TweenHelper.KillById(var_8_0.tweenId)
	end

	var_8_0.tweenId = CommandStationController.CustomOutBack(var_8_1.transform, CommandStationEnum.TimelineOpenTime, var_8_2, CommandStationEnum.TimeItemWidth, nil, arg_8_0, nil)
	arg_8_0._curIndex = arg_8_0._curIndex - 1

	if arg_8_0._curIndex <= 0 then
		TaskDispatcher.cancelTask(arg_8_0._playItemOpen, arg_8_0)
	end
end

function var_0_0.closeTimelineAnim(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0:_checkAnimNotDone(CommandStationEnum.TimelineCloseTime + #arg_9_1 * CommandStationEnum.TimeItemDelay) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_timeline2)
	arg_9_0:_clearTimelineAnim()

	arg_9_0._itemPosMap = arg_9_1
	arg_9_0._timeGroupWidth = arg_9_2

	gohelper.setActive(arg_9_0._gotimeGroup, true)

	if #arg_9_0._itemPosMap == 0 then
		return
	end

	arg_9_0._curIndex = 1

	TaskDispatcher.runRepeat(arg_9_0._playItemClose, arg_9_0, CommandStationEnum.TimeItemDelay)
end

function var_0_0._playItemClose(arg_10_0)
	local var_10_0 = arg_10_0._itemPosMap[arg_10_0._curIndex]
	local var_10_1 = var_10_0.go
	local var_10_2 = var_10_0.posX

	if var_10_0.tweenId then
		ZProj.TweenHelper.KillById(var_10_0.tweenId)
	end

	var_10_0.tweenId = CommandStationController.CustomOutBack(var_10_1.transform, CommandStationEnum.TimelineCloseTime, var_10_2 - arg_10_0._timeGroupWidth, CommandStationEnum.TimeItemWidth, nil, arg_10_0, nil, EaseType.InBack)
	arg_10_0._curIndex = arg_10_0._curIndex + 1

	if arg_10_0._curIndex > #arg_10_0._itemPosMap then
		TaskDispatcher.cancelTask(arg_10_0._playItemClose, arg_10_0)
	end
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:_clearTimelineAnim()
	TaskDispatcher.cancelTask(arg_11_0._playAnimDone, arg_11_0)
end

return var_0_0
