module("modules.logic.dungeon.view.DungeonWeekWalkView", package.seeall)

local var_0_0 = class("DungeonWeekWalkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "anim/rewards/#go_empty")
	arg_1_0._gohasrewards = gohelper.findChild(arg_1_0.viewGO, "anim/rewards/#go_hasrewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "anim/rewards/#go_hasrewards/Scroll View/Viewport/#go_rewards")
	arg_1_0._btnshop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#btn_shop")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#btn_start")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#simage_line")
	arg_1_0._goeasy = gohelper.findChild(arg_1_0.viewGO, "anim/map/scenetype/#go_easy")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "anim/map/scenetype/#go_hard")
	arg_1_0._txtscenetype = gohelper.findChildText(arg_1_0.viewGO, "anim/map/scenetype/#txt_scenetype")
	arg_1_0._txtcurprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/map/#txt_curprogress")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#btn_reward")
	arg_1_0._golingqu = gohelper.findChild(arg_1_0.viewGO, "anim/#btn_reward/#go_lingqu")
	arg_1_0._gorewardredpoint = gohelper.findChild(arg_1_0.viewGO, "anim/#btn_reward/#go_rewardredpoint")
	arg_1_0._txttaskprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/#btn_reward/#txt_taskprogress")
	arg_1_0._txtmaptaskprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/#txt_maptaskprogress")
	arg_1_0._gomapprogressitem = gohelper.findChild(arg_1_0.viewGO, "anim/mapprogresslist/#go_mapprogressitem")
	arg_1_0._txtresettime = gohelper.findChildText(arg_1_0.viewGO, "anim/#txt_resettime")
	arg_1_0._simagebgimgnext = gohelper.findChildSingleImage(arg_1_0.viewGO, "transition/ani/#simage_bgimg_next")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshop:AddClickListener(arg_2_0._btnshopOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshop:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
end

function var_0_0._btnrewardOnClick(arg_4_0)
	WeekWalkController.instance:openWeekWalkRewardView()
end

function var_0_0._btnshopOnClick(arg_5_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		arg_5_0:_openStoreView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end
end

function var_0_0._updateTaskStatus(arg_6_0)
	local var_6_0 = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)

	gohelper.setActive(arg_6_0._golingqu, var_6_0)
	gohelper.setActive(arg_6_0._gorewardredpoint, var_6_0)
end

function var_0_0._openStoreView(arg_7_0)
	StoreController.instance:openStoreView(StoreEnum.StoreId.WeekWalk)
end

function var_0_0._btnstartOnClick(arg_8_0)
	arg_8_0:openWeekWalkView()
end

function var_0_0._initImgs(arg_9_0)
	arg_9_0._simagebg = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#bg")
	arg_9_0._simagexingdian1 = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#xingdian1")
	arg_9_0._simagexingdian2 = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#xingdian2")
	arg_9_0._simagerightdownglow = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#rightdown_glow")
	arg_9_0._simagecentertopglow = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#centertop_glow")
	arg_9_0._simagelefttopglow = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#lefttop_glow")
	arg_9_0._simagelefttopglow2 = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#lefttop_glow2")
	arg_9_0._simageleftdownglow = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#leftdown_glow")
	arg_9_0._simagerihtttopglow = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#rihtttop_glow")
	arg_9_0._simagerihtttopblack = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#rihtttop_black")
	arg_9_0._simagecenterdown = gohelper.findChildSingleImage(arg_9_0.viewGO, "bg/#centerdown")

	arg_9_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/weekwalkbg.jpg"))
	arg_9_0._simagexingdian1:LoadImage(ResUrl.getWeekWalkBg("xingdian.png"))
	arg_9_0._simagexingdian2:LoadImage(ResUrl.getWeekWalkBg("xingdian.png"))
	arg_9_0._simagerightdownglow:LoadImage(ResUrl.getWeekWalkBg("rightdown_glow.png"))
	arg_9_0._simagecentertopglow:LoadImage(ResUrl.getWeekWalkBg("centertop_hlow.png"))
	arg_9_0._simagelefttopglow:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow.png"))
	arg_9_0._simagelefttopglow2:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow2.png"))
	arg_9_0._simageleftdownglow:LoadImage(ResUrl.getWeekWalkBg("leftdown_glow.png"))
	arg_9_0._simagerihtttopglow:LoadImage(ResUrl.getWeekWalkBg("righttop_glow.png"))
	arg_9_0._simagerihtttopblack:LoadImage(ResUrl.getWeekWalkBg("leftdown_black.png"))
	arg_9_0._simagecenterdown:LoadImage(ResUrl.getWeekWalkBg("centerdown.png"))
	arg_9_0._simagebgimgnext:LoadImage(ResUrl.getWeekWalkBg("full/weekwalkbg.jpg"))
end

function var_0_0._editableInitView(arg_10_0)
	WeekWalkController.instance:requestTask()
	arg_10_0:_showBonus()
	arg_10_0:_updateTaskStatus()
	arg_10_0:_showDeadline()
	WeekWalkController.instance:startCheckTime()
	arg_10_0:_initImgs()

	arg_10_0._viewAnim = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_10_0._simageline:LoadImage(ResUrl.getWeekWalkBg("hw2.png"))
	arg_10_0:_showProgress()
	gohelper.addUIClickAudio(arg_10_0._btnstart.gameObject, AudioEnum.WeekWalk.play_artificial_ui_entrance)
	gohelper.addUIClickAudio(arg_10_0._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskopen)
	gohelper.addUIClickAudio(arg_10_0._btnshop.gameObject, AudioEnum.UI.play_ui_checkpoint_sources_open)
	arg_10_0:_initOnOpen()
end

function var_0_0._updateDegrade(arg_11_0)
	local var_11_0 = WeekWalkModel.instance:getLevel()
	local var_11_1 = WeekWalkModel.instance:getChangeLevel()

	gohelper.setActive(arg_11_0._btndegrade.gameObject, var_11_0 >= 2 and var_11_1 <= 0)
end

function var_0_0._showProgress(arg_12_0)
	local var_12_0 = WeekWalkModel.instance:getInfo()
	local var_12_1, var_12_2 = var_12_0:getNotFinishedMap()
	local var_12_3 = lua_weekwalk_scene.configDict[var_12_1.sceneId]

	arg_12_0._txtcurprogress.text = formatLuaLang("DungeonWeekWalkView_txtcurprogress_battleName", var_12_3.battleName)
	arg_12_0._txtscenetype.text = GameUtil.getSubPlaceholderLuaLang(luaLang("DungeonWeekWalkView_txtscenetype_typeName_name"), {
		var_12_3.typeName,
		var_12_3.name
	})

	if var_12_1 then
		local var_12_4, var_12_5 = var_12_1:getCurStarInfo()

		arg_12_0._txtmaptaskprogress.text = string.format("%s/%s", var_12_4, var_12_5)
	else
		arg_12_0._txtmaptaskprogress.text = "0/10"
	end

	local var_12_6 = WeekWalkModel.isShallowMap(var_12_1.sceneId)

	gohelper.setActive(arg_12_0._goeasy, var_12_6)
	gohelper.setActive(arg_12_0._gohard, not var_12_6)

	arg_12_0._mapFinishItemTab = arg_12_0._mapFinishItemTab or arg_12_0:getUserDataTb_()

	local var_12_7 = var_12_0:getMapInfos()
	local var_12_8 = 1
	local var_12_9 = 10

	if not var_12_6 then
		local var_12_10 = WeekWalkModel.instance:getInfo()
		local var_12_11 = WeekWalkConfig.instance:getDeepLayer(var_12_10.issueId)

		var_12_8 = 11
		var_12_9 = var_12_8 + #var_12_11 - 1
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0._mapFinishItemTab) do
		gohelper.setActive(iter_12_1, false)
	end

	for iter_12_2 = var_12_8, var_12_9 do
		local var_12_12 = arg_12_0._mapFinishItemTab[iter_12_2]

		if not var_12_12 then
			var_12_12 = gohelper.cloneInPlace(arg_12_0._gomapprogressitem, "item_" .. iter_12_2)
			arg_12_0._mapFinishItemTab[iter_12_2] = var_12_12
		end

		gohelper.setActive(var_12_12, true)

		local var_12_13 = gohelper.findChild(var_12_12, "finish")
		local var_12_14 = var_12_7[iter_12_2]
		local var_12_15 = var_12_14 and var_12_14.isFinished > 0

		gohelper.setActive(var_12_13, var_12_15)

		local var_12_16 = gohelper.findChildImage(var_12_12, "unfinish")
		local var_12_17 = gohelper.findChildImage(var_12_12, "finish")

		if not UISpriteSetMgr.instance:getWeekWalkSpriteSetUnit() then
			arg_12_0:_setImgAlpha(var_12_16, 0)
			arg_12_0:_setImgAlpha(var_12_17, 0)
		end

		UISpriteSetMgr.instance:setWeekWalkSprite(var_12_16, var_12_6 and "btn_dian2" or "btn_dian4", true, 1)
		UISpriteSetMgr.instance:setWeekWalkSprite(var_12_17, var_12_6 and "btn_dian1" or "btn_dian3", true, 1)
		gohelper.setActive(gohelper.findChild(var_12_12, "finish_light_deepdream01"), not var_12_6 and var_12_15)
		gohelper.setActive(gohelper.findChild(var_12_12, "finish_light"), var_12_6 and var_12_15)
	end
end

function var_0_0._setImgAlpha(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.color

	var_13_0.a = arg_13_2
	arg_13_1.color = var_13_0
end

function var_0_0.getWeekTaskProgress()
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = {}

	WeekWalkTaskListModel.instance:showTaskList(WeekWalkEnum.TaskType.Week)

	local var_14_3 = WeekWalkTaskListModel.instance:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_3) do
		local var_14_4 = WeekWalkTaskListModel.instance:getTaskMo(iter_14_1.id)

		if var_14_4 and (var_14_4.finishCount > 0 or var_14_4.hasFinished) then
			local var_14_5 = GameUtil.splitString2(iter_14_1.bonus, true, "|", "#")

			for iter_14_2, iter_14_3 in ipairs(var_14_5) do
				local var_14_6 = iter_14_3[1]
				local var_14_7 = iter_14_3[2]
				local var_14_8 = iter_14_3[3]
				local var_14_9 = string.format("%s_%s", var_14_6, var_14_7)
				local var_14_10 = var_14_2[var_14_9]

				if not var_14_10 then
					var_14_2[var_14_9] = iter_14_3
				else
					var_14_10[3] = var_14_10[3] + var_14_8
					var_14_2[var_14_9] = var_14_10
				end
			end
		end

		if var_14_4 then
			var_14_0 = math.max(var_14_4.progress or 0, var_14_0)
		end

		local var_14_11 = lua_task_weekwalk.configDict[iter_14_1.id]

		if var_14_11 then
			var_14_1 = math.max(var_14_11.maxProgress or 0, var_14_1)
		end
	end

	local var_14_12 = {}

	for iter_14_4, iter_14_5 in pairs(var_14_2) do
		table.insert(var_14_12, iter_14_5)
	end

	table.sort(var_14_12, var_0_0._sort)

	return var_14_0, var_14_1, var_14_12
end

function var_0_0._sort(arg_15_0, arg_15_1)
	local var_15_0 = ItemModel.instance:getItemConfig(arg_15_0[1], arg_15_0[2])
	local var_15_1 = ItemModel.instance:getItemConfig(arg_15_1[1], arg_15_1[2])

	if var_15_0.rare ~= var_15_1.rare then
		return var_15_0.rare > var_15_1.rare
	end

	return arg_15_0[3] > arg_15_1[3]
end

function var_0_0._showBonus(arg_16_0)
	if not WeekWalkTaskListModel.instance:hasTaskList() then
		return
	end

	local var_16_0, var_16_1, var_16_2 = var_0_0.getWeekTaskProgress()

	arg_16_0._txttaskprogress.text = string.format("%s/%s", var_16_0, var_16_1)

	gohelper.destroyAllChildren(arg_16_0._gorewards)

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		local var_16_3 = IconMgr.instance:getCommonItemIcon(arg_16_0._gorewards)

		var_16_3:setMOValue(iter_16_1[1], iter_16_1[2], iter_16_1[3])
		var_16_3:isShowCount(true)
		var_16_3:setCountFontSize(31)
	end

	local var_16_4 = #var_16_2 > 0

	gohelper.setActive(arg_16_0._goempty, not var_16_4)
	gohelper.setActive(arg_16_0._gohasrewards, var_16_4)
end

function var_0_0.onUpdateParam(arg_17_0)
	arg_17_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
end

function var_0_0.onShow(arg_18_0)
	arg_18_0.viewContainer:setNavigateButtonViewHelpId()
	arg_18_0:_showWeekWalkSettlementView()

	if arg_18_0._bgmId then
		return
	end
end

function var_0_0._onFinishGuide(arg_19_0, arg_19_1)
	if arg_19_1 == 501 then
		arg_19_0:_showWeekWalkSettlementView()
	end
end

function var_0_0._showWeekWalkSettlementView(arg_20_0)
	local var_20_0 = GameGlobalMgr.instance:getLoadingState()

	if var_20_0 and var_20_0:getLoadingViewName() then
		return
	end

	if WeekWalkModel.instance:getSkipShowSettlementView() then
		WeekWalkModel.instance:setSkipShowSettlementView(false)

		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	local var_20_1 = WeekWalkModel.instance:getInfo()

	if var_20_1.isPopShallowSettle then
		WeekWalkController.instance:openWeekWalkShallowSettlementView()

		return
	end

	if var_20_1.isPopDeepSettle then
		WeekWalkController.instance:checkOpenWeekWalkDeepLayerNoticeView()

		return
	end
end

function var_0_0.onHide(arg_21_0)
	arg_21_0.viewContainer:resetNavigateButtonViewHelpId()
end

function var_0_0.onOpen(arg_22_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_22_0._refreshHelpFunc, arg_22_0._refreshTarget)
	arg_22_0:onShow()
end

function var_0_0._showDeadline(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onRefreshDeadline, arg_23_0)

	arg_23_0._endTime = WeekWalkController.getTaskEndTime(WeekWalkEnum.TaskType.Week)

	if not arg_23_0._endTime then
		return
	end

	TaskDispatcher.runRepeat(arg_23_0._onRefreshDeadline, arg_23_0, 1)
	arg_23_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_24_0)
	local var_24_0 = arg_24_0._endTime - ServerTime.now()

	if var_24_0 <= 0 then
		WeekWalkController.instance:requestTask(true)
		TaskDispatcher.cancelTask(arg_24_0._onRefreshDeadline, arg_24_0)
	end

	local var_24_1, var_24_2 = TimeUtil.secondToRoughTime2(math.floor(var_24_0))
	local var_24_3 = {
		var_24_1,
		var_24_2
	}

	arg_24_0._txtresettime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeonweekwalkview_resettime"), var_24_3)
