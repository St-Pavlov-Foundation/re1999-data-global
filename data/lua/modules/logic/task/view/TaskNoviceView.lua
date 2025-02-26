module("modules.logic.task.view.TaskNoviceView", package.seeall)

slot0 = class("TaskNoviceView", BaseView)

function slot0.onInitView(slot0)
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_right")
	slot0._gotaskitemcontent = gohelper.findChild(slot0.viewGO, "#go_right/viewport/#go_taskitemcontent")
	slot0._gogrowitemcontent = gohelper.findChild(slot0.viewGO, "#go_right/viewport/#go_taskitemcontent/#go_growitemcontent")
	slot0._gogrowtip = gohelper.findChild(slot0.viewGO, "#go_right/viewport/#go_taskitemcontent/#go_growitemcontent/#go_growtip")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_left/#simage_leftbg")
	slot0._simageren = gohelper.findChildSingleImage(slot0.viewGO, "#go_left/#simage_ren")
	slot0._btnshowdetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/title/#btn_showdetail")
	slot0._gotex = gohelper.findChild(slot0.viewGO, "#go_left/title/ani/tex")
	slot0._gotexzh = gohelper.findChild(slot0.viewGO, "#go_left/title/ani/tex_zh")
	slot0._goactlist = gohelper.findChild(slot0.viewGO, "#go_left/act/actlistscroll/Viewport/#go_actlist")
	slot0._goactitem = gohelper.findChild(slot0.viewGO, "#go_left/act/actlistscroll/Viewport/#go_actlist/#go_actitem")
	slot0._txtstagename = gohelper.findChildText(slot0.viewGO, "#go_left/#txt_stagename")
	slot0._goflag = gohelper.findChild(slot0.viewGO, "#go_left/curprogresslist/#go_flag")
	slot0._txtcurprogress = gohelper.findChildText(slot0.viewGO, "#go_left/#txt_stagename/#txt_curprogress")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_left/rewardscroll/Viewport/#go_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_left/rewardscroll/Viewport/#go_rewards/#go_rewarditem")
	slot0._golingqumax = gohelper.findChild(slot0.viewGO, "#go_left/#lingqumax")
	slot0._gohasreceive = gohelper.findChild(slot0.viewGO, "#go_left/#go_hasreceive")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshowdetail:AddClickListener(slot0._btnshowDetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshowdetail:RemoveClickListener()
end

function slot0._btnshowDetailOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, 302303, false, nil, false)
end

function slot0._onUpdateTaskList(slot0)
	for slot6 = 1, #TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice) do
		if slot1[slot6].config.minTypeId == TaskEnum.TaskMinType.GrowBack then
			slot2 = 0 + 1
		end
	end

	TaskModel.instance:setNoviceTaskCurStage(TaskModel.instance:getNoviceTaskMaxUnlockStage())
	TaskDispatcher.runDelay(slot0._onCheckRefreshNovice, slot0, 0.2)
end

function slot0._onCheckRefreshNovice(slot0)
	if TaskModel.instance:couldGetTaskNoviceStageReward() then
		return
	end

	slot0:_refreshNovice()
end

function slot0._onPlayActState(slot0, slot1)
	if slot1.taskType ~= TaskEnum.TaskType.Novice then
		return
	end

	if slot1.force then
		slot0:_refreshNovice()

		return
	end

	if slot1.growCount then
		gohelper.setActive(slot0._gogrowitemcontent, slot1.growCount > 1)
		gohelper.setActive(slot0._gogrowtip, slot1.growCount > 1)
	end

	TaskDispatcher.cancelTask(slot0._flagPlayUpdate, slot0)

	if slot1.num < 1 then
		return
	end

	slot3 = TaskModel.instance:getNoviceTaskCurSelectStage()

	if TaskModel.instance:getNoviceTaskCurStage() < TaskModel.instance:getNoviceTaskMaxUnlockStage() then
		return
	end

	if slot4 < slot3 then
		TaskModel.instance:setNoviceTaskCurStage(slot4)
		TaskModel.instance:setNoviceTaskCurSelectStage(slot4)
		slot0:_refreshStageInfo()
		slot0:_refreshActItem()
		slot0:_refreshProgressItem()
	end

	slot7 = 0
	slot7 = TaskModel.instance:getCurStageMaxActDot() < TaskModel.instance:getCurStageActDotGetNum() + slot1.num and slot5 + slot1.num - slot6 or slot1.num
	slot0._totalAct = slot5 + slot7

	if slot7 > 0 then
		slot0._flagPlayCount = 0

		TaskDispatcher.runRepeat(slot0._flagPlayUpdate, slot0, 0.06, slot7)
	end
