module("modules.logic.turnback.view.new.view.TurnbackNewTaskView", package.seeall)

slot0 = class("TurnbackNewTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnreplay = gohelper.findChildButton(slot0.viewGO, "top/#btn_replay")
	slot0._btnbuy = gohelper.findChildButton(slot0.viewGO, "top/normalbg/#btn_buy")
	slot0._gotop = gohelper.findChild(slot0.viewGO, "top")
	slot0._goright = gohelper.findChild(slot0.viewGO, "right")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "top/normalbg")
	slot0._godouble = gohelper.findChild(slot0.viewGO, "top/doublebg")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "top/#scroll_view")
	slot0._scrolltask = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_task")
	slot0._gorewardviewport = gohelper.findChild(slot0.viewGO, "top/#scroll_view/Viewport")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "top/#scroll_view/Viewport/Content")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "top/#scroll_view/Viewport/Content/#go_rewarditem")
	slot0._gobigrewardItem = gohelper.findChild(slot0.viewGO, "top/#go_special")
	slot0._imgFill = gohelper.findChildImage(slot0.viewGO, "top/#scroll_view/Viewport/Content/progressbg/fill")
	slot0._txtActiveNum = gohelper.findChildText(slot0.viewGO, "top/#txt_activeNum")
	slot0._btnleft = gohelper.findChildButton(slot0.viewGO, "right/simage_rightbg/#btn_last")
	slot0._btnright = gohelper.findChildButton(slot0.viewGO, "right/simage_rightbg/#btn_next")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "right/simage_rightbg/numbg/#txt_num")
	slot0._gonumbg = gohelper.findChild(slot0.viewGO, "right/simage_rightbg/numbg")
	slot0._gotitlebg = gohelper.findChild(slot0.viewGO, "right/simage_rightbg/titlebg")
	slot0._gounfinish = gohelper.findChild(slot0.viewGO, "right/unfinish")
	slot0._gofinished = gohelper.findChild(slot0.viewGO, "right/finished")
	slot0._simageHero = gohelper.findChildSingleImage(slot0.viewGO, "right/unfinish/simage_role")
	slot0._goscrolldesc = gohelper.findChild(slot0.viewGO, "right/unfinish/#scroll_desc")
	slot0._txtHeroDesc = gohelper.findChildText(slot0.viewGO, "right/unfinish/#scroll_desc/Viewport/#txt_dec")
	slot0._btnexchange = gohelper.findChildButton(slot0.viewGO, "right/unfinish/#btn_exchange")
	slot0._rewardNodeList = {}
	slot0._heroIndex = 1
	slot0._isreverse = false
	slot0._isfinish = false
	slot0._topAnimator = slot0._gotop:GetComponent(typeof(UnityEngine.Animator))
	slot0._rightAnimator = slot0._goright:GetComponent(typeof(UnityEngine.Animator))
	slot0._rightTextAnim = slot0._goscrolldesc:GetComponent(typeof(UnityEngine.Animation))
	slot0.fullscrollWidth = 780
	slot0.normalscrollWidth = 604

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreplay:AddClickListener(slot0.onClickReplay, slot0)
	slot0._btnbuy:AddClickListener(slot0.onClickBuy, slot0)
	slot0._btnleft:AddClickListener(slot0.onClickLeft, slot0)
	slot0._btnright:AddClickListener(slot0.onClickRight, slot0)
	slot0._btnexchange:AddClickListener(slot0.onCilckReverse, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onCurrencyChange, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, slot0.succbuydoublereward, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	slot0._scrollreward:AddOnValueChanged(slot0._onScrollRectValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreplay:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnexchange:RemoveClickListener()
	slot0._scrollreward:RemoveOnValueChanged()
	slot0._scrolltask:RemoveOnValueChanged()
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, slot0._playGetRewardFinishAnim, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onCurrencyChange, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, slot0.succbuydoublereward, slot0)

	slot4 = ViewEvent.OnCloseView
	slot5 = slot0._onCloseViewFinish

	slot0:removeEventCb(ViewMgr.instance, slot4, slot5, slot0)

	for slot4, slot5 in ipairs(slot0._rewardNodeList) do
		slot5.btnclick:RemoveClickListener()
	end
end

function slot0._editableInitView(slot0)
	slot0._turnbackId = TurnbackModel.instance:getCurTurnbackId()

	slot0:_initRewardNode()
	slot0:_initBigRewardNode()
	slot0:_refreshFill()
	slot0:refreshTopBg()

	slot1 = TurnbackModel.instance:getUnlockHeroList()
	slot0._heroIndex = #slot1
	slot0._maxUnlockHeroIndex = #slot1

	slot0:_refreshHero()

	slot0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0.viewContainer._scrollView)

	slot0._taskAnimRemoveItem:setMoveInterval(0)
	slot0._taskAnimRemoveItem:setMoveAnimationTime(TurnbackEnum.TaskMaskTime - TurnbackEnum.TaskGetAnimTime)

	gohelper.findChildText(slot0.viewGO, "left/txt_dec").text = ServerTime.ReplaceUTCStr(luaLang("p_turnbacknewtaskview_txt_daily"))
