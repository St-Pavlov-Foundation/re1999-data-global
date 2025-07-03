module("modules.logic.versionactivity2_5.challenge.view.enter.Act183MainView", package.seeall)

local var_0_0 = class("Act183MainView", BaseView)
local var_0_1 = 7
local var_0_2 = 30
local var_0_3 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/left/#txt_time")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_reward")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "root/left/#btn_reward/#go_taskreddot")
	arg_1_0._btnrecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_record")
	arg_1_0._btnmedal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_medal")
	arg_1_0._gomedalreddot = gohelper.findChild(arg_1_0.viewGO, "root/left/#btn_medal/#go_medalreddot")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_main")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_main/#go_normal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_main/#go_hard")
	arg_1_0._btnentermain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/middle/#btn_entermain")
	arg_1_0._scrolldaily = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#scroll_daily")
	arg_1_0._godailyitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#scroll_daily/Viewport/Content/#go_dailyitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnrecord:AddClickListener(arg_2_0._btnrecordOnClick, arg_2_0)
	arg_2_0._btnmedal:AddClickListener(arg_2_0._btnmedalOnClick, arg_2_0)
	arg_2_0._btnentermain:AddClickListener(arg_2_0._btnentermainOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnrecord:RemoveClickListener()
	arg_3_0._btnmedal:RemoveClickListener()
	arg_3_0._btnentermain:RemoveClickListener()
end

function var_0_0._btnrewardOnClick(arg_4_0)
	Act183Controller.instance:openAct183TaskView()
end

function var_0_0._btnrecordOnClick(arg_5_0)
	Act183Controller.instance:openAct183ReportView()
end

function var_0_0._btnmedalOnClick(arg_6_0)
	Act183Controller.instance:openAct183BadgeView()
end

function var_0_0._btnentermainOnClick(arg_7_0)
	local var_7_0 = Act183Helper.getLastEnterMainGroupTypeInLocal(arg_7_0._actId, Act183Enum.GroupType.NormalMain)
	local var_7_1 = arg_7_0._mainGroupEpisodeTab[var_7_0]

	if not var_7_1 then
		return
	end

	local var_7_2 = var_7_1:getStatus()

	if var_7_2 == Act183Enum.GroupStatus.Locked and var_7_0 ~= Act183Enum.GroupType.NormalMain then
		logError(string.format("本地标记的上一次进入关卡组未解锁!!!, 保底进入普通日常关卡。lastEnterGroupType = %s, status = %s", var_7_0, var_7_2))

		local var_7_3 = Act183Enum.GroupType.NormalMain

		var_7_1 = arg_7_0._mainGroupEpisodeTab[var_7_3]
	end

	local var_7_4 = var_7_1 and var_7_1:getGroupId()
	local var_7_5 = var_7_1 and var_7_1:getGroupType()
	local var_7_6 = Act183Helper.generateDungeonViewParams(var_7_5, var_7_4)

	Act183Controller.instance:openAct183DungeonView(var_7_6)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._mainItemTab = arg_8_0:getUserDataTb_()
	arg_8_0._dailyItemTab = arg_8_0:getUserDataTb_()
	arg_8_0._actId = Act183Model.instance:getActivityId()
	arg_8_0._info = Act183Model.instance:getActInfo()

	Act183Model.instance:initTaskStatusMap()

	arg_8_0._rewardReddotAnim = gohelper.findChildComponent(arg_8_0._btnreward.gameObject, "ani", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(arg_8_0._gotaskreddot, RedDotEnum.DotNode.V2a5_Act183Task, nil, arg_8_0._taskReddotFunc, arg_8_0)
	arg_8_0:addEventCb(Act183Controller.instance, Act183Event.RefreshMedalReddot, arg_8_0.initOrRefreshMedalReddot, arg_8_0)

	arg_8_0._hasPlayUnlockAnimGroupIds = Act183Helper.getUnlockGroupIdsInLocal(arg_8_0._actId)
	arg_8_0._hasPlayUnlockAnimGroupIdMap = Act183Helper.listToMap(arg_8_0._hasPlayUnlockAnimGroupIds)
end

function var_0_0._taskReddotFunc(arg_9_0, arg_9_1)
	arg_9_1:defaultRefreshDot()
	arg_9_0._rewardReddotAnim:Play(arg_9_1.show and "loop" or "idle", 0, 0)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:initRemainTime()
	arg_10_0:initMainChapters()
	arg_10_0:initDailyChapters()
	arg_10_0:startCheckDailyGroupUnlock()
	arg_10_0:initOrRefreshMedalReddot()
end

function var_0_0.startCheckDailyGroupUnlock(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.checkDailyGroupUnlock, arg_11_0)
	TaskDispatcher.runRepeat(arg_11_0.checkDailyGroupUnlock, arg_11_0, var_0_2)
end

function var_0_0.checkDailyGroupUnlock(arg_12_0)
	if arg_12_0._dailyGroupEpisodeCount <= arg_12_0._unlockGroupEpisodeCount then
		TaskDispatcher.cancelTask(arg_12_0.checkDailyGroupUnlock, arg_12_0)

		return
	end

	arg_12_0:initDailyChapters()
end

function var_0_0.initRemainTime(arg_13_0)
	arg_13_0:showLeftTime()
	TaskDispatcher.runRepeat(arg_13_0.showLeftTime, arg_13_0, var_0_3)
end

function var_0_0.showLeftTime(arg_14_0)
	arg_14_0._txttime.text = ActivityHelper.getActivityRemainTimeStr(arg_14_0._actId)
end

function var_0_0.initMainChapters(arg_15_0)
	local var_15_0 = arg_15_0._info:getGroupEpisodeMos(Act183Enum.GroupType.NormalMain)
	local var_15_1 = arg_15_0._info:getGroupEpisodeMos(Act183Enum.GroupType.HardMain)
	local var_15_2 = var_15_0 and var_15_0[1]
	local var_15_3 = var_15_1 and var_15_1[1]

	if not var_15_2 or not var_15_3 then
		return
	end

	arg_15_0._mainGroupEpisodeTab = {
		[Act183Enum.GroupType.NormalMain] = var_15_2,
		[Act183Enum.GroupType.HardMain] = var_15_3
	}

	for iter_15_0, iter_15_1 in pairs(arg_15_0._mainGroupEpisodeTab) do
		local var_15_4 = arg_15_0:_getMainGroupEpisodeItem(iter_15_0)

		arg_15_0:_refreshMainGroupEpisodeItem(var_15_4, iter_15_1)
	end
end

function var_0_0._getMainGroupEpisodeItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._mainItemTab[arg_16_1]

	if not var_16_0 then
		var_16_0 = arg_16_0:getUserDataTb_()
		var_16_0.viewGO = arg_16_0[arg_16_1 == Act183Enum.GroupType.NormalMain and "_gonormal" or "_gohard"]
		var_16_0.goresult = gohelper.findChild(var_16_0.viewGO, "go_result")
		var_16_0.txttitle = gohelper.findChildText(var_16_0.viewGO, "txt_title")
		var_16_0.txttotalprogress = gohelper.findChildText(var_16_0.viewGO, "go_result/txt_totalprogress")
		var_16_0.golock = gohelper.findChild(var_16_0.viewGO, "go_lock")
		var_16_0.animlock = gohelper.onceAddComponent(var_16_0.golock, gohelper.Type_Animator)
		arg_16_0._mainItemTab[arg_16_1] = var_16_0
	end

	return var_16_0
end

function var_0_0._refreshMainGroupEpisodeItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2:getStatus()
	local var_17_1 = var_17_0 ~= Act183Enum.GroupStatus.Locked
	local var_17_2 = var_17_0 == Act183Enum.GroupStatus.Finished

	gohelper.setActive(arg_17_1.golock, not var_17_1)
	gohelper.setActive(arg_17_1.goresult, var_17_1)

	if var_17_1 then
		local var_17_3 = arg_17_2:getGroupId()
		local var_17_4 = arg_17_2:getGroupType()
		local var_17_5, var_17_6 = Act183Helper.getGroupEpisodeTaskProgress(arg_17_0._actId, var_17_3)

		arg_17_1.txttotalprogress.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_finished"), var_17_6, var_17_5)

		if var_17_4 ~= Act183Enum.GroupType.NormalMain then
			arg_17_0:checkPlayUnlockAnim(var_17_3, var_17_1, var_17_2, arg_17_1.golock, arg_17_1.animlock)
		end
	end
end

function var_0_0.initDailyChapters(arg_18_0)
	arg_18_0._dailyGroupEpisodeMos = arg_18_0._info:getGroupEpisodeMos(Act183Enum.GroupType.Daily)
	arg_18_0._dailyGroupEpisodeCount = arg_18_0._dailyGroupEpisodeMos and #arg_18_0._dailyGroupEpisodeMos or 0
	arg_18_0._unlockGroupEpisodeCount = 0

	if not arg_18_0._dailyGroupEpisodeMos then
		return
	end

	local var_18_0 = {}
	local var_18_1 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._dailyGroupEpisodeMos) do
		local var_18_2 = arg_18_0:_getOrCreateDailyGroupItem(iter_18_0)
		local var_18_3 = arg_18_0:_refreshDailyGroupItem(iter_18_0, var_18_2, iter_18_1)

		var_18_0[var_18_2] = true
		var_18_1 = var_18_1 + 1

		if var_18_3 then
			arg_18_0._unlockGroupEpisodeCount = arg_18_0._unlockGroupEpisodeCount + 1
		else
			break
		end
	end

	if var_18_1 < var_0_1 then
		for iter_18_2 = var_18_1 + 1, var_0_1 do
			local var_18_4 = arg_18_0:_getOrCreateDailyGroupItem(iter_18_2)

			arg_18_0:_refreshDailyGroupItem(iter_18_2, var_18_4)

			var_18_0[var_18_4] = true
		end
	end

	for iter_18_3, iter_18_4 in pairs(arg_18_0._dailyItemTab) do
		if not var_18_0[iter_18_4] then
			gohelper.setActive(iter_18_4.viewGO, false)
		end
	end
end

function var_0_0._getOrCreateDailyGroupItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._dailyItemTab[arg_19_1]

	if not var_19_0 then
		var_19_0 = arg_19_0:getUserDataTb_()
		var_19_0.viewGO = gohelper.cloneInPlace(arg_19_0._godailyitem, "daily_" .. arg_19_1)
		var_19_0.golock = gohelper.findChild(var_19_0.viewGO, "go_lock")
		var_19_0.gounlock = gohelper.findChild(var_19_0.viewGO, "go_unlock")
		var_19_0.goempty = gohelper.findChild(var_19_0.viewGO, "go_Empty")
		var_19_0.gofinish = gohelper.findChild(var_19_0.viewGO, "go_unlock/go_Finished")
		var_19_0.txtunlocktime = gohelper.findChildText(var_19_0.viewGO, "go_lock/txt_unlocktime")
		var_19_0.txtindex = gohelper.findChildText(var_19_0.viewGO, "go_unlock/txt_index")
		var_19_0.txtprogress = gohelper.findChildText(var_19_0.viewGO, "go_unlock/txt_progress")
		var_19_0.btnclick = gohelper.findChildButtonWithAudio(var_19_0.viewGO, "btn_click")

		var_19_0.btnclick:AddClickListener(arg_19_0._onClickDailyGroupItem, arg_19_0, arg_19_1)

		var_19_0.animlock = gohelper.onceAddComponent(var_19_0.golock, gohelper.Type_Animator)
		var_19_0.animfinish = gohelper.onceAddComponent(var_19_0.gofinish, gohelper.Type_Animator)
		arg_19_0._dailyItemTab[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0._onClickDailyGroupItem(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._dailyGroupEpisodeMos[arg_20_1]

	if not var_20_0 then
		return
	end

	if var_20_0:getStatus() == Act183Enum.GroupStatus.Locked then
		GameFacade.showToast(ToastEnum.Act183GroupNotOpen)

		return
	end

	local var_20_1 = var_20_0:getGroupId()
	local var_20_2 = Act183Helper.generateDungeonViewParams(Act183Enum.GroupType.Daily, var_20_1)

	Act183Controller.instance:openAct183DungeonView(var_20_2)
end

function var_0_0._refreshDailyGroupItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	gohelper.setActive(arg_21_2.viewGO, true)
	gohelper.setActive(arg_21_2.goempty, arg_21_3 == nil)

	if not arg_21_3 then
		gohelper.setActive(arg_21_2.golock, false)
		gohelper.setActive(arg_21_2.gounlock, false)

		return
	end

	local var_21_0 = arg_21_3:getGroupId()
	local var_21_1 = arg_21_3:getStatus() == Act183Enum.GroupStatus.Locked

	gohelper.setActive(arg_21_2.golock, var_21_1)
	gohelper.setActive(arg_21_2.gounlock, not var_21_1)

	local var_21_2 = false

	if var_21_1 then
		local var_21_3, var_21_4 = TimeUtil.secondToRoughTime(arg_21_3:getUnlockRemainTime())

		arg_21_2.txtunlocktime.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_unlock"), var_21_3, var_21_4)
	else
		local var_21_5, var_21_6 = Act183Helper.getGroupEpisodeTaskProgress(arg_21_0._actId, var_21_0)
		local var_21_7 = var_21_5 <= var_21_6

		arg_21_2.txtindex.text = string.format("<color=#E1E1E14D>RT</color><color=#E1E1E180><size=77>%s</size></color>", arg_21_1)
		arg_21_2.txtprogress.text = string.format("%s/%s", var_21_6, var_21_5)

		gohelper.setActive(arg_21_2.gofinish, var_21_7)
		arg_21_0:checkPlayUnlockAnim(var_21_0, true, var_21_7, arg_21_2.golock, arg_21_2.animlock)
	end

	return not var_21_1
end

function var_0_0.checkPlayUnlockAnim(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	if not arg_22_1 or not arg_22_4 or not arg_22_5 or not arg_22_2 or arg_22_3 then
		return
	end

	if not arg_22_0._hasPlayUnlockAnimGroupIdMap[arg_22_1] then
		gohelper.setActive(arg_22_4, true)
		arg_22_5:Play("unlock", 0, 0)
		table.insert(arg_22_0._hasPlayUnlockAnimGroupIds, arg_22_1)

		arg_22_0._hasPlayUnlockAnimGroupIdMap[arg_22_1] = true
	end
end

function var_0_0.releaseDailyGroupItems(arg_23_0)
	if arg_23_0._dailyItemTab then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._dailyItemTab) do
			iter_23_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.initOrRefreshMedalReddot(arg_24_0)
	if not arg_24_0._medatReddot then
		arg_24_0._medatReddot = RedDotController.instance:addNotEventRedDot(arg_24_0._gomedalreddot, arg_24_0._checkMedalReddot, arg_24_0, RedDotEnum.Style.Normal)
	end

	arg_24_0._medatReddot:refreshRedDot()
end

function var_0_0._checkMedalReddot(arg_25_0)
	local var_25_0 = Act183Helper.getHasReadUnlockSupportHeroIdsInLocal(arg_25_0._actId)
	local var_25_1 = Act183Helper.listToMap(var_25_0)
	local var_25_2 = arg_25_0._info:getUnlockSupportHeroIds()

	if var_25_2 then
		for iter_25_0, iter_25_1 in ipairs(var_25_2) do
			if not var_25_1[iter_25_1] then
				return true
			end
		end
	end
end

function var_0_0.onClose(arg_26_0)
	Act183Helper.saveUnlockGroupIdsInLocal(arg_26_0._actId, arg_26_0._hasPlayUnlockAnimGroupIds)
	TaskDispatcher.cancelTask(arg_26_0.showLeftTime, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.checkDailyGroupUnlock, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0:releaseDailyGroupItems()
end

return var_0_0