end

function slot0._flagPlayUpdate(slot0)
	slot1 = TaskModel.instance:getCurStageActDotGetNum()
	slot2 = TaskModel.instance:getCurStageMaxActDot()
	slot0._flagPlayCount = slot0._flagPlayCount + 1

	gohelper.setActive(slot0._noviceFlags[slot0._flagPlayCount + slot1].go, true)
	slot0._noviceFlags[slot0._flagPlayCount + slot1].ani:Play("play")

	if slot0._totalAct <= slot0._flagPlayCount + slot1 then
		TaskDispatcher.cancelTask(slot0._flagPlayUpdate, slot0)

		for slot6 = slot1, slot0._totalAct - 1 do
			UISpriteSetMgr.instance:setCommonSprite(slot0._noviceFlags[slot6 + 1].img, "logo_huoyuedu")
		end
	end
end

function slot0._editableInitView(slot0)
	slot0._noviceTaskAni = slot0._goleft:GetComponent(typeof(UnityEngine.Animator))
	slot0._noviceReceiveAni = slot0._gohasreceive:GetComponent(typeof(UnityEngine.Animator))

	slot0._simageleftbg:LoadImage(ResUrl.getTaskBg("bg_yusijia"))
	slot0._simageren:LoadImage(ResUrl.getTaskBg("bg_yusijiaren"))

	slot0._taskItems = {}
	slot0._actItems = {}
	slot0._pointItems = {}
	slot0._extraRewardItems = {}
	slot0._initActPos = transformhelper.getLocalPos(slot0._goactlist.transform)

	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.RefreshActState, slot0._onPlayActState, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._onGetBonus, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, slot0._onShowTaskFinished, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnRefreshActItem, slot0._onRefreshRewardActItem, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	slot2 = false

	if LangSettings.instance:getCurLangShortcut() == "zh" or slot1 == "tw" then
		slot2 = true
	end

	gohelper.setActive(slot0._gotex, not slot2)
	gohelper.setActive(slot0._gotexzh, slot2)
end

function slot0._onRefreshRewardActItem(slot0, slot1)
	slot3 = TaskModel.instance:getNoviceTaskCurStage()

	if TaskModel.instance:getNoviceTaskMaxUnlockStage() < TaskModel.instance:getNoviceTaskCurSelectStage() then
		slot0:_refreshStageInfo()
		slot0:_refreshActItem()
		slot0:_refreshProgressItem()
		TaskModel.instance:setNoviceTaskCurStage(slot4)

		if slot1 and not slot1.isFinishClick then
			TaskDispatcher.runDelay(slot0._setNoviceTaskItem, slot0, 0.5)

			return
		end
	end

	if not slot1 or not slot1.isActClick then
		if not TaskModel.instance:couldGetTaskNoviceStageReward() then
			TaskModel.instance:setNoviceTaskCurSelectStage(slot4)
			TaskModel.instance:setNoviceTaskCurStage(slot4)
		end

		slot0:_refreshStageInfo()
		slot0:_refreshActItem()
		slot0:_refreshProgressItem()
		TaskModel.instance:setNoviceTaskCurSelectStage(slot4)
		TaskModel.instance:setNoviceTaskCurStage(slot4)

		if TaskModel.instance:couldGetTaskNoviceStageReward() then
			return
		end

		TaskDispatcher.runDelay(slot0._setNoviceTaskItem, slot0, 0.5)

		return
	end

	slot0:_refreshStageInfo()
	slot0:_refreshActItem()
	slot0:_refreshProgressItem()
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshNovice()
end

