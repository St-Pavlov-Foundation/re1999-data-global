module("modules.logic.seasonver.act123.view1_8.Season123_1_8EntryItem", package.seeall)

slot0 = class("Season123_1_8EntryItem", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0._enterEpiosdeList, slot0)
	slot0:removeEvents()
	slot0:__onDispose()
end

function slot0.init(slot0, slot1, slot2)
	slot0.viewGO = slot1
	slot0.anim = slot2

	slot0:initComponent()
end

function slot0.initComponent(slot0)
	slot0._btnentrance = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_entrance")
	slot0._txtpassround = gohelper.findChildText(slot0.viewGO, "#go_time/#txt_time")
	slot0._txtmapname = gohelper.findChildText(slot0.viewGO, "#txt_mapname")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_time")
	slot0._btnrecords = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_records")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_new")
	slot0._gofighting = gohelper.findChild(slot0.viewGO, "#go_fighting")
	slot0._gounlockline = gohelper.findChild(slot0.viewGO, "decorates/line")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "progress")
	slot0._progressActives = slot0:getUserDataTb_()
	slot0._progressDeactives = slot0:getUserDataTb_()
	slot0._progressHard = slot0:getUserDataTb_()
	slot0._progressAnim = slot0:getUserDataTb_()

	for slot4 = 1, Activity123Enum.SeasonStageStepCount do
		slot0._progressActives[slot4] = gohelper.findChild(slot0.viewGO, string.format("progress/#go_progress%s/light", slot4))
		slot0._progressDeactives[slot4] = gohelper.findChild(slot0.viewGO, string.format("progress/#go_progress%s/dark", slot4))
		slot0._progressHard[slot4] = gohelper.findChild(slot0.viewGO, string.format("progress/#go_progress%s/red", slot4))
		slot0._progressAnim[slot4] = gohelper.findChild(slot0.viewGO, string.format("progress/#go_progress%s/levelup", slot4))
	end

	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._txtunlocktime = gohelper.findChildText(slot0.viewGO, "#go_locked/#txt_lockedtime")

	slot0._btnentrance:AddClickListener(slot0._btnentranceOnClick, slot0)
	slot0._btnrecords:AddClickListener(slot0._btnrecordsOnClick, slot0)

	slot0.animLock = slot0._golocked:GetComponent(gohelper.Type_Animator)

	TaskDispatcher.runRepeat(slot0.refreshLockRepeat, slot0, 3)
end

function slot0.removeEvents(slot0)
	slot0._btnentrance:RemoveClickListener()
	slot0._btnrecords:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0.refreshLockRepeat, slot0)
end

function slot0.initData(slot0, slot1)
	slot0._actId = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._stageId = Season123EntryModel.instance:getCurrentStage()

	if not slot0._stageId then
		return
	end

	if Season123Config.instance:getStageCo(slot0._actId, slot0._stageId) then
		slot0._txtmapname.text = slot1.name
	end

	gohelper.setActive(slot0._gofighting, Season123ProgressUtils.stageInChallenge(slot0._actId, slot0._stageId))
	slot0:refreshRound()
	slot0:refreshLock()
	slot0:refreshProgress()
	slot0:refreshNew()
	slot0:refreshRecordBtn()
end

function slot0.refreshRound(slot0)
	if Season123Model.instance:getActInfo(slot0._actId) then
		if slot1:getStageMO(slot0._stageId) and slot2:alreadyPass() then
			if slot2.minRound == 0 then
				gohelper.setActive(slot0._gotime, false)
			else
				gohelper.setActive(slot0._gotime, true)

				slot0._txtpassround.text = tostring(slot3)
			end
		else
			gohelper.setActive(slot0._gotime, false)
		end
	else
		gohelper.setActive(slot0._gotime, false)
	end
end

