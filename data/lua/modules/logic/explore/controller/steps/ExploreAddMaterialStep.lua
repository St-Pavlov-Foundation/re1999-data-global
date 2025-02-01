module("modules.logic.explore.controller.steps.ExploreAddMaterialStep", package.seeall)

slot0 = class("ExploreAddMaterialStep", ExploreStepBase)

function slot0.onStart(slot0)
	for slot5 = 1, #slot0._data.materialData do
	end

	ExploreController.instance:addItem({
		[slot5] = cjson.decode(slot0._data.materialData[slot5])
	})

	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.checkHavePopup, slot0)
	else
		slot0:onDone()
	end
end

function slot0.checkHavePopup(slot0)
	if PopupController.instance:getPopupCount() <= 0 and not ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) then
		if not ViewMgr.instance:isOpen(ViewName.CommonPropView) then
			slot0:onDone()
		end
	end
end

function slot0.onDestory(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.checkHavePopup, slot0)
	uv0.super.onDestory(slot0)
end

return slot0
