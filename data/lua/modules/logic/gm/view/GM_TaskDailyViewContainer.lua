module("modules.logic.gm.view.GM_TaskDailyViewContainer", package.seeall)

slot0 = class("GM_TaskDailyViewContainer", GM_TaskListCommonItemContainer)
slot1 = nil

function slot0.buildViews(slot0)
	return {
		GM_TaskDailyView.New()
	}
end

function slot0._gm_showAllTabIdUpdate(slot0, slot1)
	assert(uv0)
	uv0:_gm_showAllTabIdUpdate(slot1)
end

function slot0._gm_enableFinishOnSelect(slot0, slot1)
	assert(uv0)
	uv0:_gm_enableFinishOnSelect(slot1)
end

function slot0._gm_onClickFinishAll(slot0)
	assert(uv0)
	uv0:_gm_onClickFinishAll()
end

function slot0.addEvents(slot0)
	uv0 = assert(slot0)
end

function slot0.removeEvents(slot0)
	uv0 = nil
end

return slot0
