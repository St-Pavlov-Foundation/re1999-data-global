module("modules.logic.story.view.StoryDialogSlideItem", package.seeall)

local var_0_0 = class("StoryDialogSlideItem")

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = ViewMgr.instance:getContainer(ViewName.StoryView)
	local var_1_1 = var_1_0:getSetting().otherRes[3]

	arg_1_0._dialogGo = var_1_0:getResInst(var_1_1, arg_1_1)
	arg_1_0._simagedialog = gohelper.findChildSingleImage(arg_1_0._dialogGo, "#simage_dialog")
	arg_1_0._imagedialog = gohelper.findChildImage(arg_1_0._dialogGo, "#simage_dialog")
end

function var_0_0.clearSlideDialog(arg_2_0)
	arg_2_0._callback = nil
	arg_2_0._callbackObj = nil
end

function var_0_0.startShowDialog(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = ResUrl.getStoryLangPath(arg_3_1.img)

	arg_3_0._speed = arg_3_1.speed
	arg_3_0._showTime = arg_3_1.showTime
	arg_3_0._callback = arg_3_2
	arg_3_0._callbackObj = arg_3_3

	gohelper.setActive(arg_3_0._dialogGo, true)
	arg_3_0._simagedialog:LoadImage(var_3_0, arg_3_0._imgLoaded, arg_3_0)
end

function var_0_0.hideDialog(arg_4_0)
	gohelper.setActive(arg_4_0._dialogGo, false)
	arg_4_0._simagedialog:UnLoadImage()
end

function var_0_0._imgLoaded(arg_5_0)
	gohelper.setActive(arg_5_0._imagedialog.gameObject, false)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(arg_5_0._imagedialog.gameObject, true)
		arg_5_0._imagedialog:SetNativeSize()
		arg_5_0:_startMove()
	end, nil, 0.05)
end

function var_0_0._moveUpdate(arg_7_0, arg_7_1)
	local var_7_0, var_7_1 = transformhelper.getLocalPos(arg_7_0._simagedialog.transform)

	transformhelper.setLocalPosXY(arg_7_0._simagedialog.transform, arg_7_1, var_7_1)
end

function var_0_0._startMove(arg_8_0)
	if arg_8_0._tweenId then
		ZProj.TweenHelper.KillById(arg_8_0._tweenId)

		arg_8_0._tweenId = nil
	end

	local var_8_0 = recthelper.getWidth(arg_8_0._simagedialog.transform)
	local var_8_1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	local var_8_2 = 0.5 * (var_8_1 + var_8_0)
	local var_8_3 = arg_8_0._showTime
	local var_8_4 = var_8_2 - 0.2 * (var_8_1 + var_8_0) * arg_8_0._speed * var_8_3

	arg_8_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_8_2, var_8_4, var_8_3, arg_8_0._moveUpdate, arg_8_0._moveDone, arg_8_0, nil, EaseType.Linear)
end

function var_0_0._moveDone(arg_9_0)
	if arg_9_0._callback then
		arg_9_0._callback(arg_9_0._callbackObj)
	end

	TaskDispatcher.runDelay(arg_9_0._startMove, arg_9_0, 3)
end

function var_0_0.destroy(arg_10_0)
	if arg_10_0._tweenId then
		ZProj.TweenHelper.KillById(arg_10_0._tweenId)

		arg_10_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_10_0._startMove, arg_10_0)
	arg_10_0._simagedialog:UnLoadImage()
end

return var_0_0
