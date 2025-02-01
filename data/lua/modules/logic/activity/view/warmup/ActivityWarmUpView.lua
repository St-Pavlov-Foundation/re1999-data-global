module("modules.logic.activity.view.warmup.ActivityWarmUpView", package.seeall)

slot0 = class("ActivityWarmUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagebg3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_main/#simage_bg3")
	slot0._simagebg4 = gohelper.findChildSingleImage(slot0.viewGO, "#go_main/#simage_bg4")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_main/#go_btns")
	slot0._simagemap = gohelper.findChildSingleImage(slot0.viewGO, "#go_main/#simage_map")
	slot0._godayitem = gohelper.findChild(slot0.viewGO, "#go_main/#scroll_daylist/Viewport/Content/#go_dayitem")
	slot0._gochangllenitem = gohelper.findChild(slot0.viewGO, "#go_main/#go_area/#go_changllenitem")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_main/#btn_extra/#go_reddot")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#btn_extra/#btn_task")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "#go_main/#txt_remaintime")
	slot0._gowelcome = gohelper.findChild(slot0.viewGO, "#go_welcome")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_welcome/#btn_start")
	slot0._gomain = gohelper.findChild(slot0.viewGO, "#go_main")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
end

slot0.OrderMaxPos = 4

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("full/bj003"))
	slot0._simagebg3:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi6"))

	slot0._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._simagebg3.gameObject, SingleBgToMaterial)

	slot0._bgMaterial:loadMaterial(slot0._simagebg3, "ui_black2transparent")
	slot0._simagebg4:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi7"))

	slot4 = UnityEngine.Animator
	slot0._animtorSelf = slot0.viewGO:GetComponent(typeof(slot4))
	slot0._posListX = {}
	slot0._posListY = {}

	for slot4 = 1, uv0.OrderMaxPos do
		slot0._posListX[slot4], slot0._posListY[slot4] = recthelper.getAnchor(gohelper.findChild(slot0.viewGO, "#go_main/#go_area/#go_pos" .. slot4).transform)
	end

	slot0._tabItems = {}
	slot0._orderItems = {}

	gohelper.setActive(slot0._gowelcome, false)
	gohelper.setActive(slot0._gomain, true)

	slot0._imageBossFrameTab = slot0:getUserDataTb_()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._tabItems) do
		slot5.btn:RemoveClickListener()
	end

	for slot4, slot5 in pairs(slot0._orderItems) do
		slot5.btnDetail:RemoveClickListener()
		slot5.btnPlay:RemoveClickListener()
		slot5.btnGoto:RemoveClickListener()
		slot5.btnFinishInfo:RemoveClickListener()
	end

	for slot4, slot5 in pairs(slot0._imageBossFrameTab) do
		slot5:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagebg3:UnLoadImage()
	slot0._bgMaterial:dispose()
	slot0._simagebg4:UnLoadImage()
end

function slot0.onOpen(slot0)
	slot2 = slot0.viewParam.actId

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderFinish, slot0.onPlayOrderFinish, slot0)
	slot0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderCancel, slot0.onPlayOrderCancel, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinishCall, slot0)
	ActivityWarmUpController.instance:init(slot2)
	Activity106Rpc.instance:sendGet106InfosRequest(slot2)

	slot3, slot4 = ActivityWarmUpController.instance:getRedDotParam()

	if slot3 ~= nil then
		RedDotController.instance:addRedDot(slot0._goreddot, slot3, slot4)
	end

	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
	slot0:checkFirstShowHelp(slot2)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, slot0.refreshUI, slot0)
	slot0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, slot0.refreshUI, slot0)
	slot0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderFinish, slot0.onPlayOrderFinish, slot0)
	slot0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.PlayOrderCancel, slot0.onPlayOrderCancel, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinishCall, slot0)
	gohelper.setActive(slot0._gomain, true)
	gohelper.setActive(slot0._gowelcome, false)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.checkFirstShowHelp(slot0, slot1)
	if string.nilorempty(PlayerPrefsHelper.getString(slot0:getFirstHelpKey(), "")) then
		gohelper.setActive(slot0._gomain, false)
		gohelper.setActive(slot0._gowelcome, true)
	end
