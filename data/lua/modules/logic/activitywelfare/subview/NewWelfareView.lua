module("modules.logic.activitywelfare.subview.NewWelfareView", package.seeall)

local var_0_0 = class("NewWelfareView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Descr")
	arg_1_0._goNormal1 = gohelper.findChild(arg_1_0.viewGO, "Root/Card1/#go_Normal")
	arg_1_0._txtCondition1 = gohelper.findChildText(arg_1_0.viewGO, "Root/Card1/#go_Normal/#txt_Condition")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Card1/#go_Normal/#btn_Claim")
	arg_1_0._btnGo1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Card1/#go_Normal/#btn_Go")
	arg_1_0._goComplete1 = gohelper.findChild(arg_1_0.viewGO, "Root/Card1/#go_Complete")
	arg_1_0._goComplete2 = gohelper.findChild(arg_1_0.viewGO, "Root/Card2/#go_Complete")
	arg_1_0._btnGo2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Card2/#btn_Go")
	arg_1_0._goComplete3 = gohelper.findChild(arg_1_0.viewGO, "Root/Card3/#go_Complete")
	arg_1_0._btnGo3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Card3/#btn_Go")
	arg_1_0._goComplete4 = gohelper.findChild(arg_1_0.viewGO, "Root/Card4/#go_Complete")
	arg_1_0._btnGo4 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Card4/#btn_Go")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Card1/image_Search/#btn_Info")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "#go_Tips")
	arg_1_0._closeFlag = gohelper.findChild(arg_1_0.viewGO, "#go_Tips/close")
	arg_1_0._animTips = arg_1_0._goTips:GetComponent(gohelper.Type_Animator)
	arg_1_0._btnTipClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Tips/close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
	arg_2_0._btnGo1:AddClickListener(arg_2_0._btnGoOnClick1, arg_2_0)
	arg_2_0._btnGo2:AddClickListener(arg_2_0._btnGoOnClick2, arg_2_0)
	arg_2_0._btnGo3:AddClickListener(arg_2_0._btnGoOnClick3, arg_2_0)
	arg_2_0._btnGo4:AddClickListener(arg_2_0._btnGoOnClick4, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnInfo, arg_2_0._btnInfoOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnTipClose, arg_2_0._btnInfoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnGo1:RemoveClickListener()
	arg_3_0._btnGo2:RemoveClickListener()
	arg_3_0._btnGo3:RemoveClickListener()
	arg_3_0._btnGo4:RemoveClickListener()
end

function var_0_0._btnClaimOnClick(arg_4_0)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(arg_4_0.actId, arg_4_0.curMission)
end

function var_0_0._btnGoOnClick1(arg_5_0)
	local var_5_0 = arg_5_0.missionCO[arg_5_0.curMission].episodeId

	if var_5_0 ~= 0 then
		local var_5_1 = DungeonConfig.instance:getEpisodeCO(var_5_0)
		local var_5_2 = {}
		local var_5_3 = var_5_1.id
		local var_5_4 = var_5_1.chapterId

		var_5_2.chapterType = lua_chapter.configDict[var_5_4].type
		var_5_2.chapterId = var_5_4
		var_5_2.episodeId = var_5_3

		ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
		DungeonController.instance:jumpDungeon(var_5_2)
	end
end

function var_0_0._btnGoOnClick2(arg_6_0)
	local var_6_0 = arg_6_0._taskConfigDataTab[1].jumpId

	if var_6_0 ~= 0 then
		GameFacade.jump(var_6_0, arg_6_0._jumpFinishCallBack, arg_6_0)
	end
end

function var_0_0._btnGoOnClick3(arg_7_0)
	arg_7_0:switchTab(ActivityEnum.Activity.NoviceSign)
end

function var_0_0._btnGoOnClick4(arg_8_0)
	local var_8_0 = DungeonModel.instance:getLastEpisodeShowData()

	if not var_8_0 then
		return
	end

	if TeachNoteModel.instance:isTeachNoteUnlock() then
		local var_8_1 = {}
		local var_8_2 = var_8_0.id
		local var_8_3 = var_8_0.chapterId

		var_8_1.chapterType = lua_chapter.configDict[var_8_3].type
		var_8_1.chapterId = var_8_3
		var_8_1.episodeId = var_8_2

		TeachNoteModel.instance:setJumpEnter(false)

		arg_8_0.jumpClassShow = true

		DungeonController.instance:jumpDungeon(var_8_1)
	else
		GameFacade.showToast(ToastEnum.ClassShow)
	end
end

function var_0_0._btnInfoOnClick(arg_9_0)
	local var_9_0 = arg_9_0._closeFlag.activeSelf and "close" or "open"

	arg_9_0._animTips:Play(var_9_0)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.actId = ActivityEnum.Activity.NewWelfare
	arg_10_0.missionCO = Activity160Config.instance:getActivityMissions(arg_10_0.actId)

	arg_10_0:_initTipsView()
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	local var_12_0 = arg_12_0.viewParam.parent

	gohelper.addChild(var_12_0, arg_12_0.viewGO)
	arg_12_0:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, arg_12_0._onInfoUpdate, arg_12_0)
	arg_12_0:addEventCb(Activity160Controller.instance, Activity160Event.HasReadMail, arg_12_0._onReadMail, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_12_0._onOpenViewFinish, arg_12_0, LuaEventSystem.Low)
	arg_12_0:initStoryShowData()
	arg_12_0:refreshView()
	arg_12_0:_refreshTip()
