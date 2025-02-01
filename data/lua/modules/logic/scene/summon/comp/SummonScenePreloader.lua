module("modules.logic.scene.summon.comp.SummonScenePreloader", package.seeall)

slot0 = class("SummonScenePreloader", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._isImageLoad = false
	slot0._assetItemDict = {}

	slot0:_startLoadImage()
end

function slot0._startLoadImage(slot0)
	if #SummonMainController.instance:pickAllUIPreloadRes() > 0 then
		slot0._uiLoader = SequenceAbLoader.New()

		slot0._uiLoader:setPathList(slot1)
		slot0._uiLoader:setConcurrentCount(5)
		slot0._uiLoader:startLoad(slot0._onUIPreloadFinish, slot0)
	end
end

function slot0._onUIPreloadFinish(slot0)
	for slot5, slot6 in pairs(slot0._uiLoader:getAssetItemDict()) do
		slot6:Retain()

		slot0._assetItemDict[slot5] = slot6
	end

	if slot0._uiLoader then
		slot0._uiLoader:dispose()

		slot0._uiLoader = nil
	end

	slot0._isImageLoad = true
end

function slot0.getAssetItem(slot0, slot1)
	if slot0._assetItemDict[slot1] then
		return slot2
	end
end

function slot0.onSceneClose(slot0)
	if slot0._uiLoader then
		slot0._uiLoader:dispose()

		slot0._uiLoader = nil
	end

	for slot4, slot5 in pairs(slot0._assetItemDict) do
		slot5:Release()
	end

	slot0._assetItemDict = {}
end

function slot0.onSceneHide(slot0)
	slot0:onSceneClose()
end

return slot0