end

function var_0_0._onGetInfo(arg_25_0)
	arg_25_0:_showDeadline()
end

function var_0_0._onWeekwalkTaskUpdate(arg_26_0)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
		return
	end

	arg_26_0:_updateTaskStatus()
	arg_26_0:_showBonus()
	arg_26_0:_showDeadline()
end

function var_0_0._initOnOpen(arg_27_0)
	local var_27_0 = arg_27_0.viewContainer._navigateButtonView

	arg_27_0._refreshHelpFunc = var_27_0.showHelpBtnIcon
	arg_27_0._refreshTarget = var_27_0

	arg_27_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, arg_27_0._OnSelectLevel, arg_27_0)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_27_0._onCloseView, arg_27_0, LuaEventSystem.Low)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_27_0._onOpenView, arg_27_0, LuaEventSystem.Low)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_27_0._onOpenViewFinish, arg_27_0, LuaEventSystem.Low)
	arg_27_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_27_0._onWeekwalkTaskUpdate, arg_27_0)
	arg_27_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_27_0._onGetInfo, arg_27_0)
	arg_27_0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_27_0._onFinishGuide, arg_27_0)
end

function var_0_0._OnSelectLevel(arg_28_0)
	arg_28_0._dropLevel.dropDown.enabled = false

	if WeekWalkModel.instance:getChangeLevel() > 0 then
		return
	end

	arg_28_0:openWeekWalkView()
