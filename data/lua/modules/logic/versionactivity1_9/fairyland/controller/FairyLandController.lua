module("modules.logic.versionactivity1_9.fairyland.controller.FairyLandController", package.seeall)

slot0 = class("FairyLandController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.openFairyLandView(slot0, slot1)
	slot0.viewParam = slot1

	if FairyLandModel.instance.hasInfo then
		slot0:_openView()
	else
		FairyLandRpc.instance:sendGetFairylandInfoRequest(slot0._openView, slot0)
	end
end

function slot0._openView(slot0)
	if FairyLandModel.instance:isFinishFairyLand() then
		slot0:checkFinishFairyLandElement()

		return
	end

	ViewMgr.instance:openView(ViewName.FairyLandView, slot0.viewParam)
end

function slot0.checkFinishFairyLandElement(slot0)
	if not DungeonMapModel.instance:elementIsFinished(FairyLandEnum.ElementId) then
		DungeonRpc.instance:sendMapElementRequest(FairyLandEnum.ElementId)
	end
end

function slot0.openDialogView(slot0, slot1)
	uv0.instance:dispatchEvent(FairyLandEvent.ShowDialogView, slot1)
end

function slot0.closeDialogView(slot0)
	uv0.instance:dispatchEvent(FairyLandEvent.CloseDialogView)
end

function slot0.openCompleteView(slot0, slot1, slot2, slot3)
	if FairyLandEnum.Puzzle2ShapeType[slot1] then
		ViewMgr.instance:openView(ViewName.FairyLandCompleteView, {
			shapeType = slot4,
			callback = slot2,
			callbackObj = slot3
		})
	elseif slot2 then
		slot2(slot3)
	end
end

function slot0.endFairyLandStory()
	uv0.instance:checkFinishFairyLandElement()
end

slot0.instance = slot0.New()

return slot0
