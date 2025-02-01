module("modules.logic.activitywelfare.subview.NewWelfareView", package.seeall)

slot0 = class("NewWelfareView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Root/#txt_Descr")
	slot0._goNormal1 = gohelper.findChild(slot0.viewGO, "Root/Card1/#go_Normal")
	slot0._txtCondition1 = gohelper.findChildText(slot0.viewGO, "Root/Card1/#go_Normal/#txt_Condition")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Card1/#go_Normal/#btn_Claim")
	slot0._btnGo1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Card1/#go_Normal/#btn_Go")
	slot0._goComplete1 = gohelper.findChild(slot0.viewGO, "Root/Card1/#go_Complete")
	slot0._goComplete2 = gohelper.findChild(slot0.viewGO, "Root/Card2/#go_Complete")
	slot0._btnGo2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Card2/#btn_Go")
	slot0._goComplete3 = gohelper.findChild(slot0.viewGO, "Root/Card3/#go_Complete")
	slot0._btnGo3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Card3/#btn_Go")
	slot0._goComplete4 = gohelper.findChild(slot0.viewGO, "Root/Card4/#go_Complete")
	slot0._btnGo4 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Card4/#btn_Go")
	slot0._btnInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Card1/image_Search/#btn_Info")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "#go_Tips")
	slot0._closeFlag = gohelper.findChild(slot0.viewGO, "#go_Tips/close")
	slot0._animTips = slot0._goTips:GetComponent(gohelper.Type_Animator)
	slot0._btnTipClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Tips/close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)
	slot0._btnGo1:AddClickListener(slot0._btnGoOnClick1, slot0)
	slot0._btnGo2:AddClickListener(slot0._btnGoOnClick2, slot0)
	slot0._btnGo3:AddClickListener(slot0._btnGoOnClick3, slot0)
	slot0._btnGo4:AddClickListener(slot0._btnGoOnClick4, slot0)
	slot0:addClickCb(slot0._btnInfo, slot0._btnInfoOnClick, slot0)
	slot0:addClickCb(slot0._btnTipClose, slot0._btnInfoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClaim:RemoveClickListener()
	slot0._btnGo1:RemoveClickListener()
	slot0._btnGo2:RemoveClickListener()
	slot0._btnGo3:RemoveClickListener()
	slot0._btnGo4:RemoveClickListener()
end

function slot0._btnClaimOnClick(slot0)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(slot0.actId, slot0.curMission)
end

function slot0._btnGoOnClick1(slot0)
	if slot0.missionCO[slot0.curMission].episodeId ~= 0 then
		slot2 = DungeonConfig.instance:getEpisodeCO(slot1)
		slot5 = slot2.chapterId

		ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
		DungeonController.instance:jumpDungeon({
			chapterType = lua_chapter.configDict[slot5].type,
			chapterId = slot5,
			episodeId = slot2.id
		})
	end
end

function slot0._btnGoOnClick2(slot0)
	if slot0._taskConfigDataTab[1].jumpId ~= 0 then
		GameFacade.jump(slot1, slot0._jumpFinishCallBack, slot0)
	end
end

function slot0._btnGoOnClick3(slot0)
	slot0:switchTab(ActivityEnum.Activity.NoviceSign)
end

function slot0._btnGoOnClick4(slot0)
	if not DungeonModel.instance:getLastEpisodeShowData() then
		return
	end

	if TeachNoteModel.instance:isTeachNoteUnlock() then
		slot4 = slot1.chapterId

		TeachNoteModel.instance:setJumpEnter(false)

		slot0.jumpClassShow = true

		DungeonController.instance:jumpDungeon({
			chapterType = lua_chapter.configDict[slot4].type,
			chapterId = slot4,
			episodeId = slot1.id
		})
	else
		GameFacade.showToast(ToastEnum.ClassShow)
	end
end

function slot0._btnInfoOnClick(slot0)
	slot0._animTips:Play(slot0._closeFlag.activeSelf and "close" or "open")
end

function slot0._editableInitView(slot0)
	slot0.actId = ActivityEnum.Activity.NewWelfare
	slot0.missionCO = Activity160Config.instance:getActivityMissions(slot0.actId)

	slot0:_initTipsView()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, slot0._onInfoUpdate, slot0)
	slot0:addEventCb(Activity160Controller.instance, Activity160Event.HasReadMail, slot0._onReadMail, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0, LuaEventSystem.Low)
	slot0:initStoryShowData()
	slot0:refreshView()
	slot0:_refreshTip()
end

function slot0.refreshView(slot0)
	slot0._txtDescr.text = ActivityConfig.instance:getActivityCo(slot0.actId).actDesc
	slot0._txtLimitTime.text = luaLang("activityshow_unlimittime")
	slot2 = false

	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Novice) and next(slot3) and TaskModel.instance:isFinishAllNoviceTask() then
		slot2 = true
	end

	gohelper.setActive(slot0._goComplete2, slot2)
	gohelper.setActive(slot0._btnGo2, not slot2)

	slot4 = ActivityType101Model.instance:hasReceiveAllReward(ActivityEnum.Activity.NoviceSign)

	gohelper.setActive(slot0._goComplete3, slot4)
	gohelper.setActive(slot0._btnGo3, not slot4)

	slot5 = TeachNoteModel.instance:isFinalRewardGet()

	gohelper.setActive(slot0._goComplete4, slot5)
	gohelper.setActive(slot0._btnGo4, not slot5)
	slot0:refreshNewWelfarePart()
