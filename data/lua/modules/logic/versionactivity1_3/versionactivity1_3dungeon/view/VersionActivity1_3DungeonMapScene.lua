module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapScene", package.seeall)

slot0 = class("VersionActivity1_3DungeonMapScene", VersionActivity1_3DungeonBaseMapScene)

function slot0.getInteractiveItem(slot0)
	return slot0.viewContainer.mapView:openMapInteractiveItem()
end

function slot0.createInteractiveItem(slot0)
	uv0.super.getInteractiveItem(slot0)
end

function slot0.showInteractiveItem(slot0)
	return slot0.viewContainer.mapView:showInteractiveItem() or uv0.super.showInteractiveItem(slot0)
end

function slot0._isSameMap(slot0, slot1, slot2)
	return slot1 == slot2 and slot1 ~= VersionActivity1_3DungeonEnum.DailyEpisodeId
end

function slot0.getMapTime(slot0)
	slot1 = slot0.activityDungeonMo.episodeId

	if not slot0._lastEpisodeId or slot1 == slot2 then
		return
	end

	if VersionActivity1_3DungeonController.instance:isDayTime(slot2) == VersionActivity1_3DungeonController.instance:isDayTime(slot1) then
		return
	end

	return slot4 and "sun" or "moon"
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	MainCameraMgr.instance:addView(ViewName.VersionActivity1_3DungeonMapView, slot0._initCamera, nil, slot0)
end

return slot0