end

function var_0_0.refreshView(arg_13_0)
	local var_13_0 = ActivityConfig.instance:getActivityCo(arg_13_0.actId)

	arg_13_0._txtDescr.text = var_13_0.actDesc
	arg_13_0._txtLimitTime.text = luaLang("activityshow_unlimittime")

	local var_13_1 = false
	local var_13_2 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Novice)

	if var_13_2 and next(var_13_2) and TaskModel.instance:isFinishAllNoviceTask() then
		var_13_1 = true
	end

	gohelper.setActive(arg_13_0._goComplete2, var_13_1)
	gohelper.setActive(arg_13_0._btnGo2, not var_13_1)

	local var_13_3 = ActivityType101Model.instance:hasReceiveAllReward(ActivityEnum.Activity.NoviceSign)

	gohelper.setActive(arg_13_0._goComplete3, var_13_3)
	gohelper.setActive(arg_13_0._btnGo3, not var_13_3)

	local var_13_4 = TeachNoteModel.instance:isFinalRewardGet()

	gohelper.setActive(arg_13_0._goComplete4, var_13_4)
	gohelper.setActive(arg_13_0._btnGo4, not var_13_4)
	arg_13_0:refreshNewWelfarePart()
end

function var_0_0.refreshNewWelfarePart(arg_14_0)
	arg_14_0.curMission = Activity160Model.instance:getCurMission(arg_14_0.actId)
	arg_14_0._txtCondition1.text = arg_14_0.missionCO[arg_14_0.curMission].desc

	local var_14_0 = Activity160Model.instance:hasRewardClaim(arg_14_0.actId)
	local var_14_1 = Activity160Model.instance:hasRewardCanGet(arg_14_0.actId)

	gohelper.setActive(arg_14_0._goNormal1, var_14_1)
	gohelper.setActive(arg_14_0._goComplete1, not var_14_1)
	gohelper.setActive(arg_14_0._btnClaim, var_14_0)
	gohelper.setActive(arg_14_0._btnGo1, var_14_1 and not var_14_0)
	arg_14_0:_refreshTip()
end

