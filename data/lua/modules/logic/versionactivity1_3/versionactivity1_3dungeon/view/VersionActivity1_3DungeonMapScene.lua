module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonMapScene", VersionActivity1_3DungeonBaseMapScene)

function var_0_0.getInteractiveItem(arg_1_0)
	return arg_1_0.viewContainer.mapView:openMapInteractiveItem()
end

function var_0_0.createInteractiveItem(arg_2_0)
	var_0_0.super.getInteractiveItem(arg_2_0)
end

function var_0_0.showInteractiveItem(arg_3_0)
	return arg_3_0.viewContainer.mapView:showInteractiveItem() or var_0_0.super.showInteractiveItem(arg_3_0)
end

function var_0_0._isSameMap(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_1 == arg_4_2 and arg_4_1 ~= VersionActivity1_3DungeonEnum.DailyEpisodeId
end

function var_0_0.getMapTime(arg_5_0)
	local var_5_0 = arg_5_0.activityDungeonMo.episodeId
	local var_5_1 = arg_5_0._lastEpisodeId

	if not var_5_1 or var_5_0 == var_5_1 then
		return
	end

	local var_5_2 = VersionActivity1_3DungeonController.instance:isDayTime(var_5_1)
	local var_5_3 = VersionActivity1_3DungeonController.instance:isDayTime(var_5_0)

	if var_5_2 == var_5_3 then
		return
	end

	return var_5_3 and "sun" or "moon"
end

function var_0_0.onOpen(arg_6_0)
	var_0_0.super.onOpen(arg_6_0)
	MainCameraMgr.instance:addView(ViewName.VersionActivity1_3DungeonMapView, arg_6_0._initCamera, nil, arg_6_0)
end

return var_0_0
