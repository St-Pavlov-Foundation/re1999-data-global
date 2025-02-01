module("modules.logic.gm.view.GM_TaskListCommonItemContainer", package.seeall)

slot0 = class("GM_TaskListCommonItemContainer", BaseViewContainer)

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.buildViews(slot0)
	assert(false)
end

function slot0._gm_showAllTabIdUpdate(slot0)
	assert(false, "please override this function")
end

function slot0._gm_enableFinishOnSelect(slot0)
	assert(false, "please override this function")
end

function slot0._gm_onClickFinishAll(slot0)
	assert(false, "please override this function")
end

return slot0
