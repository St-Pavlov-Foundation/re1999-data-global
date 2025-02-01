module("modules.logic.seasonver.act123.view1_9.Season123_1_9EntryOverview", package.seeall)

slot0 = class("Season123_1_9EntryOverview", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

slot0.UI_Item_Count = 6

function slot0._editableInitView(slot0)
	slot0._entryList = {}

	slot0:initItems()
end

function slot0.onDestroyView(slot0)
	if slot0._entryList then
		for slot4, slot5 in ipairs(slot0._entryList) do
			slot5.btnclick:RemoveClickListener()
		end

		slot0._entryList = nil
	end

	Season123EntryOverviewController.instance:onCloseView()
	TaskDispatcher.cancelTask(slot0._closeCallback, slot0)
	TaskDispatcher.cancelTask(slot0._playUnlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0.refreshUI, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_overview_open)

	if not ActivityModel.instance:getActMO(slot0.viewParam.actId) or not slot2:isOpen() or slot2:isExpired() then
		return
	end

	slot0:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, slot0.handleGetActInfo, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.TaskUpdated, slot0.refreshUI, slot0)
	Season123EntryOverviewController.instance:onOpenView(slot1)
	slot0:refreshUI()
	NavigateMgr.instance:addEscape(slot0.viewName, slot0.closeThis, slot0)
	TaskDispatcher.runDelay(slot0._playUnlockAnim, slot0, 0.83)
	TaskDispatcher.runRepeat(slot0.refreshUI, slot0, 3)
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshItems()
end

function slot0.refreshItems(slot0)
	if Season123Config.instance:getStageCos(Season123EntryOverviewModel.instance:getActId()) then
		for slot6 = 1, uv0.UI_Item_Count do
			slot7 = slot0._entryList[slot6]

			if slot2[slot6] then
				gohelper.setActive(slot7.go, true)
				slot0:refreshItem(slot7, slot8, Season123EntryOverviewModel.instance:getStageMO(slot8.stage))
			else
				gohelper.setActive(slot7.go, false)
			end
		end
	end
end

function slot0.refreshItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.gofighting, slot3 and Season123ProgressUtils.stageInChallenge(Season123EntryOverviewModel.instance:getActId(), slot3.stage))
	gohelper.setActive(slot1.gofinish, slot3 and slot3:alreadyPass())

	if slot3 and slot3:alreadyPass() then
		slot1.txtpassround.text = tostring(slot3.minRound or 0)
	else
		slot1.txtpassround.text = ""
	end

	slot1.txtname.text = slot2.name

	slot0:refreshProgress(slot1, slot2, slot3)
	slot0:refreshUnlockStatus(slot1, slot2)
end

function slot0.refreshProgress(slot0, slot1, slot2, slot3)
	slot4, slot5 = nil

	if slot3 then
		slot6 = Season123EntryOverviewModel.instance:stageIsPassed(slot3.stage)

		gohelper.setActive(slot1.goprogress, slot6)

		if not slot6 then
			return
		end

		slot4, slot5 = Season123ProgressUtils.getStageProgressStep(slot0.viewParam.actId, slot3.stage)
	else
		gohelper.setActive(slot1.goprogress, false)

		slot4 = 0
		slot5 = 0
	end

	for slot9 = 1, Activity123Enum.SeasonStageStepCount do
		slot10, slot11, slot12 = Season123ProgressUtils.isStageUnlock(slot0.viewParam.actId, slot2.stage)

		if slot10 then
			slot13 = slot9 <= slot4

			gohelper.setActive(slot1.progressActives[slot9], slot13 and slot9 < slot5)
			gohelper.setActive(slot1.progressDeactives[slot9], not slot13 and slot9 <= slot5)
			gohelper.setActive(slot1.progressHard[slot9], slot9 == slot5 and slot4 == slot5)
		else
			gohelper.setActive(slot1.progressActives[slot9], false)
			gohelper.setActive(slot1.progressDeactives[slot9], false)
			gohelper.setActive(slot1.progressHard[slot9], false)
		end
	end
end

