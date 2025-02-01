module("modules.logic.weekwalk.view.WeekWalkRewardView", package.seeall)

slot0 = class("WeekWalkRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goweek = gohelper.findChild(slot0.viewGO, "left/#go_week")
	slot0._goweekunchoose = gohelper.findChild(slot0.viewGO, "left/#go_week/#go_weekunchoose")
	slot0._goweekchoose = gohelper.findChild(slot0.viewGO, "left/#go_week/#go_weekchoose")
	slot0._goweekreddot = gohelper.findChild(slot0.viewGO, "left/#go_week/#go_weekreddot")
	slot0._btnweek = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_week/#btn_week")
	slot0._godream = gohelper.findChild(slot0.viewGO, "left/#go_dream")
	slot0._godreamunchoose = gohelper.findChild(slot0.viewGO, "left/#go_dream/#go_dreamunchoose")
	slot0._godreamchoose = gohelper.findChild(slot0.viewGO, "left/#go_dream/#go_dreamchoose")
	slot0._godreamreddot = gohelper.findChild(slot0.viewGO, "left/#go_dream/#go_dreamreddot")
	slot0._btndream = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_dream/#btn_dream")
	slot0._gochallenge = gohelper.findChild(slot0.viewGO, "left/#go_challenge")
	slot0._gochallengeunchoose = gohelper.findChild(slot0.viewGO, "left/#go_challenge/#go_challengeunchoose")
	slot0._gochallengechoose = gohelper.findChild(slot0.viewGO, "left/#go_challenge/#go_challengechoose")
	slot0._gochallengereddot = gohelper.findChild(slot0.viewGO, "left/#go_challenge/#go_challengereddot")
	slot0._btnchallenge = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_challenge/#btn_challenge")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "right/#scroll_reward")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")
	slot0._gofinishall = gohelper.findChild(slot0.viewGO, "bottom/#go_finishall")
	slot0._btnfinishall = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#go_finishall/#btn_finishall")
	slot0._gocountdown = gohelper.findChild(slot0.viewGO, "title/#go_countdown")
	slot0._txtcountdowntitle = gohelper.findChildText(slot0.viewGO, "title/#go_countdown/#txt_countdowntitle")
	slot0._txtcountday = gohelper.findChildText(slot0.viewGO, "title/#go_countdown/#txt_countdowntitle/#txt_countday")
	slot0._txtlayer = gohelper.findChildText(slot0.viewGO, "#txt_layer")
	slot0._gotiptxt = gohelper.findChild(slot0.viewGO, "#go_tiptxt")
	slot0._txttotalprogress = gohelper.findChildText(slot0.viewGO, "#txt_totalprogress")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnweek:AddClickListener(slot0._btnweekOnClick, slot0)
	slot0._btndream:AddClickListener(slot0._btndreamOnClick, slot0)
	slot0._btnchallenge:AddClickListener(slot0._btnchallengeOnClick, slot0)
	slot0._btnfinishall:AddClickListener(slot0._btnfinishallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnweek:RemoveClickListener()
	slot0._btndream:RemoveClickListener()
	slot0._btnchallenge:RemoveClickListener()
	slot0._btnfinishall:RemoveClickListener()
end

function slot0._btnchallengeOnClick(slot0)
	slot0._btnIndex = WeekWalkEnum.TaskType.Challenge

	slot0:_updateBtns()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnweekOnClick(slot0)
	slot0._btnIndex = WeekWalkEnum.TaskType.Week

	slot0:_updateBtns()
end

function slot0._btndreamOnClick(slot0)
	slot0._btnIndex = WeekWalkEnum.TaskType.Dream

	slot0:_updateBtns()
end

function slot0._updateBtns(slot0)
	slot1 = slot0._btnIndex == WeekWalkEnum.TaskType.Week

	gohelper.setActive(slot0._goweekchoose, slot1)
	gohelper.setActive(slot0._goweekunchoose, not slot1)
	gohelper.setActive(slot0._goweekreddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week))

	slot2 = slot0._btnIndex == WeekWalkEnum.TaskType.Dream

	gohelper.setActive(slot0._godreamchoose, slot2)
	gohelper.setActive(slot0._godreamunchoose, not slot2)
	gohelper.setActive(slot0._godreamreddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Dream))

	slot3 = slot0._btnIndex == WeekWalkEnum.TaskType.Challenge

	gohelper.setActive(slot0._gochallengechoose, slot3)
	gohelper.setActive(slot0._gochallengeunchoose, not slot3)
	gohelper.setActive(slot0._gochallengereddot, WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Challenge))
	gohelper.setActive(slot0._gocountdown, not slot2)
	gohelper.setActive(slot0._gotiptxt, slot1)

	if not slot2 then
		slot0:_showDeadline()
	else
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end

	slot0._scrollreward.verticalNormalizedPosition = 1

	WeekWalkTaskListModel.instance:showTaskList(slot0._btnIndex, slot0._mapId)

	slot0._mapId = nil

	gohelper.setActive(slot0._gofinishall.gameObject, WeekWalkTaskListModel.instance:hasFinished())

	slot6 = 0

	for slot10, slot11 in ipairs(WeekWalkTaskListModel.instance:getList()) do
		if WeekWalkTaskListModel.instance:getTaskMo(slot11.id) then
			slot5 = math.max(slot12.progress or 0, 0)
		end

		if lua_task_weekwalk.configDict[slot11.id] then
			slot6 = math.max(slot13.maxProgress or 0, slot6)
		end
	end

	slot0._txttotalprogress.text = string.format("%s/%s", slot5, slot6)
