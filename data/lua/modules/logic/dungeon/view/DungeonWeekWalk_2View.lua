module("modules.logic.dungeon.view.DungeonWeekWalk_2View", package.seeall)

local var_0_0 = class("DungeonWeekWalk_2View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnenterbtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/shallowbox/#btn_enterbtn")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/shallowbox/#btn_reward")
	arg_1_0._golingqu = gohelper.findChild(arg_1_0.viewGO, "anim/shallowbox/#btn_reward/#go_lingqu")
	arg_1_0._gorewardredpoint = gohelper.findChild(arg_1_0.viewGO, "anim/shallowbox/#btn_reward/#go_rewardredpoint")
	arg_1_0._txttaskprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/shallowbox/#btn_reward/#txt_taskprogress")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/deepbox/#btn_start")
	arg_1_0._goeasy = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/map/scenetype/#go_easy")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/map/scenetype/#go_hard")
	arg_1_0._txtscenetype = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/map/scenetype/#txt_scenetype")
	arg_1_0._txtcurprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/map/#txt_curprogress")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/limittime/#txt_time")
	arg_1_0._txtmaptaskprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/#txt_maptaskprogress")
	arg_1_0._gomapprogressitem = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/mapprogresslist/#go_mapprogressitem")
	arg_1_0._btnstart2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/heartbox/#btn_start_2")
	arg_1_0._goeasy2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/map/scenetype/#go_easy2")
	arg_1_0._gohard2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/map/scenetype/#go_hard2")
	arg_1_0._txtscenetype2 = gohelper.findChildText(arg_1_0.viewGO, "anim/heartbox/map/scenetype/#txt_scenetype2")
	arg_1_0._txtcurprogress2 = gohelper.findChildText(arg_1_0.viewGO, "anim/heartbox/map/#txt_curprogress2")
	arg_1_0._btnreward2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/heartbox/map/#btn_reward2")
	arg_1_0._gobubble = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/map/#btn_reward2/#go_bubble")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/heartbox/map/#btn_reward2/#go_bubble/#simage_icon")
	arg_1_0._gomapprogressitem2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/mapprogresslist/#go_mapprogressitem2")
	arg_1_0._txttime2 = gohelper.findChildText(arg_1_0.viewGO, "anim/heartbox/limittime/#txt_time2")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/badgelist/1/badgelayout/#go_item_1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/badgelist/2/badgelayout/#go_item_2")
	arg_1_0._btnshop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#btn_shop")
	arg_1_0._simagebgimgnext = gohelper.findChildSingleImage(arg_1_0.viewGO, "transition/ani/#simage_bgimg_next")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenterbtn:AddClickListener(arg_2_0._btnenterbtnOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnstart2:AddClickListener(arg_2_0._btnstart2OnClick, arg_2_0)
	arg_2_0._btnreward2:AddClickListener(arg_2_0._btnreward2OnClick, arg_2_0)
	arg_2_0._btnshop:AddClickListener(arg_2_0._btnshopOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenterbtn:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnstart2:RemoveClickListener()
	arg_3_0._btnreward2:RemoveClickListener()
	arg_3_0._btnshop:RemoveClickListener()
end

function var_0_0._btnreward2OnClick(arg_4_0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = 0
	})
end

function var_0_0._btnstart2OnClick(arg_5_0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView()
end

function var_0_0._btnenterbtnOnClick(arg_6_0)
	module_views_preloader.WeekWalkLayerViewPreload(function()
		WeekWalkController.instance:openWeekWalkLayerView({
			layerId = 10
		})
	end)
end

function var_0_0._btnrewardOnClick(arg_8_0)
	WeekWalkController.instance:openWeekWalkRewardView()
end

function var_0_0._btnshopOnClick(arg_9_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		arg_9_0:_openStoreView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end
end

function var_0_0._updateTaskStatus(arg_10_0)
	local var_10_0 = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)

	gohelper.setActive(arg_10_0._golingqu, var_10_0)
	gohelper.setActive(arg_10_0._gorewardredpoint, var_10_0)
end

function var_0_0._openStoreView(arg_11_0)
	StoreController.instance:openStoreView(StoreEnum.WeekWalkTabId)
end

function var_0_0._btnstartOnClick(arg_12_0)
	arg_12_0:openWeekWalkView()
end

function var_0_0._initImgs(arg_13_0)
	arg_13_0._simagexingdian1 = gohelper.findChildSingleImage(arg_13_0.viewGO, "bg/#xingdian1")
	arg_13_0._simagelefttopglow = gohelper.findChildSingleImage(arg_13_0.viewGO, "bg/#lefttop_glow")
	arg_13_0._simagelefttopglow2 = gohelper.findChildSingleImage(arg_13_0.viewGO, "bg/#lefttop_glow2")
	arg_13_0._simageleftdownglow = gohelper.findChildSingleImage(arg_13_0.viewGO, "bg/#leftdown_glow")
	arg_13_0._simagerihtttopglow = gohelper.findChildSingleImage(arg_13_0.viewGO, "bg/#rihtttop_glow")
	arg_13_0._simagerihtttopblack = gohelper.findChildSingleImage(arg_13_0.viewGO, "bg/#rihtttop_black")
	arg_13_0._simagecenterdown = gohelper.findChildSingleImage(arg_13_0.viewGO, "bg/#centerdown")

	arg_13_0._simagexingdian1:LoadImage(ResUrl.getWeekWalkBg("xingdian.png"))
	arg_13_0._simagelefttopglow:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow.png"))
	arg_13_0._simagelefttopglow2:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow2.png"))
	arg_13_0._simageleftdownglow:LoadImage(ResUrl.getWeekWalkBg("leftdown_glow.png"))
	arg_13_0._simagerihtttopglow:LoadImage(ResUrl.getWeekWalkBg("righttop_glow.png"))
	arg_13_0._simagerihtttopblack:LoadImage(ResUrl.getWeekWalkBg("leftdown_black.png"))
	arg_13_0._simagecenterdown:LoadImage(ResUrl.getWeekWalkBg("centerdown.png"))
end

function var_0_0._editableInitView(arg_14_0)
	WeekWalkController.instance:requestTask()
	arg_14_0:_showBonus()
	arg_14_0:_updateTaskStatus()
	arg_14_0:_onWeekwalk_2TaskUpdate()
	arg_14_0:_showDeadline()
	WeekWalkController.instance:startCheckTime()
	arg_14_0:_initImgs()

	arg_14_0._viewAnim = arg_14_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_14_0:_showProgress()
	arg_14_0:_showProgress2()
	gohelper.addUIClickAudio(arg_14_0._btnstart.gameObject, AudioEnum.WeekWalk.play_artificial_ui_entrance)
	gohelper.addUIClickAudio(arg_14_0._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskopen)
	gohelper.addUIClickAudio(arg_14_0._btnshop.gameObject, AudioEnum.UI.play_ui_checkpoint_sources_open)
	arg_14_0:_initOnOpen()
end

function var_0_0._updateDegrade(arg_15_0)
	local var_15_0 = WeekWalkModel.instance:getLevel()
	local var_15_1 = WeekWalkModel.instance:getChangeLevel()

	gohelper.setActive(arg_15_0._btndegrade.gameObject, var_15_0 >= 2 and var_15_1 <= 0)
end

function var_0_0._showProgress2(arg_16_0)
	local var_16_0 = WeekWalk_2Model.instance:getInfo()
	local var_16_1, var_16_2 = var_16_0:getNotFinishedMap()

	if not var_16_1 then
		logError("DungeonWeekWalk_2View _showProgress2 map is nil")

		return
	end

	local var_16_3 = var_16_1.sceneConfig

	arg_16_0._txtcurprogress2.text = formatLuaLang("DungeonWeekWalkView_txtcurprogress_battleName", var_16_3.battleName)
	arg_16_0._txtscenetype2.text = GameUtil.getSubPlaceholderLuaLang(luaLang("DungeonWeekWalkView_txtscenetype_typeName_name"), {
		var_16_3.typeName,
		var_16_3.name
	})
	arg_16_0._mapFinishItemTab2 = arg_16_0._mapFinishItemTab2 or arg_16_0:getUserDataTb_()

	for iter_16_0, iter_16_1 in pairs(arg_16_0._mapFinishItemTab2) do
		gohelper.setActive(iter_16_1, false)
	end

	for iter_16_2 = 1, WeekWalk_2Enum.MaxLayer do
		local var_16_4 = arg_16_0._mapFinishItemTab2[iter_16_2]

		if not var_16_4 then
			var_16_4 = gohelper.cloneInPlace(arg_16_0._gomapprogressitem2, "item_" .. iter_16_2)
			arg_16_0._mapFinishItemTab2[iter_16_2] = var_16_4
		end

		gohelper.setActive(var_16_4, true)

		local var_16_5 = gohelper.findChild(var_16_4, "finish")
		local var_16_6 = gohelper.findChild(var_16_4, "unfinish")
		local var_16_7 = var_16_0:getLayerInfoByLayerIndex(iter_16_2)
		local var_16_8 = var_16_7 and var_16_7.finished

		gohelper.setActive(var_16_5, var_16_8)
		gohelper.setActive(var_16_6, not var_16_8)
		gohelper.setActive(gohelper.findChild(var_16_4, "finish_light_deepdream01"), var_16_8)
	end

	arg_16_0._battleStar1List = arg_16_0._battleStar1List or arg_16_0:getUserDataTb_()
	arg_16_0._battleStar2List = arg_16_0._battleStar2List or arg_16_0:getUserDataTb_()

	arg_16_0:_showBattleInfo(arg_16_0._battleStar1List, arg_16_0._goitem1, var_16_1:getBattleInfoByIndex(WeekWalk_2Enum.BattleIndex.First))
	arg_16_0:_showBattleInfo(arg_16_0._battleStar2List, arg_16_0._goitem2, var_16_1:getBattleInfoByIndex(WeekWalk_2Enum.BattleIndex.Second))
end

function var_0_0._showBattleInfo(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	gohelper.setActive(arg_17_2, false)

	for iter_17_0 = 1, WeekWalk_2Enum.MaxStar do
		local var_17_0 = arg_17_1[iter_17_0]

		if not var_17_0 then
			local var_17_1 = gohelper.cloneInPlace(arg_17_2)
			local var_17_2 = gohelper.findChildImage(var_17_1, "1")

			gohelper.setActive(var_17_1, true)

			var_17_2.enabled = false
			var_17_0 = arg_17_0.viewContainer:getResInst(arg_17_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_17_2.gameObject)
			arg_17_1[iter_17_0] = var_17_0
		end

		local var_17_3 = arg_17_3:getCupInfo(iter_17_0)
		local var_17_4 = var_17_3 and var_17_3.result or 0

		WeekWalk_2Helper.setCupEffectByResult(var_17_0, var_17_4)
	end
end

function var_0_0._showProgress(arg_18_0)
	local var_18_0 = WeekWalkModel.instance:getInfo()
	local var_18_1, var_18_2 = var_18_0:getNotFinishedMap()
	local var_18_3 = lua_weekwalk_scene.configDict[var_18_1.sceneId]

	arg_18_0._txtcurprogress.text = formatLuaLang("DungeonWeekWalkView_txtcurprogress_battleName", var_18_3.battleName)
	arg_18_0._txtscenetype.text = GameUtil.getSubPlaceholderLuaLang(luaLang("DungeonWeekWalkView_txtscenetype_typeName_name"), {
		var_18_3.typeName,
		var_18_3.name
	})

	if var_18_1 then
		local var_18_4, var_18_5 = var_18_1:getCurStarInfo()

		arg_18_0._txtmaptaskprogress.text = string.format("%s/%s", var_18_4, var_18_5)
	else
		arg_18_0._txtmaptaskprogress.text = "0/10"
	end

	local var_18_6 = WeekWalkModel.isShallowMap(var_18_1.sceneId)

	gohelper.setActive(arg_18_0._goeasy, var_18_6)
	gohelper.setActive(arg_18_0._gohard, not var_18_6)

	arg_18_0._mapFinishItemTab = arg_18_0._mapFinishItemTab or arg_18_0:getUserDataTb_()

	local var_18_7 = var_18_0:getMapInfos()
	local var_18_8 = 1
	local var_18_9 = 10

	if not var_18_6 then
		local var_18_10 = WeekWalkModel.instance:getInfo()
		local var_18_11 = WeekWalkConfig.instance:getDeepLayer(var_18_10.issueId)

		var_18_8 = 11
		var_18_9 = var_18_8 + #var_18_11 - 1
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._mapFinishItemTab) do
		gohelper.setActive(iter_18_1, false)
	end

	for iter_18_2 = var_18_8, var_18_9 do
		local var_18_12 = arg_18_0._mapFinishItemTab[iter_18_2]

		if not var_18_12 then
			var_18_12 = gohelper.cloneInPlace(arg_18_0._gomapprogressitem, "item_" .. iter_18_2)
			arg_18_0._mapFinishItemTab[iter_18_2] = var_18_12
		end

		gohelper.setActive(var_18_12, true)

		local var_18_13 = gohelper.findChild(var_18_12, "finish")
		local var_18_14 = var_18_7[iter_18_2]
		local var_18_15 = var_18_14 and var_18_14.isFinished > 0

		gohelper.setActive(var_18_13, var_18_15)

		local var_18_16 = gohelper.findChildImage(var_18_12, "unfinish")
		local var_18_17 = gohelper.findChildImage(var_18_12, "finish")

		if not UISpriteSetMgr.instance:getWeekWalkSpriteSetUnit() then
			arg_18_0:_setImgAlpha(var_18_16, 0)
			arg_18_0:_setImgAlpha(var_18_17, 0)
		end

		UISpriteSetMgr.instance:setWeekWalkSprite(var_18_16, var_18_6 and "btn_dian2" or "btn_dian4", true, 1)
		UISpriteSetMgr.instance:setWeekWalkSprite(var_18_17, var_18_6 and "btn_dian1" or "btn_dian3", true, 1)
		gohelper.setActive(gohelper.findChild(var_18_12, "finish_light_deepdream01"), not var_18_6 and var_18_15)
		gohelper.setActive(gohelper.findChild(var_18_12, "finish_light"), var_18_6 and var_18_15)
	end
end

function var_0_0._setImgAlpha(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1.color

	var_19_0.a = arg_19_2
	arg_19_1.color = var_19_0
end

function var_0_0.getWeekTaskProgress()
	local var_20_0 = 0
	local var_20_1 = 0
	local var_20_2 = {}

	WeekWalkTaskListModel.instance:showTaskList(WeekWalkEnum.TaskType.Week)

	local var_20_3 = WeekWalkTaskListModel.instance:getList()

	for iter_20_0, iter_20_1 in ipairs(var_20_3) do
		local var_20_4 = WeekWalkTaskListModel.instance:getTaskMo(iter_20_1.id)

		if var_20_4 and (var_20_4.finishCount > 0 or var_20_4.hasFinished) then
			local var_20_5 = GameUtil.splitString2(iter_20_1.bonus, true, "|", "#")

			for iter_20_2, iter_20_3 in ipairs(var_20_5) do
				local var_20_6 = iter_20_3[1]
				local var_20_7 = iter_20_3[2]
				local var_20_8 = iter_20_3[3]
				local var_20_9 = string.format("%s_%s", var_20_6, var_20_7)
				local var_20_10 = var_20_2[var_20_9]

				if not var_20_10 then
					var_20_2[var_20_9] = iter_20_3
				else
					var_20_10[3] = var_20_10[3] + var_20_8
					var_20_2[var_20_9] = var_20_10
				end
			end
		end

		if var_20_4 then
			var_20_0 = math.max(var_20_4.progress or 0, var_20_0)
		end

		local var_20_11 = lua_task_weekwalk.configDict[iter_20_1.id]

		if var_20_11 then
			var_20_1 = math.max(var_20_11.maxProgress or 0, var_20_1)
		end
	end

	local var_20_12 = {}

	for iter_20_4, iter_20_5 in pairs(var_20_2) do
		table.insert(var_20_12, iter_20_5)
	end

	table.sort(var_20_12, var_0_0._sort)

	return var_20_0, var_20_1, var_20_12
end

function var_0_0._sort(arg_21_0, arg_21_1)
	local var_21_0 = ItemModel.instance:getItemConfig(arg_21_0[1], arg_21_0[2])
	local var_21_1 = ItemModel.instance:getItemConfig(arg_21_1[1], arg_21_1[2])

	if var_21_0.rare ~= var_21_1.rare then
		return var_21_0.rare > var_21_1.rare
	end

	return arg_21_0[3] > arg_21_1[3]
end

function var_0_0._showBonus(arg_22_0)
	if not WeekWalkTaskListModel.instance:hasTaskList() then
		return
	end

	local var_22_0, var_22_1, var_22_2 = var_0_0.getWeekTaskProgress()

	arg_22_0._txttaskprogress.text = string.format("%s/%s", var_22_0, var_22_1)

	if arg_22_0._gorewards then
		gohelper.destroyAllChildren(arg_22_0._gorewards)

		for iter_22_0, iter_22_1 in ipairs(var_22_2) do
			local var_22_3 = IconMgr.instance:getCommonItemIcon(arg_22_0._gorewards)

			var_22_3:setMOValue(iter_22_1[1], iter_22_1[2], iter_22_1[3])
			var_22_3:isShowCount(true)
			var_22_3:setCountFontSize(31)
		end
	end

	local var_22_4 = #var_22_2 > 0

	gohelper.setActive(arg_22_0._goempty, not var_22_4)
	gohelper.setActive(arg_22_0._gohasrewards, var_22_4)
end

function var_0_0.onUpdateParam(arg_23_0)
	arg_23_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
end

function var_0_0.onShow(arg_24_0)
	arg_24_0.viewContainer:setNavigateButtonViewHelpId()
	arg_24_0:_showWeekWalkSettlementView()

	if arg_24_0._bgmId then
		return
	end
end

function var_0_0._onFinishGuide(arg_25_0, arg_25_1)
	if arg_25_1 == 501 then
		arg_25_0:_showWeekWalkSettlementView()
	end
end

function var_0_0._showWeekWalkSettlementView(arg_26_0)
	local var_26_0 = GameGlobalMgr.instance:getLoadingState()

	if var_26_0 and var_26_0:getLoadingViewName() then
		return
	end

	if WeekWalkModel.instance:getSkipShowSettlementView() then
		WeekWalkModel.instance:setSkipShowSettlementView(false)

		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	local var_26_1 = WeekWalkModel.instance:getInfo()

	if var_26_1.isPopShallowSettle then
		WeekWalkController.instance:openWeekWalkShallowSettlementView()

		return
	end

	if var_26_1.isPopDeepSettle then
		WeekWalkController.instance:checkOpenWeekWalkDeepLayerNoticeView()

		return
	end

	WeekWalk_2Controller.instance:checkOpenWeekWalk_2DeepLayerNoticeView()
end

function var_0_0.onHide(arg_27_0)
	arg_27_0.viewContainer:resetNavigateButtonViewHelpId()
end

function var_0_0.onOpen(arg_28_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_28_0._refreshHelpFunc, arg_28_0._refreshTarget)
	arg_28_0:onShow()
end

function var_0_0.onOpenFinish(arg_29_0)
	arg_29_0.viewContainer:destoryTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
end

function var_0_0._showDeadline(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._onRefreshDeadline, arg_30_0)

	arg_30_0._endTaskTime = WeekWalkController.getTaskEndTime(WeekWalkEnum.TaskType.Week)
	arg_30_0._endTime = WeekWalkModel.instance:getInfo().endTime
	arg_30_0._heartEndTime = WeekWalk_2Model.instance:getInfo().endTime

	TaskDispatcher.runRepeat(arg_30_0._onRefreshDeadline, arg_30_0, 1)
	arg_30_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_31_0)
	if arg_31_0._endTaskTime and arg_31_0._endTaskTime - ServerTime.now() <= 0 then
		arg_31_0._endTaskTime = nil

		WeekWalkController.instance:requestTask(true)
	end

	local var_31_0 = luaLang("p_dungeonweekwalkview_device")

	if arg_31_0._endTime then
		local var_31_1 = arg_31_0._endTime - ServerTime.now()

		if var_31_1 <= 0 then
			arg_31_0._endTime = nil

			TaskDispatcher.cancelTask(arg_31_0._onRefreshDeadline, arg_31_0)
		end

		local var_31_2, var_31_3 = TimeUtil.secondToRoughTime2(math.floor(var_31_1))

		arg_31_0._txttime.text = var_31_0 .. var_31_2 .. var_31_3
	end

	if arg_31_0._heartEndTime then
		local var_31_4 = arg_31_0._heartEndTime - ServerTime.now()

		if var_31_4 <= 0 then
			arg_31_0._heartEndTime = nil

			TaskDispatcher.cancelTask(arg_31_0._onRefreshDeadline, arg_31_0)
		end

		local var_31_5, var_31_6 = TimeUtil.secondToRoughTime2(math.floor(var_31_4))

		arg_31_0._txttime2.text = var_31_0 .. var_31_5 .. var_31_6
	end
end

function var_0_0._onGetInfo(arg_32_0)
	arg_32_0:_showDeadline()
end

function var_0_0._onWeekwalkTaskUpdate(arg_33_0)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
		return
	end

	arg_33_0:_updateTaskStatus()
	arg_33_0:_showBonus()
	arg_33_0:_showDeadline()
end

function var_0_0._onWeekwalk_2TaskUpdate(arg_34_0)
	local var_34_0 = WeekWalk_2Enum.TaskType.Once
	local var_34_1, var_34_2 = WeekWalk_2TaskListModel.instance:canGetRewardNum(var_34_0)
	local var_34_3 = var_34_1 > 0

	gohelper.setActive(arg_34_0._gobubble, true)

	arg_34_0._gobubbleReddot = arg_34_0._gobubbleReddot or gohelper.findChild(arg_34_0.viewGO, "anim/heartbox/map/#btn_reward2/reddot")

	gohelper.setActive(arg_34_0._gobubbleReddot, var_34_3)

	arg_34_0._rewardAnimator = arg_34_0._rewardAnimator or arg_34_0._btnreward2.gameObject:GetComponent(typeof(UnityEngine.Animator))

	if arg_34_0._rewardAnimator then
		arg_34_0._rewardAnimator:Play(var_34_3 and "reward" or "idle")
	end

	if var_34_1 == 0 and var_34_2 == 0 then
		gohelper.setActive(arg_34_0._btnreward2, false)
	end
end

function var_0_0._initOnOpen(arg_35_0)
	local var_35_0 = arg_35_0.viewContainer._navigateButtonView

	arg_35_0._refreshHelpFunc = var_35_0.showHelpBtnIcon
	arg_35_0._refreshTarget = var_35_0

	arg_35_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, arg_35_0._OnSelectLevel, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_35_0._onCloseView, arg_35_0, LuaEventSystem.Low)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_35_0._onOpenView, arg_35_0, LuaEventSystem.Low)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_35_0._onOpenViewFinish, arg_35_0, LuaEventSystem.Low)
	arg_35_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_35_0._onWeekwalkTaskUpdate, arg_35_0)
	arg_35_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_35_0._onWeekwalk_2TaskUpdate, arg_35_0)
	arg_35_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_35_0._onGetInfo, arg_35_0)
	arg_35_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, arg_35_0._onGetInfo, arg_35_0)
