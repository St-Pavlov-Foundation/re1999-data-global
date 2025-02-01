module("modules.logic.turnback.view.TurnbackMainBtnItem", package.seeall)

slot0 = class("TurnbackMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.turnbackId = slot2
	slot0.go = gohelper.cloneInPlace(slot1)

	gohelper.setActive(slot0.go, true)

	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.getClick(gohelper.findChild(slot0.go, "bg"))
	slot0._reddotitem = gohelper.findChild(slot0.go, "go_activityreddot")
	slot0._txttheme = gohelper.findChildText(slot0.go, "txt_theme")
	slot0._godeadline = gohelper.findChild(slot0.go, "#go_deadline")
	slot0._txttime = gohelper.findChildText(slot0.go, "#go_deadline/#txt_time")
	slot0._hasSetRefreshTime = false

	slot0:_refreshItem()
	slot0:addEvent()
end

function slot0.addEvent(slot0)
	slot0._btnitem:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEvent(slot0)
	slot0._btnitem:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	TurnbackController.instance:openTurnbackBeginnerView({
		turnbackId = slot0.turnbackId
	})
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_activity_open)
end

function slot0._refreshItem(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, "icon_4", true)

	slot0._redDot = RedDotController.instance:addRedDot(slot0._reddotitem, RedDotEnum.DotNode.TurnbackEntre, nil, slot0._checkCustomShowRedDotData, slot0)

	if TurnbackModel.instance:getCurTurnbackMoWithNilError() then
		gohelper.setActive(slot0._godeadline, true)
		slot0:_refreshRemainTime()

		slot1, slot2, slot3, slot4 = TurnbackModel.instance:getRemainTime()

		TaskDispatcher.runDelay(slot0._delayUpdateView, slot0, slot4)
	else
		gohelper.setActive(slot0._godeadline, false)
	end
end

function slot0._delayUpdateView(slot0)
	slot0:_refreshRemainTime()

	slot1, slot2, slot3 = TurnbackModel.instance:getRemainTime()

	if slot1 <= 0 and slot2 <= 1 and slot3 <= 1 and not slot0._hasSetRefreshTime then
		TaskDispatcher.runRepeat(slot0._refreshRemainTime, slot0, 2)

		slot0._hasSetRefreshTime = true
	else
		TaskDispatcher.runRepeat(slot0._refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	end
end

function slot0._refreshRemainTime(slot0)
	slot1, slot2, slot3, slot4 = TurnbackModel.instance:getRemainTime()

	if not TurnbackModel.instance:isInOpenTime() then
		TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)
	end

	if slot1 == 0 and slot2 <= 1 and slot3 <= 1 and not slot0._hasSetRefreshTime then
		TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)
		TaskDispatcher.runRepeat(slot0._refreshRemainTime, slot0, 2)

		slot0._hasSetRefreshTime = true
	end

	if slot1 >= 1 then
		slot0._txttime.text = string.format("%d d", slot1)
	elseif slot1 == 0 and slot2 >= 1 then
		slot0._txttime.text = string.format("%d h", slot2)
	elseif slot1 == 0 and slot2 < 1 and slot3 >= 1 then
		slot0._txttime.text = string.format("%d m", slot3)
	elseif slot1 == 0 and slot2 < 1 and slot3 < 1 and slot4 >= 0 then
		slot0._txttime.text = "<1m"
	elseif slot1 < 0 or not TurnbackModel.instance:isInOpenTime() then
		TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)
	end

	TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshRemainTime)
end

function slot0._checkCustomShowRedDotData(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		if TurnbackModel.instance:getCurTurnbackMo() and TurnbackModel.instance:getCurTurnbackMo():isAdditionInOpenTime() then
			TurnbackController.instance:_checkCustomShowRedDotData(slot1, TurnbackEnum.ActivityId.DungeonShowView)
		end

		if TurnbackModel.instance:getCurTurnbackMo() and TurnbackRecommendModel.instance:getCanShowRecommendCount() > 0 then
			TurnbackController.instance:_checkCustomShowRedDotData(slot1, TurnbackEnum.ActivityId.RecommendView)
		end
	end
end

function slot0.destroy(slot0)
	slot0:removeEvent()
	TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)
	TaskDispatcher.cancelTask(slot0._delayUpdateView, slot0)
	gohelper.setActive(slot0.go, false)
	gohelper.destroy(slot0.go)
	slot0:__onDispose()
end

function slot0.isShowRedDot(slot0)
	return slot0._redDot and slot0._redDot.show
end

return slot0
