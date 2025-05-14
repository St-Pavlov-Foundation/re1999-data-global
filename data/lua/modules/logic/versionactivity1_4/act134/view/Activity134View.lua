module("modules.logic.versionactivity1_4.act134.view.Activity134View", package.seeall)

local var_0_0 = class("Activity134View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._txtdue = gohelper.findChildText(arg_1_0.viewGO, "Right/bg_normal/#txt_due")
	arg_1_0._txtrightrecordtitle = gohelper.findChildText(arg_1_0.viewGO, "Right/bg_normal/#txt_title")
	arg_1_0._txtpage = gohelper.findChildText(arg_1_0.viewGO, "Right/bg_normal/#txt_page")
	arg_1_0._scrollviewright = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#scroll_view")
	arg_1_0._goreportitem = gohelper.findChild(arg_1_0.viewGO, "Right/#scroll_view/Viewport/Content/#go_reportitem")
	arg_1_0._btnobtain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_obtain")
	arg_1_0._btnleftswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_leftswitch")
	arg_1_0._btnrightswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_rightswitch")
	arg_1_0._goleftswitchboundary = gohelper.findChild(arg_1_0._btnleftswitch.gameObject, "boundary")
	arg_1_0._gorightswitchboundary = gohelper.findChild(arg_1_0._btnrightswitch.gameObject, "boundary")
	arg_1_0._goleftswitchnormal = gohelper.findChild(arg_1_0._btnleftswitch.gameObject, "normal")
	arg_1_0._gorightswitchnormal = gohelper.findChild(arg_1_0._btnrightswitch.gameObject, "normal")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_title")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "Left/#simage_title/remiantime/bg/#txt_remiantime")
	arg_1_0._scrollviewdetail = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#simage_title/#scroll_view")
	arg_1_0._txtdetail = gohelper.findChildText(arg_1_0.viewGO, "Left/#simage_title/#scroll_view/Viewport/Content/#txt_detail")
	arg_1_0._simagedetailbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_detailbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Left/#simage_detailbg/select/#txt_num")
	arg_1_0._txtleftrecordtitle = gohelper.findChildText(arg_1_0.viewGO, "Left/#simage_detailbg/select/bg/#txt_title")
	arg_1_0._gofill = gohelper.findChild(arg_1_0.viewGO, "Left/progress/#scroll_view/Viewport/Content/fill/#go_fill")
	arg_1_0._txtschedule = gohelper.findChildText(arg_1_0.viewGO, "Left/progress/bg/#txt_schedule")
	arg_1_0._scrollviewprogress = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/progress/#scroll_view")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_progressitem")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._godetailselect = gohelper.findChild(arg_1_0.viewGO, "Left/#simage_detailbg/select")
	arg_1_0._goemptydetail = gohelper.findChild(arg_1_0.viewGO, "Right/bg_normal/bg_empty")
	arg_1_0._gobrighten = gohelper.findChild(arg_1_0.viewGO, "Left/#simage_detailbg/#go_brighten")
	arg_1_0._goIcon1 = gohelper.findChild(arg_1_0.viewGO, "Right/bg_normal/icon1")
	arg_1_0._goIcon2 = gohelper.findChild(arg_1_0.viewGO, "Right/bg_normal/icon2")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_obtain/#go_reddot")

	arg_1_0._redDot = RedDotController.instance:addRedDot(var_1_0, RedDotEnum.DotNode.Activity1_4Act134Task)
	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)

	arg_1_0.animatorPlayer:Play(UIAnimationName.Open)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnobtain:AddClickListener(arg_2_0._btnobtainOnClick, arg_2_0)
	arg_2_0._btnleftswitch:AddClickListener(arg_2_0._btnleftswitchOnClick, arg_2_0)
	arg_2_0._btnrightswitch:AddClickListener(arg_2_0._btnrightswitchOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity134Controller.instance, Activity134Event.OnGetBonus, arg_2_0.getBonusEvent, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.currencyChangeEvent, arg_2_0)
	arg_2_0:addEventCb(Activity134Controller.instance, Activity134Event.OnUpdateInfo, arg_2_0.onUpdateParam, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._onRefreshActivityState, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnobtain:RemoveClickListener()
	arg_3_0._btnleftswitch:RemoveClickListener()
	arg_3_0._btnrightswitch:RemoveClickListener()
	arg_3_0:removeEventCb(Activity134Controller.instance, Activity134Event.OnGetBonus, arg_3_0.getBonusEvent, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.currencyChangeEvent, arg_3_0)
	arg_3_0:removeEventCb(Activity134Controller.instance, Activity134Event.OnUpdateInfo, arg_3_0.onUpdateParam, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0._onRefreshActivityState, arg_3_0)
end

function var_0_0._btnobtainOnClick(arg_4_0)
	Activity134Controller.instance:openActivity134TaskView()
end

function var_0_0._btnleftswitchOnClick(arg_5_0)
	if arg_5_0._storyTabIndex <= 1 then
		-- block empty
	else
		local var_5_0 = arg_5_0._storyTabIndex - 1

		arg_5_0:cutReportTab(var_5_0, true)
	end
end

function var_0_0._btnrightswitchOnClick(arg_6_0)
	if arg_6_0._storyTabIndex >= Activity134Model.instance:getFinishStoryCount() then
		if arg_6_0._storyTabIndex < arg_6_0.storyTotalCount then
			GameFacade.showToast(ToastEnum.Act134LackofClueTip)
		end
	else
		local var_6_0 = arg_6_0._storyTabIndex + 1

		arg_6_0:cutReportTab(var_6_0, true)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagefullbg:LoadImage(ResUrl.getV1a4DustRecordsIcon("v1a4_dustyrecords_fullbg_1"))

	arg_7_0.storyTotalCount = Activity134Model.instance:getStoryTotalCount()
	arg_7_0.actId = VersionActivity1_4Enum.ActivityId.DustyRecords
	arg_7_0._brightenPos = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, 6 do
		local var_7_0 = gohelper.findChild(arg_7_0._gobrighten, iter_7_0)

		table.insert(arg_7_0._brightenPos, var_7_0)
	end

	arg_7_0:initView()
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagefullbg:UnLoadImage()
	arg_8_0._simagedetailbg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_8_0.cutAnimEnd, arg_8_0)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.bonusItemList) do
		iter_8_1:onDestroyView()
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.reportItemList) do
		iter_8_3:onDestroy()
	end