function slot0.refreshLock(slot0)
	slot1, slot2, slot3 = Season123ProgressUtils.isStageUnlock(slot0._actId, slot0._stageId)

	if slot2 == Activity123Enum.PreCondition.OpenTime then
		if slot3.showSec then
			slot0._txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime_custom"), string.format("%s%s", TimeUtil.secondToRoughTime2(slot3.remainTime)))
		else
			slot0._txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime"), slot3.day)
		end
	else
		slot0._txtunlocktime.text = string.format(luaLang("season123_entry_is_lock"), slot3)
	end

	if slot1 then
		if Season123EntryModel.instance:needPlayUnlockAnim(slot0._actId, slot0._stageId) then
			gohelper.setActive(slot0._gounlockline, false)
			gohelper.setActive(slot0._golocked, true)
			slot0.animLock:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_unlock)
			Season123EntryModel.instance:setAlreadyUnLock(slot0._actId, slot0._stageId)
		else
			gohelper.setActive(slot0._golocked, false)
			gohelper.setActive(slot0._gounlockline, true)
		end
	else
		gohelper.setActive(slot0._gounlockline, false)
		gohelper.setActive(slot0._golocked, true)
	end
end

function slot0.refreshProgress(slot0)
	slot1 = Season123EntryModel.instance:stageIsPassed(slot0._stageId)

	gohelper.setActive(slot0._goprogress, slot1)

	if slot1 then
		slot3, slot4 = Season123ProgressUtils.getStageProgressStep(slot0._actId, slot0._stageId)
		slot2 = slot1 and slot4 > 0

		for slot8 = 1, Activity123Enum.SeasonStageStepCount do
			slot9 = slot8 <= slot3

			gohelper.setActive(slot0._progressActives[slot8], slot9 and slot8 < slot4)
			gohelper.setActive(slot0._progressDeactives[slot8], not slot9 and slot8 <= slot4)
			gohelper.setActive(slot0._progressHard[slot8], slot8 == slot4 and slot3 == slot4)
		end
	end

	if slot0._gounlockline.activeSelf and not slot2 then
		gohelper.setActive(slot0._gounlockline, false)
	end
end

function slot0.refreshNew(slot0)
	if not Season123Model.instance:getActInfo(slot0._actId) then
		gohelper.setActive(slot0._gonew, false)

		return
	end

	slot2, slot3, slot4 = Season123ProgressUtils.isStageUnlock(slot0._actId, slot0._stageId)

	if not slot1:getStageMO(slot0._stageId) then
		gohelper.setActive(slot0._gonew, false)

		return
	end

	gohelper.setActive(slot0._gonew, slot2 and slot5:isNeverTry())
end

function slot0.refreshRecordBtn(slot0)
	if not Season123Model.instance:getActInfo(slot0._actId) then
		gohelper.setActive(slot0._btnrecords, false)

		return
	end

	gohelper.setActive(slot0._btnrecords, slot1:getStageMO(slot0._stageId) and slot2.isPass)
end

function slot0.refreshLockRepeat(slot0)
	slot0:refreshLock()
	slot0:refreshProgress()
end

function slot0._btnentranceOnClick(slot0)
	logNormal("_btnentranceOnClick ： " .. tostring(slot0._stageId))

	slot2 = Season123Model.instance:getActInfo(slot0._actId)
	slot3, slot4, slot5 = Season123ProgressUtils.isStageUnlock(slot0._actId, slot0._stageId)

	if slot3 then
		if Season123EntryController.instance:openStage(slot0._stageId) then
			slot0.anim:Play(UIAnimationName.Close)
			Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, true)
			TaskDispatcher.runDelay(slot0._enterEpiosdeList, slot0, 0.17)
		end
	else
		GameFacade.showToast(ToastEnum.SeasonStageLockTip, Season123Config.instance:getStageCo(slot0._actId, slot0._stageId).name)
	end
end

function slot0._enterEpiosdeList(slot0)
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = slot0._stageId
	})
end

function slot0._btnrecordsOnClick(slot0)
	Season123EntryController.instance:openStageRecords(slot0._stageId)
end

return slot0
