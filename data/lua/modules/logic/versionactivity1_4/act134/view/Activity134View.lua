module("modules.logic.versionactivity1_4.act134.view.Activity134View", package.seeall)

slot0 = class("Activity134View", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._txtdue = gohelper.findChildText(slot0.viewGO, "Right/bg_normal/#txt_due")
	slot0._txtrightrecordtitle = gohelper.findChildText(slot0.viewGO, "Right/bg_normal/#txt_title")
	slot0._txtpage = gohelper.findChildText(slot0.viewGO, "Right/bg_normal/#txt_page")
	slot0._scrollviewright = gohelper.findChildScrollRect(slot0.viewGO, "Right/#scroll_view")
	slot0._goreportitem = gohelper.findChild(slot0.viewGO, "Right/#scroll_view/Viewport/Content/#go_reportitem")
	slot0._btnobtain = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_obtain")
	slot0._btnleftswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_leftswitch")
	slot0._btnrightswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_rightswitch")
	slot0._goleftswitchboundary = gohelper.findChild(slot0._btnleftswitch.gameObject, "boundary")
	slot0._gorightswitchboundary = gohelper.findChild(slot0._btnrightswitch.gameObject, "boundary")
	slot0._goleftswitchnormal = gohelper.findChild(slot0._btnleftswitch.gameObject, "normal")
	slot0._gorightswitchnormal = gohelper.findChild(slot0._btnrightswitch.gameObject, "normal")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_title")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "Left/#simage_title/remiantime/bg/#txt_remiantime")
	slot0._scrollviewdetail = gohelper.findChildScrollRect(slot0.viewGO, "Left/#simage_title/#scroll_view")
	slot0._txtdetail = gohelper.findChildText(slot0.viewGO, "Left/#simage_title/#scroll_view/Viewport/Content/#txt_detail")
	slot0._simagedetailbg = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_detailbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Left/#simage_detailbg/select/#txt_num")
	slot0._txtleftrecordtitle = gohelper.findChildText(slot0.viewGO, "Left/#simage_detailbg/select/bg/#txt_title")
	slot0._gofill = gohelper.findChild(slot0.viewGO, "Left/progress/#scroll_view/Viewport/Content/fill/#go_fill")
	slot0._txtschedule = gohelper.findChildText(slot0.viewGO, "Left/progress/bg/#txt_schedule")
	slot0._scrollviewprogress = gohelper.findChildScrollRect(slot0.viewGO, "Left/progress/#scroll_view")
	slot0._goprogressitem = gohelper.findChild(slot0.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_progressitem")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._godetailselect = gohelper.findChild(slot0.viewGO, "Left/#simage_detailbg/select")
	slot0._goemptydetail = gohelper.findChild(slot0.viewGO, "Right/bg_normal/bg_empty")
	slot0._gobrighten = gohelper.findChild(slot0.viewGO, "Left/#simage_detailbg/#go_brighten")
	slot0._goIcon1 = gohelper.findChild(slot0.viewGO, "Right/bg_normal/icon1")
	slot0._goIcon2 = gohelper.findChild(slot0.viewGO, "Right/bg_normal/icon2")
	slot0._redDot = RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "Right/#btn_obtain/#go_reddot"), RedDotEnum.DotNode.Activity1_4Act134Task)
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)

	slot0.animatorPlayer:Play(UIAnimationName.Open)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnobtain:AddClickListener(slot0._btnobtainOnClick, slot0)
	slot0._btnleftswitch:AddClickListener(slot0._btnleftswitchOnClick, slot0)
	slot0._btnrightswitch:AddClickListener(slot0._btnrightswitchOnClick, slot0)
	slot0:addEventCb(Activity134Controller.instance, Activity134Event.OnGetBonus, slot0.getBonusEvent, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.currencyChangeEvent, slot0)
	slot0:addEventCb(Activity134Controller.instance, Activity134Event.OnUpdateInfo, slot0.onUpdateParam, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._onRefreshActivityState, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnobtain:RemoveClickListener()
	slot0._btnleftswitch:RemoveClickListener()
	slot0._btnrightswitch:RemoveClickListener()
	slot0:removeEventCb(Activity134Controller.instance, Activity134Event.OnGetBonus, slot0.getBonusEvent, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.currencyChangeEvent, slot0)
	slot0:removeEventCb(Activity134Controller.instance, Activity134Event.OnUpdateInfo, slot0.onUpdateParam, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._onRefreshActivityState, slot0)
end

function slot0._btnobtainOnClick(slot0)
	Activity134Controller.instance:openActivity134TaskView()
end

function slot0._btnleftswitchOnClick(slot0)
	if slot0._storyTabIndex > 1 then
		slot0:cutReportTab(slot0._storyTabIndex - 1, true)
	end
end

function slot0._btnrightswitchOnClick(slot0)
	if Activity134Model.instance:getFinishStoryCount() <= slot0._storyTabIndex then
		if slot0._storyTabIndex < slot0.storyTotalCount then
			GameFacade.showToast(ToastEnum.Act134LackofClueTip)
		end
	else
		slot0:cutReportTab(slot0._storyTabIndex + 1, true)
	end
end

function slot0._editableInitView(slot0)
	slot4 = "v1a4_dustyrecords_fullbg_1"

	slot0._simagefullbg:LoadImage(ResUrl.getV1a4DustRecordsIcon(slot4))

	slot0.storyTotalCount = Activity134Model.instance:getStoryTotalCount()
	slot0.actId = VersionActivity1_4Enum.ActivityId.DustyRecords
	slot0._brightenPos = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		table.insert(slot0._brightenPos, gohelper.findChild(slot0._gobrighten, slot4))
	end

	slot0:initView()
end

function slot0.onDestroyView(slot0)
	slot0._simagefullbg:UnLoadImage()
	slot0._simagedetailbg:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.cutAnimEnd, slot0)

	for slot4, slot5 in ipairs(slot0.bonusItemList) do
		slot5:onDestroyView()
	end

	for slot4, slot5 in ipairs(slot0.reportItemList) do
		slot5:onDestroy()
	end