end

function var_0_0.refreshRemainTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActivityInfo()[arg_9_0.actId]

	if var_9_0 then
		local var_9_1 = var_9_0:getRemainTimeStr2ByEndTime()

		arg_9_0._txtremaintime.text = string.format(luaLang("remain"), var_9_1)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:refreshRemainTime()
end

function var_0_0._onDailyRefresh(arg_11_0)
	Activity134Rpc.instance:sendGet134InfosRequest(arg_11_0.actId, function()
		Activity134TaskListModel.instance:sortTaskMoList()
	end)
end

function var_0_0._onRefreshActivityState(arg_13_0, arg_13_1)
	if string.nilorempty(arg_13_1) or arg_13_1 == 0 then
		return
	end

	if arg_13_1 ~= arg_13_0.actId then
		return
	end

	local var_13_0 = ActivityHelper.getActivityStatus(arg_13_1)

	local function var_13_1()
		ViewMgr.instance:closeView(ViewName.Activity134View)
	end

	if var_13_0 ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, var_13_1)
	end
end

function var_0_0.initBonusItem(arg_15_0)
	local var_15_0 = arg_15_0.viewContainer:getSetting().otherRes[2]
	local var_15_1 = gohelper.findChild(arg_15_0._scrollviewprogress.gameObject, "Viewport/Content")

	arg_15_0.bonusItemList = {}

	local var_15_2 = Activity134Model.instance:getAllStoryMo()

	arg_15_0._storyTabIndex = Activity134Model.instance:getFinishStoryCount()

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		local var_15_3 = arg_15_0:getResInst(var_15_0, var_15_1, "bonus" .. iter_15_0)
		local var_15_4 = Activity134BonusItem.New()

		var_15_4:init(var_15_3.gameObject)
		var_15_4:initMo(iter_15_0, iter_15_1)
		var_15_4:refreshProgress()
		table.insert(arg_15_0.bonusItemList, var_15_4)
	end
end

function var_0_0.CenterBonusItem(arg_16_0, arg_16_1)
	if arg_16_1 <= 1 then
		arg_16_0._scrollviewprogress.horizontalNormalizedPosition = 0

		return
	elseif arg_16_1 >= arg_16_0.storyTotalCount - 1 then
		arg_16_0._scrollviewprogress.horizontalNormalizedPosition = 1

		return
	end

	local var_16_0 = arg_16_1 / arg_16_0.storyTotalCount

	arg_16_0._scrollviewprogress.horizontalNormalizedPosition = var_16_0
