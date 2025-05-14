module("modules.logic.weekwalk.view.WeekWalkRewardView", package.seeall)

local var_0_0 = class("WeekWalkRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goweek = gohelper.findChild(arg_1_0.viewGO, "left/#go_week")
	arg_1_0._goweekunchoose = gohelper.findChild(arg_1_0.viewGO, "left/#go_week/#go_weekunchoose")
	arg_1_0._goweekchoose = gohelper.findChild(arg_1_0.viewGO, "left/#go_week/#go_weekchoose")
	arg_1_0._goweekreddot = gohelper.findChild(arg_1_0.viewGO, "left/#go_week/#go_weekreddot")
	arg_1_0._btnweek = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_week/#btn_week")
	arg_1_0._godream = gohelper.findChild(arg_1_0.viewGO, "left/#go_dream")
	arg_1_0._godreamunchoose = gohelper.findChild(arg_1_0.viewGO, "left/#go_dream/#go_dreamunchoose")
	arg_1_0._godreamchoose = gohelper.findChild(arg_1_0.viewGO, "left/#go_dream/#go_dreamchoose")
	arg_1_0._godreamreddot = gohelper.findChild(arg_1_0.viewGO, "left/#go_dream/#go_dreamreddot")
	arg_1_0._btndream = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_dream/#btn_dream")
	arg_1_0._gochallenge = gohelper.findChild(arg_1_0.viewGO, "left/#go_challenge")
	arg_1_0._gochallengeunchoose = gohelper.findChild(arg_1_0.viewGO, "left/#go_challenge/#go_challengeunchoose")
	arg_1_0._gochallengechoose = gohelper.findChild(arg_1_0.viewGO, "left/#go_challenge/#go_challengechoose")
	arg_1_0._gochallengereddot = gohelper.findChild(arg_1_0.viewGO, "left/#go_challenge/#go_challengereddot")
	arg_1_0._btnchallenge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#go_challenge/#btn_challenge")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#scroll_reward")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")
	arg_1_0._gofinishall = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_finishall")
	arg_1_0._btnfinishall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#go_finishall/#btn_finishall")
	arg_1_0._gocountdown = gohelper.findChild(arg_1_0.viewGO, "title/#go_countdown")
	arg_1_0._txtcountdowntitle = gohelper.findChildText(arg_1_0.viewGO, "title/#go_countdown/#txt_countdowntitle")
	arg_1_0._txtcountday = gohelper.findChildText(arg_1_0.viewGO, "title/#go_countdown/#txt_countdowntitle/#txt_countday")
	arg_1_0._txtlayer = gohelper.findChildText(arg_1_0.viewGO, "#txt_layer")
	arg_1_0._gotiptxt = gohelper.findChild(arg_1_0.viewGO, "#go_tiptxt")
	arg_1_0._txttotalprogress = gohelper.findChildText(arg_1_0.viewGO, "#txt_totalprogress")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnweek:AddClickListener(arg_2_0._btnweekOnClick, arg_2_0)
	arg_2_0._btndream:AddClickListener(arg_2_0._btndreamOnClick, arg_2_0)
	arg_2_0._btnchallenge:AddClickListener(arg_2_0._btnchallengeOnClick, arg_2_0)
	arg_2_0._btnfinishall:AddClickListener(arg_2_0._btnfinishallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnweek:RemoveClickListener()
	arg_3_0._btndream:RemoveClickListener()
	arg_3_0._btnchallenge:RemoveClickListener()
	arg_3_0._btnfinishall:RemoveClickListener()
end

function var_0_0._btnchallengeOnClick(arg_4_0)
	arg_4_0._btnIndex = WeekWalkEnum.TaskType.Challenge

	arg_4_0:_updateBtns()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnweekOnClick(arg_6_0)
	arg_6_0._btnIndex = WeekWalkEnum.TaskType.Week

	arg_6_0:_updateBtns()
end

function var_0_0._btndreamOnClick(arg_7_0)
	arg_7_0._btnIndex = WeekWalkEnum.TaskType.Dream

	arg_7_0:_updateBtns()
end

function var_0_0._updateBtns(arg_8_0)
	local var_8_0 = arg_8_0._btnIndex == WeekWalkEnum.TaskType.Week

	gohelper.setActive(arg_8_0._goweekchoose, var_8_0)
	gohelper.setActive(arg_8_0._goweekunchoose, not var_8_0)
	gohelper.setActive(arg_8_0._goweekreddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week))

	local var_8_1 = arg_8_0._btnIndex == WeekWalkEnum.TaskType.Dream

	gohelper.setActive(arg_8_0._godreamchoose, var_8_1)
	gohelper.setActive(arg_8_0._godreamunchoose, not var_8_1)
	gohelper.setActive(arg_8_0._godreamreddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Dream))

	local var_8_2 = arg_8_0._btnIndex == WeekWalkEnum.TaskType.Challenge

	gohelper.setActive(arg_8_0._gochallengechoose, var_8_2)
	gohelper.setActive(arg_8_0._gochallengeunchoose, not var_8_2)
	gohelper.setActive(arg_8_0._gochallengereddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Challenge))
	gohelper.setActive(arg_8_0._gocountdown, not var_8_1)
	gohelper.setActive(arg_8_0._gotiptxt, var_8_0)

	if not var_8_1 then
		arg_8_0:_showDeadline()
	else
		TaskDispatcher.cancelTask(arg_8_0._onRefreshDeadline, arg_8_0)
	end

	arg_8_0._scrollreward.verticalNormalizedPosition = 1

	WeekWalkTaskListModel.instance:showTaskList(arg_8_0._btnIndex, arg_8_0._mapId)

	arg_8_0._mapId = nil

	gohelper.setActive(arg_8_0._gofinishall.gameObject, WeekWalkTaskListModel.instance:hasFinished())

	local var_8_3 = WeekWalkTaskListModel.instance:getList()
	local var_8_4 = 0
	local var_8_5 = 0

	for iter_8_0, iter_8_1 in ipairs(var_8_3) do
		local var_8_6 = WeekWalkTaskListModel.instance:getTaskMo(iter_8_1.id)

		if var_8_6 then
			var_8_4 = math.max(var_8_6.progress or 0, var_8_4)
		end

		local var_8_7 = lua_task_weekwalk.configDict[iter_8_1.id]

		if var_8_7 then
			var_8_5 = math.max(var_8_7.maxProgress or 0, var_8_5)
		end
	end

	arg_8_0._txttotalprogress.text = string.format("%s/%s", var_8_4, var_8_5)