end

function slot0.refreshNewWelfarePart(slot0)
	slot0.curMission = Activity160Model.instance:getCurMission(slot0.actId)
	slot0._txtCondition1.text = slot0.missionCO[slot0.curMission].desc
	slot2 = Activity160Model.instance:hasRewardCanGet(slot0.actId)

	gohelper.setActive(slot0._goNormal1, slot2)
	gohelper.setActive(slot0._goComplete1, not slot2)
	gohelper.setActive(slot0._btnClaim, Activity160Model.instance:hasRewardClaim(slot0.actId))
	gohelper.setActive(slot0._btnGo1, slot2 and not slot1)
	slot0:_refreshTip()
end

function slot0._onInfoUpdate(slot0, slot1)
	if slot1 == slot0.actId then
		slot0:refreshNewWelfarePart()
	end
end

function slot0.switchTab(slot0, slot1)
	ActivityBeginnerController.instance:setFirstEnter(slot1)
	ActivityModel.instance:setTargetActivityCategoryId(slot1)
	ActivityController.instance:dispatchEvent(ActivityEvent.SwitchWelfareActivity)
end

function slot0.initStoryShowData(slot0)
	slot0._taskConfigDataTab = slot0:getUserDataTb_()
	slot4 = ActivityConfig.instance
	slot5 = slot4

	for slot5 = 1, GameUtil.getTabLen(slot4.getActivityShowTaskCount(slot5, ActivityEnum.Activity.StoryShow)) do
		table.insert(slot0._taskConfigDataTab, ActivityConfig.instance:getActivityShowTaskList(slot1, slot5))
	end
end

function slot0._jumpFinishCallBack(slot0)
	ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot0.jumpClassShow then
		slot0.jumpClassShow = false

		if slot1 == ViewName.DungeonMapView then
			TeachNoteController.instance:enterTeachNoteView(nil, false)
			ViewMgr.instance:closeView(ViewName.ActivityWelfareView, true)
		end
	end
end

function slot0._onReadMail(slot0, slot1, slot2)
	if slot1 == slot0.actId then
		GameFacade.showToastString(luaLang("activity160_mail_hasreceive"))
	end
end

function slot0._initTipsView(slot0)
	slot0._goSchedule = gohelper.findChild(slot0.viewGO, "Root/Card1/#go_Normal/#go_Schedule")
	slot0._progressGoList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0._progressGoList[slot4] = gohelper.findChild(slot0.viewGO, "Root/Card1/#go_Normal/#go_Schedule/#go_" .. slot4 .. "/#go_FG")
	end

	slot0._tipItems = {}

	for slot4, slot5 in ipairs(slot0.missionCO) do
		slot6 = slot0:getUserDataTb_()
		slot7 = gohelper.findChild(slot0.viewGO, "#go_Tips/frameRoot/List/#go_" .. slot4)
		slot6.txtDescr = gohelper.findChildText(slot7, "#txt_Descr")
		slot6.txtDescr.text = slot5.desc
		slot6.txtNum = gohelper.findChildText(slot7, "#txt_Descr/#txt_Num")
		slot8 = gohelper.findChild(slot7, "#scroll_Rewards/Viewport/#go_Rewards/#go_RewardItem")
		slot6.rewardItems = {}

		for slot13 = 1, #string.split(slot5.bonus, "|") do
			slot14 = string.splitToNumber(slot9[slot13], "#")
			slot17 = IconMgr.instance:getCommonItemIcon(gohelper.findChild(gohelper.cloneInPlace(slot8), "go_icon"))

			slot17:setMOValue(slot14[1], slot14[2], slot14[3], nil, slot14[1] == 4)
			slot17:setCountFontSize(42)

			slot17.hasGet = gohelper.findChild(slot15, "go_receive")
			slot6.rewardItems[slot13] = slot17
		end

		gohelper.setActive(slot8, false)

		slot0._tipItems[slot4] = slot6
	end
end

function slot0._refreshTip(slot0)
	slot1 = true

	for slot5, slot6 in ipairs(slot0.missionCO) do
		slot7 = Activity160Model.instance:isMissionFinish(slot0.actId, slot5)

		gohelper.setActive(slot0._progressGoList[slot5], slot7)

		if not slot7 then
			slot1 = false
		end

		slot8 = Activity160Model.instance:isMissionCanGet(slot0.actId, slot5)

		if slot0._tipItems[slot5] then
			for slot13, slot14 in ipairs(slot9.rewardItems) do
				gohelper.setActive(slot14.hasGet, slot7)
			end

			slot9.txtNum.text = slot7 and "<color=#726D6A>1/1</color>" or slot8 and "<color=#E5DBD4>1/1</color>" or "<color=#DA7374>0/1</color>"
			slot9.txtDescr.text = string.format("<color=%s>%s</color>", slot7 and "#726D6A" or "#E5DBD4", slot6.desc)
		end
	end

	gohelper.setActive(slot0._goSchedule, not slot1)
end

return slot0
