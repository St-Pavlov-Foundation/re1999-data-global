module("modules.logic.versionactivity1_7.dungeon.view.DungeonMapActDropView", package.seeall)

local var_0_0 = class("DungeonMapActDropView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goact = gohelper.findChild(arg_1_0.viewGO, "#go_act")
	arg_1_0._bg1 = gohelper.findChild(arg_1_0.viewGO, "#go_act/bg")
	arg_1_0._bg2 = gohelper.findChild(arg_1_0.viewGO, "#go_act/bg2")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_act/layout/#btn_store")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_act/layout/#btn_task")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "#go_act/layout/#btn_task/#go_reddot")
	arg_1_0._txtshop = gohelper.findChildText(arg_1_0.viewGO, "#go_act/layout/#btn_store/normal/txt_shop")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_act/layout/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "#go_act/layout/#btn_store/#go_time/#txt_time")
	arg_1_0._goStoreTime = gohelper.findChild(arg_1_0.viewGO, "#go_act/layout/#btn_store/#go_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0.onClickStore, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0.onClickTask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
end

var_0_0.ActBtnPosY = {
	Resource = 345,
	Equip = 236,
	Normal = 160
}

function var_0_0.onClickStore(arg_4_0)
	VersionActivity2_8DungeonController.instance:openStoreView()
end

function var_0_0.onClickTask(arg_5_0)
	VersionActivity2_8DungeonController.instance:openTaskView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.rectTrLayout = gohelper.findChildComponent(arg_6_0.viewGO, "#go_act/layout", gohelper.Type_RectTransform)

	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0.onOpenView, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_6_0.onCloseViewFinish, arg_6_0)
	arg_6_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_6_0.onRefreshActivityState, arg_6_0)
	arg_6_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_6_0.refreshStoreCurrency, arg_6_0)
	arg_6_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_6_0.setEpisodeListVisible, arg_6_0)
end

function var_0_0.onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(arg_7_0._goact, false)
	end
end

function var_0_0.onCloseViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.DungeonMapLevelView then
		arg_8_0:_showActNode(arg_8_0:checkCanShowAct())
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.chapterId = arg_9_0.viewParam.chapterId
	arg_9_0.chapterCo = DungeonConfig.instance:getChapterCO(arg_9_0.chapterId)

	RedDotController.instance:addRedDot(arg_9_0._gotaskreddot, RedDotEnum.DotNode.V2a8DungeonTask)
	arg_9_0:_showActNode(arg_9_0:checkCanShowAct())
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0.chapterId = arg_10_0.viewParam.chapterId
	arg_10_0.chapterCo = DungeonConfig.instance:getChapterCO(arg_10_0.chapterId)

	arg_10_0:_showActNode(arg_10_0:checkCanShowAct())
end

function var_0_0._showActNode(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)

	gohelper.setActive(arg_11_0._goact, arg_11_1)

	if arg_11_1 then
		arg_11_0:refreshLayout()
		arg_11_0:refreshStoreCurrency()
		arg_11_0:refreshRemainTime()
	end
end

function var_0_0.refreshLayout(arg_12_0)
	local var_12_0 = arg_12_0.chapterCo.type
	local var_12_1 = var_0_0.ActBtnPosY.Normal

	if DungeonModel.instance:chapterListIsNormalType(var_12_0) then
		var_12_1 = var_0_0.ActBtnPosY.Normal
	elseif var_12_0 == DungeonEnum.ChapterType.Equip then
		var_12_1 = var_0_0.ActBtnPosY.Equip
	elseif DungeonModel.instance:chapterListIsResType(var_12_0) or DungeonModel.instance:chapterListIsBreakType(var_12_0) then
		var_12_1 = var_0_0.ActBtnPosY.Resource
	end

	gohelper.setActive(arg_12_0._gobg1, var_12_1 == var_0_0.ActBtnPosY.Normal)
	gohelper.setActive(arg_12_0._gobg2, var_12_1 ~= var_0_0.ActBtnPosY.Normal)
	recthelper.setAnchorY(arg_12_0.rectTrLayout, var_12_1)
end

function var_0_0.refreshStoreCurrency(arg_13_0)
	local var_13_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a8Dungeon)
	local var_13_1 = var_13_0 and var_13_0.quantity or 0

	arg_13_0._txtnum.text = GameUtil.numberDisplay(var_13_1)
end

function var_0_0.refreshRemainTime(arg_14_0)
	local var_14_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_8Enum.ActivityId.DungeonStore]

	if not var_14_0 then
		gohelper.setActive(arg_14_0._goStoreTime, false)

		return
	end

	gohelper.setActive(arg_14_0._goStoreTime, true)

	arg_14_0._txtStoreTime.text = var_14_0:getRemainTimeStr2ByEndTime(true)
	arg_14_0._txtshop.text = var_14_0.config.name
end

function var_0_0.checkCanShowAct(arg_15_0)
	return arg_15_0:checkHadAct155Drop() and arg_15_0:checkActActive()
end

function var_0_0.checkHadAct155Drop(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(lua_activity155_drop.configList) do
		if iter_16_1.chapterId == arg_16_0.chapterId then
			var_16_0[iter_16_1.activityId] = true
		end
	end

	for iter_16_2 in pairs(var_16_0) do
		if ActivityHelper.getActivityStatus(iter_16_2) == ActivityEnum.ActivityStatus.Normal then
			arg_16_0.actId = iter_16_2

			return true
		end
	end

	return false
end

function var_0_0.checkActActive(arg_17_0)
	if not arg_17_0.actId then
		return false
	end

	return ActivityHelper.getActivityStatus(arg_17_0.actId) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.setEpisodeListVisible(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._goact, arg_18_1 and arg_18_0:checkCanShowAct())
end

function var_0_0.onRefreshActivityState(arg_19_0)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		return
	end

	gohelper.setActive(arg_19_0._goact, arg_19_0:checkCanShowAct())
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