end

function var_0_0._btnfinishallOnClick(arg_9_0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))
end

function var_0_0._showDeadline(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onRefreshDeadline, arg_11_0)

	arg_11_0._endTime = WeekWalkController.getTaskEndTime(arg_11_0._btnIndex)

	if not arg_11_0._endTime then
		return
	end

	TaskDispatcher.runRepeat(arg_11_0._onRefreshDeadline, arg_11_0, 1)
	arg_11_0:_onRefreshDeadline()

	arg_11_0._txtcountdowntitle.text = luaLang(arg_11_0._btnIndex == WeekWalkEnum.TaskType.Challenge and "p_dungeonweekwalkview_device" or "p_dungeonweekwalkview_task")
end

function var_0_0._onRefreshDeadline(arg_12_0)
	local var_12_0 = arg_12_0._endTime - ServerTime.now()

	if var_12_0 <= 0 then
		TaskDispatcher.cancelTask(arg_12_0._onRefreshDeadline, arg_12_0)
	end

	local var_12_1, var_12_2 = TimeUtil.secondToRoughTime2(math.floor(var_12_0))

	arg_12_0._txtcountday.text = var_12_1 .. var_12_2
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0._btnIndex = WeekWalkEnum.TaskType.Week
	arg_14_0._mapId = arg_14_0.viewParam and arg_14_0.viewParam.mapId

	if arg_14_0._mapId then
		arg_14_0._btnIndex = var_0_0.getTaskType(arg_14_0._mapId)
	end

	arg_14_0:_updateBtns()
	arg_14_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_14_0._onWeekwalkTaskUpdate, arg_14_0)
	arg_14_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_14_0._onGetInfo, arg_14_0)
	arg_14_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetTaskReward, arg_14_0._getTaskBouns, arg_14_0)
end

function var_0_0._onGetInfo(arg_15_0)
	arg_15_0:_updateBtns()
end

