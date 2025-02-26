module("modules.logic.turnback.view.TurnbackTaskView", package.seeall)

slot0 = class("TurnbackTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._goprocessIcon = gohelper.findChild(slot0.viewGO, "left/title/#go_progressIcon")
	slot0._gonoprocessIcon = gohelper.findChild(slot0.viewGO, "left/title/#go_noprogressIcon")
	slot0._txtactiveNum = gohelper.findChildText(slot0.viewGO, "left/title/#txt_activeNum")
	slot0._imageactiveIcon = gohelper.findChildImage(slot0.viewGO, "left/title/#txt_activeNum/icon")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_reward")
	slot0._gobar = gohelper.findChild(slot0.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_bar")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_bar/#image_progress")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_rewardItem")
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "right/#txt_remainTime")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "right/desc_scroll/viewport/#txt_desc")
	slot0._scrolltask = gohelper.findChildScrollRect(slot0.viewGO, "right/#scroll_task")
	slot0._gotaskViewport = gohelper.findChild(slot0.viewGO, "right/#scroll_task/Viewport")
	slot0._gotaskContent = gohelper.findChild(slot0.viewGO, "right/#scroll_task/Viewport/#go_taskContent")
	slot0._godaytime = gohelper.findChild(slot0.viewGO, "right/#go_daytime")
	slot0._gotoggleGroup = gohelper.findChild(slot0.viewGO, "right/taskToggleGroup")
	slot0._toggleGroup = slot0._gotoggleGroup:GetComponent(typeof(UnityEngine.UI.ToggleGroup))
	slot0._btnstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_story")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end

	slot0._txtdaytime = gohelper.findChildText(slot0.viewGO, "right/#go_daytime/txt")
	slot0._txtdaytime.text = ServerTime.ReplaceUTCStr(luaLang("p_turnbacktaskview_txt_time"))
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshTaskRedDot, slot0._refreshRedDot, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._playEndStory, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshBonusPoint, slot0)
	slot0._btnstory:AddClickListener(slot0._btnstoryOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshTaskRedDot, slot0._refreshRedDot, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._playEndStory, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshBonusPoint, slot0)
	slot0._btnstory:RemoveClickListener()
end

slot1 = {
	TurnbackEnum.TaskLoopType.Day,
	TurnbackEnum.TaskLoopType.Long
}
slot2 = 4

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_taskfullbg"))

	slot0._isFirstEnter = true

	gohelper.setActive(slot0._gorewardItem, false)

	slot0._rewardItemTab = slot0:getUserDataTb_()
	slot0._taskToggleWraps = slot0:getUserDataTb_()
	slot0._toggleRedDotTab = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.viewConfig = TurnbackConfig.instance:getTurnbackSubModuleCo(slot0.viewParam.actId)
	slot0.curTaskLoopType = TurnbackEnum.TaskLoopType.Day
	slot0.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	slot0.bonusPointType, slot0.bonusPointId = TurnbackConfig.instance:getBonusPointCo(slot0.curTurnbackId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageactiveIcon, CurrencyConfig.instance:getCurrencyCo(slot0.bonusPointId).icon .. "_1")
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:_initComp()
	slot0:_createTaskBonusItem()
	slot0:_onToggleValueChanged(1, true)
	slot0:_refreshUI()

	slot0._isFirstEnter = false
end

function slot0._initComp(slot0)
	for slot6 = 1, slot0._gotoggleGroup.transform.childCount do
		if slot1:GetChild(slot6 - 1):GetComponent(typeof(UnityEngine.UI.Toggle)) then
			slot9 = gohelper.onceAddComponent(slot7, typeof(SLFramework.UGUI.ToggleWrap))

			slot9:AddOnValueChanged(slot0._onToggleValueChanged, slot0, slot6)

			slot0._taskToggleWraps[slot6] = slot9
		end
	end

	for slot6 = 1, 2 do
		slot0._toggleRedDotTab[slot6] = gohelper.findChild(slot0.viewGO, "right/redDot/#go_reddot" .. slot6)
	end

	slot0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0.viewContainer._scrollView)

	slot0._taskAnimRemoveItem:setMoveInterval(0)
	slot0._taskAnimRemoveItem:setMoveAnimationTime(TurnbackEnum.TaskMaskTime - TurnbackEnum.TaskGetAnimTime)
end

function slot0._createTaskBonusItem(slot0)
	for slot5 = 1, GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)) do
		if not slot0._rewardItemTab[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.clone(slot0._gorewardItem, slot0._gorewardContent, "rewardItem" .. slot5)
			slot7.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot7.go, TurnbackTaskBonusItem, {
				index = slot5,
				parentScrollGO = slot0._scrollreward.gameObject
			})

			gohelper.setActive(slot7.go, true)
			table.insert(slot0._rewardItemTab, slot7)
		end
	end

	for slot5 = slot1 + 1, #slot0._rewardItemTab do
		gohelper.setActive(slot0._rewardItemTab[slot5].go, false)
	end
end

