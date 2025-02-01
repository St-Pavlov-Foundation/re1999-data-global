module("modules.logic.versionactivity1_2.jiexika.view.Activity114DiceView", package.seeall)

slot0 = class("Activity114DiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtneedNum = gohelper.findChildText(slot0.viewGO, "throw/#txt_needNum")
	slot0._txtdiceNum1 = gohelper.findChildText(slot0.viewGO, "dice1/#txt_diceNum")
	slot0._txtdiceNum2 = gohelper.findChildText(slot0.viewGO, "dice2/#txt_diceNum")
	slot0._imageresult = gohelper.findChildImage(slot0.viewGO, "throw/#image_result")
	slot0._txtdotip = gohelper.findChildText(slot0.viewGO, "#go_doing/#txt_dotip")
	slot0._gosucc = gohelper.findChild(slot0.viewGO, "#go_succ")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._godoing = gohelper.findChild(slot0.viewGO, "#go_doing")
	slot0._btnclose = gohelper.findChildClickWithAudio(slot0.viewGO, "#btn_close")
	slot0._gogreaterIcon = gohelper.findChild(slot0.viewGO, "throw/#go_greaterIcon")
	slot0._goequalIcon = gohelper.findChild(slot0.viewGO, "throw/#go_equalIcon")
	slot0._golessIcon = gohelper.findChild(slot0.viewGO, "throw/#go_lessIcon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.onCloseClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)

	slot0._txtdotip.text = luaLang("versionactivity_1_2_114diceview_doing")
	slot0.isDone = false
	slot0._txtneedNum.text = slot0.viewParam.realVerify

	gohelper.setActive(slot0._imageresult.gameObject, false)
	recthelper.setAnchorX(slot0._txtdotip.transform, 17.1)
	TaskDispatcher.runRepeat(slot0.everyFrame, slot0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dice)
	gohelper.setActive(slot0._godoing, true)
	gohelper.setActive(slot0._gosucc, false)
	gohelper.setActive(slot0._gofail, false)
	gohelper.setActive(slot0._golessIcon, false)
	gohelper.setActive(slot0._goequalIcon, false)
	gohelper.setActive(slot0._gogreaterIcon, false)
	TaskDispatcher.runDelay(slot0.onDone, slot0, 2)
end

function slot0.everyFrame(slot0)
	slot0._txtdiceNum1.text = math.random(1, 6)
	slot0._txtdiceNum2.text = math.random(1, 6)
end

function slot0.onDone(slot0)
	TaskDispatcher.cancelTask(slot0.everyFrame, slot0)
	TaskDispatcher.cancelTask(slot0.onDone, slot0)

	slot1 = slot0.viewParam.diceResult
	slot0._txtdiceNum1.text = slot1[1]
	slot0._txtdiceNum2.text = slot1[2]

	recthelper.setAnchorX(slot0._txtdotip.transform, 1.3)

	slot0._txtdotip.text = luaLang("versionactivity_1_2_114diceview_finish")

	TaskDispatcher.runDelay(slot0.showResult, slot0, 0)
end

function slot0.showResult(slot0)
	slot0.isDone = true
	slot1 = slot0.viewParam.realVerify
	slot2 = slot0.viewParam.diceResult

	if slot0.viewParam.result == Activity114Enum.Result.Success then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	end

	gohelper.setActive(slot0._imageresult.gameObject, true)
	gohelper.setActive(slot0._godoing, false)
	gohelper.setActive(slot0._gosucc, slot3)
	gohelper.setActive(slot0._gofail, not slot3)

	slot4 = slot2[1] + slot2[2]

	gohelper.setActive(slot0._golessIcon, slot4 < slot1)
	gohelper.setActive(slot0._goequalIcon, slot4 == slot1)
	gohelper.setActive(slot0._gogreaterIcon, slot1 < slot4)
	UISpriteSetMgr.instance:setVersionActivity114Sprite(slot0._imageresult, (slot3 and "succ_" or "img_") .. slot4, true)
end

function slot0.onCloseClick(slot0)
	if slot0:isRunning() then
		return
	end

	slot0:closeThis()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.showResult, slot0)
	TaskDispatcher.cancelTask(slot0.onDone, slot0)
end

function slot0.isRunning(slot0)
	return not slot0.isDone
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.everyFrame, slot0)
end

return slot0
