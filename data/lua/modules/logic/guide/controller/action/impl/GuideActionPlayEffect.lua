module("modules.logic.guide.controller.action.impl.GuideActionPlayEffect", package.seeall)

slot0 = class("GuideActionPlayEffect", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot0._effectRoot = slot2[1]
	slot0._effectPathList = string.split(slot2[2], ",")
	slot0._effectGoList = {}
	slot0._loader = MultiAbLoader.New()

	for slot7, slot8 in ipairs(slot0._effectPathList) do
		slot3:addPath(slot8)
	end

	slot3:startLoad(slot0._loadedFinish, slot0)
	slot0:onDone(true)
end

function slot0._loadedFinish(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._effectPathList) do
		table.insert(slot0._effectGoList, gohelper.clone(slot0._loader:getAssetItem(slot7):GetResource(slot7), gohelper.find(slot0._effectRoot)))
	end
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)

	if slot0._loader then
		slot0._loader:dispose()
	end

	if slot0._effectGoList then
		for slot4, slot5 in ipairs(slot0._effectGoList) do
			UnityEngine.GameObject.Destroy(slot5)
		end
	end
end

return slot0