end

function slot0._onScrollRectValueChanged(slot0, slot1, slot2)
	slot0:checkNeedHideReward(slot1)

	if not slot0._scrollTime then
		slot0._scrollTime = 0
		slot0._scrollX = slot1

		TaskDispatcher.runRepeat(slot0.checkScrollEnd, slot0, 0)
	end

	if slot0._scrollTime and math.abs(slot0._scrollX - slot1) > 0.05 then
		slot0._scrollTime = 0
		slot0._scrollX = slot1
	end
end

function slot0.checkScrollEnd(slot0)
	slot0._scrollTime = slot0._scrollTime + UnityEngine.Time.deltaTime

	if slot0._scrollTime > 0.05 then
		slot0._scrollTime = nil

		TaskDispatcher.cancelTask(slot0.checkScrollEnd, slot0)
	end
end

function slot0.checkNeedHideReward(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1 > 0.8 then
		recthelper.setWidth(slot0._scrollreward.transform, slot0.fullscrollWidth)
		gohelper.setActive(slot0._gobigrewardItem, false)
	else
		recthelper.setWidth(slot0._scrollreward.transform, slot0.normalscrollWidth)
		gohelper.setActive(slot0._gobigrewardItem, true)
	end
end

function slot0._refreshUI(slot0)
	slot0:refreshTopBg()
	slot0:_refreshFill()
	slot0:_refreshHero()
	slot0:refreshBigRewardNode()

	for slot4, slot5 in ipairs(slot0._rewardNodeList) do
		slot0:refreshRewardNode(slot5)
	end

	if TurnbackModel.instance:checkHasGetAllTaskReward() and TurnbackConfig.instance:getTurnbackCo(slot0._turnbackId) and not StoryModel.instance:isStoryFinished(slot2.endStory) then
		if slot2.endStory then
			StoryController.instance:playStory(slot4)
		else
			logError(string.format("TurnbackTaskView endStoryId is nil", slot4))
		end
	end
end

function slot0._refreshHero(slot0)
	slot0._unlockHeroCoList = TurnbackModel.instance:getUnlockHeroList()

	gohelper.setActive(slot0._btnleft.gameObject, slot0._heroIndex > 1)
	gohelper.setActive(slot0._btnright.gameObject, slot0._heroIndex < #slot0._unlockHeroCoList)

	if slot0._heroIndex == #TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0._turnbackId) then
		gohelper.setActive(slot0._btnright.gameObject, true)
	end

	if not slot0._unlockHeroCoList[slot0._heroIndex] then
		return
	end

	slot0._txtHeroDesc.text = slot4.content

	slot0._simageHero:LoadImage(ResUrl.getTurnbackIcon("new/task/turnback_new_task_role" .. slot0._heroIndex))

	slot5 = TurnbackModel.instance:getCanGetRewardList()

	if slot0._heroIndex > 1 then
		slot0._txtnum.text = slot0._unlockHeroCoList[slot0._heroIndex - 1].needPoint

		gohelper.setActive(slot0._gonumbg, true)
	else
		gohelper.setActive(slot0._gonumbg, false)
	end
end

function slot0.getSchedule(slot0)
	slot1 = 0
	slot2 = 0.06
	slot3 = 1
	slot4 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0._turnbackId)
	slot5 = #slot4
	slot6 = slot4[1].needPoint
	slot7 = TurnbackModel.instance:getCurrentPointId(slot0._turnbackId)
	slot8 = 0
	slot9 = 0
	slot10 = 0

	for slot14, slot15 in ipairs(slot4) do
		if slot15.needPoint <= slot7 then
			slot8 = slot14
			slot9 = slot15.needPoint
		else
			slot10 = slot15.needPoint

			break
		end
	end

	slot12 = (slot7 - slot9) / (slot10 - slot9)

	return slot8 == slot5 and 1 or slot8 - 1 + slot12 <= 0 and slot7 / slot6 * slot2 or slot2 + (slot3 - slot2) / (slot5 - 1) * (slot8 - 1 + slot12)
end

function slot0.refreshTopBg(slot0)
	slot1 = TurnbackModel.instance:getBuyDoubleBonus()

	gohelper.setActive(slot0._gonormal, not slot1)
	gohelper.setActive(slot0._godouble, slot1)

	slot2 = 50
	slot3 = 50
	slot4 = 100
	slot5 = 100
	slot6 = TurnbackModel.instance:getNextUnlockReward()
	slot8 = TurnbackModel.instance:getContentWidth() - slot0.normalscrollWidth

	if TurnbackModel.instance:checkHasGetAllTaskReward() then
		slot0._scrollreward.horizontalNormalizedPosition = 1
	elseif slot6 > 1 then
		slot6 = slot6 - 2
		slot9 = 0

		if (slot5 * slot6 + slot4 * (slot6 - 1) + slot2 + slot3) / slot8 >= 1 then
			slot0._scrollreward.horizontalNormalizedPosition = 1
		else
			slot0._scrollreward.horizontalNormalizedPosition = slot9
		end
	else
		slot0._scrollreward.horizontalNormalizedPosition = 0
	end
end

function slot0.onCurrencyChange(slot0)
	slot0:_refreshFill()

	slot0._unlockHeroCoList = TurnbackModel.instance:getUnlockHeroList()

	if slot0._maxUnlockHeroIndex < #slot0._unlockHeroCoList then
		slot0._maxUnlockHeroIndex = slot1
		slot0._heroIndex = slot1

		if slot0._isreverse then
			slot0._isreverse = not slot0._isreverse

			gohelper.setActive(slot0._simageHero.gameObject, not slot0._isreverse)
			gohelper.setActive(slot0._goscrolldesc, slot0._isreverse)
		end
	end

	slot0:_refreshHero()
	slot0:refreshTopBg()
end

function slot0._refreshFill(slot0)
	slot0._txtActiveNum.text = TurnbackModel.instance:getCurrentPointId(slot0._turnbackId) .. "/" .. TurnbackConfig.instance:getTurnbackLastBounsPoint(slot0._turnbackId)
	slot0._imgFill.fillAmount = slot0:getSchedule()
end

function slot0._initRewardNode(slot0)
	for slot5, slot6 in ipairs(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0._turnbackId)) do
		slot7 = slot0:getUserDataTb_()
		slot7.co = slot6
		slot7.go = gohelper.cloneInPlace(slot0._gorewardItem, "node" .. slot5)
		slot7.imgquality = gohelper.findChildImage(slot7.go, "#image_quality")
		slot7.imgCircle = gohelper.findChildImage(slot7.go, "#image_circle")
		slot7.goicon = gohelper.findChild(slot7.go, "go_icon")
		slot7.txtNum = gohelper.findChildText(slot7.go, "#txt_num")
		slot7.gocanget = gohelper.findChild(slot7.go, "go_canget")
		slot7.goreceive = gohelper.findChild(slot7.go, "go_receive")
		slot7.txtPoint = gohelper.findChildText(slot7.go, "point/#txt_point")
		slot7.golight = gohelper.findChild(slot7.go, "point/light")
		slot7.gogrey = gohelper.findChild(slot7.go, "point/grey")
		slot7.btnclick = gohelper.findChildButton(slot7.go, "go_canget/btn_click")

		slot7.btnclick:AddClickListener(function ()
			TurnbackRpc.instance:sendTurnbackBonusPointRequest({
				id = TurnbackModel.instance:getCurTurnbackId(),
				bonusPointId = uv0.co.id
			})
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonegg)
		end, slot0)
		gohelper.setActive(slot7.go, true)
		table.insert(slot0._rewardNodeList, slot7)

		slot9 = string.splitToNumber(slot6.bonus, "#")
		slot12 = slot9[3]
		slot13 = ItemConfig.instance:getItemConfig(slot9[1], slot9[2])

		UISpriteSetMgr.instance:setUiFBSprite(slot7.imgquality, "bg2_pinjidi_" .. slot13.rare)
		UISpriteSetMgr.instance:setUiFBSprite(slot7.imgCircle, "bg_pinjidi_lanse_" .. slot13.rare)

		if slot9 then
			if not slot7.itemIcon then
				slot7.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot7.goicon)
			end

			slot7.itemIcon:setMOValue(slot9[1], slot9[2], slot9[3], nil, true)
			slot7.itemIcon:isShowQuality(false)
			slot7.itemIcon:isShowCount(false)
		end

		slot7.txtNum.text = slot12
		slot7.txtPoint.text = slot6.needPoint

		slot0:refreshRewardNode(slot7)
	end
