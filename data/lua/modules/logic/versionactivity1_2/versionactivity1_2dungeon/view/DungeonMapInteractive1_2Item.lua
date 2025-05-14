module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.DungeonMapInteractive1_2Item", package.seeall)

local var_0_0 = class("DungeonMapInteractive1_2Item", BaseViewExtended)

function var_0_0._OnClickElement(arg_1_0, arg_1_1)
	arg_1_0._config = arg_1_1._config

	local var_1_0 = arg_1_0._config.type

	if var_1_0 == DungeonEnum.ElementType.DailyEpisode then
		local var_1_1 = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapinteractiveitem16.prefab"

		arg_1_0:openSubView(VersionActivity_1_2_DungeonMapInteractiveItem16, var_1_1, arg_1_0.viewGO, arg_1_0._config)
	elseif var_1_0 == DungeonEnum.ElementType.Activity1_2Building_Repair then
		local var_1_2 = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapinteractiveitem102.prefab"

		arg_1_0:openSubView(VersionActivity_1_2_DungeonMapInteractiveItem102, var_1_2, arg_1_0.viewGO, arg_1_0._config, arg_1_1)
	elseif var_1_0 == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		local var_1_3 = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmaplevelupitem.prefab"

		arg_1_0:openSubView(VersionActivity_1_2_DungeonMapLevelUpItem, var_1_3, arg_1_0.viewGO, arg_1_0._config)
	elseif var_1_0 == DungeonEnum.ElementType.Activity1_2Building_Trap then
		local var_1_4 = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmaptrapitem.prefab"

		arg_1_0:openSubView(VersionActivity_1_2_DungeonMapTrapItem, var_1_4, arg_1_0.viewGO, arg_1_0._config)
	elseif var_1_0 == DungeonEnum.ElementType.Activity1_2Fight then
		local var_1_5 = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapitem105.prefab"

		arg_1_0:openSubView(VersionActivity_1_2_DungeonMapItem105, var_1_5, arg_1_0.viewGO, arg_1_0._config)
	elseif var_1_0 == DungeonEnum.ElementType.Activity1_2Note then
		local var_1_6 = "ui/viewres/versionactivity_1_2/map/versionactivity_1_2_dungeonmapitem105.prefab"

		arg_1_0:openSubView(VersionActivity_1_2_DungeonMapItem107, var_1_6, arg_1_0.viewGO, arg_1_0._config)
	else
		arg_1_0.viewContainer.mapScene:createInteractiveItem()
		arg_1_0.viewContainer.mapScene._interactiveItem:_OnClickElement(arg_1_1)
	end
end

function var_0_0.destroySubView(arg_2_0, arg_2_1)
	var_0_0.super.destroySubView(arg_2_0, arg_2_1)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return var_0_0