end

function slot0.onWelcomeUIClose(slot0)
	gohelper.setActive(slot0._gomain, true)
	PlayerPrefsHelper.setString(slot0:getFirstHelpKey(), "watched")
	HelpController.instance:showHelp(HelpEnum.HelpId.ActivityWarmUp)
end

function slot0.getFirstHelpKey(slot0)
	return "ActivityWarmUpViewHelp#" .. tostring(slot0.viewParam.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function slot0.refreshUI(slot0)
	slot0:refreshAllTabBtns()
	slot0:refreshAllOrder()
	slot0:refreshRemainTime()
end

function slot0.refreshAllTabBtns(slot0)
	slot2 = ActivityWarmUpModel.instance:getCurrentDay()

	for slot6 = 1, ActivityWarmUpModel.instance:getTotalContentDays() do
		slot0:refreshTabBtn(slot0:getOrCreateTabItem(slot6), slot6)
	end
end

function slot0.refreshTabBtn(slot0, slot1, slot2)
	gohelper.setActive(slot1.go, true)

	slot4 = tostring(slot2)

	UISpriteSetMgr.instance:setActivityWarmUpSprite(slot1.imageUnchooseDay, "xi_0" .. slot2)
	UISpriteSetMgr.instance:setActivityWarmUpSprite(slot1.imageChooseDay, "da_0" .. slot2)

	slot5 = ActivityWarmUpModel.instance:getSelectedDay() == slot2

	gohelper.setActive(slot1.goChoose, slot5)
	gohelper.setActive(slot1.goUnchoose, not slot5)
	gohelper.setActive(slot1.goLock, ActivityWarmUpModel.instance:getCurrentDay() < slot2)
end

function slot0.refreshRemainTime(slot0)
	if ActivityModel.instance:getActMO(ActivityWarmUpModel.instance:getActId()) then
		slot4, slot5 = TimeUtil.secondToRoughTime2(slot2.endTime / 1000 - ServerTime.now())
		slot0._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), slot4 .. slot5)
	else
		slot0._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), "--")
	end
end

function slot0.getOrCreateTabItem(slot0, slot1)
	if not slot0._tabItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._godayitem, "tabitem_" .. tostring(slot1))
		slot2.go = slot3
		slot2.goUnchoose = gohelper.findChild(slot3, "go_unselected")
		slot2.goChoose = gohelper.findChild(slot3, "go_selected")
		slot2.imageUnchooseDay = gohelper.findChildImage(slot3, "go_unselected/day")
		slot2.imageChooseDay = gohelper.findChildImage(slot3, "go_selected/day")
		slot2.goLock = gohelper.findChild(slot3, "go_lock")
		slot2.btn = gohelper.findChildButtonWithAudio(slot3, "btn_click")

		slot2.btn:AddClickListener(uv0.onClickTabItem, {
			self = slot0,
			index = slot1
		})

		slot0._tabItems[slot1] = slot2
	end

	return slot2
end

function slot0.refreshAllOrder(slot0)
	slot0._processedItemSet = slot0._processedItemSet or {}

	if ActivityWarmUpModel.instance:getSelectedDayOrders() then
		for slot5, slot6 in ipairs(slot1) do
			slot0:refreshOrder(slot5, slot6)
		end
	end

	for slot5, slot6 in pairs(slot0._orderItems) do
		if not slot0._processedItemSet[slot6] then
			gohelper.setActive(slot6.go, false)
		end
	end

	for slot5, slot6 in pairs(slot0._processedItemSet) do
		slot0._processedItemSet[slot5] = nil
	end
end

