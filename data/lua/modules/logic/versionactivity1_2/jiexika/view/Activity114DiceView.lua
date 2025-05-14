module("modules.logic.versionactivity1_2.jiexika.view.Activity114DiceView", package.seeall)

local var_0_0 = class("Activity114DiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtneedNum = gohelper.findChildText(arg_1_0.viewGO, "throw/#txt_needNum")
	arg_1_0._txtdiceNum1 = gohelper.findChildText(arg_1_0.viewGO, "dice1/#txt_diceNum")
	arg_1_0._txtdiceNum2 = gohelper.findChildText(arg_1_0.viewGO, "dice2/#txt_diceNum")
	arg_1_0._imageresult = gohelper.findChildImage(arg_1_0.viewGO, "throw/#image_result")
	arg_1_0._txtdotip = gohelper.findChildText(arg_1_0.viewGO, "#go_doing/#txt_dotip")
	arg_1_0._gosucc = gohelper.findChild(arg_1_0.viewGO, "#go_succ")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._godoing = gohelper.findChild(arg_1_0.viewGO, "#go_doing")
	arg_1_0._btnclose = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gogreaterIcon = gohelper.findChild(arg_1_0.viewGO, "throw/#go_greaterIcon")
	arg_1_0._goequalIcon = gohelper.findChild(arg_1_0.viewGO, "throw/#go_equalIcon")
	arg_1_0._golessIcon = gohelper.findChild(arg_1_0.viewGO, "throw/#go_lessIcon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.onCloseClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)

	arg_4_0._txtdotip.text = luaLang("versionactivity_1_2_114diceview_doing")
	arg_4_0.isDone = false
	arg_4_0._txtneedNum.text = arg_4_0.viewParam.realVerify

	gohelper.setActive(arg_4_0._imageresult.gameObject, false)
	recthelper.setAnchorX(arg_4_0._txtdotip.transform, 17.1)
	TaskDispatcher.runRepeat(arg_4_0.everyFrame, arg_4_0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dice)
	gohelper.setActive(arg_4_0._godoing, true)
	gohelper.setActive(arg_4_0._gosucc, false)
	gohelper.setActive(arg_4_0._gofail, false)
	gohelper.setActive(arg_4_0._golessIcon, false)
	gohelper.setActive(arg_4_0._goequalIcon, false)
	gohelper.setActive(arg_4_0._gogreaterIcon, false)
	TaskDispatcher.runDelay(arg_4_0.onDone, arg_4_0, 2)
end

function var_0_0.everyFrame(arg_5_0)
	arg_5_0._txtdiceNum1.text = math.random(1, 6)
	arg_5_0._txtdiceNum2.text = math.random(1, 6)
end

function var_0_0.onDone(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.everyFrame, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onDone, arg_6_0)

	local var_6_0 = arg_6_0.viewParam.diceResult

	arg_6_0._txtdiceNum1.text = var_6_0[1]
	arg_6_0._txtdiceNum2.text = var_6_0[2]

	recthelper.setAnchorX(arg_6_0._txtdotip.transform, 1.3)

	arg_6_0._txtdotip.text = luaLang("versionactivity_1_2_114diceview_finish")

	TaskDispatcher.runDelay(arg_6_0.showResult, arg_6_0, 0)
end

function var_0_0.showResult(arg_7_0)
	arg_7_0.isDone = true

	local var_7_0 = arg_7_0.viewParam.realVerify
	local var_7_1 = arg_7_0.viewParam.diceResult
	local var_7_2 = arg_7_0.viewParam.result == Activity114Enum.Result.Success

	if var_7_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	end

	gohelper.setActive(arg_7_0._imageresult.gameObject, true)
	gohelper.setActive(arg_7_0._godoing, false)
	gohelper.setActive(arg_7_0._gosucc, var_7_2)
	gohelper.setActive(arg_7_0._gofail, not var_7_2)

	local var_7_3 = var_7_1[1] + var_7_1[2]
	local var_7_4 = (var_7_2 and "succ_" or "img_") .. var_7_3

	gohelper.setActive(arg_7_0._golessIcon, var_7_3 < var_7_0)
	gohelper.setActive(arg_7_0._goequalIcon, var_7_3 == var_7_0)
	gohelper.setActive(arg_7_0._gogreaterIcon, var_7_0 < var_7_3)
	UISpriteSetMgr.instance:setVersionActivity114Sprite(arg_7_0._imageresult, var_7_4, true)
end

function var_0_0.onCloseClick(arg_8_0)
	if arg_8_0:isRunning() then
		return
	end

	arg_8_0:closeThis()
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.showResult, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.onDone, arg_9_0)
end

function var_0_0.isRunning(arg_10_0)
	return not arg_10_0.isDone
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.everyFrame, arg_11_0)
end

return var_0_0
