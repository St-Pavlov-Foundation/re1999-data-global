module("modules.logic.activity.view.warmup.ActivityWarmUpView", package.seeall)

local var_0_0 = class("ActivityWarmUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagebg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_main/#simage_bg3")
	arg_1_0._simagebg4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_main/#simage_bg4")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_btns")
	arg_1_0._simagemap = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_main/#simage_map")
	arg_1_0._godayitem = gohelper.findChild(arg_1_0.viewGO, "#go_main/#scroll_daylist/Viewport/Content/#go_dayitem")
	arg_1_0._gochangllenitem = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_area/#go_changllenitem")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_main/#btn_extra/#go_reddot")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/#btn_extra/#btn_task")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "#go_main/#txt_remaintime")
	arg_1_0._gowelcome = gohelper.findChild(arg_1_0.viewGO, "#go_welcome")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_welcome/#btn_start")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "#go_main")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
end

var_0_0.OrderMaxPos = 4

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("full/bj003"))
	arg_4_0._simagebg3:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi6"))

	arg_4_0._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._simagebg3.gameObject, SingleBgToMaterial)

	arg_4_0._bgMaterial:loadMaterial(arg_4_0._simagebg3, "ui_black2transparent")
	arg_4_0._simagebg4:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi7"))

	arg_4_0._animtorSelf = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._posListX = {}
	arg_4_0._posListY = {}

	for iter_4_0 = 1, var_0_0.OrderMaxPos do
		local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "#go_main/#go_area/#go_pos" .. iter_4_0)
		local var_4_1, var_4_2 = recthelper.getAnchor(var_4_0.transform)

		arg_4_0._posListX[iter_4_0], arg_4_0._posListY[iter_4_0] = var_4_1, var_4_2
	end

	arg_4_0._tabItems = {}
	arg_4_0._orderItems = {}

	gohelper.setActive(arg_4_0._gowelcome, false)
	gohelper.setActive(arg_4_0._gomain, true)

	arg_4_0._imageBossFrameTab = arg_4_0:getUserDataTb_()
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._tabItems) do
		iter_5_1.btn:RemoveClickListener()
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0._orderItems) do
		iter_5_3.btnDetail:RemoveClickListener()
		iter_5_3.btnPlay:RemoveClickListener()
		iter_5_3.btnGoto:RemoveClickListener()
		iter_5_3.btnFinishInfo:RemoveClickListener()
	end

	for iter_5_4, iter_5_5 in pairs(arg_5_0._imageBossFrameTab) do
		iter_5_5:UnLoadImage()
	end

	arg_5_0._simagebg:UnLoadImage()
	arg_5_0._simagebg3:UnLoadImage()
	arg_5_0._bgMaterial:dispose()
	arg_5_0._simagebg4:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent
	local var_6_1 = arg_6_0.viewParam.actId

	gohelper.addChild(var_6_0, arg_6_0.viewGO)
	arg_6_0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderFinish, arg_6_0.onPlayOrderFinish, arg_6_0)
	arg_6_0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderCancel, arg_6_0.onPlayOrderCancel, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_6_0.onCloseViewFinishCall, arg_6_0)
	ActivityWarmUpController.instance:init(var_6_1)
	Activity106Rpc.instance:sendGet106InfosRequest(var_6_1)

	local var_6_2, var_6_3 = ActivityWarmUpController.instance:getRedDotParam()

	if var_6_2 ~= nil then
		RedDotController.instance:addRedDot(arg_6_0._goreddot, var_6_2, var_6_3)
	end

	TaskDispatcher.runRepeat(arg_6_0.refreshRemainTime, arg_6_0, 1)
	arg_6_0:checkFirstShowHelp(var_6_1)
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderFinish, arg_7_0.onPlayOrderFinish, arg_7_0)
	arg_7_0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderCancel, arg_7_0.onPlayOrderCancel, arg_7_0)
	arg_7_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_7_0.onCloseViewFinishCall, arg_7_0)
	gohelper.setActive(arg_7_0._gomain, true)
	gohelper.setActive(arg_7_0._gowelcome, false)
	TaskDispatcher.cancelTask(arg_7_0.refreshRemainTime, arg_7_0)
end