end

function var_0_0.refreshBonusItem(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.bonusItemList) do
		iter_17_1:refreshProgress()
	end
end

function var_0_0.refreshschedule(arg_18_0)
	local var_18_0 = Activity134Model.instance:getMaxClueCount()
	local var_18_1 = Activity134Model.instance:getClueCount()

	arg_18_0._txtschedule.text = string.format("<color=#87f8db>%s</color>/%s", var_18_1, var_18_0)
end

function var_0_0.initReportItem(arg_19_0)
	local var_19_0 = arg_19_0.viewContainer:getSetting().otherRes[1]
	local var_19_1 = gohelper.findChild(arg_19_0._scrollviewright.gameObject, "Viewport/Content")
	local var_19_2 = arg_19_0:getResInst(var_19_0, var_19_1, "reportTemplate")

	arg_19_0.goright = gohelper.findChild(var_19_2.gameObject, "#go_right")

	local var_19_3 = gohelper.findChild(arg_19_0.viewGO, "Right")

	arg_19_0.goright.transform:SetParent(arg_19_0._scrollviewright.transform, false)
	transformhelper.setLocalPosXY(arg_19_0.goright.transform, 0, 255)

	arg_19_0.reportItemList = {}

	local var_19_4 = Activity134Model.instance:getAllStoryMo()

	for iter_19_0, iter_19_1 in ipairs(var_19_4) do
		local var_19_5 = gohelper.cloneInPlace(arg_19_0._goreportitem, "report_" .. iter_19_0)
		local var_19_6 = gohelper.findChild(var_19_2, iter_19_1.config.showTab)
		local var_19_7 = Activity134ReportItem.New()

		var_19_7:init(var_19_6, var_19_5)
		var_19_7:initMo(iter_19_0, iter_19_1)
		table.insert(arg_19_0.reportItemList, var_19_7)
	end
end

var_0_0.UI_CLICK_BLOCK_KEY = "Activity134TaskItemClick"

function var_0_0.cutReportTab(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._curCutPage = arg_20_1

	local var_20_0 = arg_20_2 and arg_20_0._storyTabIndex and arg_20_0._storyTabIndex ~= arg_20_1

	TaskDispatcher.cancelTask(arg_20_0.cutAnimEnd, arg_20_0)

	if var_20_0 then
		arg_20_0.animatorPlayer:Stop()
		UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)

		if arg_20_1 < arg_20_0._storyTabIndex then
			arg_20_0.animatorPlayer:Play(Activity134Enum.AnimName.CutLeft, arg_20_0.endAnimBlock, arg_20_0)
		else
			arg_20_0.animatorPlayer:Play(Activity134Enum.AnimName.CutRight, arg_20_0.endAnimBlock, arg_20_0)
		end

		TaskDispatcher.runDelay(arg_20_0.cutAnimEnd, arg_20_0, 0.3)
	else
		arg_20_0:cutAnimEnd()
	end
end

function var_0_0.cutAnimEnd(arg_21_0)
	if arg_21_0._curCutPage then
		arg_21_0:_onCutPageAnimEnd(arg_21_0._curCutPage)

		local var_21_0 = arg_21_0._brightenPos[arg_21_0._curCutPage] or arg_21_0._godetailselect
		local var_21_1 = var_21_0.transform.localPosition.x
		local var_21_2 = var_21_0.transform.localPosition.y

		transformhelper.setLocalPosXY(arg_21_0._godetailselect.transform, var_21_1, var_21_2)
	end
end