end

function var_0_0._OnSelectLevel(arg_36_0)
	arg_36_0._dropLevel.dropDown.enabled = false

	if WeekWalkModel.instance:getChangeLevel() > 0 then
		return
	end

	arg_36_0:openWeekWalkView()
end

function var_0_0.openWeekWalkView(arg_37_0)
	module_views_preloader.WeekWalkLayerViewPreload(function()
		arg_37_0:delayOpenWeekWalkView()
	end)
end

function var_0_0.delayOpenWeekWalkView(arg_39_0)
	WeekWalkController.instance:openWeekWalkLayerView()
end

function var_0_0._onOpenViewFinish(arg_40_0, arg_40_1)
	if arg_40_1 == ViewName.WeekWalkLayerView or arg_40_1 == ViewName.WeekWalk_2HeartLayerView or arg_40_1 == ViewName.StoreView then
		local var_40_0 = ViewMgr.instance:getContainer(ViewName.DungeonView)
		local var_40_1 = gohelper.findChild(var_40_0.viewGO, "top_left")

		gohelper.setActive(var_40_1, true)
	end
end

function var_0_0._onOpenView(arg_41_0, arg_41_1)
	if arg_41_1 == ViewName.WeekWalkLayerView then
		-- block empty
	end

	if arg_41_1 == ViewName.WeekWalkLayerView or arg_41_1 == ViewName.WeekWalk_2HeartLayerView or arg_41_1 == ViewName.StoreView then
		if arg_41_1 == ViewName.WeekWalk_2HeartLayerView then
			if ViewMgr.instance:isOpen(ViewName.WeekWalk_2HeartView) then
				return
			end

			arg_41_0._viewAnim:Play("dungeonweekwalk_out2", 0, 0)
		else
			arg_41_0._viewAnim:Play("dungeonweekwalk_out", 0, 0)
		end

		local var_41_0 = ViewMgr.instance:getContainer(ViewName.DungeonView)

		gohelper.setAsLastSibling(var_41_0.viewGO)

		local var_41_1 = gohelper.findChild(var_41_0.viewGO, "top_left")

		gohelper.setActive(var_41_1, false)
	end