function slot0.refreshUnlockStatus(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = Season123ProgressUtils.isStageUnlock(slot0.viewParam.actId, slot2.stage)

	if slot4 and not Season123EntryModel.instance:needPlayUnlockAnim1(slot0.viewParam.actId, slot2.stage) then
		ZProj.UGUIHelper.SetGrayscale(slot1.imageicon.gameObject, false)
		ZProj.UGUIHelper.SetGrayscale(slot1.imagechapter.gameObject, false)
		gohelper.setActive(slot1.gounlocked, false)
		gohelper.setActive(slot1.gounlockedtime, false)
	else
		ZProj.UGUIHelper.SetGrayscale(slot1.imageicon.gameObject, true)
		ZProj.UGUIHelper.SetGrayscale(slot1.imagechapter.gameObject, true)

		if slot5 == Activity123Enum.PreCondition.OpenTime then
			gohelper.setActive(slot1.gounlocked, false)
			gohelper.setActive(slot1.gounlockedtime, true)

			if slot6.showSec then
				slot1.txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime_custom"), string.format("%s%s", TimeUtil.secondToRoughTime2(slot6.remainTime)))
			else
				slot1.txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime"), slot6.day)
			end
		else
			gohelper.setActive(slot1.gounlocked, true)
			gohelper.setActive(slot1.gounlockedtime, false)
		end
	end
end

function slot0.initItems(slot0)
	for slot4 = 1, uv0.UI_Item_Count do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "go_center/go_item" .. tostring(slot4))
		slot5.txtname = gohelper.findChildText(slot5.go, "#txt_name")
		slot5.imageicon = gohelper.findChildImage(slot5.go, "#image_icon")
		slot5.imagechapter = gohelper.findChildImage(slot5.go, "image_chapternum")
		slot5.gofinish = gohelper.findChild(slot5.go, "#image_finish")
		slot5.gofighting = gohelper.findChild(slot5.go, "#image_fighting")
		slot5.goprogress = gohelper.findChild(slot5.go, "#go_progress")
		slot5.txtpassround = gohelper.findChildText(slot5.go, "#image_finish/#txt_time")
		slot5.btnclick = gohelper.findChildButton(slot5.go, "btn_click")
		slot9 = slot0

		slot5.btnclick:AddClickListener(slot0.onClickIndex, slot9, slot4)

		slot5.progressActives = slot0:getUserDataTb_()
		slot5.progressDeactives = slot0:getUserDataTb_()
		slot5.progressHard = slot0:getUserDataTb_()

		for slot9 = 1, Activity123Enum.SeasonStageStepCount do
			slot5.progressActives[slot9] = gohelper.findChild(slot5.go, string.format("#go_progress/#go_progress%s/light", slot9))
			slot5.progressDeactives[slot9] = gohelper.findChild(slot5.go, string.format("#go_progress/#go_progress%s/dark", slot9))
			slot5.progressHard[slot9] = gohelper.findChild(slot5.go, string.format("#go_progress/#go_progress%s/red", slot9))
		end

		slot5.gounlocked = gohelper.findChild(slot5.go, "#image_locked")
		slot5.gounlockedtime = gohelper.findChild(slot5.go, "#image_unlockedtime")
		slot5.txtunlocktime = gohelper.findChildText(slot5.go, "#image_unlockedtime/#txt_time")
		slot5.animtor = slot5.go:GetComponent(gohelper.Type_Animator)
		slot0._entryList[slot4] = slot5
	end
end

function slot0.handleGetActInfo(slot0, slot1)
	if slot0.viewParam.actId == slot1 then
		slot0:refreshUI()
	end
end

function slot0.onClickIndex(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_click)

	slot5 = Season123Model.instance:getActInfo()

	if not Season123Config.instance:getStageCos(Season123EntryOverviewModel.instance:getActId())[slot1] then
		return
	end

	Season123Controller.instance:dispatchEvent(Season123Event.LocateToStage, {
		actId = slot2,
		stageId = slot4.stage
	})
	slot0:_btncloseOnClick()
end

function slot0._btncloseOnClick(slot0)
	slot0._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(slot0._closeCallback, slot0, 0.17)
end

function slot0._closeCallback(slot0)
	slot0:closeThis()
end

function slot0._playUnlockAnim(slot0)
	for slot6, slot7 in pairs(slot0._entryList) do
		slot8 = Season123Config.instance:getStageCos(Season123EntryOverviewModel.instance:getActId())[slot6]

		if Season123ProgressUtils.isStageUnlock(slot0.viewParam.actId, slot8.stage) and Season123EntryModel.instance:needPlayUnlockAnim1(slot0.viewParam.actId, slot8.stage) then
			slot7.animtor:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_unlock)
			Season123EntryModel.instance:setAlreadyUnLock1(slot0.viewParam.actId, slot8.stage)
		end
	end
end

return slot0
