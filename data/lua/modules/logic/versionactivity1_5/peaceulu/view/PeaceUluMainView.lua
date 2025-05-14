module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluMainView", package.seeall)

local var_0_0 = class("PeaceUluMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "left/remaintime/bg/#txt_remaintime")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_desc")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/progress/#scroll_view")
	arg_1_0._imgfill = gohelper.findChildImage(arg_1_0.viewGO, "right/progress/#scroll_view/Viewport/Content/fill/#go_fill")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "right/progress/#scroll_view/Viewport/Content")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "right/progress/#scroll_view/Viewport/Content/#go_progressitem")
	arg_1_0._txtschedule = gohelper.findChildText(arg_1_0.viewGO, "right/progress/bg/#txt_schedule")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.bonusItemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._updateUI, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0:addEventCb(PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, arg_2_0._updateUI, arg_2_0)
	arg_2_0:addEventCb(PeaceUluController.instance, PeaceUluEvent.onSwitchTab, arg_2_0._toSwitchTab, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, PeaceUluEvent.onFinishTask, arg_2_0.playFinishAnim, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._updateUI, arg_3_0)
	arg_3_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.OnUpdateInfo, arg_3_0._updateUI, arg_3_0)
	arg_3_0:removeEventCb(PeaceUluController.instance, PeaceUluEvent.onSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
	arg_3_0:removeEventCb(arg_3_0.viewContainer, PeaceUluEvent.onFinishTask, arg_3_0.playFinishAnim, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._animator:Play(UIAnimationName.Open, 0, 0)
	arg_4_0._animator:Update(0)
	arg_4_0:_initBonus()
	arg_4_0:_initTaskMoList(true)

	local var_4_0 = PeaceUluModel.instance:getLastGameRecord()

	if not string.nilorempty(var_4_0) then
		GameFacade.showToast(ToastEnum.PeaceUluMainViewTips, var_4_0)
		PeaceUluRpc.instance:sendAct145ClearGameRecordRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	end

	arg_4_0:_refreshRemainTime()
	arg_4_0:_checkCanGetReward()
	arg_4_0:_refreshSchedule()
end

function var_0_0._refreshRemainTime(arg_5_0)
	local var_5_0 = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.PeaceUlu]:getRemainTimeStr3()

	arg_5_0._txtremaintime.text = formatLuaLang("remain", var_5_0)
end

function var_0_0._onCloseViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.CharacterBackpackView then
		PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	end
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = ListScrollParam.New()

	var_7_0.scrollGOPath = "right/#scroll_task"
	var_7_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_7_0.prefabUrl = arg_7_0.viewContainer:getSetting().otherRes[1]
	var_7_0.cellClass = PeaceUluTaskItem
	var_7_0.scrollDir = ScrollEnum.ScrollDirV
	var_7_0.lineCount = 1
	var_7_0.cellWidth = 1160
	var_7_0.cellHeight = 160
	var_7_0.cellSpaceV = 0
	var_7_0.startSpace = 0
	arg_7_0._csListView = SLFramework.UGUI.ListScrollView.Get(gohelper.findChild(arg_7_0.viewGO, "right/#scroll_task"))
	arg_7_0._scrolltaskview = LuaListScrollView.New(PeaceUluTaskModel.instance, var_7_0)

	arg_7_0:addChildView(arg_7_0._scrolltaskview)

	arg_7_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_7_0._scrolltaskview)

	arg_7_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_7_0._taskAnimRemoveItem:setMoveAnimationTime(PeaceUluEnum.TaskMaskTime - PeaceUluEnum.TaskGetAnimTime)
end

function var_0_0.playFinishAnim(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0._tweenIndexes = {
			arg_8_1
		}
	end

	TaskDispatcher.runDelay(arg_8_0.delayPlayFinishAnim, arg_8_0, PeaceUluEnum.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_9_0)
	arg_9_0._taskAnimRemoveItem:removeByIndexs(arg_9_0._tweenIndexes)
end

function var_0_0._initBonus(arg_10_0)
	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes[2]
	local var_10_1 = gohelper.findChild(arg_10_0._scrollview.gameObject, "Viewport/Content")
	local var_10_2 = PeaceUluConfig.instance:getBonusCoList()

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_3 = arg_10_0.bonusItemList[iter_10_0]

		if not var_10_3 then
			local var_10_4 = arg_10_0:getResInst(var_10_0, var_10_1, "bonus" .. iter_10_0)

			var_10_3 = PeaceUluProgressItem.New()

			var_10_3:init(var_10_4.gameObject)
			var_10_3:initMo(iter_10_0, iter_10_1)
			table.insert(arg_10_0.bonusItemList, var_10_3)
		end

		var_10_3:refreshProgress()
	end
end

function var_0_0._updateUI(arg_11_0)
	arg_11_0:_refreshSchedule()
	arg_11_0:_checkCanGetReward()
	arg_11_0:refreshBonusItem()
	arg_11_0:_initTaskMoList()
	arg_11_0:_refreshRemainTime()
end

function var_0_0._refreshSchedule(arg_12_0)
	arg_12_0._imgfill.fillAmount = PeaceUluModel.instance:getSchedule()

	local var_12_0 = PeaceUluConfig.instance:getMaxProgress()
	local var_12_1 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity

	arg_12_0._txtschedule.text = var_12_1 .. "/" .. var_12_0

	local var_12_2 = arg_12_0:_getnextIndex() - 1
	local var_12_3 = 40
	local var_12_4 = (268 - var_12_3) * var_12_2 - (var_12_2 > 0 and 174 or 0)

	if arg_12_0._dotweenId then
		ZProj.TweenHelper.KillById(arg_12_0._dotweenId)

		arg_12_0._dotweenId = nil
	end

	arg_12_0._dotweenId = ZProj.TweenHelper.DOAnchorPosX(arg_12_0._goContent.transform, -var_12_4, 0.2)
end

function var_0_0._getnextIndex(arg_13_0)
	local var_13_0 = PeaceUluConfig.instance:getBonusCoList()
	local var_13_1 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_2 = string.split(iter_13_1.needProgress, "#")[3]

		if var_13_1 <= tonumber(var_13_2) then
			return iter_13_0
		end
	end

	return #var_13_0
end

function var_0_0._checkCanGetReward(arg_14_0)
	local var_14_0 = PeaceUluConfig.instance:getBonusCoList()
	local var_14_1 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act145).quantity

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = string.split(iter_14_1.needProgress, "#")[3]

		if var_14_1 >= tonumber(var_14_2) and not PeaceUluModel.instance:checkGetReward(iter_14_1.id) then
			PeaceUluRpc.instance:sendAct145GetRewardsRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)

			break
		end
	end
end

function var_0_0._initTaskMoList(arg_15_0, arg_15_1)
	PeaceUluTaskModel.instance:sortTaskMoList(arg_15_1)
end

function var_0_0.refreshBonusItem(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.bonusItemList) do
		iter_16_1:refreshProgress()
	end
end

function var_0_0._onDailyRefresh(arg_17_0)
	PeaceUluRpc.instance:sendGet145InfosRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
end

function var_0_0._toSwitchTab(arg_18_0, arg_18_1)
	arg_18_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_18_1)
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.delayPlayFinishAnim, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.bonusItemList) do
		iter_20_1:onDestroyView()
	end
end

return var_0_0
