module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.DungeonMapInteractive1_2Item", package.seeall)

slot0 = class("DungeonMapInteractive1_2Item", BaseViewExtended)

function slot0._OnClickElement(slot0, slot1)
	slot0._config = slot1._config

	if slot0._config.type == DungeonEnum.ElementType.DailyEpisode then
		slot0:openSubView(VersionActivity_1_2_DungeonMapInteractiveItem16, "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapinteractiveitem16.prefab", slot0.viewGO, slot0._config)
	elseif slot2 == DungeonEnum.ElementType.Activity1_2Building_Repair then
		slot0:openSubView(VersionActivity_1_2_DungeonMapInteractiveItem102, "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapinteractiveitem102.prefab", slot0.viewGO, slot0._config, slot1)
	elseif slot2 == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		slot0:openSubView(VersionActivity_1_2_DungeonMapLevelUpItem, "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmaplevelupitem.prefab", slot0.viewGO, slot0._config)
	elseif slot2 == DungeonEnum.ElementType.Activity1_2Building_Trap then
		slot0:openSubView(VersionActivity_1_2_DungeonMapTrapItem, "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmaptrapitem.prefab", slot0.viewGO, slot0._config)
	elseif slot2 == DungeonEnum.ElementType.Activity1_2Fight then
		slot0:openSubView(VersionActivity_1_2_DungeonMapItem105, "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapitem105.prefab", slot0.viewGO, slot0._config)
	elseif slot2 == DungeonEnum.ElementType.Activity1_2Note then
		slot0:openSubView(VersionActivity_1_2_DungeonMapItem107, "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapitem105.prefab", slot0.viewGO, slot0._config)
	else
		slot0.viewContainer.mapScene:createInteractiveItem()
		slot0.viewContainer.mapScene._interactiveItem:_OnClickElement(slot1)
	end
end

function slot0.destroySubView(slot0, slot1)
	uv0.super.destroySubView(slot0, slot1)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return slot0