function var_0_0.checkFirstShowHelp(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getFirstHelpKey()
	local var_8_1 = PlayerPrefsHelper.getString(var_8_0, "")

	if string.nilorempty(var_8_1) then
		gohelper.setActive(arg_8_0._gomain, false)
		gohelper.setActive(arg_8_0._gowelcome, true)
	end
end

function var_0_0.onWelcomeUIClose(arg_9_0)
	gohelper.setActive(arg_9_0._gomain, true)

	local var_9_0 = arg_9_0:getFirstHelpKey()

	PlayerPrefsHelper.setString(var_9_0, "watched")
	HelpController.instance:showHelp(HelpEnum.HelpId.ActivityWarmUp)
end

function var_0_0.getFirstHelpKey(arg_10_0)
	local var_10_0 = arg_10_0.viewParam.actId

	return "ActivityWarmUpViewHelp#" .. tostring(var_10_0) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0:refreshAllTabBtns()
	arg_11_0:refreshAllOrder()
	arg_11_0:refreshRemainTime()
end

function var_0_0.refreshAllTabBtns(arg_12_0)
	local var_12_0 = ActivityWarmUpModel.instance:getTotalContentDays()
	local var_12_1 = ActivityWarmUpModel.instance:getCurrentDay()

	for iter_12_0 = 1, var_12_0 do
		local var_12_2 = arg_12_0:getOrCreateTabItem(iter_12_0)

		arg_12_0:refreshTabBtn(var_12_2, iter_12_0)
	end
end

function var_0_0.refreshTabBtn(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ActivityWarmUpModel.instance:getCurrentDay()

	gohelper.setActive(arg_13_1.go, true)

	local var_13_1 = tostring(arg_13_2)

	UISpriteSetMgr.instance:setActivityWarmUpSprite(arg_13_1.imageUnchooseDay, "xi_0" .. arg_13_2)
	UISpriteSetMgr.instance:setActivityWarmUpSprite(arg_13_1.imageChooseDay, "da_0" .. arg_13_2)

	local var_13_2 = ActivityWarmUpModel.instance:getSelectedDay() == arg_13_2

	gohelper.setActive(arg_13_1.goChoose, var_13_2)
	gohelper.setActive(arg_13_1.goUnchoose, not var_13_2)
	gohelper.setActive(arg_13_1.goLock, var_13_0 < arg_13_2)
end

function var_0_0.refreshRemainTime(arg_14_0)
	local var_14_0 = ActivityWarmUpModel.instance:getActId()
	local var_14_1 = ActivityModel.instance:getActMO(var_14_0)

	if var_14_1 then
		local var_14_2 = var_14_1.endTime / 1000 - ServerTime.now()
		local var_14_3, var_14_4 = TimeUtil.secondToRoughTime2(var_14_2)

		arg_14_0._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), var_14_3 .. var_14_4)
	else
		arg_14_0._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), "--")
	end
end

