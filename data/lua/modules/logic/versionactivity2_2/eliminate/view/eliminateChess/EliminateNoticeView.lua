module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateNoticeView", package.seeall)

slot0 = class("EliminateNoticeView", BaseView)

function slot0.onInitView(slot0)
	slot0._goOccupy = gohelper.findChild(slot0.viewGO, "#go_Occupy")
	slot0._simageMaskBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_Occupy/#simage_MaskBG")
	slot0._simageOccupy = gohelper.findChildSingleImage(slot0.viewGO, "#go_Occupy/#simage_Occupy")
	slot0._goStart = gohelper.findChild(slot0.viewGO, "#go_Start")
	slot0._simageStart = gohelper.findChildSingleImage(slot0.viewGO, "#go_Start/#simage_Start")
	slot0._txtStart = gohelper.findChildText(slot0.viewGO, "#go_Start/#txt_Start")
	slot0._goFinish = gohelper.findChild(slot0.viewGO, "#go_Finish")
	slot0._simageFinish = gohelper.findChildSingleImage(slot0.viewGO, "#go_Finish/#simage_Finish")
	slot0._goAssess1 = gohelper.findChild(slot0.viewGO, "#go_Assess1")
	slot0._goAssess2 = gohelper.findChild(slot0.viewGO, "#go_Assess2")
	slot0._goAssess3 = gohelper.findChild(slot0.viewGO, "#go_Assess3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._isFinish = slot0.viewParam.isFinish or false
	slot0._isStart = slot1.isStart or false
	slot0._isTeamChess = slot1.isTeamChess or false
	slot0._closeCallback = slot1.closeCallback
	slot0._time = slot1.closeTime or 1
	slot0._closeCallbackTarget = slot1.closeCallbackTarget
	slot0._isShowEvaluate = slot1.isShowEvaluate or false
	slot0._evaluateLevel = slot1.evaluateLevel or 1

	if slot0._isFinish then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_succeed)
	end

	if slot0._isStart then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_clearing)
	end

	if slot0._isTeamChess then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_clearing)
	end

	if slot0._isShowEvaluate then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess["play_ui_youyu_appraise_text_" .. slot0._evaluateLevel])
	end

	gohelper.setActive(slot0._goFinish, slot0._isFinish)
	gohelper.setActive(slot0._goStart, slot0._isStart)
	gohelper.setActive(slot0._goOccupy, slot0._isTeamChess)
	gohelper.setActive(slot0._goAssess1, slot0._isShowEvaluate and slot0._evaluateLevel == 3)
	gohelper.setActive(slot0._goAssess2, slot0._isShowEvaluate and slot0._evaluateLevel == 2)
	gohelper.setActive(slot0._goAssess3, slot0._isShowEvaluate and slot0._evaluateLevel == 1)

	if slot0._time then
		TaskDispatcher.runDelay(slot0.close, slot0, slot0._time)
	end
end

function slot0.close(slot0)
	ViewMgr.instance:closeView(ViewName.EliminateNoticeView)

	if slot0._closeCallbackTarget and slot0._closeCallback then
		slot0._closeCallback(slot0._closeCallbackTarget)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.close, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