function slot0.refreshOrder(slot0, slot1, slot2)
	if uv0.OrderMaxPos < slot1 then
		logError("order config count error : " .. tostring(slot1) .. ", max is " .. tostring(uv0.OrderMaxPos))

		return
	end

	slot3 = slot0:getOrCreateOrderItem(slot1)

	gohelper.setActive(slot3.go, true)

	slot3.txtName.text = tostring(slot2.cfg.name)
	slot3.txtLocation.text = tostring(string.format(luaLang("activity_warmup_location"), slot2.cfg.location))

	UISpriteSetMgr.instance:setActivityWarmUpSprite(slot3.imageBoss, slot2.cfg.bossPic)

	if (slot3.orderActId ~= slot2.cfg.activityId or slot3.orderId ~= slot2.cfg.id) and slot3.animOrderFinish.isActiveAndEnabled then
		slot3.animOrderFinish:Play(UIAnimationName.Idle)
	end

	slot3.orderActId = slot2.cfg.activityId
	slot3.orderId = slot2.cfg.id

	if not string.nilorempty(ActivityWarmUpEnum.Quality2FramePath[slot2.cfg.rare]) then
		gohelper.setActive(slot3.imageBossFrame.gameObject, true)
		slot3.imageBossFrame:LoadImage(ResUrl.getActivityWarmUpLangIcon(slot4))
		table.insert(slot0._imageBossFrameTab, slot3.imageBossFrame)
	else
		gohelper.setActive(slot3.imageBossFrame.gameObject, false)
	end

	gohelper.setActive(slot3.btnPlay.gameObject, slot2:getStatus() == ActivityWarmUpEnum.OrderStatus.Collected)
	gohelper.setActive(slot3.btnGoto.gameObject, slot5 == ActivityWarmUpEnum.OrderStatus.Accepted)
	gohelper.setActive(slot3.btnFinishInfo.gameObject, slot5 == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(slot3.goFinish, slot5 == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(slot3.btnDetail.gameObject, slot5 ~= ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(slot3.goOrderFinish, slot5 == ActivityWarmUpEnum.OrderStatus.Finished)
	gohelper.setActive(slot3.goOrderRunning, slot5 ~= ActivityWarmUpEnum.OrderStatus.Finished)

	if slot5 == ActivityWarmUpEnum.OrderStatus.Accepted or slot5 == ActivityWarmUpEnum.OrderStatus.Collected then
		gohelper.setActive(slot3.txtProgress.gameObject, true)

		slot3.txtProgress.text = string.format("%s/%s", slot2.progress or 0, slot2.cfg.maxProgress)
	elseif slot5 == ActivityWarmUpEnum.OrderStatus.Finished then
		gohelper.setActive(slot3.txtProgress.gameObject, true)

		slot3.txtProgress.text = luaLang("p_task_get")
		slot3.txtNewsInfo.text = ActivityWarmUpModel.getBriefName(slot2.cfg.infoDesc, 96, "...")
	else
		gohelper.setActive(slot3.txtProgress.gameObject, false)
	end

	slot0._processedItemSet[slot3] = true
end

function slot0.getOrCreateOrderItem(slot0, slot1)
	if not slot0._orderItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gochangllenitem, "orderitem_" .. tostring(slot1))
		slot2.go = slot3
		slot2.txtName = gohelper.findChildText(slot3, "go_unpassgame/txt_title")
		slot2.txtProgress = gohelper.findChildText(slot3, "go_unpassgame/txt_progress")
		slot2.txtLocation = gohelper.findChildText(slot3, "go_unpassgame/txt_bossdesc")
		slot2.imageBoss = gohelper.findChildImage(slot3, "go_unpassgame/image_icon")
		slot2.imageBossFrame = gohelper.findChildSingleImage(slot3, "go_unpassgame/image_iconbg")
		slot2.btnPlay = gohelper.findChildButtonWithAudio(slot3, "go_unpassgame/btn_challenge")
		slot2.btnDetail = gohelper.findChildButtonWithAudio(slot3, "go_unpassgame/btn_detail")
		slot2.btnGoto = gohelper.findChildButtonWithAudio(slot3, "go_unpassgame/btn_goto")
		slot2.btnFinishInfo = gohelper.findChildButtonWithAudio(slot3, "go_passgame/btn_news")
		slot2.goFinish = gohelper.findChild(slot3, "go_unpassgame/go_finish")
		slot2.goOrderRunning = gohelper.findChild(slot3, "go_unpassgame")
		slot2.goOrderFinish = gohelper.findChild(slot3, "go_passgame")
		slot2.animOrderFinish = slot2.goOrderFinish:GetComponent(typeof(UnityEngine.Animator))
		slot2.txtBossDesc = gohelper.findChild(slot3, "go_unpassgame/txt_bossdesc")
		slot2.txtNewsInfo = gohelper.findChildText(slot3, "go_passgame/txt_newsinfo")
		slot4 = {
			self = slot0,
			index = slot1
		}

		slot2.btnPlay:AddClickListener(slot0.onClickPlayOrder, slot4)
		slot2.btnDetail:AddClickListener(slot0.onClickDetailOrder, slot4)
		slot2.btnGoto:AddClickListener(slot0.onClickGotoOrder, slot4)
		slot2.btnFinishInfo:AddClickListener(slot0.onClickFinishInfoOrder, slot4)
		recthelper.setAnchor(slot2.go.transform, slot0._posListX[slot1], slot0._posListY[slot1])

		slot0._orderItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClickTabItem(slot0)
	slot1 = slot0.self

	if ActivityWarmUpModel.instance:getSelectedDay() ~= slot2 and not (ActivityWarmUpModel.instance:getCurrentDay() < slot0.index) then
		ActivityWarmUpController.instance:switchTab(slot2)
	end
end

function slot0.onClickPlayOrder(slot0)
	slot1 = slot0.self

	if slot0.index <= #ActivityWarmUpModel.instance:getSelectedDayOrders() then
		slot4 = slot3[slot2]

		ActivityWarmUpController.instance:focusOrderGame(slot4.id)
		ActivityWarmUpGameController.instance:openGameView(slot4.cfg.gameSetting)
	end
end

function slot0.onClickDetailOrder(slot0)
	slot1 = slot0.self

	if slot0.index <= #ActivityWarmUpModel.instance:getSelectedDayOrders() then
		slot4 = slot3[slot2].cfg

		ViewMgr.instance:openView(ViewName.ActivityWarmUpTips, {
			actId = slot4.activityId,
			orderId = slot4.id
		})
	end
end

function slot0.onClickGotoOrder(slot0)
	slot1 = slot0.self

	if slot0.index <= #ActivityWarmUpModel.instance:getSelectedDayOrders() then
		slot5, slot6 = ActivityWarmUpController.instance:cantJumpDungeonGetName(slot3[slot2].cfg.jumpId)

		if slot5 then
			GameFacade.showToast(ToastEnum.WarmUpGotoOrder, slot6)
		else
			JumpController.instance:jump(slot4.jumpId)
		end
	end
end

function slot0.onClickFinishInfoOrder(slot0)
	slot1 = slot0.self

	if slot0.index <= #ActivityWarmUpModel.instance:getSelectedDayOrders() then
		slot4 = slot3[slot2].cfg

		ViewMgr.instance:openView(ViewName.ActivityWarmUpNews, {
			actId = slot4.activityId,
			orderId = slot4.id
		})
	end
end

function slot0.onPlayOrderCancel(slot0)
	slot0._finishedOrderId = nil
	slot0._finishedActId = nil
end

function slot0.onPlayOrderFinish(slot0, slot1)
	slot2 = slot1.actId
	slot3 = slot1.orderId

	logNormal("onPlayOrderFinish actId = " .. tostring(slot2) .. ", orderId = " .. tostring(slot3))

	slot0._finishedOrderId = slot3
	slot0._finishedActId = slot2
end

function slot0.onCloseViewFinishCall(slot0, slot1)
	if slot1 == ViewName.ActivityWarmUpGameView and slot0._finishedActId and slot0._finishedOrderId then
		for slot5, slot6 in pairs(slot0._orderItems) do
			if slot6.orderActId == slot0._finishedActId and slot6.orderId == slot0._finishedOrderId then
				slot6.animOrderFinish:Play(UIAnimationName.Open, 0, 0)
			elseif slot6.animOrderFinish.isActiveAndEnabled then
				slot6.animOrderFinish:Play(UIAnimationName.Idle)
			end
		end
	end
end

function slot0._btntaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ActivityWarmUpTask, {
		actId = ActivityWarmUpModel.instance:getActId(),
		index = ActivityWarmUpModel.instance:getSelectedDay()
	})
end

function slot0._btnstartOnClick(slot0)
	gohelper.setActive(slot0._gowelcome, false)
	slot0:onWelcomeUIClose()
end

return slot0