end

function slot0.refreshRemainTime(slot0)
	if ActivityModel.instance:getActivityInfo()[slot0.actId] then
		slot0._txtremaintime.text = string.format(luaLang("remain"), slot1:getRemainTimeStr2ByEndTime())
	end
end

function slot0.onUpdateParam(slot0)
	slot0:refreshRemainTime()
end

function slot0._onDailyRefresh(slot0)
	Activity134Rpc.instance:sendGet134InfosRequest(slot0.actId, function ()
		Activity134TaskListModel.instance:sortTaskMoList()
	end)
end

function slot0._onRefreshActivityState(slot0, slot1)
	if string.nilorempty(slot1) or slot1 == 0 then
		return
	end

	if slot1 ~= slot0.actId then
		return
	end

	if ActivityHelper.getActivityStatus(slot1) ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, function ()
			ViewMgr.instance:closeView(ViewName.Activity134View)
		end)
	end
end

function slot0.initBonusItem(slot0)
	slot0.bonusItemList = {}
	slot0._storyTabIndex = Activity134Model.instance:getFinishStoryCount()

	for slot7, slot8 in ipairs(Activity134Model.instance:getAllStoryMo()) do
		slot10 = Activity134BonusItem.New()

		slot10:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], gohelper.findChild(slot0._scrollviewprogress.gameObject, "Viewport/Content"), "bonus" .. slot7).gameObject)
		slot10:initMo(slot7, slot8)
		slot10:refreshProgress()
		table.insert(slot0.bonusItemList, slot10)
	end
end

function slot0.CenterBonusItem(slot0, slot1)
	if slot1 <= 1 then
		slot0._scrollviewprogress.horizontalNormalizedPosition = 0

		return
	elseif slot1 >= slot0.storyTotalCount - 1 then
		slot0._scrollviewprogress.horizontalNormalizedPosition = 1

		return
	end

	slot0._scrollviewprogress.horizontalNormalizedPosition = slot1 / slot0.storyTotalCount
end

function slot0.refreshBonusItem(slot0)
	for slot4, slot5 in ipairs(slot0.bonusItemList) do
		slot5:refreshProgress()
	end
end

function slot0.refreshschedule(slot0)
	slot0._txtschedule.text = string.format("<color=#87f8db>%s</color>/%s", Activity134Model.instance:getClueCount(), Activity134Model.instance:getMaxClueCount())
end

function slot0.initReportItem(slot0)
	slot0.goright = gohelper.findChild(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._scrollviewright.gameObject, "Viewport/Content"), "reportTemplate").gameObject, "#go_right")
	slot4 = gohelper.findChild(slot0.viewGO, "Right")

	slot0.goright.transform:SetParent(slot0._scrollviewright.transform, false)
	transformhelper.setLocalPosXY(slot0.goright.transform, 0, 255)

	slot0.reportItemList = {}

	for slot9, slot10 in ipairs(Activity134Model.instance:getAllStoryMo()) do
		slot13 = Activity134ReportItem.New()

		slot13:init(gohelper.findChild(slot3, slot10.config.showTab), gohelper.cloneInPlace(slot0._goreportitem, "report_" .. slot9))
		slot13:initMo(slot9, slot10)
		table.insert(slot0.reportItemList, slot13)
	end
end

slot0.UI_CLICK_BLOCK_KEY = "Activity134TaskItemClick"

function slot0.cutReportTab(slot0, slot1, slot2)
	slot0._curCutPage = slot1

	TaskDispatcher.cancelTask(slot0.cutAnimEnd, slot0)

	if slot2 and slot0._storyTabIndex and slot0._storyTabIndex ~= slot1 then
		slot0.animatorPlayer:Stop()
		UIBlockMgr.instance:startBlock(uv0.UI_CLICK_BLOCK_KEY)

		if slot1 < slot0._storyTabIndex then
			slot0.animatorPlayer:Play(Activity134Enum.AnimName.CutLeft, slot0.endAnimBlock, slot0)
		else
			slot0.animatorPlayer:Play(Activity134Enum.AnimName.CutRight, slot0.endAnimBlock, slot0)
		end

		TaskDispatcher.runDelay(slot0.cutAnimEnd, slot0, 0.3)
	else
		slot0:cutAnimEnd()
	end
