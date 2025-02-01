module("modules.logic.activity.view.Activity101SignViewItemBase", package.seeall)

slot0 = class("Activity101SignViewItemBase", ListScrollCellExtend)
slot1 = 0.03
slot2 = 0.25
slot3 = false

function slot0._optimizePlayOpenAnim(slot0)
	if slot0._index <= slot0:getScrollModel():getStartPinIndex() then
		uv0 = true
	end

	if uv0 then
		slot0:playOpenAnim()
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if slot0:isLimitedScrollViewItem() then
		slot0:_optimizePlayOpenAnim()
	end

	slot0:onRefresh()
	slot0:_refresh_TomorrowTagGo()
end

function slot0._animCmp(slot0)
	if not slot0._anim then
		slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)

		assert(slot0._anim, "can not found anim component!!")
	end

	return slot0._anim
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._playOpenInner, slot0)

	uv0 = false
end

function slot0._onItemClick(slot0)
	slot2 = slot0._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if not ActivityModel.instance:isActOnLine(slot0:actId()) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	slot4 = ActivityType101Model.instance:getType101LoginCount(slot1)

	if ActivityType101Model.instance:isType101RewardCouldGet(slot1, slot2) then
		Activity101Rpc.instance:sendGet101BonusRequest(slot1, slot2)
	end

	if slot4 < slot2 then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function slot0._playOpenInner(slot0)
	slot0:setActive(true)
	slot0:_animCmp():Play(UIAnimationName.Open, 0, 0)
end

function slot0.playOpenAnim(slot0)
	if slot0._mo.__isPlayedOpenAnim then
		slot0:_playIdle()

		return
	end

	slot1.__isPlayedOpenAnim = true
	slot2 = slot0._index
	slot3 = nil

	if slot0:isLimitedScrollViewItem() then
		if slot2 < slot0:getScrollModel():getStartPinIndex() then
			slot0:_playIdle()

			return
		end

		if uv1 < math.max(0, slot2 - slot5 + 1) * uv0 then
			slot3 = uv1

			slot0:_playIdle()

			return
		end
	else
		slot3 = slot2 * uv0
	end

	slot0:setActive(false)
	TaskDispatcher.runDelay(slot0._playOpenInner, slot0, slot3)
end

function slot0._playIdle(slot0)
	slot0:_animCmp():Play(UIAnimationName.Idle, 0, 1)
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.isLimitedScrollViewItem(slot0)
	return type(slot0._view.getScrollModel) ~= "function"
end

function slot0.getScrollModel(slot0)
	slot1 = slot0._view

	if slot0:isLimitedScrollViewItem() then
		return slot1._model
	end

	return slot1:getScrollModel()
end

function slot0._refreshRewardItem(slot0, slot1, slot2)
	slot1:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1:setCountFontSize(46)
	slot1:setHideLvAndBreakFlag(true)
	slot1:hideEquipLvAndBreak(true)
	slot1:customOnClickCallback(function ()
		slot1 = uv0._index

		if not ActivityModel.instance:isActOnLine(uv0:actId()) then
			GameFacade.showToast(ToastEnum.BattlePass)

			return
		end

		if ActivityType101Model.instance:isType101RewardCouldGet(slot0, slot1) then
			Activity101Rpc.instance:sendGet101BonusRequest(slot0, slot1)

			return
		end

		MaterialTipController.instance:showMaterialInfo(uv1[1], uv1[2])
	end)
end

function slot0._setActive_TomorrowTagGo(slot0, slot1)
	gohelper.setActive(slot0:_tomorrowTagGo(), slot1)
end

function slot0._setActive_kelingquGo(slot0, slot1)
	gohelper.setActive(slot0:_kelingquGo(), slot1)
end

slot4 = 86400

function slot0._refresh_TomorrowTagGo(slot0)
	slot0:_setActive_TomorrowTagGo(slot0._index == ActivityType101Model.instance:getType101LoginCount(slot0:actId()) + 1 and uv0 <= slot0:getRemainTimeSec() or false)
end

function slot0.actId(slot0)
	return slot0._mo.data[1]
end

function slot0.view(slot0)
	return slot0._view
end

function slot0.viewContainer(slot0)
	return slot0:view().viewContainer
end

function slot0.getRemainTimeSec(slot0)
	return ActivityModel.instance:getRemainTimeSec(slot0:actId()) or 0
end

function slot0.onRefresh(slot0)
	assert(false, "please override thid function")
end

function slot0._kelingquGo(slot0)
	if not slot0._kelinquGo then
		if slot0._goSelectedBG then
			slot0._kelinquGo = gohelper.findChild(slot0._goSelectedBG, "kelinqu")
		else
			slot0._kelinquGo = gohelper.findChild(slot0.viewGO, "Root/#go_SelectedBG/kelinqu")
		end
	end

	return slot0._kelinquGo
end

function slot0._tomorrowTagGo(slot0)
	if not slot0._goTomorrowTag then
		slot0._goTomorrowTag = gohelper.findChild(slot0.viewGO, "Root/#go_TomorrowTag")
	end

	return slot0._goTomorrowTag
end

return slot0