end

function var_0_0.openWeekWalkView(arg_29_0)
	module_views_preloader.WeekWalkLayerViewPreload(function()
		arg_29_0:delayOpenWeekWalkView()
	end)
end

function var_0_0.delayOpenWeekWalkView(arg_31_0)
	WeekWalkController.instance:openWeekWalkLayerView()
end

function var_0_0._onOpenViewFinish(arg_32_0, arg_32_1)
	if arg_32_1 == ViewName.WeekWalkLayerView or arg_32_1 == ViewName.StoreView then
		local var_32_0 = ViewMgr.instance:getContainer(ViewName.DungeonView)
		local var_32_1 = gohelper.findChild(var_32_0.viewGO, "top_left")

		gohelper.setActive(var_32_1, true)
	end
end

function var_0_0._onOpenView(arg_33_0, arg_33_1)
	if arg_33_1 == ViewName.WeekWalkLayerView then
		-- block empty
	end

	if arg_33_1 == ViewName.WeekWalkLayerView or arg_33_1 == ViewName.StoreView then
		arg_33_0._viewAnim:Play("dungeonweekwalk_out", 0, 0)

		local var_33_0 = ViewMgr.instance:getContainer(ViewName.DungeonView)

		gohelper.setAsLastSibling(var_33_0.viewGO)

		local var_33_1 = gohelper.findChild(var_33_0.viewGO, "top_left")

		gohelper.setActive(var_33_1, false)
	end