function slot0._refreshTaskProcessBar(slot0, slot1)
	slot6 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0.curTurnbackId)
	slot7 = GameUtil.getTabLen(slot6)

	recthelper.setHeight(slot0._gobar.transform, 26 + (slot7 - 1) * 98 + slot7 * 52 + 25)

	slot9 = 0
	slot10 = 0
	slot11 = 0
	slot12 = 0
	slot13 = 0

	for slot17, slot18 in ipairs(slot6) do
		if slot18.needPoint <= slot1 then
			slot9 = slot17
			slot10 = slot18.needPoint
			slot11 = slot18.needPoint
		elseif slot11 <= slot10 then
			slot11 = slot18.needPoint
		end
	end

	if slot11 ~= slot10 then
		slot12 = (slot1 - slot10) / (slot11 - slot10)
	end

	if slot9 == slot7 then
		slot13 = (slot9 == 0 and slot2 * slot12 or slot2 + slot9 * slot3 + (slot9 - 1) * slot4 + slot12 * slot4) + slot5
	end

	recthelper.setHeight(slot0._imageprogress.transform, slot13)
end

function slot0._onToggleValueChanged(slot0, slot1, slot2)
	if slot2 then
		if not slot0._isFirstEnter then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
		end

		slot0.curTaskLoopType = uv0[slot1]

		TurnbackTaskModel.instance:refreshList(slot0.curTaskLoopType)

		slot0._scrolltask.verticalNormalizedPosition = 1
	end

	for slot6 = 1, #slot0._taskToggleWraps do
		SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(slot0._taskToggleWraps[slot6].gameObject, "txt"), slot0.curTaskLoopType == uv0[slot6] and "#E99B56" or "#ffffff")
		ZProj.UGUIHelper.SetColorAlpha(slot7, slot0.curTaskLoopType == uv0[slot6] and 1 or 0.3)
		gohelper.setActive(gohelper.findChild(slot0._taskToggleWraps[slot6].gameObject, "Background/go_normal"), slot0.curTaskLoopType ~= uv0[slot6])
		gohelper.setActive(gohelper.findChild(slot0._taskToggleWraps[slot6].gameObject, "Background/go_select"), slot0.curTaskLoopType == uv0[slot6])
	end

	gohelper.setActive(slot0._godaytime, slot0.curTaskLoopType == TurnbackEnum.TaskLoopType.Day)
	recthelper.setAnchorY(slot0._scrolltask.gameObject.transform, slot0.curTaskLoopType == TurnbackEnum.TaskLoopType.Day and 0 or 50)
	recthelper.setHeight(slot0._scrolltask.gameObject.transform, TurnbackTaskModel.instance:getCount() <= uv1 and 496 or 683)

	if slot3 <= uv1 then
		slot0._gotaskViewport.transform.offsetMin = Vector2(0, 0)
	else
		slot0._gotaskViewport.transform.offsetMin = Vector2(0, slot0.viewContainer._scrollView._param.cellHeight + slot0.viewContainer._scrollView._param.cellSpaceV)
	end
end

function slot0._btnstoryOnClick(slot0)
	if TurnbackModel.instance:getCurTurnbackMo() and slot1.config and slot1.config.endStory then
		StoryController.instance:playStory(slot2)
	else
		logError(string.format("TurnbackTaskView endStoryId is nil", slot2))
	end
end

function slot0._refreshUI(slot0)
	slot2 = CurrencyModel.instance:getCurrency(slot0.bonusPointId) and slot1.quantity or 0

	slot0:_refreshTaskProcessBar(slot2)

	slot0._txtactiveNum.text = slot2
	slot0._txtdesc.text = slot0.viewConfig.actDesc

	gohelper.setActive(slot0._goprocessIcon, slot2 > 0)
	gohelper.setActive(slot0._gonoprocessIcon, slot2 == 0)
	slot0:_refreshRemainTime()
	slot0:_refreshRedDot()
	slot0:_refreshStoryBtn()
end

function slot0._refreshRedDot(slot0)
	for slot5, slot6 in pairs(slot0._toggleRedDotTab) do
		gohelper.setActive(slot6, TurnbackTaskModel.instance:getTaskLoopTypeDotState()[uv0[slot5]])
	end
end

function slot0._refreshRemainTime(slot0)
	slot0._txtremainTime.text = TurnbackController.instance:refreshRemainTime()
end

function slot0._refreshStoryBtn(slot0)
	gohelper.setActive(slot0._btnstory, TurnbackConfig.instance:getTurnbackCo(slot0.curTurnbackId) and StoryModel.instance:isStoryFinished(slot1.endStory) and slot0:_canPlayEndStory())
end

function slot0._refreshBonusPoint(slot0, slot1)
	if slot1[slot0.bonusPointId] then
		slot0:_refreshUI()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshTaskRewardItem)
	end
end

function slot0._playGetRewardFinishAnim(slot0, slot1)
	if slot1 then
		slot0.removeIndexTab = {
			slot1
		}
	end

	TaskDispatcher.runDelay(slot0.delayPlayFinishAnim, slot0, TurnbackEnum.TaskGetAnimTime)
end

function slot0.delayPlayFinishAnim(slot0)
	slot0._taskAnimRemoveItem:removeByIndexs(slot0.removeIndexTab)
end

function slot0._playEndStory(slot0, slot1)
	if slot1 == ViewName.CommonPropView and slot0:_canPlayEndStory() and not StoryModel.instance:isStoryFinished(TurnbackModel.instance:getCurTurnbackMo().config.endStory) then
		StoryController.instance:playStory(slot2, nil, slot0._refreshStoryBtn, slot0)
	end
end

function slot0._canPlayEndStory(slot0)
	slot1 = TurnbackModel.instance:getCurTurnbackMo()

	return #slot1.hasGetTaskBonus == GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot1.id))
end

function slot0.onClose(slot0)
	for slot4 = 1, #slot0._taskToggleWraps do
		slot0._taskToggleWraps[slot4]:RemoveOnValueChanged()
	end

	slot0._simagebg:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