end

function slot0._btnfinishallOnClick(slot0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("img_bg_black.png"))
end

function slot0._showDeadline(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	slot0._endTime = WeekWalkController.getTaskEndTime(slot0._btnIndex)

	if not slot0._endTime then
		return
	end

	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	slot0:_onRefreshDeadline()

	slot0._txtcountdowntitle.text = luaLang(slot0._btnIndex == WeekWalkEnum.TaskType.Challenge and "p_dungeonweekwalkview_device" or "p_dungeonweekwalkview_task")
end

function slot0._onRefreshDeadline(slot0)
	if slot0._endTime - ServerTime.now() <= 0 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end

	slot2, slot3 = TimeUtil.secondToRoughTime2(math.floor(slot1))
	slot0._txtcountday.text = slot2 .. slot3
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._btnIndex = WeekWalkEnum.TaskType.Week
	slot0._mapId = slot0.viewParam and slot0.viewParam.mapId

	if slot0._mapId then
		slot0._btnIndex = uv0.getTaskType(slot0._mapId)
	end

	slot0:_updateBtns()
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetTaskReward, slot0._getTaskBouns, slot0)
end

function slot0._onGetInfo(slot0)
	slot0:_updateBtns()
end

function slot0.getTaskType(slot0)
	return WeekWalkModel.isShallowMap(slot0) and WeekWalkEnum.TaskType.Dream or WeekWalkEnum.TaskType.Challenge
end

function slot0._onWeekwalkTaskUpdate(slot0)
	if not slot0._bounsItemList or #slot0._bounsItemList == 0 then
		return
	end

	slot0:_bonusReply()
end

function slot0._getTaskBouns(slot0, slot1)
	slot0._bounsItemList = slot0:getUserDataTb_()
	slot4 = nil

	for slot8 = 1, slot0._gorewardcontent.transform.childCount do
		if MonoHelper.getLuaComFromGo(gohelper.findChild(slot2:GetChild(slot8 - 1).gameObject, "prefabInst"), WeekWalkRewardItem)._canGet then
			table.insert(slot0._bounsItemList, slot12)
		end

		if slot12._mo.id == 0 then
			slot4 = slot12
		end
	end

	if slot1 ~= slot4 then
		slot0._bounsItemList = slot0:getUserDataTb_()

		if slot4 and #slot0._bounsItemList <= 3 then
			table.insert(slot0._bounsItemList, slot4)
		end

		table.insert(slot0._bounsItemList, slot1)
	end
end

function slot0._bonusReply(slot0)
	UIBlockMgr.instance:startBlock("WeekWalkRewardView bonus")
	slot0:_playTaskFinish()
end

function slot0._playTaskFinish(slot0)
	slot0._indexList = {}

	for slot5, slot6 in ipairs(slot0._bounsItemList) do
		slot6:playOutAnim()
		table.insert(slot0._indexList, slot6.viewGO.transform.parent:GetSiblingIndex())
	end

	slot0._bounsItemList = nil

	TaskDispatcher.runDelay(slot0._onTaskFinishDone, slot0, 0.267)
end

function slot0._onTaskFinishDone(slot0)
	slot0:_updateBtns()

	for slot6 = 1, slot0._gorewardcontent.transform.childCount do
		if slot0:_skipNum(slot6 - 1) > 0 then
			slot9 = slot1:GetChild(slot7)
			slot10, slot11 = transformhelper.getLocalPos(slot9.transform)

			transformhelper.setLocalPosXY(slot9, slot10, slot11 - 166 * slot8)

			slot12 = ZProj.TweenHelper.DOLocalMoveY(slot9, slot11, 0.3, nil, , , EaseType.Linear)
		end
	end

	TaskDispatcher.runDelay(slot0._showRewards, slot0, 0.3)
end

function slot0._skipNum(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._indexList) do
		if slot7 <= slot1 then
			slot2 = 0 + 1
		else
			break
		end
	end

	return slot2
end

function slot0._showRewards(slot0)
	UIBlockMgr.instance:endBlock("WeekWalkRewardView bonus")
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, WeekWalkTaskListModel.instance:getTaskRewardList())
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("WeekWalkRewardView bonus")
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._showRewards, slot0)
	TaskDispatcher.cancelTask(slot0._onTaskFinishDone, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
