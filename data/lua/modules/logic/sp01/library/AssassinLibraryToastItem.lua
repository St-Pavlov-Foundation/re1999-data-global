module("modules.logic.sp01.library.AssassinLibraryToastItem", package.seeall)

local var_0_0 = class("AssassinLibraryToastItem", LuaCompBase)
local var_0_1 = 10000
local var_0_2 = ZProj.TweenHelper

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "btn_click")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_1, "simage_icon")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_1, "txt_title")
	arg_1_0.canvasGroup = gohelper.onceAddComponent(arg_1_1, gohelper.Type_CanvasGroup)
	arg_1_0._duration = 0.5
	arg_1_0._showToastDuration = 3
	arg_1_0.height = recthelper.getHeight(arg_1_0.tr)
	arg_1_0.width = recthelper.getWidth(arg_1_0.tr)
	arg_1_0.startAnchorPositionY = 0
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0.libraryCo then
		return
	end

	AssassinController.instance:openAssassinLibraryDetailView(arg_4_0.libraryId)
	AssassinController.instance:dispatchEvent(AssassinEvent.RecycleToast, arg_4_0)
end

function var_0_0.setMsg(arg_5_0, arg_5_1)
	arg_5_0.msg = arg_5_1
	arg_5_0.libraryId = arg_5_1
	arg_5_0.canvasGroup.alpha = 1
	arg_5_0.libraryCo = AssassinConfig.instance:getLibrarConfig(arg_5_0.libraryId)
	arg_5_0._txttitle.text = arg_5_0.libraryCo and arg_5_0.libraryCo.title

	AssassinHelper.setLibraryToastIcon(arg_5_0.msg, arg_5_0._simageicon)
end

function var_0_0._delay(arg_6_0)
	AssassinController.instance:dispatchEvent(AssassinEvent.RecycleToast, arg_6_0)
end

function var_0_0.appearAnimation(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	recthelper.setAnchorX(arg_7_0.tr, arg_7_0.width)
	var_0_2.KillById(arg_7_0.startTweenId or -1)

	arg_7_0.startTweenId = var_0_2.DOAnchorPosX(arg_7_0.tr, 0, arg_7_0._duration, function()
		arg_7_0.startTweenId = nil

		TaskDispatcher.runDelay(arg_7_0._delay, arg_7_0, arg_7_0._showToastDuration)
	end)
end

function var_0_0.upAnimation(arg_9_0, arg_9_1)
	var_0_2.KillById(arg_9_0.upTweenId or -1)

	arg_9_0.upTweenId = var_0_2.DOAnchorPosY(arg_9_0.tr, arg_9_1, arg_9_0._duration, function()
		arg_9_0.upTweenId = nil
	end)
end

function var_0_0.quitAnimation(arg_11_0, arg_11_1, arg_11_2)
	var_0_2.KillById(arg_11_0.quitTweenId or -1)

	arg_11_0.quitAnimationDoneCallback = arg_11_1
	arg_11_0.callbackObj = arg_11_2
	arg_11_0.startAnchorPositionY = arg_11_0.tr.anchoredPosition.y
	arg_11_0.quitTweenId = var_0_2.DOTweenFloat(1, 0, arg_11_0._duration, arg_11_0.quitAnimationFrame, arg_11_0.quitAnimationDone, arg_11_0)
end

function var_0_0.quitAnimationFrame(arg_12_0, arg_12_1)
	local var_12_0 = (1 - arg_12_1) * arg_12_0.height

	recthelper.setAnchorY(arg_12_0.tr, arg_12_0.startAnchorPositionY + var_12_0)

	arg_12_0.canvasGroup.alpha = arg_12_1
end

function var_0_0.quitAnimationDone(arg_13_0)
	if arg_13_0.quitAnimationDoneCallback then
		arg_13_0.quitAnimationDoneCallback(arg_13_0.callbackObj, arg_13_0)
	end

	arg_13_0.quitAnimationDoneCallback = nil
	arg_13_0.callbackObj = nil
	arg_13_0.quitTweenId = nil
end

function var_0_0.clearAllTask(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delay, arg_14_0)
	var_0_2.KillById(arg_14_0.startTweenId or -1)
	var_0_2.KillById(arg_14_0.upTweenId or -1)
	var_0_2.KillById(arg_14_0.quitTweenId or -1)

	arg_14_0.startTweenId = nil
	arg_14_0.upTweenId = nil
	arg_14_0.quitTweenId = nil
	arg_14_0.quitAnimationDoneCallback = nil
	arg_14_0.callbackObj = nil
end

function var_0_0.reset(arg_15_0)
	arg_15_0.msg = nil
	arg_15_0.startAnchorPositionY = 0

	recthelper.setAnchor(arg_15_0.tr, var_0_1, var_0_1)
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0._simageicon:UnLoadImage()
	arg_16_0:clearAllTask()
end

return var_0_0
