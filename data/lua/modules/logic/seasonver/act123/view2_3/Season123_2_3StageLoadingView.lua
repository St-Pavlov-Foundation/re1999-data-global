module("modules.logic.seasonver.act123.view2_3.Season123_2_3StageLoadingView", package.seeall)

slot0 = class("Season123_2_3StageLoadingView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.handleDelayAnimTransition, slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.handleOpenView, slot0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_map_upgrade)
	logNormal(string.format("Season123_2_3StageLoadingView actId=%s, stage=%s", slot0.viewParam.actId, slot0.viewParam.stage))
	TaskDispatcher.runDelay(slot0.handleDelayAnimTransition, slot0, 2.5)
end

function slot0.onClose(slot0)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, true)
end

function slot0.handleDelayAnimTransition(slot0)
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
		actId = slot0.viewParam.actId,
		stage = slot0.viewParam.stage
	})
end

function slot0.handleOpenView(slot0, slot1)
	if slot1 == Season123Controller.instance:getEpisodeListViewName() then
		slot0:closeThis()
	end
end

return slot0
