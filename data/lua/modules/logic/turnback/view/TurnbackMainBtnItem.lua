module("modules.logic.turnback.view.TurnbackMainBtnItem", package.seeall)

slot0 = class("TurnbackMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.turnbackId = slot2
	slot0.go = gohelper.cloneInPlace(slot1)

	gohelper.setActive(slot0.go, true)

	slot0._imgGo = gohelper.findChild(slot0.go, "bg")
	slot0._imgitem = gohelper.findChildImage(slot0._imgGo, "")
	slot0._btnitem = gohelper.getClick(slot0._imgGo)

	slot0:_initReddotitem(slot0.go)

	slot0._txttheme = gohelper.findChildText(slot0.go, "txt_theme")
	slot0._godeadline = gohelper.findChild(slot0.go, "#go_deadline")
	slot0._txttime = gohelper.findChildText(slot0.go, "#go_deadline/#txt_time")
	slot0._hasSetRefreshTime = false

	slot0:addEvent()
	slot0:_refreshItem()
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
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, ActivityModel.showActivityEffect() and ActivityConfig.instance:getMainActAtmosphereConfig().mainViewActBtnPrefix .. "icon_4" or "icon_4", true)

	if not slot1 and ActivityConfig.instance:getMainActAtmosphereConfig() then
		for slot8, slot9 in ipairs(slot4.mainViewActBtn) do
			if gohelper.findChild(slot0.go, slot9) then
				gohelper.setActive(slot10, slot1)
			end
		end
	end

	if TurnbackModel.instance:getCurTurnbackMoWithNilError() then
		gohelper.setActive(slot0._godeadline, true)
		slot0:_refreshRemainTime()

		slot4, slot5, slot6, slot7 = TurnbackModel.instance:getRemainTime()

		TaskDispatcher.runDelay(slot0._delayUpdateView, slot0, slot7)
	else
		gohelper.setActive(slot0._godeadline, false)
	end

	slot0._redDot:refreshDot()
end

function slot0._delayUpdateView(slot0)
	slot0:_refreshRemainTime()

	slot1, slot2, slot3 = TurnbackModel.instance:getRemainTime()

	TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)

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

function slot0.destroy(slot0)
	slot0:removeEvent()
	TaskDispatcher.cancelTask(slot0._refreshRemainTime, slot0)
	TaskDispatcher.cancelTask(slot0._delayUpdateView, slot0)
	gohelper.destroy(slot0.go)
	slot0:__onDispose()
end

function slot0.isShowRedDot(slot0)
	return slot0._redDot.show
end

function slot0._initReddotitem(slot0, slot1)
	slot8 = slot0._checkCustomShowRedDotData
	slot0._redDot = RedDotController.instance:addRedDot(gohelper.findChild(slot1, "go_activityreddot"), RedDotEnum.DotNode.TurnbackEntre, nil, slot8, slot0)

	return

	for slot8 = 1, gohelper.findChild(slot1, "go_activityreddot/#go_special_reds").transform.childCount do
		gohelper.setActive(slot3:GetChild(slot8 - 1).gameObject, false)
	end

	slot5 = gohelper.findChild(slot2, "#go_turnback_red")
	slot0._redDot = RedDotController.instance:addRedDotTag(slot5, RedDotEnum.DotNode.TurnbackEntre, false, slot0._onRefreshDot, slot0)
	slot0._btnitem2 = gohelper.getClick(slot5)
end

function slot0._onRefreshDot(slot0, slot1)
	slot2 = slot0:_checkIsShowRed(slot1.dotId, 0)
	slot1.show = slot2

	gohelper.setActive(slot1.go, slot2)
	gohelper.setActive(slot0._imgGo, not slot2)
end

function slot0._checkIsShowRed(slot0, slot1, slot2)
	if RedDotModel.instance:isDotShow(slot1, slot2 or 0) then
		return true
	end

	if not TurnbackModel.instance:getCurTurnbackMo() then
		return false
	end

	if slot3:isAdditionInOpenTime() and TurnbackController.instance:checkIsShowCustomRedDot(TurnbackEnum.ActivityId.DungeonShowView) then
		return true
	end

	if TurnbackRecommendModel.instance:getCanShowRecommendCount() > 0 and TurnbackController.instance:checkIsShowCustomRedDot(TurnbackEnum.ActivityId.RecommendView) then
		return true
	end

	return false
end

function slot0._checkCustomShowRedDotData(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show and not TurnbackModel.instance:isNewType() then
		if TurnbackModel.instance:getCurTurnbackMo() and TurnbackModel.instance:getCurTurnbackMo():isAdditionInOpenTime() then
			TurnbackController.instance:_checkCustomShowRedDotData(slot1, TurnbackEnum.ActivityId.DungeonShowView)
		end

		if TurnbackModel.instance:getCurTurnbackMo() and TurnbackRecommendModel.instance:getCanShowRecommendCount() > 0 then
			TurnbackController.instance:_checkCustomShowRedDotData(slot1, TurnbackEnum.ActivityId.RecommendView)
		end
	end
end

return slot0