end

function slot0.refreshRewardNode(slot0, slot1)
	slot2 = slot1.co.id
	slot3 = TurnbackModel.instance:checkBonusCanGetById(slot2)

	gohelper.setActive(slot1.gocanget, slot3)
	gohelper.setActive(slot1.goreceive, TurnbackModel.instance:checkBonusGetById(slot2))

	if slot3 or slot4 then
		gohelper.setActive(slot1.golight, true)
		gohelper.setActive(slot1.gogrey, false)
	else
		gohelper.setActive(slot1.golight, false)
		gohelper.setActive(slot1.gogrey, true)
	end
end

function slot0._initBigRewardNode(slot0)
	slot0.bignode = slot0:getUserDataTb_()
	slot1 = slot0._gobigrewardItem
	slot0.bignode.go = slot1
	slot0.bignode.imgquality = gohelper.findChildImage(slot1, "#image_quality")
	slot0.bignode.imgCircle = gohelper.findChildImage(slot1, "#image_circle")
	slot0.bignode.goicon = gohelper.findChild(slot1, "go_icon")
	slot0.bignode.txtNum = gohelper.findChildText(slot1, "#txt_num")
	slot0.bignode.gocanget = gohelper.findChild(slot1, "go_canget")
	slot0.bignode.goreceive = gohelper.findChild(slot1, "go_receive")
	slot0.bignode.txtPoint = gohelper.findChildText(slot1, "point/#txt_point")
	slot0.bignode.golight = gohelper.findChild(slot1, "point/light")
	slot0.bignode.gogrey = gohelper.findChild(slot1, "point/grey")
	slot2 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0._turnbackId)
	slot3 = slot2[#slot2]
	slot0.bignode.config = slot3
	slot4 = string.splitToNumber(slot3.bonus, "#")
	slot7 = slot4[3]
	slot8 = ItemConfig.instance:getItemConfig(slot4[1], slot4[2])

	UISpriteSetMgr.instance:setUiFBSprite(slot0.bignode.imgquality, "bg2_pinjidi_" .. slot8.rare)
	UISpriteSetMgr.instance:setUiFBSprite(slot0.bignode.imgCircle, "bg_pinjidi_lanse_" .. slot8.rare)

	if slot4 then
		if not slot0.bignode.itemIcon then
			slot0.bignode.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0.bignode.goicon)
		end

		slot0.bignode.itemIcon:setMOValue(slot4[1], slot4[2], slot4[3], nil, true)
		slot0.bignode.itemIcon:isShowQuality(false)
		slot0.bignode.itemIcon:isShowCount(false)
	end

	slot0.bignode.txtNum.text = slot7
	slot0.bignode.txtPoint.text = slot3.needPoint

	slot0:refreshBigRewardNode()
