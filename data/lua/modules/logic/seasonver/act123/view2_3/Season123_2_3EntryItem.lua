module("modules.logic.seasonver.act123.view2_3.Season123_2_3EntryItem", package.seeall)

local var_0_0 = class("Season123_2_3EntryItem", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()
end

function var_0_0.dispose(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._enterEpiosdeList, arg_2_0)
	arg_2_0:removeEvents()
	arg_2_0:__onDispose()
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.viewGO = arg_3_1
	arg_3_0.anim = arg_3_2

	arg_3_0:initComponent()
end

function var_0_0.initComponent(arg_4_0)
	arg_4_0._btnentrance = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "#btn_entrance")
	arg_4_0._txtpassround = gohelper.findChildText(arg_4_0.viewGO, "#go_time/#txt_time")
	arg_4_0._txtmapname = gohelper.findChildText(arg_4_0.viewGO, "#txt_mapname")
	arg_4_0._gotime = gohelper.findChild(arg_4_0.viewGO, "#go_time")
	arg_4_0._btnrecords = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "#btn_records")
	arg_4_0._gonew = gohelper.findChild(arg_4_0.viewGO, "#go_new")
	arg_4_0._gofighting = gohelper.findChild(arg_4_0.viewGO, "#go_fighting")
	arg_4_0._gounlockline = gohelper.findChild(arg_4_0.viewGO, "decorates/line")
	arg_4_0._goprogress = gohelper.findChild(arg_4_0.viewGO, "progress")
	arg_4_0._progressActives = arg_4_0:getUserDataTb_()
	arg_4_0._progressDeactives = arg_4_0:getUserDataTb_()
	arg_4_0._progressHard = arg_4_0:getUserDataTb_()
	arg_4_0._progressAnim = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, Activity123Enum.SeasonStageStepCount do
		arg_4_0._progressActives[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, string.format("progress/#go_progress%s/light", iter_4_0))
		arg_4_0._progressDeactives[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, string.format("progress/#go_progress%s/dark", iter_4_0))
		arg_4_0._progressHard[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, string.format("progress/#go_progress%s/red", iter_4_0))
		arg_4_0._progressAnim[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, string.format("progress/#go_progress%s/levelup", iter_4_0))
	end

	arg_4_0._golocked = gohelper.findChild(arg_4_0.viewGO, "#go_locked")
	arg_4_0._txtunlocktime = gohelper.findChildText(arg_4_0.viewGO, "#go_locked/#txt_lockedtime")

	arg_4_0._btnentrance:AddClickListener(arg_4_0._btnentranceOnClick, arg_4_0)
	arg_4_0._btnrecords:AddClickListener(arg_4_0._btnrecordsOnClick, arg_4_0)

	arg_4_0.animLock = arg_4_0._golocked:GetComponent(gohelper.Type_Animator)

	TaskDispatcher.runRepeat(arg_4_0.refreshLockRepeat, arg_4_0, 3)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnentrance:RemoveClickListener()
	arg_5_0._btnrecords:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_5_0.refreshLockRepeat, arg_5_0)
end

function var_0_0.initData(arg_6_0, arg_6_1)
	arg_6_0._actId = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0._stageId = Season123EntryModel.instance:getCurrentStage()

	if not arg_7_0._stageId then
		return
	end

	local var_7_0 = Season123Config.instance:getStageCo(arg_7_0._actId, arg_7_0._stageId)

	if var_7_0 then
		arg_7_0._txtmapname.text = var_7_0.name
	end

	gohelper.setActive(arg_7_0._gofighting, Season123ProgressUtils.stageInChallenge(arg_7_0._actId, arg_7_0._stageId))
	arg_7_0:refreshRound()
	arg_7_0:refreshLock()
	arg_7_0:refreshProgress()
	arg_7_0:refreshNew()
	arg_7_0:refreshRecordBtn()
end

function var_0_0.refreshRound(arg_8_0)
	local var_8_0 = Season123Model.instance:getActInfo(arg_8_0._actId)

	if var_8_0 then
		local var_8_1 = var_8_0:getStageMO(arg_8_0._stageId)

		if var_8_1 and var_8_1:alreadyPass() then
			local var_8_2 = var_8_1.minRound

			if var_8_2 == 0 then
				gohelper.setActive(arg_8_0._gotime, false)
			else
				gohelper.setActive(arg_8_0._gotime, true)

				arg_8_0._txtpassround.text = tostring(var_8_2)
			end
		else
			gohelper.setActive(arg_8_0._gotime, false)
		end
	else
		gohelper.setActive(arg_8_0._gotime, false)
	end
end