function slot0.onOpen(slot0)
	TaskModel.instance:setHasTaskNoviceStageReward(false)

	if TaskModel.instance:getRefreshCount() == 0 and TaskView.getInitTaskType() ~= TaskEnum.TaskType.Novice then
		return
	end

	TaskModel.instance:setNoviceTaskCurSelectStage(TaskModel.instance:getNoviceTaskCurStage())

	if #slot0._taskItems < 1 then
		slot0:_refreshNovice()
	end
end

function slot0._onShowTaskFinished(slot0, slot1)
	if slot1 == TaskEnum.TaskType.Novice then
		return
	end

	slot0:_refreshNovice()
end

function slot0._onFinishTask(slot0, slot1)
	if not TaskConfig.instance:gettaskNoviceConfig(slot1) then
		return
	end

	TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem, {
		isFinishClick = true
	})
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView or slot1 == ViewName.CharacterSkinGainView then
		if TaskModel.instance:couldGetTaskNoviceStageReward() and PopupController.instance:getPopupCount() == 0 then
			TaskDispatcher.runDelay(slot0._onWaitShowGetStageReward, slot0, 0.1)
		end
	end
end

function slot0._onWaitShowGetStageReward(slot0)
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return
	end

	gohelper.setActive(slot0._golingqumax, true)
	UIBlockMgr.instance:startBlock("taskstageani")
	TaskDispatcher.runDelay(slot0._showStageReward, slot0, 1.3)
end

function slot0._showStageReward(slot0)
	UIBlockMgr.instance:endBlock("taskstageani")
	gohelper.setActive(slot0._golingqumax, false)

	slot1 = TaskModel.instance:getNoviceTaskMaxUnlockStage()

	TaskModel.instance:setNoviceTaskCurSelectStage(slot1)

	slot2 = {}
	slot7 = nil

	for slot11, slot12 in ipairs(string.split(TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, slot1 == TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice) and TaskModel.instance:getStageMaxActDot(slot1) <= TaskModel.instance:getStageActDotGetNum(slot1) and slot1 or slot1 - 1).bonus, "|")) do
		if string.splitToNumber(slot12, "#")[1] == MaterialEnum.MaterialType.PowerPotion then
			for slot18, slot19 in pairs(ItemPowerModel.instance:getLatestPowerChange()) do
				if tonumber(slot19.itemid) == tonumber(slot12.materilId) then
					slot7 = slot19.uid
				end
			end
		end

		MaterialDataMO.New():initValue(slot13[1], slot13[2], slot13[3])

		if slot13[1] ~= MaterialEnum.MaterialType.Faith then
			table.insert(slot2, slot14)
		end
	end

	TaskModel.instance:setHasTaskNoviceStageReward(false)
	TaskDispatcher.runDelay(slot0._onCheckRefreshNovice, slot0, 0.2)

	if TaskModel.instance:getTaskNoviceStageParam() then
		TaskController.instance:getRewardByLine(MaterialEnum.GetApproach.NoviceStageReward, ViewName.CharacterSkinGainView, slot8)
		TaskModel.instance:setTaskNoviceStageHeroParam()
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot2)
end

function slot0._onGetBonus(slot0)
	TaskDispatcher.runDelay(slot0._onCheckRefreshNovice, slot0, 0.1)
end

