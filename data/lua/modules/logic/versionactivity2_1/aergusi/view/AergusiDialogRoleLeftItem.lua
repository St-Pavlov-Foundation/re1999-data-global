module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleLeftItem", package.seeall)

local var_0_0 = class("AergusiDialogRoleLeftItem", AergusiDialogRoleItemBase)
local var_0_1 = -4.9039
local var_0_2 = 22

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.go = arg_2_1
	arg_2_0._resPath = arg_2_2
	arg_2_0._golight = gohelper.findChild(arg_2_1, "light")
	arg_2_0._gochess = gohelper.findChild(arg_2_1, "chessitem")
	arg_2_0._simagechess = gohelper.findChildSingleImage(arg_2_1, "chessitem/#chess")
	arg_2_0._gotalk = gohelper.findChild(arg_2_1, "go_talking")
	arg_2_0._gobubble = gohelper.findChild(arg_2_1, "go_bubble")
	arg_2_0._gospeakbubble = gohelper.findChild(arg_2_1, "go_bubble/go_speakbubble")
	arg_2_0._txtspeakbubbledesc = gohelper.findChildText(arg_2_1, "go_bubble/go_speakbubble/txt_dec")
	arg_2_0._gothinkbubble = gohelper.findChild(arg_2_1, "go_bubble/go_thinkbubble")
	arg_2_0._txtthinkbubbledesc = gohelper.findChildText(arg_2_1, "go_bubble/go_thinkbubble/txt_dec")
	arg_2_0._gopatience = gohelper.findChild(arg_2_1, "#go_patience")
	arg_2_0._imageprogress = gohelper.findChildImage(arg_2_1, "#go_patience/#image_progress")
	arg_2_0._goprogress = gohelper.findChild(arg_2_1, "#go_patience/#progress")

	gohelper.setActive(arg_2_0.go, true)
	gohelper.setActive(arg_2_0._gobubble, false)
	gohelper.setActive(arg_2_0._golight, false)
	gohelper.setActive(arg_2_0._gotalk, false)

	arg_2_0._chessAni = arg_2_0._gochess:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._progressAni = arg_2_0._goprogress:GetComponent(typeof(UnityEngine.Animator))

	arg_2_0:showPatience()
	arg_2_0._simagechess:LoadImage(ResUrl.getV2a1AergusiSingleBg(arg_2_0._resPath))
	arg_2_0:_addEvents()

	arg_2_0._txtspeakbubbledescMarkTopIndex = arg_2_0:createMarktopCmp(arg_2_0._txtspeakbubbledesc)
	arg_2_0._txtthinkbubbledescMarkTopIndex = arg_2_0:createMarktopCmp(arg_2_0._txtthinkbubbledesc)

	arg_2_0:setTopOffset(arg_2_0._txtspeakbubbledescMarkTopIndex, 0, var_0_1)
	arg_2_0:setTopOffset(arg_2_0._txtthinkbubbledescMarkTopIndex, 0, var_0_1)
	arg_2_0:setLineSpacing(arg_2_0._txtspeakbubbledescMarkTopIndex, var_0_2)
	arg_2_0:setLineSpacing(arg_2_0._txtthinkbubbledescMarkTopIndex, var_0_2)
end

function var_0_0.showTalking(arg_3_0)
	arg_3_0._chessAni:Play("jump", 0, 0)
	gohelper.setActive(arg_3_0._golight, true)
	gohelper.setActive(arg_3_0._gotalk, true)
	TaskDispatcher.runDelay(arg_3_0.hideTalking, arg_3_0, 3)
end

function var_0_0.hideTalking(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.hideTalking, arg_4_0)
	gohelper.setActive(arg_4_0._golight, false)
	gohelper.setActive(arg_4_0._gotalk, false)
end

function var_0_0.showPatience(arg_5_0)
	gohelper.setActive(arg_5_0._gopatience, true)

	local var_5_0 = AergusiDialogModel.instance:getLeftErrorTimes()
	local var_5_1 = AergusiModel.instance:getCurEpisode()
	local var_5_2 = var_5_0 / AergusiConfig.instance:getEpisodeConfig(nil, var_5_1).maxError

	arg_5_0._imageprogress.fillAmount = var_5_2

	if var_5_0 == 3 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(arg_5_0._imageprogress, "v2a1_aergusi_chat_progress_green")
	elseif var_5_0 == 2 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(arg_5_0._imageprogress, "v2a1_aergusi_chat_progress_yellow")
		gohelper.setActive(arg_5_0._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		arg_5_0._progressAni:Play("toyellow")
	elseif var_5_0 == 1 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(arg_5_0._imageprogress, "v2a1_aergusi_chat_progress_red")
		gohelper.setActive(arg_5_0._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		arg_5_0._progressAni:Play("tored")
	else
		gohelper.setActive(arg_5_0._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		arg_5_0._progressAni:Play("toempty")
	end
end

function var_0_0.showBubble(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._gobubble, true)

	if arg_6_1.bubbleType == AergusiEnum.DialogBubbleType.Speaker then
		gohelper.setActive(arg_6_0._gospeakbubble, true)
		gohelper.setActive(arg_6_0._gothinkbubble, false)
		arg_6_0:setTextWithMarktopByIndex(arg_6_0._txtspeakbubbledescMarkTopIndex, arg_6_1.content)
	else
		gohelper.setActive(arg_6_0._gothinkbubble, true)
		gohelper.setActive(arg_6_0._gospeakbubble, false)
		arg_6_0:setTextWithMarktopByIndex(arg_6_0._txtthinkbubbledescMarkTopIndex, arg_6_1.content)
	end
end

function var_0_0.hideBubble(arg_7_0)
	gohelper.setActive(arg_7_0._gobubble, false)
end

function var_0_0._addEvents(arg_8_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnStartErrorBubbleDialog, arg_8_0._onStartErrorBubbleDialog, arg_8_0)
end

function var_0_0._removeEvents(arg_9_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnStartErrorBubbleDialog, arg_9_0._onStartErrorBubbleDialog, arg_9_0)
end

function var_0_0._onStartErrorBubbleDialog(arg_10_0, arg_10_1)
	arg_10_0:showPatience()
end

function var_0_0.destroy(arg_11_0)
	arg_11_0._simagechess:UnLoadImage()
	arg_11_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_11_0.hideTalking, arg_11_0)
	var_0_0.super.destroy(arg_11_0)
end

return var_0_0