function var_0_0.getOrCreateTabItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._tabItems[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()

		local var_15_1 = gohelper.cloneInPlace(arg_15_0._godayitem, "tabitem_" .. tostring(arg_15_1))

		var_15_0.go = var_15_1
		var_15_0.goUnchoose = gohelper.findChild(var_15_1, "go_unselected")
		var_15_0.goChoose = gohelper.findChild(var_15_1, "go_selected")
		var_15_0.imageUnchooseDay = gohelper.findChildImage(var_15_1, "go_unselected/day")
		var_15_0.imageChooseDay = gohelper.findChildImage(var_15_1, "go_selected/day")
		var_15_0.goLock = gohelper.findChild(var_15_1, "go_lock")
		var_15_0.btn = gohelper.findChildButtonWithAudio(var_15_1, "btn_click")

		var_15_0.btn:AddClickListener(var_0_0.onClickTabItem, {
			self = arg_15_0,
			index = arg_15_1
		})

		arg_15_0._tabItems[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.refreshAllOrder(arg_16_0)
	arg_16_0._processedItemSet = arg_16_0._processedItemSet or {}

	local var_16_0 = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			arg_16_0:refreshOrder(iter_16_0, iter_16_1)
		end
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0._orderItems) do
		if not arg_16_0._processedItemSet[iter_16_3] then
			gohelper.setActive(iter_16_3.go, false)
		end
	end

	for iter_16_4, iter_16_5 in pairs(arg_16_0._processedItemSet) do
		arg_16_0._processedItemSet[iter_16_4] = nil
	end
end

function var_0_0.refreshOrder(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 > var_0_0.OrderMaxPos then
		logError("order config count error : " .. tostring(arg_17_1) .. ", max is " .. tostring(var_0_0.OrderMaxPos))

		return
	end

	local var_17_0 = arg_17_0:getOrCreateOrderItem(arg_17_1)

	gohelper.setActive(var_17_0.go, true)

	var_17_0.txtName.text = tostring(arg_17_2.cfg.name)
	var_17_0.txtLocation.text = tostring(string.format(luaLang("activity_warmup_location"), arg_17_2.cfg.location))

	UISpriteSetMgr.instance:setActivityWarmUpSprite(var_17_0.imageBoss, arg_17_2.cfg.bossPic)

	if (var_17_0.orderActId ~= arg_17_2.cfg.activityId or var_17_0.orderId ~= arg_17_2.cfg.id) and var_17_0.animOrderFinish.isActiveAndEnabled then
		var_17_0.animOrderFinish:Play(UIAnimationName.Idle)
	end

	var_17_0.orderActId = arg_17_2.cfg.activityId
	var_17_0.orderId = arg_17_2.cfg.id

	local var_17_1 = ActivityWarmUpEnum.Quality2FramePath[arg_17_2.cfg.rare]

	if not string.nilorempty(var_17_1) then
		gohelper.setActive(var_17_0.imageBossFrame.gameObject, true)
		var_17_0.imageBossFrame:LoadImage(ResUrl.getActivityWarmUpLangIcon(var_17_1))
		table.insert(arg_17_0._imageBossFrameTab, var_17_0.imageBossFrame)
	else
		gohelper.setActive(var_17_0.imageBossFrame.gameObject, false)
	end

	local var_17_2 = arg_17_2:getStatus()

	gohelper.setActive(var_17_0.btnPlay.gameObject, var_17_2 == ActivityWarmUpEnum.OrderStatus.Collected)
	gohelper.setActive(var_17_0.btnGoto.gameObject, var_17_2 == ActivityWarmUpEnum.OrderStatus.Accepted)
	gohelper.setActive(var_17_0.btnFinishInfo.gameObject, var_17_2 == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(var_17_0.goFinish, var_17_2 == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(var_17_0.btnDetail.gameObject, var_17_2 ~= ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(var_17_0.goOrderFinish, var_17_2 == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(var_17_0.goOrderRunning, var_17_2 ~= ActivityWarmUpEnum.OrderStatus.Finished)

	if var_17_2 == ActivityWarmUpEnum.OrderStatus.Accepted or var_17_2 == ActivityWarmUpEnum.OrderStatus.Collected then
		gohelper.setActive(var_17_0.txtProgress.gameObject, true)

		local var_17_3 = arg_17_2.progress or 0
		local var_17_4 = arg_17_2.cfg.maxProgress

		var_17_0.txtProgress.text = string.format("%s/%s", var_17_3, var_17_4)
	elseif var_17_2 == ActivityWarmUpEnum.OrderStatus.Finished then
		gohelper.setActive(var_17_0.txtProgress.gameObject, true)

		var_17_0.txtProgress.text = luaLang("p_task_get")
		var_17_0.txtNewsInfo.text = ActivityWarmUpModel.getBriefName(arg_17_2.cfg.infoDesc, 96, "...")
	else
		gohelper.setActive(var_17_0.txtProgress.gameObject, false)
	end

	arg_17_0._processedItemSet[var_17_0] = true
end

function var_0_0.getOrCreateOrderItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._orderItems[arg_18_1]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()

		local var_18_1 = gohelper.cloneInPlace(arg_18_0._gochangllenitem, "orderitem_" .. tostring(arg_18_1))

		var_18_0.go = var_18_1
		var_18_0.txtName = gohelper.findChildText(var_18_1, "go_unpassgame/txt_title")
		var_18_0.txtProgress = gohelper.findChildText(var_18_1, "go_unpassgame/txt_progress")
		var_18_0.txtLocation = gohelper.findChildText(var_18_1, "go_unpassgame/txt_bossdesc")
		var_18_0.imageBoss = gohelper.findChildImage(var_18_1, "go_unpassgame/image_icon")
		var_18_0.imageBossFrame = gohelper.findChildSingleImage(var_18_1, "go_unpassgame/image_iconbg")
		var_18_0.btnPlay = gohelper.findChildButtonWithAudio(var_18_1, "go_unpassgame/btn_challenge")
		var_18_0.btnDetail = gohelper.findChildButtonWithAudio(var_18_1, "go_unpassgame/btn_detail")
		var_18_0.btnGoto = gohelper.findChildButtonWithAudio(var_18_1, "go_unpassgame/btn_goto")
		var_18_0.btnFinishInfo = gohelper.findChildButtonWithAudio(var_18_1, "go_passgame/btn_news")
		var_18_0.goFinish = gohelper.findChild(var_18_1, "go_unpassgame/go_finish")
		var_18_0.goOrderRunning = gohelper.findChild(var_18_1, "go_unpassgame")
		var_18_0.goOrderFinish = gohelper.findChild(var_18_1, "go_passgame")
		var_18_0.animOrderFinish = var_18_0.goOrderFinish:GetComponent(typeof(UnityEngine.Animator))
		var_18_0.txtBossDesc = gohelper.findChild(var_18_1, "go_unpassgame/txt_bossdesc")
		var_18_0.txtNewsInfo = gohelper.findChildText(var_18_1, "go_passgame/txt_newsinfo")

		local var_18_2 = {
			self = arg_18_0,
			index = arg_18_1
		}

		var_18_0.btnPlay:AddClickListener(arg_18_0.onClickPlayOrder, var_18_2)
		var_18_0.btnDetail:AddClickListener(arg_18_0.onClickDetailOrder, var_18_2)
		var_18_0.btnGoto:AddClickListener(arg_18_0.onClickGotoOrder, var_18_2)
		var_18_0.btnFinishInfo:AddClickListener(arg_18_0.onClickFinishInfoOrder, var_18_2)
		recthelper.setAnchor(var_18_0.go.transform, arg_18_0._posListX[arg_18_1], arg_18_0._posListY[arg_18_1])

		arg_18_0._orderItems[arg_18_1] = var_18_0
	end

	return var_18_0
end

function var_0_0.onClickTabItem(arg_19_0)
	local var_19_0 = arg_19_0.self
	local var_19_1 = arg_19_0.index
	local var_19_2 = var_19_1 > ActivityWarmUpModel.instance:getCurrentDay()

	if ActivityWarmUpModel.instance:getSelectedDay() ~= var_19_1 and not var_19_2 then
		ActivityWarmUpController.instance:switchTab(var_19_1)
	end
end

function var_0_0.onClickPlayOrder(arg_20_0)
	local var_20_0 = arg_20_0.self
	local var_20_1 = arg_20_0.index
	local var_20_2 = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if var_20_1 <= #var_20_2 then
		local var_20_3 = var_20_2[var_20_1]

		ActivityWarmUpController.instance:focusOrderGame(var_20_3.id)
		ActivityWarmUpGameController.instance:openGameView(var_20_3.cfg.gameSetting)
	end
end

function var_0_0.onClickDetailOrder(arg_21_0)
	local var_21_0 = arg_21_0.self
	local var_21_1 = arg_21_0.index
	local var_21_2 = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if var_21_1 <= #var_21_2 then
		local var_21_3 = var_21_2[var_21_1].cfg

		ViewMgr.instance:openView(ViewName.ActivityWarmUpTips, {
			actId = var_21_3.activityId,
			orderId = var_21_3.id
		})
	end
end

function var_0_0.onClickGotoOrder(arg_22_0)
	local var_22_0 = arg_22_0.self
	local var_22_1 = arg_22_0.index
	local var_22_2 = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if var_22_1 <= #var_22_2 then
		local var_22_3 = var_22_2[var_22_1].cfg
		local var_22_4, var_22_5 = ActivityWarmUpController.instance:cantJumpDungeonGetName(var_22_3.jumpId)

		if var_22_4 then
			GameFacade.showToast(ToastEnum.WarmUpGotoOrder, var_22_5)
		else
			JumpController.instance:jump(var_22_3.jumpId)
		end
	end
end

function var_0_0.onClickFinishInfoOrder(arg_23_0)
	local var_23_0 = arg_23_0.self
	local var_23_1 = arg_23_0.index
	local var_23_2 = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if var_23_1 <= #var_23_2 then
		local var_23_3 = var_23_2[var_23_1].cfg

		ViewMgr.instance:openView(ViewName.ActivityWarmUpNews, {
			actId = var_23_3.activityId,
			orderId = var_23_3.id
		})
	end
end

function var_0_0.onPlayOrderCancel(arg_24_0)
	arg_24_0._finishedActId, arg_24_0._finishedOrderId = nil
end

function var_0_0.onPlayOrderFinish(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.actId
	local var_25_1 = arg_25_1.orderId

	logNormal("onPlayOrderFinish actId = " .. tostring(var_25_0) .. ", orderId = " .. tostring(var_25_1))

	arg_25_0._finishedActId, arg_25_0._finishedOrderId = var_25_0, var_25_1
end

function var_0_0.onCloseViewFinishCall(arg_26_0, arg_26_1)
	if arg_26_1 == ViewName.ActivityWarmUpGameView and arg_26_0._finishedActId and arg_26_0._finishedOrderId then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._orderItems) do
			if iter_26_1.orderActId == arg_26_0._finishedActId and iter_26_1.orderId == arg_26_0._finishedOrderId then
				iter_26_1.animOrderFinish:Play(UIAnimationName.Open, 0, 0)
			elseif iter_26_1.animOrderFinish.isActiveAndEnabled then
				iter_26_1.animOrderFinish:Play(UIAnimationName.Idle)
			end
		end
	end
end

function var_0_0._btntaskOnClick(arg_27_0)
	local var_27_0 = ActivityWarmUpModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.ActivityWarmUpTask, {
		actId = var_27_0,
		index = ActivityWarmUpModel.instance:getSelectedDay()
	})
end

function var_0_0._btnstartOnClick(arg_28_0)
	gohelper.setActive(arg_28_0._gowelcome, false)
	arg_28_0:onWelcomeUIClose()
end

return var_0_0
