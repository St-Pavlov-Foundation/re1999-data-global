module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.DungeonMapInteractive1_3Item", package.seeall)

local var_0_0 = class("DungeonMapInteractive1_3Item", BaseViewExtended)

function var_0_0._OnClickElement(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1._config

	if arg_1_0._config.type == DungeonEnum.ElementType.DailyEpisode then
		VersionActivity1_3DungeonController.instance.dailyFromEpisodeId = arg_1_0.viewContainer.versionActivityDungeonBaseMo.episodeId

		local var_1_0 = "ui/viewres/versionactivity_1_3/map/versionactivity_1_3_dungeonmapinteractiveitem16.prefab"

		if arg_1_0._itemView then
			arg_1_0._itemView:DESTROYSELF()

			arg_1_0._itemView = nil

			DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
		end

		arg_1_0._itemView = arg_1_0:openSubView(VersionActivity_1_3_DungeonMapInteractiveItem16, var_1_0, arg_1_0.viewGO, arg_1_0._config)
	else
		arg_1_0.viewContainer.mapScene:createInteractiveItem()
		arg_1_0.viewContainer.mapScene._interactiveItem:_OnClickElement(arg_1_1)
	end
end

function var_0_0.destroySubView(arg_2_0, arg_2_1)
	var_0_0.super.destroySubView(arg_2_0, arg_2_1)

	arg_2_0._itemView = nil

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return var_0_0