function var_0_0.refreshLock(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = Season123ProgressUtils.isStageUnlock(arg_9_0._actId, arg_9_0._stageId)

	if var_9_1 == Activity123Enum.PreCondition.OpenTime then
		if var_9_2.showSec then
			local var_9_3 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_9_2.remainTime))

			arg_9_0._txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime_custom"), var_9_3)
		else
			arg_9_0._txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime"), var_9_2.day)
		end
	else
		arg_9_0._txtunlocktime.text = string.format(luaLang("season123_entry_is_lock"), var_9_2)
	end

	if var_9_0 then
		if Season123EntryModel.instance:needPlayUnlockAnim(arg_9_0._actId, arg_9_0._stageId) then
			gohelper.setActive(arg_9_0._gounlockline, false)
			gohelper.setActive(arg_9_0._golocked, true)
			arg_9_0.animLock:Play(UIAnimationName.Unlock, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_unlock)
			Season123EntryModel.instance:setAlreadyUnLock(arg_9_0._actId, arg_9_0._stageId)
		else
			gohelper.setActive(arg_9_0._golocked, false)
			gohelper.setActive(arg_9_0._gounlockline, true)
			arg_9_0.animLock:Play(UIAnimationName.Idle, 0, 0)

			arg_9_0.animLock.speed = 1
		end
	else
		gohelper.setActive(arg_9_0._gounlockline, false)
		gohelper.setActive(arg_9_0._golocked, true)
		arg_9_0.animLock:Play(UIAnimationName.Idle, 0, 0)

		arg_9_0.animLock.speed = 1
	end
end

function var_0_0.refreshProgress(arg_10_0)
	local var_10_0 = Season123EntryModel.instance:stageIsPassed(arg_10_0._stageId)
	local var_10_1 = var_10_0

	gohelper.setActive(arg_10_0._goprogress, var_10_0)

	if var_10_0 then
		local var_10_2, var_10_3 = Season123ProgressUtils.getStageProgressStep(arg_10_0._actId, arg_10_0._stageId)

		var_10_1 = var_10_1 and var_10_3 > 0

		for iter_10_0 = 1, Activity123Enum.SeasonStageStepCount do
			local var_10_4 = iter_10_0 <= var_10_2
			local var_10_5 = iter_10_0 <= var_10_3

			gohelper.setActive(arg_10_0._progressActives[iter_10_0], var_10_4 and iter_10_0 < var_10_3)
			gohelper.setActive(arg_10_0._progressDeactives[iter_10_0], not var_10_4 and var_10_5)
			gohelper.setActive(arg_10_0._progressHard[iter_10_0], iter_10_0 == var_10_3 and var_10_2 == var_10_3)
		end
	end

	if arg_10_0._gounlockline.activeSelf and not var_10_1 then
		gohelper.setActive(arg_10_0._gounlockline, false)
	end
end

function var_0_0.refreshNew(arg_11_0)
	local var_11_0 = Season123Model.instance:getActInfo(arg_11_0._actId)

	if not var_11_0 then
		gohelper.setActive(arg_11_0._gonew, false)

		return
	end

	local var_11_1, var_11_2, var_11_3 = Season123ProgressUtils.isStageUnlock(arg_11_0._actId, arg_11_0._stageId)
	local var_11_4 = var_11_0:getStageMO(arg_11_0._stageId)

	if not var_11_4 then
		gohelper.setActive(arg_11_0._gonew, false)

		return
	end

	gohelper.setActive(arg_11_0._gonew, var_11_1 and var_11_4:isNeverTry())
end

function var_0_0.refreshRecordBtn(arg_12_0)
	local var_12_0 = Season123Model.instance:getActInfo(arg_12_0._actId)

	if not var_12_0 then
		gohelper.setActive(arg_12_0._btnrecords, false)

		return
	end

	local var_12_1 = var_12_0:getStageMO(arg_12_0._stageId)

	gohelper.setActive(arg_12_0._btnrecords, var_12_1 and var_12_1.isPass)
end

function var_0_0.refreshLockRepeat(arg_13_0)
	arg_13_0:refreshLock()
	arg_13_0:refreshProgress()
end

function var_0_0._btnentranceOnClick(arg_14_0)
	logNormal("_btnentranceOnClick ： " .. tostring(arg_14_0._stageId))

	local var_14_0 = arg_14_0._actId
	local var_14_1 = Season123Model.instance:getActInfo(var_14_0)
	local var_14_2, var_14_3, var_14_4 = Season123ProgressUtils.isStageUnlock(arg_14_0._actId, arg_14_0._stageId)

	if var_14_2 then
		if Season123EntryController.instance:openStage(arg_14_0._stageId) then
			arg_14_0.anim:Play(UIAnimationName.Close)
			Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, true)
			TaskDispatcher.runDelay(arg_14_0._enterEpiosdeList, arg_14_0, 0.17)
		end
	else
		local var_14_5 = Season123Config.instance:getStageCo(arg_14_0._actId, arg_14_0._stageId)

		GameFacade.showToast(ToastEnum.SeasonStageLockTip, var_14_5.name)
	end
end

function var_0_0._enterEpiosdeList(arg_15_0)
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = arg_15_0._stageId
	})
end

function var_0_0._btnrecordsOnClick(arg_16_0)
	Season123EntryController.instance:openStageRecords(arg_16_0._stageId)
end

return var_0_0