function slot0._refreshNovice(slot0)
	slot1 = TaskModel.instance:getRefreshCount() < 2
	slot0._noviceTaskAni.enabled = slot1

	slot0:_refreshStageInfo(slot1)
	slot0:_refreshActItem(slot1)
	slot0:_refreshProgressItem(slot1)
	slot0:_setNoviceTaskItem(slot1)
end

function slot0._refreshStageInfo(slot0, slot1)
	slot2 = TaskModel.instance:getNoviceTaskCurSelectStage()
	slot6 = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, slot2)

	if not TaskModel.instance:couldGetTaskNoviceStageReward() and (slot2 < TaskModel.instance:getNoviceTaskMaxUnlockStage() and true or TaskModel.instance:getStageMaxActDot(slot2) <= TaskModel.instance:getStageActDotGetNum(slot2)) then
		gohelper.setActive(slot0._gohasreceive, true)

		if slot1 then
			slot0._noviceReceiveAni:Play(UIAnimationName.Open)
		else
			slot0._noviceReceiveAni:Play(UIAnimationName.Idle)
		end
	else
		gohelper.setActive(slot0._gohasreceive, false)
	end

	slot0._txtstagename.text = slot6.desc
	slot0._extraRewardItems = slot0._extraRewardItems or {}

	for slot13 = 1, #string.split(slot6.bonus, "|") do
		if not slot0._extraRewardItems[slot13] then
			slot14 = {
				parentGo = gohelper.cloneInPlace(slot0._gorewarditem)
			}
			slot14.itemGo = gohelper.findChild(slot14.parentGo, "rewarditem")
			slot14.canvasGroup = slot14.itemGo:GetComponent(typeof(UnityEngine.CanvasGroup))
			slot14.itemIcon = IconMgr.instance:getCommonItemIcon(slot14.itemGo)

			table.insert(slot0._extraRewardItems, slot14)
		end

		gohelper.setActive(slot14.parentGo, true)

		slot15 = string.splitToNumber(slot9[slot13], "#")

		slot14.itemIcon:setMOValue(slot15[1], slot15[2], slot15[3], nil, true)
		slot14.itemIcon:isShowCount(slot15[1] ~= MaterialEnum.MaterialType.Hero)
		slot14.itemIcon:setCountFontSize(45)
		slot14.itemIcon:showStackableNum2()
		slot14.itemIcon:hideEquipLvAndCount()

		slot14.canvasGroup.alpha = slot8 and 0.7 or 1

		slot14.itemIcon:setItemColor(slot8 and "#3F3F3F" or nil)
	end

	for slot13 = #slot9 + 1, #slot0._extraRewardItems do
		gohelper.setActive(slot0._extraRewardItems[slot13].parentGo, false)
	end
end

function slot0._refreshActItem(slot0, slot1)
	for slot5, slot6 in pairs(slot0._actItems) do
		slot6:destroy()
	end

	slot0._actItems = {}
	slot3 = nil

	for slot7 = 1, TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice) do
		slot3 = TaskNoviceActItem.New()

		slot3:init(gohelper.cloneInPlace(slot0._goactitem), slot7)
		table.insert(slot0._actItems, slot3)
	end

	if slot0._actTweenId then
		ZProj.TweenHelper.KillById(slot0._actTweenId)
	end

	TaskDispatcher.runDelay(slot0._showActItems, slot0, 0.1)
end

function slot0._showActItems(slot0)
	slot3 = 0

	if TaskModel.instance:getNoviceTaskCurSelectStage() >= TaskModel.instance:getMaxStage(TaskEnum.TaskType.Novice) - 1 then
		slot5 = slot0._goactlist:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
		slot6 = slot5.spacing
		slot3 = transformhelper.getLocalPos(slot0._actItems[slot2 - 3].go.transform) - transformhelper.getLocalPos(slot0._actItems[1].go.transform) + 4 * recthelper.getWidth(slot0._actItems[1].go.transform) + 3 * slot5.spacing + slot5.padding.left - recthelper.getWidth(gohelper.findChild(slot0.viewGO, "#go_left/act/actlistscroll").transform)
	elseif slot1 > 1 then
		slot3 = transformhelper.getLocalPos(slot0._actItems[slot1 - 1].go.transform) - transformhelper.getLocalPos(slot0._actItems[1].go.transform)
	end

	if slot0._hasEnterNovice then
		slot0._actTweenId = ZProj.TweenHelper.DOLocalMoveX(slot0._goactlist.transform, slot0._initActPos - slot3, 0.5)
	else
		slot0._hasEnterNovice = true

		transformhelper.setLocalPosXY(slot0._goactlist.transform, slot0._initActPos - slot3, 0)
	end
