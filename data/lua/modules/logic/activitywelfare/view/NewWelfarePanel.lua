module("modules.logic.activitywelfare.view.NewWelfarePanel", package.seeall)

local var_0_0 = class("NewWelfarePanel", BaseView)

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
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Card1/image_Search/#btn_Info")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Tips")
	arg_1_0._closeFlag = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Tips/close")
	arg_1_0._animTips = arg_1_0._goTips:GetComponent(gohelper.Type_Animator)
	arg_1_0._btnTipClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#go_Tips/close")

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
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnInfo, arg_2_0._btnInfoOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnTipClose, arg_2_0._btnInfoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnGo1:RemoveClickListener()
	arg_3_0._btnGo2:RemoveClickListener()
	arg_3_0._btnGo3:RemoveClickListener()
	arg_3_0._btnGo4:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actId = ActivityEnum.Activity.NewWelfare
	arg_4_0.missionCO = Activity160Config.instance:getActivityMissions(arg_4_0.actId)

	arg_4_0:_initTipsView()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, arg_5_0._onInfoUpdate, arg_5_0)
	arg_5_0:addEventCb(Activity160Controller.instance, Activity160Event.HasReadMail, arg_5_0._onReadMail, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinish, arg_5_0, LuaEventSystem.Low)
	Activity160Rpc.instance:sendGetAct160InfoRequest(arg_5_0.actId)
	arg_5_0:initStoryShowData()
	arg_5_0:refreshView()
	arg_5_0:_refreshTip()
end

function var_0_0.refreshView(arg_6_0)
	local var_6_0 = ActivityConfig.instance:getActivityCo(arg_6_0.actId)

	arg_6_0._txtDescr.text = var_6_0.actDesc
	arg_6_0._txtLimitTime.text = luaLang("activityshow_unlimittime")

	local var_6_1 = false
	local var_6_2 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Novice)

	if var_6_2 and next(var_6_2) and TaskModel.instance:isFinishAllNoviceTask() then
		var_6_1 = true
	end

	gohelper.setActive(arg_6_0._goComplete2, var_6_1)
	gohelper.setActive(arg_6_0._btnGo2, not var_6_1)

	local var_6_3 = ActivityType101Model.instance:hasReceiveAllReward(ActivityEnum.Activity.NoviceSign)

	gohelper.setActive(arg_6_0._goComplete3, var_6_3)
	gohelper.setActive(arg_6_0._btnGo3, not var_6_3)

	local var_6_4 = TeachNoteModel.instance:isFinalRewardGet()

	gohelper.setActive(arg_6_0._goComplete4, var_6_4)
	gohelper.setActive(arg_6_0._btnGo4, not var_6_4)
end

function var_0_0.refreshNewWelfarePart(arg_7_0)
	arg_7_0.curMission = Activity160Model.instance:getCurMission(arg_7_0.actId)
	arg_7_0._txtCondition1.text = arg_7_0.missionCO[arg_7_0.curMission].desc

	local var_7_0 = Activity160Model.instance:hasRewardClaim(arg_7_0.actId)
	local var_7_1 = Activity160Model.instance:hasRewardCanGet(arg_7_0.actId)

	gohelper.setActive(arg_7_0._goNormal1, var_7_1)
	gohelper.setActive(arg_7_0._goComplete1, not var_7_1)
	gohelper.setActive(arg_7_0._btnClaim, var_7_0)
	gohelper.setActive(arg_7_0._btnGo1, var_7_1 and not var_7_0)
	arg_7_0:_refreshTip()
end

