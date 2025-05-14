module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleRightItem", package.seeall)

local var_0_0 = class("AergusiDialogRoleRightItem", AergusiDialogRoleItemBase)
local var_0_1 = -4.9039
local var_0_2 = 22

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.go = arg_2_1
	arg_2_0._resPath = arg_2_2
	arg_2_0._golight = gohelper.findChild(arg_2_1, "light")
	arg_2_0._gochess = gohelper.findChild(arg_2_1, "#chessitem")
	arg_2_0._simagechess = gohelper.findChildSingleImage(arg_2_1, "#chessitem/#chess")
	arg_2_0._gotalk = gohelper.findChild(arg_2_1, "go_talking")
	arg_2_0._gobubble = gohelper.findChild(arg_2_1, "go_bubble")
	arg_2_0._gospeakbubble = gohelper.findChild(arg_2_1, "go_bubble/go_speakbubble")
	arg_2_0._txtspeakbubbledesc = gohelper.findChildText(arg_2_1, "go_bubble/go_speakbubble/txt_dec")
	arg_2_0._gothinkbubble = gohelper.findChild(arg_2_1, "go_bubble/go_thinkbubble")
	arg_2_0._txtthinkbubbledesc = gohelper.findChildText(arg_2_1, "go_bubble/go_thinkbubble/txt_dec")
	arg_2_0._goemo = gohelper.findChild(arg_2_1, "emobg")
	arg_2_0._chessAni = arg_2_0._gochess:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_2_0.go, true)
	gohelper.setActive(arg_2_0._golight, false)
	gohelper.setActive(arg_2_0._gotalk, false)
	gohelper.setActive(arg_2_0._gobubble, false)
	gohelper.setActive(arg_2_0._goemo, false)
	arg_2_0._simagechess:LoadImage(ResUrl.getV2a1AergusiSingleBg(arg_2_0._resPath))

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
	gohelper.setActive(arg_4_0._gotalk, false)
	gohelper.setActive(arg_4_0._golight, false)
end

function var_0_0.showEmo(arg_5_0)
	gohelper.setActive(arg_5_0._goemo, true)
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

function var_0_0.destroy(arg_8_0)
	arg_8_0._simagechess:UnLoadImage()
	var_0_0.super.destroy(arg_8_0)
end

return var_0_0
