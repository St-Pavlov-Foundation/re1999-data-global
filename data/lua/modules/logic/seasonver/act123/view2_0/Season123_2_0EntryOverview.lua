module("modules.logic.seasonver.act123.view2_0.Season123_2_0EntryOverview", package.seeall)

local var_0_0 = class("Season123_2_0EntryOverview", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

var_0_0.UI_Item_Count = 6

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._entryList = {}

	arg_4_0:initItems()
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._entryList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._entryList) do
			iter_5_1.btnclick:RemoveClickListener()
		end

		arg_5_0._entryList = nil
	end

	Season123EntryOverviewController.instance:onCloseView()
	TaskDispatcher.cancelTask(arg_5_0._closeCallback, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._playUnlockAnim, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.refreshUI, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_overview_open)

	local var_6_0 = arg_6_0.viewParam.actId
	local var_6_1 = ActivityModel.instance:getActMO(var_6_0)

	if not var_6_1 or not var_6_1:isOpen() or var_6_1:isExpired() then
		return
	end

	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, arg_6_0.handleGetActInfo, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.TaskUpdated, arg_6_0.refreshUI, arg_6_0)
	Season123EntryOverviewController.instance:onOpenView(var_6_0)
	arg_6_0:refreshUI()
	NavigateMgr.instance:addEscape(arg_6_0.viewName, arg_6_0.closeThis, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._playUnlockAnim, arg_6_0, 0.83)
	TaskDispatcher.runRepeat(arg_6_0.refreshUI, arg_6_0, 3)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshItems()
end

function var_0_0.refreshItems(arg_9_0)
	local var_9_0 = Season123EntryOverviewModel.instance:getActId()
	local var_9_1 = Season123Config.instance:getStageCos(var_9_0)

	if var_9_1 then
		for iter_9_0 = 1, var_0_0.UI_Item_Count do
			local var_9_2 = arg_9_0._entryList[iter_9_0]
			local var_9_3 = var_9_1[iter_9_0]

			if var_9_3 then
				local var_9_4 = var_9_3.stage
				local var_9_5 = Season123EntryOverviewModel.instance:getStageMO(var_9_4)

				gohelper.setActive(var_9_2.go, true)
				arg_9_0:refreshItem(var_9_2, var_9_3, var_9_5)
			else
				gohelper.setActive(var_9_2.go, false)
			end
		end
	end
end

