module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapViewContainer", package.seeall)

slot0 = class("EliminateMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, EliminateMapView.New())
	table.insert(slot1, EliminateMapWindowView.New())
	table.insert(slot1, EliminateMapAudioView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function slot0.onContainerInit(slot0)
	slot0:initViewParam()
end

function slot0.initViewParam(slot0)
	slot0.chapterId = slot0.viewParam and slot0.viewParam.chapterId

	if not slot0.chapterId then
		slot0.chapterId = EliminateMapModel.instance:getLastCanFightChapterId()
	end

	if not EliminateMapModel.instance:checkChapterIsUnlock(slot0.chapterId) then
		slot0.chapterId = EliminateMapEnum.DefaultChapterId
	end
end

function slot0.changeChapterId(slot0, slot1)
	if slot0.chapterId == slot1 then
		return
	end

	slot0.chapterId = slot1

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.OnSelectChapterChange)
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
