module("modules.logic.versionactivity2_5.act187.view.Activity187View", package.seeall)

slot0 = class("Activity187View", BaseView)
slot1 = 0.5
slot2 = 1

function slot0.onInitView(slot0)
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "#go_title/image_TimeBG/#txt_remainTime")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_lantern/#txt_index")
	slot0._btnleft = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_lantern/#btn_left")
	slot0._golowribbon = gohelper.findChild(slot0.viewGO, "#go_lantern/#go_decorationLower")
	slot0._simagelantern = gohelper.findChildSingleImage(slot0.viewGO, "#go_lantern/#simage_lantern/#simage_lantern1")
	slot0._btnlantern = gohelper.findChildClick(slot0.viewGO, "#go_lantern/#simage_lantern/#btn_click")
	slot0._goupribbon = gohelper.findChild(slot0.viewGO, "#go_lantern/#go_decorationUpper")
	slot0._simagepicture = gohelper.findChildSingleImage(slot0.viewGO, "#go_lantern/#simage_lantern/#simage_picture")
	slot0._gotail = gohelper.findChild(slot0.viewGO, "#go_lantern/#simage_lantern/#go_tail")
	slot0._goincomplete = gohelper.findChild(slot0.viewGO, "#go_lantern/#simage_lantern/#go_tail/#go_incomplete")
	slot0._btnshowRiddles = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_lantern/#simage_lantern/#go_tail/#btn_showRiddles")
	slot0._goriddles = gohelper.findChild(slot0.viewGO, "#go_lantern/#simage_lantern/#go_riddles")
	slot0._btncloseRiddles = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#btn_closeRiddles")
	slot0._txtriddles = gohelper.findChildText(slot0.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#txt_riddles")
	slot0._goriddlesRewards = gohelper.findChild(slot0.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#go_riddlesRewards")
	slot0._goriddlesRewardItem = gohelper.findChild(slot0.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#go_riddlesRewards/#go_riddlesRewardItem")
	slot0._btnright = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_lantern/#btn_right")
	slot0._btnpaint = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_paint")
	slot0._gopaintreddot = gohelper.findChild(slot0.viewGO, "#btn_paint/#go_reddot")
	slot0._gobegin = gohelper.findChild(slot0.viewGO, "#btn_paint/#go_begin")
	slot0._txtpaintTimes = gohelper.findChildText(slot0.viewGO, "#btn_paint/#go_begin/#txt_paintTimes")
	slot0._gonoPaint = gohelper.findChild(slot0.viewGO, "#btn_paint/#go_noPaint")
	slot0._gorewardBarBg = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_grayLine")
	slot0._gorewardBar = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_grayLine/#go_highLine")
	slot0._gorewardItemLayout = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_rewardLayout")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "#go_rewards/#go_rewardLayout/#go_rewardItem")
	slot0._gopaintingview = gohelper.findChildClick(slot0.viewGO, "v2a5_lanternfestivalpainting")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnlantern:AddClickListener(slot0._btnlanternOnClick, slot0)
	slot0._btnshowRiddles:AddClickListener(slot0._btnshowRiddlesOnClick, slot0)
	slot0._btncloseRiddles:AddClickListener(slot0._btncloseRiddlesOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnpaint:AddClickListener(slot0._btnpaintOnClick, slot0)
	slot0._lanternAnimationEvent:AddEventListener("left", slot0._onLeftRefresh, slot0)
	slot0._lanternAnimationEvent:AddEventListener("right", slot0._onRightRefresh, slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0.onBtnEsc, slot0)
	slot0:addEventCb(Activity187Controller.instance, Activity187Event.GetAct187Info, slot0.onGetActInfo, slot0)
	slot0:addEventCb(Activity187Controller.instance, Activity187Event.FinishPainting, slot0.onFinishPainting, slot0)
	slot0:addEventCb(Activity187Controller.instance, Activity187Event.GetAccrueReward, slot0.onGetAccrueReward, slot0)
	slot0:addEventCb(Activity187Controller.instance, Activity187Event.RefreshAccrueReward, slot0.onRefreshAccrueReward, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0.checkActivityInfo, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.checkActivityInfo, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleft:RemoveClickListener()
	slot0._btnlantern:RemoveClickListener()
	slot0._btnshowRiddles:RemoveClickListener()
	slot0._btncloseRiddles:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnpaint:RemoveClickListener()
	slot0._lanternAnimationEvent:RemoveAllEventListener()
	slot0:removeEventCb(Activity187Controller.instance, Activity187Event.GetAct187Info, slot0.onGetActInfo, slot0)
	slot0:removeEventCb(Activity187Controller.instance, Activity187Event.FinishPainting, slot0.onFinishPainting, slot0)
	slot0:removeEventCb(Activity187Controller.instance, Activity187Event.GetAccrueReward, slot0.onGetAccrueReward, slot0)
	slot0:removeEventCb(Activity187Controller.instance, Activity187Event.RefreshAccrueReward, slot0.onRefreshAccrueReward, slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, slot0.checkActivityInfo, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.checkActivityInfo, slot0)
end

function slot0._btnleftOnClick(slot0)
	if slot0._curIndex <= 1 then
		return
	end

	slot0:refreshLanternIndex()

	slot0._curIndex = slot0._curIndex - 1

	slot0._lanternAnimator:Play("left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
end

function slot0._onLeftRefresh(slot0)
	slot0:refreshLanternIndex()
end

function slot0._btnlanternOnClick(slot0)
	if Activity187Model.instance:getFinishPaintingIndex() < slot0._curIndex and not Activity187Model.instance:getPaintingRewardId(slot0._curIndex) then
		slot0:_btnpaintOnClick()
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function slot0._btnshowRiddlesOnClick(slot0)
	slot0:setRiddlesShow(true)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_mln_page_turn)
end

function slot0._btncloseRiddlesOnClick(slot0)
	slot0:setRiddlesShow(false)
end

function slot0._btnrightOnClick(slot0)
	if slot0._maxIndex <= slot0._curIndex then
		return
	end

	slot0:refreshLanternIndex()

	slot0._curIndex = slot0._curIndex + 1

	slot0._lanternAnimator:Play("right", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
end

function slot0._onRightRefresh(slot0)
	slot0:refreshLanternIndex()
end

function slot0._btnpaintOnClick(slot0)
	if not ((Activity187Model.instance:getRemainPaintingCount() or 0) > 0) then
		return
	end

	if Activity187Model.instance:getFinishPaintingIndex() == slot0._maxIndex then
		return
	end

	slot0._curIndex = slot0._maxIndex

	slot0:refreshLanternIndex()
	slot0:setPaintingViewDisplay(true)
end

function slot0.onBtnEsc(slot0)
	if slot0.isShowPaintView then
		slot0:setPaintingViewDisplay(false)
	else
		slot0:closeThis()
	end
end

function slot0.onGetActInfo(slot0)
	slot0:setLanternIndex()
	slot0:setAccrueReward()
	slot0:refresh()
end

function slot0.onFinishPainting(slot0, slot1)
	slot0:setLanternIndex(slot1)
	slot0:refresh()
	slot0:refreshAccrueRewardItem()
	slot0:setRiddlesShow(true)
end

function slot0.onGetAccrueReward(slot0, slot1)
	slot0._rewardsMaterials = slot1

	slot0:refreshAccrueRewardItem(true)
end

function slot0.onRefreshAccrueReward(slot0)
	slot0:refreshAccrueProgress()

	if slot0._accrueRewardItemList then
		for slot4, slot5 in ipairs(slot0._accrueRewardItemList) do
			slot5:refreshStatus()
		end
	end
end

function slot0.checkActivityInfo(slot0, slot1)
	if slot1 and slot1 ~= Activity187Model.instance:getAct187Id() then
		return
	end

	if Activity187Model.instance:isAct187Open(true) then
		Activity187Controller.instance:getAct187Info()
	else
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	slot0._lowRibbonDict = slot0:getUserDataTb_()
	slot0._upRibbonDict = slot0:getUserDataTb_()

	slot0:_fillRibbonDict(slot0._golowribbon.transform, slot0._lowRibbonDict)
	slot0:_fillRibbonDict(slot0._goupribbon.transform, slot0._upRibbonDict)

	slot1 = gohelper.findChild(slot0.viewGO, "#go_lantern")
	slot0._lanternAnimationEvent = slot1:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._lanternAnimator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._barBgWidth = recthelper.getWidth(slot0._gorewardBarBg.transform)
	slot0._riddlesRewardItemList = {}

	gohelper.setActive(slot0._goriddlesRewardItem, false)

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.isShowPaintView = false
end

function slot0._fillRibbonDict(slot0, slot1, slot2)
	for slot7 = 1, slot1.childCount do
		slot8 = slot1:GetChild(slot7 - 1)
		slot2[slot8.name] = slot8
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:setLanternIndex()
	slot0:setAccrueReward()
	slot0:refresh()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(slot0._gopaintreddot, RedDotEnum.DotNode.V2a5_Act187CanPaint)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_tangren_yuanxiao_open)
end

function slot0.setLanternIndex(slot0, slot1)
	slot3 = Activity187Model.instance:getFinishPaintingIndex()

	if (Activity187Model.instance:getRemainPaintingCount() or 0) > 0 then
		slot3 = slot2 + 1
	end

	if (tonumber(Activity187Config.instance:getAct187Const(Activity187Enum.ConstId.MaxLanternCount)) or 0) < 0 then
		slot5 = slot3
	end

	slot0._maxIndex = math.min(slot3, slot5)
	slot0._curIndex = slot1 or slot0._maxIndex
end

function slot3(slot0, slot1)
	return slot0 < slot1
end

function slot0.setAccrueReward(slot0)
	slot0._accrueRewardItemList = {}
	slot2 = Activity187Config.instance:getAccrueRewardIdList(Activity187Model.instance:getAct187Id())

	table.sort(slot2, uv0)

	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		slot3[#slot3 + 1] = Activity187Config.instance:getAccrueRewards(slot1, slot8)[1]
	end

	gohelper.CreateObjList(slot0, slot0._onSetAccrueRewardItem, slot3, slot0._gorewardItemLayout, slot0._gorewardItem, Activity187AccrueRewardItem)
end

function slot0._onSetAccrueRewardItem(slot0, slot1, slot2, slot3)
	slot1:setData(slot2)

	slot0._accrueRewardItemList[slot3] = slot1
end

function slot0.setRiddlesShow(slot0, slot1)
	gohelper.setActive(slot0._gotail, not slot1)
	gohelper.setActive(slot0._goriddles, slot1)
end

function slot0.setPaintingViewDisplay(slot0, slot1)
	if slot0.isShowPaintView == slot1 then
		return
	end

	slot0.isShowPaintView = slot1

	if slot0.isShowPaintView then
		slot0.animator:Play("MainToDraw", 0, 0)
	else
		slot0.animator:Play("DrawToMain", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_tangren_yuanxiao_pop)
	UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.SwitchView)
	TaskDispatcher.cancelTask(slot0._endBlock, slot0)
	TaskDispatcher.runDelay(slot0._endBlock, slot0, uv0)
	Activity187Controller.instance:dispatchEvent(Activity187Event.PaintViewDisplayChange, slot0.isShowPaintView, slot0._maxIndex)
end

function slot0._endBlock(slot0)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.SwitchView)
end

function slot0.refresh(slot0)
	slot0:refreshLanternIndex()
	slot0:refreshPaintingCount()
	slot0:refreshAccrueProgress()
	slot0:refreshRemainTime()
end

function slot0.refreshLanternIndex(slot0)
	slot0._txtindex.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_wholesale_weekly_revenue"), slot0._curIndex, slot0._maxIndex)

	slot0:refreshLantern()
	slot0:refreshArrow()
end

function slot0.refreshLantern(slot0)
	slot0:hideAllRiddlesRewardItem()

	slot1 = Activity187Enum.EmptyLantern
	slot2 = nil

	if Activity187Model.instance:getPaintingRewardId(slot0._curIndex) then
		slot4 = Activity187Model.instance:getAct187Id()
		slot1 = Activity187Config.instance:getLantern(slot4, slot3)
		slot2 = Activity187Config.instance:getLanternRibbon(slot4, slot3)

		slot0._simagepicture:LoadImage(ResUrl.getAct184LanternIcon(Activity187Config.instance:getLanternImg(slot4, slot3)))

		slot10 = slot3
		slot0._txtriddles.text = Activity187Config.instance:getBlessing(slot4, slot10)

		for slot10, slot11 in ipairs(Activity187Model.instance:getPaintingRewardList(slot0._curIndex)) do
			slot0:getRiddlesRewardItem(slot10).itemIcon:onUpdateMO(slot11)
		end
	end

	slot7 = slot1

	slot0._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(slot7))

	for slot7, slot8 in pairs(slot0._lowRibbonDict) do
		gohelper.setActive(slot8, slot7 == slot2)
	end

	for slot7, slot8 in pairs(slot0._upRibbonDict) do
		gohelper.setActive(slot8, slot7 == slot2)
	end

	gohelper.setActive(slot0._simagepicture, slot3)
	gohelper.setActive(slot0._btnshowRiddles, slot3)
	gohelper.setActive(slot0._goincomplete, not slot3)
	slot0:setRiddlesShow(false)
end

function slot0.hideAllRiddlesRewardItem(slot0)
	if not slot0._riddlesRewardItemList then
		slot0._riddlesRewardItemList = {}
	end

	for slot4, slot5 in ipairs(slot0._riddlesRewardItemList) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0.getRiddlesRewardItem(slot0, slot1)
	if not slot0._riddlesRewardItemList then
		slot0._riddlesRewardItemList = {}
	end

	if not slot0._riddlesRewardItemList[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.clone(slot0._goriddlesRewardItem, slot0._goriddlesRewards, slot1)
		slot2.itemIcon = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot2.go, "#go_item"))

		slot2.itemIcon:setCountFontSize(40)

		slot0._riddlesRewardItemList[slot1] = slot2
	end

	gohelper.setActive(slot2.go, true)

	return slot2
end

function slot0.refreshArrow(slot0)
	gohelper.setActive(slot0._btnleft, slot0._curIndex > 1)
	gohelper.setActive(slot0._btnright, slot0._curIndex < slot0._maxIndex)
end

function slot0.refreshPaintingCount(slot0)
	slot1 = Activity187Model.instance:getRemainPaintingCount() or 0
	slot2 = slot1 > 0
	slot0._txtpaintTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act187_painting_count"), slot1)

	gohelper.setActive(slot0._gobegin, slot2)
	gohelper.setActive(slot0._gonoPaint, not slot2)
end

function slot0.refreshAccrueProgress(slot0)
	slot2 = Activity187Config.instance:getAccrueRewardIdList(Activity187Model.instance:getAct187Id())

	table.sort(slot2, uv0)

	slot3 = 0

	for slot8, slot9 in ipairs(slot2) do
		if slot9 <= Activity187Model.instance:getAccrueRewardIndex() then
			slot3 = slot8 - 1
		end
	end

	recthelper.setWidth(slot0._gorewardBar.transform, slot3 * 1 / (#slot2 - 1) * slot0._barBgWidth)
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremainTime.text = Activity187Model.instance:getAct187RemainTimeStr()
end

function slot0.refreshAccrueRewardItem(slot0, slot1)
	if slot0._accrueRewardItemList then
		for slot5, slot6 in ipairs(slot0._accrueRewardItemList) do
			slot6:refreshStatus(slot1)
		end
	end

	if slot0._rewardsMaterials then
		UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.GetAccrueReward)
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
		TaskDispatcher.cancelTask(slot0._showMaterials, slot0)
		TaskDispatcher.runDelay(slot0._showMaterials, slot0, uv0)
	end
end

function slot0._showMaterials(slot0)
	RoomController.instance:popUpRoomBlockPackageView(slot0._rewardsMaterials)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot0._rewardsMaterials)

	slot0._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetAccrueReward)
end

function slot0.onClose(slot0)
	slot0._simagepicture:UnLoadImage()
	slot0._simagelantern:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._endBlock, slot0)
	TaskDispatcher.cancelTask(slot0._showMaterials, slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.SwitchView)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetAccrueReward)

	slot0._rewardsMaterials = nil
end

function slot0.onDestroyView(slot0)
end

return slot0