end

function slot0.refreshBigRewardNode(slot0)
	slot1 = TurnbackModel.instance:checkBonusGetById(slot0.bignode.config.id)

	gohelper.setActive(slot0.bignode.goreceive, slot1)
	gohelper.setActive(slot0.bignode.golight, slot1)
	gohelper.setActive(slot0.bignode.gogrey, not slot1)
end

function slot0.onClickReplay(slot0)
	if TurnbackModel.instance:getCurTurnbackMo() and slot1.config and slot1.config.startStory then
		StoryController.instance:playStory(slot2)
	else
		logError(string.format("TurnbackRewardShowView startStoryId is nil", slot2))
	end
end

function slot0.onClickBuy(slot0)
	if not TurnbackModel.instance:getBuyDoubleBonus() then
		ViewMgr.instance:openView(ViewName.TurnbackDoubleRewardChargeView)
		StatController.instance:track(StatEnum.EventName.ClickReflowDoubleClaim, {})
	end
end

function slot0.onClickLeft(slot0)
	if slot0._heroIndex > 1 then
		slot0._rightAnimator:Update(0)
		slot0._rightAnimator:Play("leftout")
		TaskDispatcher.runDelay(slot0._afterleftout, slot0, 0.3)
		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end
end

function slot0._afterleftout(slot0)
	TaskDispatcher.cancelTask(slot0._afterleftout, slot0)
	slot0._rightAnimator:Update(0)
	slot0._rightAnimator:Play("leftin")

	if slot0._heroIndex == #TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0._turnbackId) and slot0._isfinish then
		slot0._isfinish = false

		gohelper.setActive(slot0._gofinished, slot0._isfinish)
		gohelper.setActive(slot0._gounfinish, not slot0._isfinish)
		gohelper.setActive(slot0._gonumbg, not slot0._isfinish)
		gohelper.setActive(slot0._gotitlebg, not slot0._isfinish)
		gohelper.setActive(slot0._btnright.gameObject, not slot0._isfinish)
	else
		slot0._heroIndex = slot0._heroIndex - 1

		slot0:_refreshHero()
	end

	TaskDispatcher.runDelay(slot0._afterleftin, slot0, 0.3)
