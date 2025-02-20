module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErTalkView", package.seeall)

slot0 = class("ZhiXinQuanErTalkView", BaseView)
slot1 = 10

function slot0._setHeight_rootTrans(slot0, slot1)
	recthelper.setHeight(slot0._rootTrans, slot1)

	slot2 = UnityEngine.Screen.height * 0.5
	slot3 = {
		max = slot2 - uv0 - slot1,
		min = -slot2 + uv0 + 30 - slot1
	}

	if GameUtil.clamp(slot0._dialogPosY, slot3.min, slot3.max) ~= slot0._dialogPosY then
		slot0._dialogPosY = slot4

		slot0:_setDialogPosition()
	end
end

function slot0.onInitView(slot0)
	slot0._godialog = gohelper.findChild(slot0.viewGO, "#go_dialog")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_dialog/#btn_close")
	slot0._rootTrans = gohelper.findChild(slot0.viewGO, "#go_dialog/root").transform
	slot0._desc = gohelper.findChildTextMesh(slot0.viewGO, "#go_dialog/root/Scroll View/Viewport/Content/txt_talk")
	slot0._headIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_dialog/root/Head/#simage_Head")
	slot0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._desc.gameObject, FixTmpBreakLine)
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._onClickNext, slot0)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnStartDialog, slot0._onStartDialog, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
end

function slot0._onStartDialog(slot0, slot1)
	slot0._steps = slot1 and slot1.co
	slot0._dialogPosX = slot1 and slot1.dialogPosX
	slot0._dialogPosY = slot1 and slot1.dialogPosY
	slot0._stepIndex = 0

	gohelper.setActive(slot0._godialog, true)
	slot0:_setDialogPosition()
	slot0:_nextStep()
end

function slot0._setDialogPosition(slot0)
	recthelper.setAnchor(slot0._rootTrans, slot0._dialogPosX or 0, slot0._dialogPosY or 0)
end

function slot0._onClickNext(slot0)
	if #slot0._charArr > 5 and slot0._curShowCount < 5 then
		return
	end

	if slot1 == slot0._curShowCount then
		slot0:_nextStep()
	else
		slot0._curShowCount = slot1 - 1

		slot0:_showNextChar()
		TaskDispatcher.cancelTask(slot0._showNextChar, slot0)
	end
end

function slot0._nextStep(slot0)
	slot0._stepIndex = slot0._stepIndex + 1

	if not slot0._steps[slot0._stepIndex] then
		slot0:onDialogFinished()

		return
	end

	slot0._curShowCount = 0
	slot0._charArr = GameUtil.getUCharArrWithoutRichTxt(slot1.content)

	if not string.nilorempty(slot1.icon) then
		slot0._curHeadIcon = slot1.icon
	end

	if slot0._curHeadIcon then
		slot0._headIcon:LoadImage(ResUrl.getHeadIconSmall(slot0._curHeadIcon))
	end

	if #slot0._charArr <= 1 then
		slot0._desc.text = ""

		recthelper.setHeight(slot0._rootTrans, 111)

		return
	end

	TaskDispatcher.runRepeat(slot0._showNextChar, slot0, 0.05, #slot0._charArr - 1)
	slot0:_showNextChar()
end

function slot0._showNextChar(slot0)
	slot0._curShowCount = slot0._curShowCount + 1
	slot0._desc.text = table.concat(slot0._charArr, "", 1, slot0._curShowCount)

	LuaUtil.updateTMPRectHeight(slot0._desc)
	slot0:_setHeight_rootTrans(math.max(111, slot0._desc.preferredHeight + 40))
end

function slot0.onDialogFinished(slot0)
	TaskDispatcher.cancelTask(slot0._showNextChar, slot0)
	gohelper.setActive(slot0._godialog, false)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnFinishDialog)
end

function slot0.onClose(slot0)
	slot0._headIcon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._showNextChar, slot0)
end

return slot0
