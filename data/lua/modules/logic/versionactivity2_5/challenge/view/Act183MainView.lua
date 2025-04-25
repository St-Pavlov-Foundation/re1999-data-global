module("modules.logic.versionactivity2_5.challenge.view.Act183MainView", package.seeall)

slot0 = class("Act183MainView", BaseView)
slot1 = 7
slot2 = 30
slot3 = 1

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "root/left/#txt_time")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/#btn_reward")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "root/left/#btn_reward/#go_taskreddot")
	slot0._btnrecord = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/#btn_record")
	slot0._btnmedal = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/#btn_medal")
	slot0._gomedalreddot = gohelper.findChild(slot0.viewGO, "root/left/#btn_medal/#go_medalreddot")
	slot0._gomain = gohelper.findChild(slot0.viewGO, "root/middle/#go_main")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "root/middle/#go_main/#go_normal")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "root/middle/#go_main/#go_hard")
	slot0._btnentermain = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/middle/#btn_entermain")
	slot0._scrolldaily = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#scroll_daily")
	slot0._godailyitem = gohelper.findChild(slot0.viewGO, "root/right/#scroll_daily/Viewport/Content/#go_dailyitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnrecord:AddClickListener(slot0._btnrecordOnClick, slot0)
	slot0._btnmedal:AddClickListener(slot0._btnmedalOnClick, slot0)
	slot0._btnentermain:AddClickListener(slot0._btnentermainOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
	slot0._btnrecord:RemoveClickListener()
	slot0._btnmedal:RemoveClickListener()
	slot0._btnentermain:RemoveClickListener()
end

function slot0._btnrewardOnClick(slot0)
	Act183Controller.instance:openAct183TaskView()
end

function slot0._btnrecordOnClick(slot0)
	Act183Controller.instance:openAct183ReportView()
end

function slot0._btnmedalOnClick(slot0)
	Act183Controller.instance:openAct183BadgeView()
end

function slot0._btnentermainOnClick(slot0)
	if not slot0._mainGroupEpisodeTab[Act183Helper.getLastEnterMainGroupTypeInLocal(slot0._actId, Act183Enum.GroupType.NormalMain)] then
		return
	end

	if slot2:getStatus() == Act183Enum.GroupStatus.Locked and slot1 ~= Act183Enum.GroupType.NormalMain then
		logError(string.format("本地标记的上一次进入关卡组未解锁!!!, 保底进入普通日常关卡。lastEnterGroupType = %s, status = %s", slot1, slot3))

		slot2 = slot0._mainGroupEpisodeTab[Act183Enum.GroupType.NormalMain]
	end

	Act183Controller.instance:openAct183DungeonView(Act183Helper.generateDungeonViewParams(slot2 and slot2:getGroupType(), slot2 and slot2:getGroupId()))
end

function slot0._editableInitView(slot0)
	slot0._mainItemTab = slot0:getUserDataTb_()
	slot0._dailyItemTab = slot0:getUserDataTb_()
	slot0._actId = Act183Model.instance:getActivityId()
	slot0._info = Act183Model.instance:getActInfo()

	Act183Model.instance:initTaskStatusMap()

	slot0._rewardReddotAnim = gohelper.findChildComponent(slot0._btnreward.gameObject, "ani", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(slot0._gotaskreddot, RedDotEnum.DotNode.V2a5_Act183Task, nil, slot0._taskReddotFunc, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.RefreshMedalReddot, slot0.initOrRefreshMedalReddot, slot0)

	slot0._hasPlayUnlockAnimGroupIds = Act183Helper.getUnlockGroupIdsInLocal(slot0._actId)
	slot0._hasPlayUnlockAnimGroupIdMap = Act183Helper.listToMap(slot0._hasPlayUnlockAnimGroupIds)
end

function slot0._taskReddotFunc(slot0, slot1)
	slot1:defaultRefreshDot()
	slot0._rewardReddotAnim:Play(slot1.show and "loop" or "idle", 0, 0)
end

function slot0.onOpen(slot0)
	slot0:initRemainTime()
	slot0:initMainChapters()
	slot0:initDailyChapters()
	slot0:startCheckDailyGroupUnlock()
	slot0:initOrRefreshMedalReddot()
end

function slot0.startCheckDailyGroupUnlock(slot0)
	TaskDispatcher.cancelTask(slot0.checkDailyGroupUnlock, slot0)
	TaskDispatcher.runRepeat(slot0.checkDailyGroupUnlock, slot0, uv0)
end

function slot0.checkDailyGroupUnlock(slot0)
	if slot0._dailyGroupEpisodeCount <= slot0._unlockGroupEpisodeCount then
		TaskDispatcher.cancelTask(slot0.checkDailyGroupUnlock, slot0)

		return
	end

	slot0:initDailyChapters()
end

function slot0.initRemainTime(slot0)
	slot0:showLeftTime()
	TaskDispatcher.runRepeat(slot0.showLeftTime, slot0, uv0)
end

function slot0.showLeftTime(slot0)
	slot0._txttime.text = ActivityHelper.getActivityRemainTimeStr(slot0._actId)
end

function slot0.initMainChapters(slot0)
	slot2 = slot0._info:getGroupEpisodeMos(Act183Enum.GroupType.HardMain)
	slot4 = slot2 and slot2[1]

	if not slot0._info:getGroupEpisodeMos(Act183Enum.GroupType.NormalMain) or not slot1[1] or not slot4 then
		return
	end

	slot0._mainGroupEpisodeTab = {
		[Act183Enum.GroupType.NormalMain] = slot3,
		[Act183Enum.GroupType.HardMain] = slot4
	}

	for slot8, slot9 in pairs(slot0._mainGroupEpisodeTab) do
		slot0:_refreshMainGroupEpisodeItem(slot0:_getMainGroupEpisodeItem(slot8), slot9)
	end
end

function slot0._getMainGroupEpisodeItem(slot0, slot1)
	if not slot0._mainItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = slot0[slot1 == Act183Enum.GroupType.NormalMain and "_gonormal" or "_gohard"]
		slot2.goresult = gohelper.findChild(slot2.viewGO, "go_result")
		slot2.txttitle = gohelper.findChildText(slot2.viewGO, "txt_title")
		slot2.txttotalprogress = gohelper.findChildText(slot2.viewGO, "go_result/txt_totalprogress")
		slot2.golock = gohelper.findChild(slot2.viewGO, "go_lock")
		slot2.animlock = gohelper.onceAddComponent(slot2.golock, gohelper.Type_Animator)
		slot0._mainItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._refreshMainGroupEpisodeItem(slot0, slot1, slot2)
	slot4 = slot2:getStatus() ~= Act183Enum.GroupStatus.Locked

	gohelper.setActive(slot1.golock, not slot4)
	gohelper.setActive(slot1.goresult, slot4)

	if slot4 then
		slot8, slot9 = Act183Helper.getGroupEpisodeTaskProgress(slot2:getGroupId())
		slot1.txttotalprogress.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_finished"), slot9, slot8)

		if slot2:getGroupType() ~= Act183Enum.GroupType.NormalMain then
			slot0:checkPlayUnlockAnim(slot6, slot4, slot3 == Act183Enum.GroupStatus.Finished, slot1.golock, slot1.animlock)
		end
	end
end

function slot0.initDailyChapters(slot0)
	slot0._dailyGroupEpisodeMos = slot0._info:getGroupEpisodeMos(Act183Enum.GroupType.Daily)
	slot0._dailyGroupEpisodeCount = slot0._dailyGroupEpisodeMos and #slot0._dailyGroupEpisodeMos or 0
	slot0._unlockGroupEpisodeCount = 0

	if not slot0._dailyGroupEpisodeMos then
		return
	end

	slot1 = {
		[slot8] = true
	}

	for slot6, slot7 in ipairs(slot0._dailyGroupEpisodeMos) do
		slot2 = 0 + 1

		if slot0:_refreshDailyGroupItem(slot6, slot0:_getOrCreateDailyGroupItem(slot6), slot7) then
			slot0._unlockGroupEpisodeCount = slot0._unlockGroupEpisodeCount + 1
		else
			break
		end
	end

	if slot2 < uv0 then
		for slot6 = slot2 + 1, uv0 do
			slot7 = slot0:_getOrCreateDailyGroupItem(slot6)

			slot0:_refreshDailyGroupItem(slot6, slot7)

			slot1[slot7] = true
		end
	end

	for slot6, slot7 in pairs(slot0._dailyItemTab) do
		if not slot1[slot7] then
			gohelper.setActive(slot7.viewGO, false)
		end
	end
end

function slot0._getOrCreateDailyGroupItem(slot0, slot1)
	if not slot0._dailyItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._godailyitem, "daily_" .. slot1)
		slot2.golock = gohelper.findChild(slot2.viewGO, "go_lock")
		slot2.gounlock = gohelper.findChild(slot2.viewGO, "go_unlock")
		slot2.goempty = gohelper.findChild(slot2.viewGO, "go_Empty")
		slot2.gofinish = gohelper.findChild(slot2.viewGO, "go_unlock/go_Finished")
		slot2.txtunlocktime = gohelper.findChildText(slot2.viewGO, "go_lock/txt_unlocktime")
		slot2.txtindex = gohelper.findChildText(slot2.viewGO, "go_unlock/txt_index")
		slot2.txtprogress = gohelper.findChildText(slot2.viewGO, "go_unlock/txt_progress")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._onClickDailyGroupItem, slot0, slot1)

		slot2.animlock = gohelper.onceAddComponent(slot2.golock, gohelper.Type_Animator)
		slot2.animfinish = gohelper.onceAddComponent(slot2.gofinish, gohelper.Type_Animator)
		slot0._dailyItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onClickDailyGroupItem(slot0, slot1)
	if not slot0._dailyGroupEpisodeMos[slot1] then
		return
	end

	if slot2:getStatus() == Act183Enum.GroupStatus.Locked then
		GameFacade.showToast(ToastEnum.Act183GroupNotOpen)

		return
	end

	Act183Controller.instance:openAct183DungeonView(Act183Helper.generateDungeonViewParams(Act183Enum.GroupType.Daily, slot2:getGroupId()))
end

function slot0._refreshDailyGroupItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot2.viewGO, true)
	gohelper.setActive(slot2.goempty, slot3 == nil)

	if not slot3 then
		gohelper.setActive(slot2.golock, false)
		gohelper.setActive(slot2.gounlock, false)

		return
	end

	slot4 = slot3:getGroupId()
	slot6 = slot3:getStatus() == Act183Enum.GroupStatus.Locked

	gohelper.setActive(slot2.golock, slot6)
	gohelper.setActive(slot2.gounlock, not slot6)

	slot7 = false

	if slot6 then
		slot8, slot9 = TimeUtil.secondToRoughTime(slot3:getUnlockRemainTime())
		slot2.txtunlocktime.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_unlock"), slot8, slot9)
	else
		slot8, slot9 = Act183Helper.getGroupEpisodeTaskProgress(slot4)
		slot7 = slot8 <= slot9
		slot2.txtindex.text = string.format("<color=#E1E1E14D>RT</color><color=#E1E1E180><size=77>%s</size></color>", slot1)
		slot2.txtprogress.text = string.format("%s/%s", slot9, slot8)

		gohelper.setActive(slot2.gofinish, slot7)
		slot0:checkPlayUnlockAnim(slot4, true, slot7, slot2.golock, slot2.animlock)
	end

	return not slot6