function var_0_0.getTaskType(arg_16_0)
	return WeekWalkModel.isShallowMap(arg_16_0) and WeekWalkEnum.TaskType.Dream or WeekWalkEnum.TaskType.Challenge
end

function var_0_0._onWeekwalkTaskUpdate(arg_17_0)
	if not arg_17_0._bounsItemList or #arg_17_0._bounsItemList == 0 then
		return
	end

	arg_17_0:_bonusReply()
end

function var_0_0._getTaskBouns(arg_18_0, arg_18_1)
	arg_18_0._bounsItemList = arg_18_0:getUserDataTb_()

	local var_18_0 = arg_18_0._gorewardcontent.transform
	local var_18_1 = var_18_0.childCount
	local var_18_2

	for iter_18_0 = 1, var_18_1 do
		local var_18_3 = iter_18_0 - 1
		local var_18_4 = var_18_0:GetChild(var_18_3)
		local var_18_5 = gohelper.findChild(var_18_4.gameObject, "prefabInst")
		local var_18_6 = MonoHelper.getLuaComFromGo(var_18_5, WeekWalkRewardItem)

		if var_18_6._canGet then
			table.insert(arg_18_0._bounsItemList, var_18_6)
		end

		if var_18_6._mo.id == 0 then
			var_18_2 = var_18_6
		end
	end

	if arg_18_1 ~= var_18_2 then
		local var_18_7 = #arg_18_0._bounsItemList

		arg_18_0._bounsItemList = arg_18_0:getUserDataTb_()

		if var_18_2 and var_18_7 <= 3 then
			table.insert(arg_18_0._bounsItemList, var_18_2)
		end

		table.insert(arg_18_0._bounsItemList, arg_18_1)
	end
end

function var_0_0._bonusReply(arg_19_0)
	UIBlockMgr.instance:startBlock("WeekWalkRewardView bonus")
	arg_19_0:_playTaskFinish()
end

function var_0_0._playTaskFinish(arg_20_0)
	local var_20_0 = arg_20_0._bounsItemList

	arg_20_0._indexList = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		iter_20_1:playOutAnim()

		local var_20_1 = iter_20_1.viewGO.transform.parent:GetSiblingIndex()

		table.insert(arg_20_0._indexList, var_20_1)
	end

	arg_20_0._bounsItemList = nil

	TaskDispatcher.runDelay(arg_20_0._onTaskFinishDone, arg_20_0, 0.267)
end

function var_0_0._onTaskFinishDone(arg_21_0)
	arg_21_0:_updateBtns()

	local var_21_0 = arg_21_0._gorewardcontent.transform
	local var_21_1 = var_21_0.childCount

	for iter_21_0 = 1, var_21_1 do
		local var_21_2 = iter_21_0 - 1
		local var_21_3 = arg_21_0:_skipNum(var_21_2)

		if var_21_3 > 0 then
			local var_21_4 = var_21_0:GetChild(var_21_2)
			local var_21_5, var_21_6 = transformhelper.getLocalPos(var_21_4.transform)

			transformhelper.setLocalPosXY(var_21_4, var_21_5, var_21_6 - 166 * var_21_3)

			local var_21_7 = ZProj.TweenHelper.DOLocalMoveY(var_21_4, var_21_6, 0.3, nil, nil, nil, EaseType.Linear)
		end
	end

	TaskDispatcher.runDelay(arg_21_0._showRewards, arg_21_0, 0.3)
end

function var_0_0._skipNum(arg_22_0, arg_22_1)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._indexList) do
		if iter_22_1 <= arg_22_1 then
			var_22_0 = var_22_0 + 1
		else
			break
		end
	end

	return var_22_0
end

function var_0_0._showRewards(arg_23_0)
	UIBlockMgr.instance:endBlock("WeekWalkRewardView bonus")

	local var_23_0 = WeekWalkTaskListModel.instance:getTaskRewardList()

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_23_0)
end

function var_0_0.onClose(arg_24_0)
	UIBlockMgr.instance:endBlock("WeekWalkRewardView bonus")
	TaskDispatcher.cancelTask(arg_24_0._onRefreshDeadline, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._showRewards, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._onTaskFinishDone, arg_24_0)
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0._simagebg:UnLoadImage()
end

return var_0_0
