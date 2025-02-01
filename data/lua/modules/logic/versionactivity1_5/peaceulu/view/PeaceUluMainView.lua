module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluMainView", package.seeall)

slot0 = class("PeaceUluMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "left/remaintime/bg/#txt_remaintime")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "left/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "left/#txt_desc")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "right/progress/#scroll_view")
	slot0._imgfill = gohelper.findChildImage(slot0.viewGO, "right/progress/#scroll_view/Viewport/Content/fill/#go_fill")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "right/progress/#scroll_view/Viewport/Content")
	slot0._goprogressitem = gohelper.findChild(slot0.viewGO, "right/progress/#scroll_view/Viewport/Content/#go_progressitem")
	slot0._txtschedule = gohelper.findChildText(slot0.viewGO, "right/progress/bg/#txt_schedule")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.bonusItemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._updateUI, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:addEventCb(PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, slot0._updateUI, slot0)
	slot0:addEventCb(PeaceUluController.instance, PeaceUluEvent.onSwitchTab, slot0._toSwitchTab, slot0)
	slot0:addEventCb(slot0.viewContainer, PeaceUluEvent.onFinishTask, slot0.playFinishAnim, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._updateUI, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, slot0._updateUI, slot0)
	slot0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.onSwitchTab, slot0._toSwitchTab, slot0)
	slot0:removeEventCb(slot0.viewContainer, PeaceUluEvent.onFinishTask, slot0.playFinishAnim, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.onOpen(slot0)
	slot0._animator:Play(UIAnimationName.Open, 0, 0)
	slot0._animator:Update(0)
	slot0:_initBonus()
	slot0:_initTaskMoList(true)

	if not string.nilorempty(PeaceUluModel.instance:getLastGameRecord()) then
		GameFacade.showToast(ToastEnum.PeaceUluMainViewTips, slot1)
		PeaceUluRpc.instance:sendAct145ClearGameRecordRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	end

	slot0:_refreshRemainTime()
	slot0:_checkCanGetReward()
	slot0:_refreshSchedule()
end

function slot0._refreshRemainTime(slot0)
	slot0._txtremaintime.text = formatLuaLang("remain", ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.PeaceUlu]:getRemainTimeStr3())
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CharacterBackpackView then
		PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	end
end

function slot0._editableInitView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "right/#scroll_task"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0.viewContainer:getSetting().otherRes[1]
	slot1.cellClass = PeaceUluTaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1160
	slot1.cellHeight = 160
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot0._csListView = SLFramework.UGUI.ListScrollView.Get(gohelper.findChild(slot0.viewGO, "right/#scroll_task"))
	slot0._scrolltaskview = LuaListScrollView.New(PeaceUluTaskModel.instance, slot1)

	slot0:addChildView(slot0._scrolltaskview)

	slot0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0._scrolltaskview)

	slot0._taskAnimRemoveItem:setMoveInterval(0)
	slot0._taskAnimRemoveItem:setMoveAnimationTime(PeaceUluEnum.TaskMaskTime - PeaceUluEnum.TaskGetAnimTime)
end

function slot0.playFinishAnim(slot0, slot1)
	if slot1 then
		slot0._tweenIndexes = {
			slot1
		}
	end

	TaskDispatcher.runDelay(slot0.delayPlayFinishAnim, slot0, PeaceUluEnum.TaskGetAnimTime)
end

function slot0.delayPlayFinishAnim(slot0)
	slot0._taskAnimRemoveItem:removeByIndexs(slot0._tweenIndexes)
end

function slot0._initBonus(slot0)
	for slot7, slot8 in ipairs(PeaceUluConfig.instance:getBonusCoList()) do
		if not slot0.bonusItemList[slot7] then
			slot9 = PeaceUluProgressItem.New()

			slot9:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], gohelper.findChild(slot0._scrollview.gameObject, "Viewport/Content"), "bonus" .. slot7).gameObject)
			slot9:initMo(slot7, slot8)
			table.insert(slot0.bonusItemList, slot9)
		end

		slot9:refreshProgress()
	end
end

function slot0._updateUI(slot0)
	slot0:_refreshSchedule()
	slot0:_checkCanGetReward()
	slot0:refreshBonusItem()
	slot0:_initTaskMoList()
	slot0:_refreshRemainTime()
end

function slot0._refreshSchedule(slot0)
	slot0._imgfill.fillAmount = PeaceUluModel.instance:getSchedule()
	slot0._txtschedule.text = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity .. "/" .. PeaceUluConfig.instance:getMaxProgress()
	slot3 = slot0:_getnextIndex() - 1
	slot6 = (268 - 40) * slot3 - (slot3 > 0 and 174 or 0)

	if slot0._dotweenId then
		ZProj.TweenHelper.KillById(slot0._dotweenId)

		slot0._dotweenId = nil
	end

	slot0._dotweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._goContent.transform, -slot6, 0.2)
end

function slot0._getnextIndex(slot0)
	for slot6, slot7 in ipairs(PeaceUluConfig.instance:getBonusCoList()) do
		if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity <= tonumber(string.split(slot7.needProgress, "#")[3]) then
			return slot6
		end
	end

	return #slot1
end

function slot0._checkCanGetReward(slot0)
	for slot6, slot7 in ipairs(PeaceUluConfig.instance:getBonusCoList()) do
		if tonumber(string.split(slot7.needProgress, "#")[3]) <= CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity and not PeaceUluModel.instance:checkGetReward(slot7.id) then
			PeaceUluRpc.instance:sendAct145GetRewardsRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)

			break
		end
	end
end

function slot0._initTaskMoList(slot0, slot1)
	PeaceUluTaskModel.instance:sortTaskMoList(slot1)
end

function slot0.refreshBonusItem(slot0)
	for slot4, slot5 in ipairs(slot0.bonusItemList) do
		slot5:refreshProgress()
	end
end

function slot0._onDailyRefresh(slot0)
	PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
end

function slot0._toSwitchTab(slot0, slot1)
	slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayFinishAnim, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.bonusItemList) do
		slot5:onDestroyView()
	end
end

return slot0