function var_0_0._onInfoUpdate(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0.actId then
		arg_15_0:refreshNewWelfarePart()
	end
end

function var_0_0.switchTab(arg_16_0, arg_16_1)
	ActivityBeginnerController.instance:setFirstEnter(arg_16_1)
	ActivityModel.instance:setTargetActivityCategoryId(arg_16_1)
	ActivityController.instance:dispatchEvent(ActivityEvent.SwitchWelfareActivity)
end

function var_0_0.initStoryShowData(arg_17_0)
	local var_17_0 = ActivityEnum.Activity.StoryShow

	arg_17_0._taskConfigDataTab = arg_17_0:getUserDataTb_()

	for iter_17_0 = 1, GameUtil.getTabLen(ActivityConfig.instance:getActivityShowTaskCount(var_17_0)) do
		local var_17_1 = ActivityConfig.instance:getActivityShowTaskList(var_17_0, iter_17_0)

		table.insert(arg_17_0._taskConfigDataTab, var_17_1)
	end
end

function var_0_0._jumpFinishCallBack(arg_18_0)
	ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
end

function var_0_0._onOpenViewFinish(arg_19_0, arg_19_1)
	if arg_19_0.jumpClassShow then
		arg_19_0.jumpClassShow = false

		if arg_19_1 == ViewName.DungeonMapView then
			TeachNoteController.instance:enterTeachNoteView(nil, false)
			ViewMgr.instance:closeView(ViewName.ActivityWelfareView, true)
		end
	end
end

function var_0_0._onReadMail(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == arg_20_0.actId then
		GameFacade.showToastString(luaLang("activity160_mail_hasreceive"))
	end
end

function var_0_0._initTipsView(arg_21_0)
	arg_21_0._goSchedule = gohelper.findChild(arg_21_0.viewGO, "Root/Card1/#go_Normal/#go_Schedule")
	arg_21_0._progressGoList = arg_21_0:getUserDataTb_()

	for iter_21_0 = 1, 3 do
		arg_21_0._progressGoList[iter_21_0] = gohelper.findChild(arg_21_0.viewGO, "Root/Card1/#go_Normal/#go_Schedule/#go_" .. iter_21_0 .. "/#go_FG")
	end

	arg_21_0._tipItems = {}

	for iter_21_1, iter_21_2 in ipairs(arg_21_0.missionCO) do
		local var_21_0 = arg_21_0:getUserDataTb_()
		local var_21_1 = gohelper.findChild(arg_21_0.viewGO, "#go_Tips/frameRoot/List/#go_" .. iter_21_1)

		var_21_0.txtDescr = gohelper.findChildText(var_21_1, "#txt_Descr")
		var_21_0.txtDescr.text = iter_21_2.desc
		var_21_0.txtNum = gohelper.findChildText(var_21_1, "#txt_Descr/#txt_Num")

		local var_21_2 = gohelper.findChild(var_21_1, "#scroll_Rewards/Viewport/#go_Rewards/#go_RewardItem")
		local var_21_3 = string.split(iter_21_2.bonus, "|")

		var_21_0.rewardItems = {}

		for iter_21_3 = 1, #var_21_3 do
			local var_21_4 = string.splitToNumber(var_21_3[iter_21_3], "#")
			local var_21_5 = gohelper.cloneInPlace(var_21_2)
			local var_21_6 = gohelper.findChild(var_21_5, "go_icon")
			local var_21_7 = IconMgr.instance:getCommonItemIcon(var_21_6)

			var_21_7:setMOValue(var_21_4[1], var_21_4[2], var_21_4[3], nil, var_21_4[1] == 4)
			var_21_7:setCountFontSize(42)

			var_21_7.hasGet = gohelper.findChild(var_21_5, "go_receive")
			var_21_0.rewardItems[iter_21_3] = var_21_7
		end

		gohelper.setActive(var_21_2, false)

		arg_21_0._tipItems[iter_21_1] = var_21_0
	end
end

function var_0_0._refreshTip(arg_22_0)
	local var_22_0 = true

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.missionCO) do
		local var_22_1 = Activity160Model.instance:isMissionFinish(arg_22_0.actId, iter_22_0)

		gohelper.setActive(arg_22_0._progressGoList[iter_22_0], var_22_1)

		if not var_22_1 then
			var_22_0 = false
		end

		local var_22_2 = Activity160Model.instance:isMissionCanGet(arg_22_0.actId, iter_22_0)
		local var_22_3 = arg_22_0._tipItems[iter_22_0]

		if var_22_3 then
			for iter_22_2, iter_22_3 in ipairs(var_22_3.rewardItems) do
				gohelper.setActive(iter_22_3.hasGet, var_22_1)
			end

			var_22_3.txtNum.text = var_22_1 and "<color=#726D6A>1/1</color>" or var_22_2 and "<color=#E5DBD4>1/1</color>" or "<color=#DA7374>0/1</color>"

			local var_22_4 = var_22_1 and "#726D6A" or "#E5DBD4"

			var_22_3.txtDescr.text = string.format("<color=%s>%s</color>", var_22_4, iter_22_1.desc)
		end
	end

	gohelper.setActive(arg_22_0._goSchedule, not var_22_0)
end

return var_0_0