end

function var_0_0._onCloseView(arg_34_0, arg_34_1)
	if arg_34_1 == ViewName.WeekWalkLayerView then
		arg_34_0:_showProgress()
		arg_34_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif arg_34_1 == ViewName.StoreView then
		arg_34_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif arg_34_1 == ViewName.WeekWalkRewardView then
		arg_34_0:_onWeekwalkTaskUpdate()
	end
end

function var_0_0.onClose(arg_35_0)
	arg_35_0:onHide()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_35_0._refreshHelpFunc, arg_35_0._refreshTarget)
end

function var_0_0._clearOnDestroy(arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.delayOpenWeekWalkView, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._openStoreView, arg_36_0)
	arg_36_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, arg_36_0._OnSelectLevel, arg_36_0)
	arg_36_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_36_0._onCloseView, arg_36_0, LuaEventSystem.Low)
	arg_36_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_36_0._onOpenView, arg_36_0, LuaEventSystem.Low)
	arg_36_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_36_0._onOpenViewFinish, arg_36_0, LuaEventSystem.Low)
	arg_36_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_36_0._onWeekwalkTaskUpdate, arg_36_0)
	arg_36_0:removeEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_36_0._onFinishGuide, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._onRefreshDeadline, arg_36_0)
end

function var_0_0.onDestroyView(arg_37_0)
	arg_37_0:_clearOnDestroy()
	arg_37_0._simagebg:UnLoadImage()
	arg_37_0._simageline:UnLoadImage()
	arg_37_0._simagexingdian1:UnLoadImage()
	arg_37_0._simagexingdian2:UnLoadImage()
	arg_37_0._simagerightdownglow:UnLoadImage()
	arg_37_0._simagecentertopglow:UnLoadImage()
	arg_37_0._simagelefttopglow:UnLoadImage()
	arg_37_0._simagelefttopglow2:UnLoadImage()
	arg_37_0._simageleftdownglow:UnLoadImage()
	arg_37_0._simagerihtttopglow:UnLoadImage()
	arg_37_0._simagerihtttopblack:UnLoadImage()
	arg_37_0._simagecenterdown:UnLoadImage()
	arg_37_0._simagebgimgnext:UnLoadImage()
end

return var_0_0