function var_0_0.endAnimBlock(arg_22_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._onCutPageAnimEnd(arg_23_0, arg_23_1)
	arg_23_0._storyTabIndex = arg_23_1

	arg_23_0:updateDetailBg(arg_23_1)
	arg_23_0:updateSwitchBtn()

	arg_23_0._scrollviewright.verticalNormalizedPosition = 1

	local var_23_0 = Activity134Model.instance:getFinishStoryCount() >= arg_23_0.storyTotalCount and "%s/%s" or "%s/<color=#9ea099>%s</color>"

	arg_23_0._txtpage.text = string.format(var_23_0, arg_23_1, arg_23_0.storyTotalCount)

	local var_23_1 = Activity134Model.instance:getStoryMoByIndex(arg_23_1)

	if not var_23_1 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.reportItemList) do
			local var_23_2 = iter_23_1.viewGO

			gohelper.setActive(var_23_2, false)
		end

		gohelper.setActive(arg_23_0._goIcon1, false)
		gohelper.setActive(arg_23_0._goIcon2, false)

		return
	end

	local var_23_3 = var_23_1.config

	arg_23_0._txtrightrecordtitle.text = var_23_3.title
	arg_23_0._txtleftrecordtitle.text = var_23_3.title
	arg_23_0._txtnum.text = var_23_3.number

	for iter_23_2, iter_23_3 in ipairs(arg_23_0.reportItemList) do
		local var_23_4 = iter_23_3.viewGO

		gohelper.setActive(var_23_4, arg_23_1 == iter_23_3.mo.index)
	end

	local var_23_5 = var_23_3.due

	arg_23_0._txtdue.text = var_23_5 and var_23_5 or ""

	local var_23_6 = var_23_3.showTab == "3"

	gohelper.setActive(arg_23_0.goright, var_23_6)

	if var_23_3.storyType >= 3 then
		local var_23_7 = string.split(var_23_3.introduce, "<split>")

		for iter_23_4 = 1, 3 do
			local var_23_8 = gohelper.findChildText(arg_23_0.goright, iter_23_4 .. "/#txt_dec")
			local var_23_9 = gohelper.findChild(arg_23_0.goright, iter_23_4 .. "/img_scrape")

			var_23_8.text = var_23_7[iter_23_4]

			gohelper.setActive(var_23_9, false)
		end
	end

	local var_23_10 = var_23_3.storyType == 2 or var_23_3.storyType == 3

	gohelper.setActive(arg_23_0._goIcon1, var_23_10)
	gohelper.setActive(arg_23_0._goIcon2, not var_23_10)
end

function var_0_0.updateSwitchBtn(arg_24_0)
	local var_24_0 = Activity134Model.instance:getFinishStoryCount()

	gohelper.setActive(arg_24_0._goleftswitchboundary, arg_24_0._storyTabIndex <= 1)
	gohelper.setActive(arg_24_0._gorightswitchboundary, var_24_0 <= arg_24_0._storyTabIndex)
	gohelper.setActive(arg_24_0._goleftswitchnormal, arg_24_0._storyTabIndex > 1)
	gohelper.setActive(arg_24_0._gorightswitchnormal, var_24_0 > arg_24_0._storyTabIndex)
end

function var_0_0.updateDetailBg(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._storyTabIndex > 0 and arg_25_0._storyTabIndex <= 6

	gohelper.setActive(arg_25_0._godetailselect, var_25_0)
	gohelper.setActive(arg_25_0._goemptydetail, not var_25_0)

	if var_25_0 then
		arg_25_1 = arg_25_0._storyTabIndex
	end

	local var_25_1 = "v1a4_dustyrecords_" .. arg_25_1

	arg_25_0._simagedetailbg:LoadImage(ResUrl.getV1a4DustRecordsIcon(var_25_1))
end

function var_0_0.initView(arg_26_0)
	arg_26_0._curCutPage = nil

	arg_26_0:initBonusItem()
	arg_26_0:initReportItem()

	local var_26_0 = Activity134Model.instance:checkGetStoryBonus()

	arg_26_0:refreshView()
	arg_26_0:refreshRemainTime()
	recthelper.setWidth(arg_26_0._gofill.transform, Activity134Model.instance:getBonusFillWidth())
end

function var_0_0.refreshView(arg_27_0, arg_27_1)
	arg_27_0:refreshBonusItem()

	local var_27_0 = Activity134Model.instance:getFinishStoryCount()

	arg_27_0:cutReportTab(var_27_0, arg_27_1)
	arg_27_0:CenterBonusItem(var_27_0)
	arg_27_0:refreshschedule()
end

function var_0_0.getBonusEvent(arg_28_0)
	arg_28_0:refreshView(true)
end

function var_0_0.currencyChangeEvent(arg_29_0, arg_29_1)
	if not arg_29_1[CurrencyEnum.CurrencyType.Act134Clue] then
		return
	end

	arg_29_0:refreshschedule()

	if Activity134Model.instance:checkGetStoryBonus() then
		arg_29_0:refreshView(true)
	end

	recthelper.setWidth(arg_29_0._gofill.transform, Activity134Model.instance:getBonusFillWidth())
end

return var_0_0