function var_0_0._onInfoUpdate(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0.actId then
		arg_8_0:refreshNewWelfarePart()
	end
end

function var_0_0.initStoryShowData(arg_9_0)
	local var_9_0 = ActivityEnum.Activity.StoryShow

	arg_9_0._taskConfigDataTab = arg_9_0:getUserDataTb_()

	for iter_9_0 = 1, GameUtil.getTabLen(ActivityConfig.instance:getActivityShowTaskCount(var_9_0)) do
		local var_9_1 = ActivityConfig.instance:getActivityShowTaskList(var_9_0, iter_9_0)

		table.insert(arg_9_0._taskConfigDataTab, var_9_1)
	end
end

function var_0_0._jumpFinishCallBack(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._onOpenViewFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.DungeonMapView then
		if arg_11_0.jumpClassShow then
			arg_11_0.jumpClassShow = false

			if arg_11_1 == ViewName.DungeonMapView then
				TeachNoteController.instance:enterTeachNoteView(nil, false)
				arg_11_0:closeThis()
			end
		end
	elseif arg_11_1 == ViewName.ActivityWelfareView then
		local var_11_0 = ActivityEnum.Activity.NoviceSign

		ActivityBeginnerController.instance:setFirstEnter(var_11_0)
		ActivityModel.instance:setTargetActivityCategoryId(var_11_0)
		ActivityController.instance:dispatchEvent(ActivityEvent.SwitchWelfareActivity)
	end
end

function var_0_0._onReadMail(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == arg_12_0.actId then
		GameFacade.showToastString(luaLang("activity160_mail_hasreceive"))
	end
end

function var_0_0._btnCloseOnClick(arg_13_0)
	arg_13_0:closeThis()
end

function var_0_0._btnClaimOnClick(arg_14_0)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(arg_14_0.actId, arg_14_0.curMission)
end

function var_0_0._btnGoOnClick1(arg_15_0)
	local var_15_0 = arg_15_0.missionCO[arg_15_0.curMission].episodeId

	if var_15_0 ~= 0 then
		local var_15_1 = DungeonConfig.instance:getEpisodeCO(var_15_0)
		local var_15_2 = {}
		local var_15_3 = var_15_1.id
		local var_15_4 = var_15_1.chapterId

		var_15_2.chapterType = lua_chapter.configDict[var_15_4].type
		var_15_2.chapterId = var_15_4
		var_15_2.episodeId = var_15_3

		arg_15_0:closeThis()
		DungeonController.instance:jumpDungeon(var_15_2)
	end
end

function var_0_0._btnGoOnClick2(arg_16_0)
	local var_16_0 = arg_16_0._taskConfigDataTab[1].jumpId

	if var_16_0 ~= 0 then
		GameFacade.jump(var_16_0, arg_16_0._jumpFinishCallBack, arg_16_0)
	end
end

function var_0_0._btnGoOnClick3(arg_17_0)
	ActivityController.instance:openActivityWelfareView()
	arg_17_0:closeThis()
end

function var_0_0._btnGoOnClick4(arg_18_0)
	local var_18_0 = DungeonModel.instance:getLastEpisodeShowData()

	if not var_18_0 then
		return
	end

	if TeachNoteModel.instance:isTeachNoteUnlock() then
		local var_18_1 = {}
		local var_18_2 = var_18_0.id
		local var_18_3 = var_18_0.chapterId

		var_18_1.chapterType = lua_chapter.configDict[var_18_3].type
		var_18_1.chapterId = var_18_3
		var_18_1.episodeId = var_18_2

		TeachNoteModel.instance:setJumpEnter(false)

		arg_18_0.jumpClassShow = true

		DungeonController.instance:jumpDungeon(var_18_1)
	else
		GameFacade.showToast(ToastEnum.ClassShow)
	end
end

function var_0_0._btnInfoOnClick(arg_19_0)
	local var_19_0 = arg_19_0._closeFlag.activeSelf and "close" or "open"

	arg_19_0._animTips:Play(var_19_0)
end

function var_0_0._initTipsView(arg_20_0)
	arg_20_0._goSchedule = gohelper.findChild(arg_20_0.viewGO, "Root/Card1/#go_Normal/#go_Schedule")
	arg_20_0._progressGoList = arg_20_0:getUserDataTb_()

	for iter_20_0 = 1, 3 do
		arg_20_0._progressGoList[iter_20_0] = gohelper.findChild(arg_20_0.viewGO, "Root/Card1/#go_Normal/#go_Schedule/#go_" .. iter_20_0 .. "/#go_FG")
	end

	arg_20_0._tipItems = {}

	for iter_20_1, iter_20_2 in ipairs(arg_20_0.missionCO) do
		local var_20_0 = arg_20_0:getUserDataTb_()
		local var_20_1 = gohelper.findChild(arg_20_0.viewGO, "Root/#go_Tips/List/#go_" .. iter_20_1)

		var_20_0.txtDescr = gohelper.findChildText(var_20_1, "#txt_Descr")
		var_20_0.txtDescr.text = iter_20_2.desc
		var_20_0.txtNum = gohelper.findChildText(var_20_1, "#txt_Descr/#txt_Num")

		local var_20_2 = gohelper.findChild(var_20_1, "#scroll_Rewards/Viewport/#go_Rewards/#go_RewardItem")
		local var_20_3 = string.split(iter_20_2.bonus, "|")

		var_20_0.rewardItems = {}

		for iter_20_3 = 1, #var_20_3 do
			local var_20_4 = string.splitToNumber(var_20_3[iter_20_3], "#")
			local var_20_5 = gohelper.cloneInPlace(var_20_2)
			local var_20_6 = gohelper.findChild(var_20_5, "go_icon")
			local var_20_7 = IconMgr.instance:getCommonItemIcon(var_20_6)

			var_20_7:setMOValue(var_20_4[1], var_20_4[2], var_20_4[3], nil, var_20_4[1] == 4)
			var_20_7:setCountFontSize(42)

			var_20_7.hasGet = gohelper.findChild(var_20_5, "go_receive")
			var_20_0.rewardItems[iter_20_3] = var_20_7
		end

		gohelper.setActive(var_20_2, false)

		arg_20_0._tipItems[iter_20_1] = var_20_0
	end
end

function var_0_0._refreshTip(arg_21_0)
	local var_21_0 = true

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.missionCO) do
		local var_21_1 = Activity160Model.instance:isMissionFinish(arg_21_0.actId, iter_21_0)

		gohelper.setActive(arg_21_0._progressGoList[iter_21_0], var_21_1)

		if not var_21_1 then
			var_21_0 = false
		end

		local var_21_2 = Activity160Model.instance:isMissionCanGet(arg_21_0.actId, iter_21_0)
		local var_21_3 = arg_21_0._tipItems[iter_21_0]

		if var_21_3 then
			for iter_21_2, iter_21_3 in ipairs(var_21_3.rewardItems) do
				gohelper.setActive(iter_21_3.hasGet, var_21_1)
			end

			var_21_3.txtNum.text = var_21_1 and "<color=#726D6A>1/1</color>" or var_21_2 and "<color=#E5DBD4>1/1</color>" or "<color=#DA7374>0/1</color>"

			local var_21_4 = var_21_1 and "#726D6A" or "#E5DBD4"

			var_21_3.txtDescr.text = string.format("<color=%s>%s</color>", var_21_4, iter_21_1.desc)
		end
	end

	gohelper.setActive(arg_21_0._goSchedule, not var_21_0)
end

return var_0_0
