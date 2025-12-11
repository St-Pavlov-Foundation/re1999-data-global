module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiTalkView", package.seeall)

local var_0_0 = class("YeShuMeiTalkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godialog = gohelper.findChild(arg_1_0.viewGO, "#go_dialog")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_dialog/#btn_close")
	arg_1_0._rootTrans = gohelper.findChild(arg_1_0.viewGO, "#go_dialog/root").transform
	arg_1_0._desc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_dialog/root/Scroll View/Viewport/Content/txt_talk")
	arg_1_0._headIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_dialog/root/Head/#simage_Head")
	arg_1_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._desc.gameObject, FixTmpBreakLine)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._onClickNext, arg_2_0)
	arg_2_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnStartDialog, arg_2_0._onStartDialog, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0._onStartDialog(arg_5_0, arg_5_1)
	arg_5_0._steps = arg_5_1 and arg_5_1.co
	arg_5_0._dialogPosX = arg_5_1 and arg_5_1.dialogPosX
	arg_5_0._dialogPosY = arg_5_1 and arg_5_1.dialogPosY
	arg_5_0._stepIndex = 0

	gohelper.setActive(arg_5_0._godialog, true)
	arg_5_0:_setDialogPosition()
	arg_5_0:_nextStep()
end

function var_0_0._setDialogPosition(arg_6_0)
	recthelper.setAnchor(arg_6_0._rootTrans, arg_6_0._dialogPosX or 0, arg_6_0._dialogPosY or 0)
end

function var_0_0._onClickNext(arg_7_0)
	local var_7_0 = #arg_7_0._charArr

	if var_7_0 > 5 and arg_7_0._curShowCount < 5 then
		return
	end

	if var_7_0 == arg_7_0._curShowCount then
		arg_7_0:_nextStep()
	else
		arg_7_0._curShowCount = var_7_0 - 1

		arg_7_0:_showNextChar()
		TaskDispatcher.cancelTask(arg_7_0._showNextChar, arg_7_0)
	end
end

function var_0_0._nextStep(arg_8_0)
	arg_8_0._stepIndex = arg_8_0._stepIndex + 1

	local var_8_0 = arg_8_0._steps[arg_8_0._stepIndex]

	if not var_8_0 then
		arg_8_0:onDialogFinished()

		return
	end

	arg_8_0._curShowCount = 0
	arg_8_0._charArr = GameUtil.getUCharArrWithoutRichTxt(var_8_0.content)

	if not string.nilorempty(var_8_0.icon) then
		arg_8_0._curHeadIcon = var_8_0.icon
	end

	if arg_8_0._curHeadIcon then
		arg_8_0._headIcon:LoadImage(ResUrl.getHeadIconSmall(arg_8_0._curHeadIcon))
	end

	if #arg_8_0._charArr <= 1 then
		arg_8_0._desc.text = ""

		recthelper.setHeight(arg_8_0._rootTrans, 111)

		return
	end

	TaskDispatcher.runRepeat(arg_8_0._showNextChar, arg_8_0, 0.05, #arg_8_0._charArr - 1)
	arg_8_0:_showNextChar()
end

function var_0_0._showNextChar(arg_9_0)
	arg_9_0._curShowCount = arg_9_0._curShowCount + 1
	arg_9_0._desc.text = table.concat(arg_9_0._charArr, "", 1, arg_9_0._curShowCount)

	local var_9_0 = arg_9_0._desc.preferredHeight

	arg_9_0._fixTmpBreakLine:refreshTmpContent(arg_9_0._desc)
	recthelper.setHeight(arg_9_0._rootTrans, math.max(111, var_9_0 + 40))
end

function var_0_0.onDialogFinished(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._showNextChar, arg_10_0)
	gohelper.setActive(arg_10_0._godialog, false)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnFinishDialog)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._headIcon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_11_0._showNextChar, arg_11_0)
end

return var_0_0
