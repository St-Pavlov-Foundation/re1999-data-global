module("modules.logic.fight.view.FightSkipTimelineView", package.seeall)

slot0 = class("FightSkipTimelineView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#go_btnright/#btn_skip")
end

function slot0.addEvents(slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	FightController.instance:dispatchEvent(FightEvent.SkipAppearTimeline)
end

function slot0.onOpen(slot0)
	slot0._timeline = slot0.viewParam

	if uv0.getState(slot0._timeline) == 0 then
		uv0.setState(slot0._timeline, 1)
		gohelper.setActive(slot0.viewGO, false)
	else
		gohelper.setActive(slot0.viewGO, true)

		slot0._canSkip = true
	end

	NavigateMgr.instance:addEscape(ViewName.FightSkipTimelineView, slot0._onEscBtnClick, slot0)
end

function slot0._onEscBtnClick(slot0)
	if slot0._canSkip then
		FightController.instance:dispatchEvent(FightEvent.SkipAppearTimeline)
	end
end

function slot0.getState(slot0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.SkipAppearTimeline .. slot0, 0)
end

function slot0.setState(slot0, slot1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.SkipAppearTimeline .. slot0, slot1 or 1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