function var_0_0.refreshItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = Season123EntryOverviewModel.instance:getActId()

	gohelper.setActive(arg_10_1.gofighting, arg_10_3 and Season123ProgressUtils.stageInChallenge(var_10_0, arg_10_3.stage))
	gohelper.setActive(arg_10_1.gofinish, arg_10_3 and arg_10_3:alreadyPass())

	if arg_10_3 and arg_10_3:alreadyPass() then
		arg_10_1.txtpassround.text = tostring(arg_10_3.minRound or 0)
	else
		arg_10_1.txtpassround.text = ""
	end

	arg_10_1.txtname.text = arg_10_2.name

	arg_10_0:refreshProgress(arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:refreshUnlockStatus(arg_10_1, arg_10_2)
end

function var_0_0.refreshProgress(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0
	local var_11_1

	if arg_11_3 then
		local var_11_2 = Season123EntryOverviewModel.instance:stageIsPassed(arg_11_3.stage)

		gohelper.setActive(arg_11_1.goprogress, var_11_2)

		if not var_11_2 then
			return
		end

		var_11_0, var_11_1 = Season123ProgressUtils.getStageProgressStep(arg_11_0.viewParam.actId, arg_11_3.stage)
	else
		gohelper.setActive(arg_11_1.goprogress, false)

		var_11_0 = 0
		var_11_1 = 0
	end

	for iter_11_0 = 1, Activity123Enum.SeasonStageStepCount do
		local var_11_3, var_11_4, var_11_5 = Season123ProgressUtils.isStageUnlock(arg_11_0.viewParam.actId, arg_11_2.stage)

		if var_11_3 then
			local var_11_6 = iter_11_0 <= var_11_0
			local var_11_7 = iter_11_0 <= var_11_1

			gohelper.setActive(arg_11_1.progressActives[iter_11_0], var_11_6 and iter_11_0 < var_11_1)
			gohelper.setActive(arg_11_1.progressDeactives[iter_11_0], not var_11_6 and var_11_7)
			gohelper.setActive(arg_11_1.progressHard[iter_11_0], iter_11_0 == var_11_1 and var_11_0 == var_11_1)
		else
			gohelper.setActive(arg_11_1.progressActives[iter_11_0], false)
			gohelper.setActive(arg_11_1.progressDeactives[iter_11_0], false)
			gohelper.setActive(arg_11_1.progressHard[iter_11_0], false)
		end
	end
end

function var_0_0.refreshUnlockStatus(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0, var_12_1, var_12_2 = Season123ProgressUtils.isStageUnlock(arg_12_0.viewParam.actId, arg_12_2.stage)
	local var_12_3 = Season123EntryModel.instance:needPlayUnlockAnim1(arg_12_0.viewParam.actId, arg_12_2.stage)

	if var_12_0 and not var_12_3 then
		ZProj.UGUIHelper.SetGrayscale(arg_12_1.imageicon.gameObject, false)
		ZProj.UGUIHelper.SetGrayscale(arg_12_1.imagechapter.gameObject, false)
		gohelper.setActive(arg_12_1.gounlocked, false)
		gohelper.setActive(arg_12_1.gounlockedtime, false)
	else
		ZProj.UGUIHelper.SetGrayscale(arg_12_1.imageicon.gameObject, true)
		ZProj.UGUIHelper.SetGrayscale(arg_12_1.imagechapter.gameObject, true)

		if var_12_1 == Activity123Enum.PreCondition.OpenTime then
			gohelper.setActive(arg_12_1.gounlocked, false)
			gohelper.setActive(arg_12_1.gounlockedtime, true)

			if var_12_2.showSec then
				local var_12_4 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_12_2.remainTime))

				arg_12_1.txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime_custom"), var_12_4)
			else
				arg_12_1.txtunlocktime.text = string.format(luaLang("season123_overview_unlocktime"), var_12_2.day)
			end
		else
			gohelper.setActive(arg_12_1.gounlocked, true)
			gohelper.setActive(arg_12_1.gounlockedtime, false)
		end
	end
end

function var_0_0.initItems(arg_13_0)
	for iter_13_0 = 1, var_0_0.UI_Item_Count do
		local var_13_0 = arg_13_0:getUserDataTb_()

		var_13_0.go = gohelper.findChild(arg_13_0.viewGO, "go_center/go_item" .. tostring(iter_13_0))
		var_13_0.txtname = gohelper.findChildText(var_13_0.go, "#txt_name")
		var_13_0.imageicon = gohelper.findChildImage(var_13_0.go, "#image_icon")
		var_13_0.imagechapter = gohelper.findChildImage(var_13_0.go, "image_chapternum")
		var_13_0.gofinish = gohelper.findChild(var_13_0.go, "#image_finish")
		var_13_0.gofighting = gohelper.findChild(var_13_0.go, "#image_fighting")
		var_13_0.goprogress = gohelper.findChild(var_13_0.go, "#go_progress")
		var_13_0.txtpassround = gohelper.findChildText(var_13_0.go, "#image_finish/#txt_time")
		var_13_0.btnclick = gohelper.findChildButton(var_13_0.go, "btn_click")

		var_13_0.btnclick:AddClickListener(arg_13_0.onClickIndex, arg_13_0, iter_13_0)

		var_13_0.progressActives = arg_13_0:getUserDataTb_()
		var_13_0.progressDeactives = arg_13_0:getUserDataTb_()
		var_13_0.progressHard = arg_13_0:getUserDataTb_()

		for iter_13_1 = 1, Activity123Enum.SeasonStageStepCount do
			var_13_0.progressActives[iter_13_1] = gohelper.findChild(var_13_0.go, string.format("#go_progress/#go_progress%s/light", iter_13_1))
			var_13_0.progressDeactives[iter_13_1] = gohelper.findChild(var_13_0.go, string.format("#go_progress/#go_progress%s/dark", iter_13_1))
			var_13_0.progressHard[iter_13_1] = gohelper.findChild(var_13_0.go, string.format("#go_progress/#go_progress%s/red", iter_13_1))
		end

		var_13_0.gounlocked = gohelper.findChild(var_13_0.go, "#image_locked")
		var_13_0.gounlockedtime = gohelper.findChild(var_13_0.go, "#image_unlockedtime")
		var_13_0.txtunlocktime = gohelper.findChildText(var_13_0.go, "#image_unlockedtime/#txt_time")
		var_13_0.animtor = var_13_0.go:GetComponent(gohelper.Type_Animator)
		arg_13_0._entryList[iter_13_0] = var_13_0
	end
end

function var_0_0.handleGetActInfo(arg_14_0, arg_14_1)
	if arg_14_0.viewParam.actId == arg_14_1 then
		arg_14_0:refreshUI()
	end
end

function var_0_0.onClickIndex(arg_15_0, arg_15_1)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_click)

	local var_15_0 = Season123EntryOverviewModel.instance:getActId()
	local var_15_1 = Season123Config.instance:getStageCos(var_15_0)[arg_15_1]
	local var_15_2 = Season123Model.instance:getActInfo()

	if not var_15_1 then
		return
	end

	Season123Controller.instance:dispatchEvent(Season123Event.LocateToStage, {
		actId = var_15_0,
		stageId = var_15_1.stage
	})
	arg_15_0:_btncloseOnClick()
end

function var_0_0._btncloseOnClick(arg_16_0)
	arg_16_0._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(arg_16_0._closeCallback, arg_16_0, 0.17)
end

function var_0_0._closeCallback(arg_17_0)
	arg_17_0:closeThis()
end

function var_0_0._playUnlockAnim(arg_18_0)
	local var_18_0 = Season123EntryOverviewModel.instance:getActId()
	local var_18_1 = Season123Config.instance:getStageCos(var_18_0)

	for iter_18_0, iter_18_1 in pairs(arg_18_0._entryList) do
		local var_18_2 = var_18_1[iter_18_0]
		local var_18_3 = Season123ProgressUtils.isStageUnlock(arg_18_0.viewParam.actId, var_18_2.stage)
		local var_18_4 = Season123EntryModel.instance:needPlayUnlockAnim1(arg_18_0.viewParam.actId, var_18_2.stage)

		if var_18_3 and var_18_4 then
			iter_18_1.animtor:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_unlock)
			Season123EntryModel.instance:setAlreadyUnLock1(arg_18_0.viewParam.actId, var_18_2.stage)
		end
	end
end

return var_0_0