end

function slot0.cutAnimEnd(slot0)
	if slot0._curCutPage then
		slot0:_onCutPageAnimEnd(slot0._curCutPage)

		slot1 = slot0._brightenPos[slot0._curCutPage] or slot0._godetailselect

		transformhelper.setLocalPosXY(slot0._godetailselect.transform, slot1.transform.localPosition.x, slot1.transform.localPosition.y)
	end
end

function slot0.endAnimBlock(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)
end

function slot0._onCutPageAnimEnd(slot0, slot1)
	slot0._storyTabIndex = slot1

	slot0:updateDetailBg(slot1)
	slot0:updateSwitchBtn()

	slot0._scrollviewright.verticalNormalizedPosition = 1
	slot0._txtpage.text = string.format(slot0.storyTotalCount <= Activity134Model.instance:getFinishStoryCount() and "%s/%s" or "%s/<color=#9ea099>%s</color>", slot1, slot0.storyTotalCount)

	if not Activity134Model.instance:getStoryMoByIndex(slot1) then
		for slot7, slot8 in ipairs(slot0.reportItemList) do
			gohelper.setActive(slot8.viewGO, false)
		end

		gohelper.setActive(slot0._goIcon1, false)
		gohelper.setActive(slot0._goIcon2, false)

		return
	end

	slot4 = slot3.config
	slot0._txtrightrecordtitle.text = slot4.title
	slot0._txtleftrecordtitle.text = slot4.title
	slot0._txtnum.text = slot4.number

	for slot8, slot9 in ipairs(slot0.reportItemList) do
		gohelper.setActive(slot9.viewGO, slot1 == slot9.mo.index)
	end

	slot0._txtdue.text = slot4.due and slot5 or ""

	gohelper.setActive(slot0.goright, slot4.showTab == "3")

	if slot4.storyType >= 3 then
		for slot11 = 1, 3 do
			gohelper.findChildText(slot0.goright, slot11 .. "/#txt_dec").text = string.split(slot4.introduce, "<split>")[slot11]

			gohelper.setActive(gohelper.findChild(slot0.goright, slot11 .. "/img_scrape"), false)
		end
	end

	slot7 = slot4.storyType == 2 or slot4.storyType == 3

	gohelper.setActive(slot0._goIcon1, slot7)
	gohelper.setActive(slot0._goIcon2, not slot7)
end

function slot0.updateSwitchBtn(slot0)
	slot1 = Activity134Model.instance:getFinishStoryCount()

	gohelper.setActive(slot0._goleftswitchboundary, slot0._storyTabIndex <= 1)
	gohelper.setActive(slot0._gorightswitchboundary, slot1 <= slot0._storyTabIndex)
	gohelper.setActive(slot0._goleftswitchnormal, slot0._storyTabIndex > 1)
	gohelper.setActive(slot0._gorightswitchnormal, slot0._storyTabIndex < slot1)
end

function slot0.updateDetailBg(slot0, slot1)
	slot2 = slot0._storyTabIndex > 0 and slot0._storyTabIndex <= 6

	gohelper.setActive(slot0._godetailselect, slot2)
	gohelper.setActive(slot0._goemptydetail, not slot2)

	if slot2 then
		slot1 = slot0._storyTabIndex
	end

	slot0._simagedetailbg:LoadImage(ResUrl.getV1a4DustRecordsIcon("v1a4_dustyrecords_" .. slot1))
end

function slot0.initView(slot0)
	slot0._curCutPage = nil

	slot0:initBonusItem()
	slot0:initReportItem()

	slot1 = Activity134Model.instance:checkGetStoryBonus()

	slot0:refreshView()
	slot0:refreshRemainTime()
	recthelper.setWidth(slot0._gofill.transform, Activity134Model.instance:getBonusFillWidth())
end

function slot0.refreshView(slot0, slot1)
	slot0:refreshBonusItem()

	slot2 = Activity134Model.instance:getFinishStoryCount()

	slot0:cutReportTab(slot2, slot1)
	slot0:CenterBonusItem(slot2)
	slot0:refreshschedule()
end

function slot0.getBonusEvent(slot0)
	slot0:refreshView(true)
end

function slot0.currencyChangeEvent(slot0, slot1)
	if not slot1[CurrencyEnum.CurrencyType.Act134Clue] then
		return
	end

	slot0:refreshschedule()

	if Activity134Model.instance:checkGetStoryBonus() then
		slot0:refreshView(true)
	end

	recthelper.setWidth(slot0._gofill.transform, Activity134Model.instance:getBonusFillWidth())
end

return slot0