end

function var_0_0._onCloseView(arg_42_0, arg_42_1)
	if arg_42_1 == ViewName.WeekWalkLayerView then
		arg_42_0:_showProgress()
		arg_42_0:_showWeekWalkSettlementView()
		arg_42_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif arg_42_1 == ViewName.StoreView then
		arg_42_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif arg_42_1 == ViewName.WeekWalkRewardView then
		arg_42_0:_onWeekwalkTaskUpdate()
	elseif arg_42_1 == ViewName.WeekWalk_2HeartLayerView then
		arg_42_0:_showProgress2()
		arg_42_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	end
end

function var_0_0.onClose(arg_43_0)
	arg_43_0:onHide()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_43_0._refreshHelpFunc, arg_43_0._refreshTarget)
end

function var_0_0._clearOnDestroy(arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0.delayOpenWeekWalkView, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._openStoreView, arg_44_0)
	arg_44_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, arg_44_0._OnSelectLevel, arg_44_0)
	arg_44_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_44_0._onCloseView, arg_44_0, LuaEventSystem.Low)
	arg_44_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_44_0._onOpenView, arg_44_0, LuaEventSystem.Low)
	arg_44_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_44_0._onOpenViewFinish, arg_44_0, LuaEventSystem.Low)
	arg_44_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_44_0._onWeekwalkTaskUpdate, arg_44_0)
	arg_44_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_44_0._onGetInfo, arg_44_0)
	arg_44_0:removeEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, arg_44_0._onGetInfo, arg_44_0)
	arg_44_0:removeEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_44_0._onFinishGuide, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._onRefreshDeadline, arg_44_0)
end

function var_0_0.onDestroyView(arg_45_0)
	arg_45_0:_clearOnDestroy()
	arg_45_0._simagexingdian1:UnLoadImage()
	arg_45_0._simagelefttopglow:UnLoadImage()
	arg_45_0._simagelefttopglow2:UnLoadImage()
	arg_45_0._simageleftdownglow:UnLoadImage()
	arg_45_0._simagerihtttopglow:UnLoadImage()
	arg_45_0._simagerihtttopblack:UnLoadImage()
	arg_45_0._simagecenterdown:UnLoadImage()
end

return var_0_0