end

function slot0._refreshProgressItem(slot0, slot1)
	if slot0._noviceFlags then
		for slot5, slot6 in pairs(slot0._noviceFlags) do
			gohelper.destroy(slot6.go)
		end
	end

	slot0._noviceFlags = slot0:getUserDataTb_()
	slot2 = TaskModel.instance:getNoviceTaskCurStage()
	slot3 = TaskModel.instance:getNoviceTaskCurSelectStage()
	slot7 = slot3 < TaskModel.instance:getNoviceTaskMaxUnlockStage() and TaskModel.instance:getStageMaxActDot(slot3) or TaskModel.instance:getStageActDotGetNum(slot3)

	if slot4 < slot3 then
		slot6 = TaskModel.instance:getStageActDotGetNum(slot3)
		slot5 = TaskModel.instance:getStageMaxActDot(slot3)
		slot7 = 0
	end

	for slot11 = 1, slot5 do
		slot12 = gohelper.cloneInPlace(slot0._goflag)

		gohelper.setActive(slot12, not slot1)

		slot13 = {
			go = slot12
		}
		slot13.idle = gohelper.findChild(slot13.go, "idle")

		gohelper.setActive(slot13.idle, true)

		slot13.img = gohelper.findChildImage(slot13.go, "idle")
		slot14 = slot3 < slot4 and true or slot11 <= slot6

		if slot4 < slot3 then
			slot14 = false
		end

		UISpriteSetMgr.instance:setCommonSprite(slot13.img, slot14 and "logo_huoyuedu" or "logo_huoyuedu_dis")

		slot13.play = gohelper.findChild(slot13.go, "play")

		gohelper.setActive(slot13.play, false)

		slot13.ani = slot13.go:GetComponent(typeof(UnityEngine.Animator))

		slot13.ani:Play(UIAnimationName.Idle)
		table.insert(slot0._noviceFlags, slot13)
	end

	slot0._txtcurprogress.text = string.format("%s/%s", slot7, slot5)

	if slot1 then
		slot0._flagopenCount = 0

		TaskDispatcher.cancelTask(slot0._flagOpenUpdate, slot0)
		TaskDispatcher.runRepeat(slot0._flagOpenUpdate, slot0, 0.03, slot5)
	end
end

function slot0._flagOpenUpdate(slot0)
	slot0._flagopenCount = slot0._flagopenCount + 1

	gohelper.setActive(slot0._noviceFlags[slot0._flagopenCount].go, true)
	slot0._noviceFlags[slot0._flagopenCount].ani:Play(UIAnimationName.Open)
end

function slot0._setNoviceTaskItem(slot0, slot1)
	if slot0._taskItems then
		for slot5, slot6 in pairs(slot0._taskItems) do
			if slot6.go then
				slot6:destroy()
			end
		end

		slot0._taskItems = {}
	end

	gohelper.setActive(slot0._gogrowitemcontent, false)

	if slot1 then
		UIBlockMgr.instance:startBlock("taskani")

		slot0._repeatCount = 0

		TaskDispatcher.runRepeat(slot0.showByLine, slot0, 0.04, #TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice))
	else
		for slot6 = 1, #slot2 do
			table.insert(slot0._taskItems, slot0:getItem(slot2[slot6], slot6, false))
		end
	end
end

function slot0.showByLine(slot0)
	slot0._repeatCount = slot0._repeatCount + 1
	slot1 = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Novice)

	table.insert(slot0._taskItems, slot0:getItem(slot1[slot0._repeatCount], slot0._repeatCount, true))

	if slot0._repeatCount >= #slot1 then
		UIBlockMgr.instance:endBlock("taskani")
		TaskDispatcher.cancelTask(slot0.showByLine, slot0)
		TaskDispatcher.runDelay(slot0._onStartTaskFinished, slot0, 0.5)
	end
