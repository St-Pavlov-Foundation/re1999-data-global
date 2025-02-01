module("modules.logic.versionactivity2_1.warmup.view.V2a1_WarmUpContainer", package.seeall)

slot0 = class("V2a1_WarmUpContainer", Activity125WarmUpViewBaseContainer)
slot1 = {
	Closed = 0,
	Opened = 1
}
slot2 = "v2a1_warmup_reward%s"

function slot0.getImgSpriteName(slot0, slot1)
	return string.format(uv0, slot1)
end

function slot0.buildViews(slot0)
	slot0._warmUp = V2a1_WarmUp.New()
	slot0._warmUpLeftView = Act2_1WarmUpLeftView.New()

	return {
		slot0._warmUp,
		slot0._warmUpLeftView
	}
end

function slot0.onContainerInit(slot0)
	slot0.__isWaitingPlayHasGetAnim = false

	uv0.super.onContainerInit(slot0)

	slot0._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function slot0.onContainerOpen(slot0)
	slot0._warmUp:setBlock_scroll(false)
	uv0.super.onContainerOpen(slot0)
end

function slot0.onContainerClose(slot0)
	uv0.super.onContainerClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	slot0:setCurSelectEpisodeIdSlient(nil)
end

function slot0.onContainerCloseFinish(slot0)
end

function slot0.onDataUpdateFirst(slot0)
	slot0._warmUp:onDataUpdateFirst()
	slot0._warmUpLeftView:onDataUpdateFirst()
end

function slot0.onDataUpdate(slot0)
	slot0._warmUp:onDataUpdate()
	slot0._warmUpLeftView:onDataUpdate()
end

function slot0.onDataUpdateDoneFirst(slot0)
	if not slot0:checkIsOpen(slot0:getCurSelectedEpisode()) then
		slot0:openGuide()

		return
	end

	slot0:tryTweenDesc()
end

function slot0.onSwitchEpisode(slot0)
	slot0.__isWaitingPlayHasGetAnim = false

	slot0._warmUp:setBlock_scroll(false)
	slot0._warmUp:onSwitchEpisode()
	slot0._warmUpLeftView:onSwitchEpisode()
end

function slot0.episode2Index(slot0, slot1)
	return slot0._warmUp:episode2Index(slot1)
end

function slot0.switchTabWithAnim(slot0, slot1, slot2)
	if slot0._tweenSwitchContext.lastEpisode then
		return
	end

	if not slot2 then
		slot0._tweenSwitchContext.lastEpisode = false
		slot0._tweenSwitchContext.curEpisodeId = false

		return
	end

	slot0._tweenSwitchContext.lastEpisode = slot1
	slot0._tweenSwitchContext.curEpisodeId = slot2

	slot0._warmUp:tweenSwitch(function ()
		uv0._tweenSwitchContext.lastEpisode = false
	end)
end

function slot0.switchTabNoAnim(slot0, slot1, slot2)
	slot0._tweenSwitchContext.lastEpisode = false
	slot0._tweenSwitchContext.curEpisodeId = false

	slot0:setCurSelectEpisodeIdSlient(slot2 or slot0._tweenSwitchContext.curEpisodeId)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function slot0.sendFinishAct125EpisodeRequest(slot0, ...)
	slot0.__isWaitingPlayHasGetAnim = true

	uv0.super.sendFinishAct125EpisodeRequest(slot0, ...)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 ~= ViewName.CommonPropView then
		return
	end

	slot0._warmUp:playRewardItemsHasGetAnim()

	slot0.__isWaitingPlayHasGetAnim = false
end

function slot0.isWaitingPlayHasGetAnim(slot0)
	return slot0.__isWaitingPlayHasGetAnim
end

function slot0.tryTweenDesc(slot0)
	slot1, slot2 = slot0:getRLOCCur()

	if slot1 then
		return
	end

	if slot2 then
		return
	end

	if not slot0:checkIsOpen(slot0:getCurSelectedEpisode()) then
		return
	end

	slot0:openDesc()
end

function slot0.checkIsOpen(slot0, slot1)
	if slot0:getRLOCCur() then
		return true
	end

	return slot0:_get_box(slot1 or slot0:getCurSelectedEpisode(), uv0.Closed) == uv0.Opened
end

function slot0.saveBoxState(slot0, slot1, slot2)
	slot0:_save_box(slot1 or slot0:getCurSelectedEpisode(), slot2 and uv0.Opened or uv0.Closed)
end

function slot0.openDesc(slot0)
	slot0._warmUp:setBlock_scroll(true)
	slot0._warmUp:openDesc(function ()
		uv0:setLocalIsPlayCur()
		uv0._warmUp:_refresh()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_read_over)
		uv0._warmUp:setBlock_scroll(false)
	end)
end

function slot0.openGuide(slot0)
	slot0._warmUpLeftView:openGuide()
end

slot3 = "box|"

function slot0._getPrefsKey_box(slot0, slot1)
	return slot0:getPrefsKeyPrefix() .. uv0 .. tostring(slot1)
end

function slot0._save_box(slot0, slot1, slot2)
	slot0:saveInt(slot0:_getPrefsKey_box(slot1), slot2 or uv0.Closed)
end

function slot0._get_box(slot0, slot1, slot2)
	return slot0:getInt(slot0:_getPrefsKey_box(slot1), slot2 or uv0.Closed)
end

return slot0
