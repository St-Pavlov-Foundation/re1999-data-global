module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErTalkView", package.seeall)

local var_0_0 = class("ZhiXinQuanErTalkView", BaseView)
local var_0_1 = 10

function var_0_0._setHeight_rootTrans(arg_1_0, arg_1_1)
	recthelper.setHeight(arg_1_0._rootTrans, arg_1_1)

	local var_1_0 = UnityEngine.Screen.height * 0.5
	local var_1_1 = {
		max = var_1_0 - var_0_1 - arg_1_1,
		min = -var_1_0 + var_0_1 + 30 - arg_1_1
	}
	local var_1_2 = GameUtil.clamp(arg_1_0._dialogPosY, var_1_1.min, var_1_1.max)

	if var_1_2 ~= arg_1_0._dialogPosY then
		arg_1_0._dialogPosY = var_1_2

		arg_1_0:_setDialogPosition()
	end
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._godialog = gohelper.findChild(arg_2_0.viewGO, "#go_dialog")
	arg_2_0._btnclose = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_dialog/#btn_close")
	arg_2_0._rootTrans = gohelper.findChild(arg_2_0.viewGO, "#go_dialog/root").transform
	arg_2_0._desc = gohelper.findChildTextMesh(arg_2_0.viewGO, "#go_dialog/root/Scroll View/Viewport/Content/txt_talk")
	arg_2_0._headIcon = gohelper.findChildSingleImage(arg_2_0.viewGO, "#go_dialog/root/Head/#simage_Head")
	arg_2_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._desc.gameObject, FixTmpBreakLine)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnclose:AddClickListener(arg_3_0._onClickNext, arg_3_0)
	arg_3_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnStartDialog, arg_3_0._onStartDialog, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0._onStartDialog(arg_6_0, arg_6_1)
	arg_6_0._steps = arg_6_1 and arg_6_1.co
	arg_6_0._dialogPosX = arg_6_1 and arg_6_1.dialogPosX
	arg_6_0._dialogPosY = arg_6_1 and arg_6_1.dialogPosY
	arg_6_0._stepIndex = 0

	gohelper.setActive(arg_6_0._godialog, true)
	arg_6_0:_setDialogPosition()
	arg_6_0:_nextStep()
end

function var_0_0._setDialogPosition(arg_7_0)
	recthelper.setAnchor(arg_7_0._rootTrans, arg_7_0._dialogPosX or 0, arg_7_0._dialogPosY or 0)
end

function var_0_0._onClickNext(arg_8_0)
	local var_8_0 = #arg_8_0._charArr

	if var_8_0 > 5 and arg_8_0._curShowCount < 5 then
		return
	end

	if var_8_0 == arg_8_0._curShowCount then
		arg_8_0:_nextStep()
	else
		arg_8_0._curShowCount = var_8_0 - 1

		arg_8_0:_showNextChar()
		TaskDispatcher.cancelTask(arg_8_0._showNextChar, arg_8_0)
	end
end

function var_0_0._nextStep(arg_9_0)
	arg_9_0._stepIndex = arg_9_0._stepIndex + 1

	local var_9_0 = arg_9_0._steps[arg_9_0._stepIndex]

	if not var_9_0 then
		arg_9_0:onDialogFinished()

		return
	end

	arg_9_0._curShowCount = 0
	arg_9_0._charArr = GameUtil.getUCharArrWithoutRichTxt(var_9_0.content)

	if not string.nilorempty(var_9_0.icon) then
		arg_9_0._curHeadIcon = var_9_0.icon
	end

	if arg_9_0._curHeadIcon then
		arg_9_0._headIcon:LoadImage(ResUrl.getHeadIconSmall(arg_9_0._curHeadIcon))
	end

	if #arg_9_0._charArr <= 1 then
		arg_9_0._desc.text = ""

		recthelper.setHeight(arg_9_0._rootTrans, 111)

		return
	end

	TaskDispatcher.runRepeat(arg_9_0._showNextChar, arg_9_0, 0.05, #arg_9_0._charArr - 1)
	arg_9_0:_showNextChar()
end

function var_0_0._showNextChar(arg_10_0)
	arg_10_0._curShowCount = arg_10_0._curShowCount + 1
	arg_10_0._desc.text = table.concat(arg_10_0._charArr, "", 1, arg_10_0._curShowCount)

	LuaUtil.updateTMPRectHeight(arg_10_0._desc)
	arg_10_0:_setHeight_rootTrans(math.max(111, arg_10_0._desc.preferredHeight + 40))
end

function var_0_0.onDialogFinished(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._showNextChar, arg_11_0)
	gohelper.setActive(arg_11_0._godialog, false)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnFinishDialog)
end

function var_0_0.onClose(arg_12_0)
	arg_12_0._headIcon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_12_0._showNextChar, arg_12_0)
end

return var_0_0