end

function slot0._afterleftin(slot0)
	TaskDispatcher.cancelTask(slot0._afterleftin, slot0)
end

function slot0._afterrightout(slot0)
	TaskDispatcher.cancelTask(slot0._afterrightout, slot0)
	slot0._rightAnimator:Update(0)
	slot0._rightAnimator:Play("rightin")

	if slot0._heroIndex < #TurnbackConfig.instance:getAllTurnbackTaskBonusCo(slot0._turnbackId) then
		slot0._heroIndex = slot0._heroIndex + 1

		slot0:_refreshHero()
	else
		slot0._isfinish = true

		gohelper.setActive(slot0._gofinished, slot0._isfinish)
		gohelper.setActive(slot0._gounfinish, not slot0._isfinish)
		gohelper.setActive(slot0._gonumbg, not slot0._isfinish)
		gohelper.setActive(slot0._gotitlebg, not slot0._isfinish)
		gohelper.setActive(slot0._btnright.gameObject, not slot0._isfinish)
	end

	TaskDispatcher.runDelay(slot0._afterrightin, slot0, 0.3)
end

function slot0._afterrightin(slot0)
	TaskDispatcher.cancelTask(slot0._afterrightin, slot0)
end

function slot0.onClickRight(slot0)
	slot0._rightAnimator:Update(0)
	slot0._rightAnimator:Play("rightout")
	TaskDispatcher.runDelay(slot0._afterrightout, slot0, 0.3)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
end

function slot0.onCilckReverse(slot0)
	slot0._isreverse = not slot0._isreverse

	gohelper.setActive(slot0._simageHero.gameObject, not slot0._isreverse)
	gohelper.setActive(slot0._goscrolldesc, slot0._isreverse)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)

	if slot0._isreverse then
		slot0._rightTextAnim:Play()
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

function slot0.succbuydoublereward(slot0)
	slot0._needPlayAnim = true
end

function slot0._afterbuyanim(slot0)
	slot0._needPlayAnim = false

	TaskDispatcher.cancelTask(slot0._afterbuyanim, slot0)
	gohelper.setActive(slot0._gonormal, true)
	gohelper.setActive(slot0._godouble, true)
	slot0._topAnimator:Play("unlock")
	TaskDispatcher.runDelay(slot0._afterunlockanim, slot0, 0.6)
end

function slot0._afterunlockanim(slot0)
	TaskDispatcher.cancelTask(slot0._afterunlockanim, slot0)
	slot0:refreshTopBg()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:_refreshUI()
	end

	if slot0._needPlayAnim then
		TaskDispatcher.runDelay(slot0._afterbuyanim, slot0, 0.3)
	end
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_01)
	slot0:refreshTopBg()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._afterbuyanim, slot0)
	TaskDispatcher.cancelTask(slot0._afterunlockanim, slot0)
	TaskDispatcher.cancelTask(slot0._afterleftin, slot0)
	TaskDispatcher.cancelTask(slot0._afterleftout, slot0)
	TaskDispatcher.cancelTask(slot0._afterrightin, slot0)
	TaskDispatcher.cancelTask(slot0._afterrightout, slot0)
	TaskDispatcher.cancelTask(slot0.checkScrollEnd, slot0)
	TaskDispatcher.cancelTask(slot0.checkTaskScrollEnd, slot0)
	slot0._simageHero:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayFinishAnim, slot0)
end

return slot0