end

function slot0.checkPlayUnlockAnim(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot1 or not slot4 or not slot5 or not slot2 or slot3 then
		return
	end

	if not slot0._hasPlayUnlockAnimGroupIdMap[slot1] then
		gohelper.setActive(slot4, true)
		slot5:Play("unlock", 0, 0)
		table.insert(slot0._hasPlayUnlockAnimGroupIds, slot1)

		slot0._hasPlayUnlockAnimGroupIdMap[slot1] = true
	end
end

function slot0.releaseDailyGroupItems(slot0)
	if slot0._dailyItemTab then
		for slot4, slot5 in pairs(slot0._dailyItemTab) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.initOrRefreshMedalReddot(slot0)
	if not slot0._medatReddot then
		slot0._medatReddot = RedDotController.instance:addNotEventRedDot(slot0._gomedalreddot, slot0._checkMedalReddot, slot0, RedDotEnum.Style.Normal)
	end

	slot0._medatReddot:refreshRedDot()
end

function slot0._checkMedalReddot(slot0)
	slot2 = Act183Helper.listToMap(Act183Helper.getHasReadUnlockSupportHeroIdsInLocal(slot0._actId))

	if slot0._info:getUnlockSupportHeroIds() then
		for slot7, slot8 in ipairs(slot3) do
			if not slot2[slot8] then
				return true
			end
		end
	end
end

function slot0.onClose(slot0)
	Act183Helper.saveUnlockGroupIdsInLocal(slot0._actId, slot0._hasPlayUnlockAnimGroupIds)
	TaskDispatcher.cancelTask(slot0.showLeftTime, slot0)
	TaskDispatcher.cancelTask(slot0.checkDailyGroupUnlock, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:releaseDailyGroupItems()
end

return slot0
