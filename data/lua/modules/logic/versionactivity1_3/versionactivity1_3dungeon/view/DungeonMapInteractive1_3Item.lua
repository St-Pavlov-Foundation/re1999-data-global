module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.DungeonMapInteractive1_3Item", package.seeall)

slot0 = class("DungeonMapInteractive1_3Item", BaseViewExtended)

function slot0._OnClickElement(slot0, slot1)
	slot0._config = slot1._config

	if slot0._config.type == DungeonEnum.ElementType.DailyEpisode then
		VersionActivity1_3DungeonController.instance.dailyFromEpisodeId = slot0.viewContainer.versionActivityDungeonBaseMo.episodeId
		slot3 = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_dungeonmapinteractiveitem16.prefab"

		if slot0._itemView then
			slot0._itemView:DESTROYSELF()

			slot0._itemView = nil

			DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
		end

		slot0._itemView = slot0:openSubView(VersionActivity_1_3_DungeonMapInteractiveItem16, slot3, slot0.viewGO, slot0._config)
	else
		slot0.viewContainer.mapScene:createInteractiveItem()
		slot0.viewContainer.mapScene._interactiveItem:_OnClickElement(slot1)
	end
end

function slot0.destroySubView(slot0, slot1)
	uv0.super.destroySubView(slot0, slot1)

	slot0._itemView = nil

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return slot0