end

function slot0._onStartTaskFinished(slot0)
	TaskModel.instance:setRefreshCount(TaskModel.instance:getRefreshCount() + 1)
	TaskController.instance:dispatchEvent(TaskEvent.OnShowTaskFinished, TaskEnum.TaskType.Novice)
end

function slot0.getItem(slot0, slot1, slot2, slot3)
	slot4 = {}

	if slot1.type == TaskEnum.TaskType.Novice and slot1.config.chapter ~= 0 then
		slot6 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[4], slot0._gotaskitemcontent, "item" .. slot2)

		gohelper.setSiblingBefore(slot6, slot0._gogrowitemcontent)
		TaskListNoviceSpItem.New():init(slot6, slot2, slot1, slot3, slot0._goright)
	elseif slot1.config.minTypeId == TaskEnum.TaskMinType.GrowBack then
		gohelper.setActive(slot0._gogrowitemcontent, true)
		gohelper.setActive(slot0._gogrowtip, true)
		TaskListNoviceGrowItem.New():init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._gogrowitemcontent, "item" .. slot2), slot2, slot1, slot3, slot0._goright)
	else
		TaskListNoviceNormalItem.New():init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gotaskitemcontent, "item" .. slot2), slot2, slot1, slot3, slot0._goright)
	end

	return slot4
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("taskstageani")
	TaskModel.instance:setNoviceTaskCurStage(0)

	if slot0._extraRewardItems then
		for slot4, slot5 in pairs(slot0._extraRewardItems) do
			gohelper.destroy(slot5.itemIcon.go)
			gohelper.destroy(slot5.parentGo)
			slot5.itemIcon:onDestroy()
		end

		slot0._extraRewardItems = nil
	end

	slot0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._onUpdateTaskList, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.RefreshActState, slot0._onPlayActState, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._onGetBonus, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnShowTaskFinished, slot0._onShowTaskFinished, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnRefreshActItem, slot0._onRefreshRewardActItem, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	TaskDispatcher.cancelTask(slot0._flagOpenUpdate, slot0)
	TaskDispatcher.cancelTask(slot0._flagPlayUpdate, slot0)
	TaskDispatcher.cancelTask(slot0._onCheckRefreshNovice, slot0)
	TaskDispatcher.cancelTask(slot0._showStageReward, slot0)
	TaskDispatcher.cancelTask(slot0._showActItems, slot0)
	TaskDispatcher.cancelTask(slot0._setNoviceTaskItem, slot0)
	TaskDispatcher.cancelTask(slot0._onWaitShowGetStageReward, slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simageren:UnLoadImage()

	if slot0._actTweenId then
		ZProj.TweenHelper.KillById(slot0._actTweenId)

		slot0._actTweenId = nil
	end

	if slot0._taskItems then
		for slot4, slot5 in ipairs(slot0._taskItems) do
			if slot5.go then
				slot5:destroy()
			end
		end

		slot0._taskItems = nil
	end

	if slot0._actItems then
		for slot4, slot5 in pairs(slot0._actItems) do
			slot5:destroy()
		end

		slot0._actItems = nil
	end

	if slot0._pointItems then
		for slot4, slot5 in pairs(slot0._pointItems) do
			slot5:destroy()
		end

		slot0._pointItems = nil
	end
end

return slot0
