module("modules.logic.turnback.view.TurnbackTaskBonusItem", package.seeall)

slot0 = class("TurnbackTaskBonusItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.param = slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.index = slot0.param.index
	slot0.goItemContent = gohelper.findChild(slot0.go, "scroll_item/Viewport/go_itemContent")
	slot0.goGetState = gohelper.findChild(slot0.go, "rewardState/go_get")
	slot0.btnCanGetState = gohelper.findChildButtonWithAudio(slot0.go, "rewardState/btn_canget")
	slot0.goDoingState = gohelper.findChild(slot0.go, "rewardState/go_doing")
	slot0.goNotGetActiveState = gohelper.findChild(slot0.go, "activeState/go_notget")
	slot0.txtNoGetActiveState = gohelper.findChildText(slot0.go, "activeState/go_notget/txt_notgetNum")
	slot0.goCanGetActiveState = gohelper.findChild(slot0.go, "activeState/go_canget")
	slot0.txtCanGetActiveState = gohelper.findChildText(slot0.go, "activeState/go_canget/txt_cangetNum")
	slot0.goRedDot = gohelper.findChild(slot0.go, "go_reddot")
	slot0._scrollitem = gohelper.findChild(slot0.go, "scroll_item"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._scrollitem.parentGameObject = slot0.param.parentScrollGO
	slot0._goGetAnim = gohelper.findChild(slot0.go, "ani")

	slot0:initItem()
	slot0:refreshItem()
end

function slot0.addEventListeners(slot0)
	slot0.btnCanGetState:AddClickListener(slot0._btnCanGetOnClick, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshTaskRewardItem, slot0.refreshItem, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnCanGetState:RemoveClickListener()
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshTaskRewardItem, slot0.refreshItem, slot0)
end

function slot0.initItem(slot0)
	slot0.rewardTab = {}
	slot0.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	slot5 = slot0.index
	slot0.config = TurnbackConfig.instance:getTurnbackTaskBonusCo(slot0.curTurnbackId, slot5)
	slot0.bonusPointType, slot0.bonusPointId = TurnbackConfig.instance:getBonusPointCo(slot0.curTurnbackId)

	for slot5 = 1, #string.split(slot0.config.bonus, "|") do
		slot6 = string.split(slot1[slot5], "#")
		slot7 = IconMgr.instance:getCommonPropItemIcon(slot0.goItemContent)

		slot7:setMOValue(slot6[1], slot6[2], slot6[3])
		slot7:setPropItemScale(0.55)
		slot7:setHideLvAndBreakFlag(true)
		slot7:hideEquipLvAndBreak(true)
		slot7:setCountFontSize(50)
		table.insert(slot0.rewardTab, slot7)
	end

	slot0.txtNoGetActiveState.text = slot0.config.needPoint
	slot0.txtCanGetActiveState.text = slot0.config.needPoint

	gohelper.setActive(slot0._goGetAnim, false)
end

function slot0.refreshItem(slot0)
	slot0.hasGetState = false
	slot2 = CurrencyModel.instance:getCurrency(slot0.bonusPointId) and slot1.quantity or 0

	gohelper.setActive(slot0.goNotGetActiveState, slot2 < slot0.config.needPoint)
	gohelper.setActive(slot0.goCanGetActiveState, slot0.config.needPoint <= slot2)

	for slot7, slot8 in ipairs(TurnbackModel.instance:getCurHasGetTaskBonus()) do
		if slot8 == slot0.index then
			slot0.hasGetState = true

			break
		end
	end

	gohelper.setActive(slot0.goGetState, slot0.hasGetState)
	gohelper.setActive(slot0.btnCanGetState.gameObject, not slot0.hasGetState and slot0.config.needPoint <= slot2)
	gohelper.setActive(slot0.goDoingState, not slot0.hasGetState and slot2 < slot0.config.needPoint)
	gohelper.setActive(slot0.goRedDot, false)

	for slot7, slot8 in ipairs(slot0.rewardTab) do
		slot8:setGetMask(slot0.hasGetState)
	end
end

function slot0._btnCanGetOnClick(slot0)
	gohelper.setActive(slot0._goGetAnim, true)
	UIBlockMgr.instance:startBlock("TurnbackTaskBonusItemFinish")
	TaskDispatcher.runDelay(slot0._playGetAnimFinish, slot0, TurnbackEnum.TaskGetBonusAnimTime)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
end

function slot0._playGetAnimFinish(slot0)
	gohelper.setActive(slot0._goGetAnim, false)
	UIBlockMgr.instance:endBlock("TurnbackTaskBonusItemFinish")
	TurnbackRpc.instance:sendTurnbackBonusPointRequest({
		id = TurnbackModel.instance:getCurTurnbackId(),
		bonusPointId = slot0.index
	})
end

function slot0.destroy(slot0)
	slot0:__onDispose()
	TaskDispatcher.TaskDispatcher.cancelTask(slot0._playGetAnimFinish, slot0)
end

return slot0
