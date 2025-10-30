module("modules.logic.versionactivity3_0.dungeon.controller.VersionActivity3_0DungeonController", package.seeall)

local var_0_0 = class("VersionActivity3_0DungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0._getModuleConfig(arg_3_0)
	arg_3_0._moduleConfig = arg_3_0._moduleConfig or {
		TaskViewRes = "ui/viewres/versionactivity_3_0/v3a0_taskview.prefab",
		StoreViewRes = "ui/viewres/versionactivity_3_0/v3a0_storeview.prefab",
		TaskItemRes = "ui/viewres/versionactivity_3_0/v3a0_taskitem.prefab",
		EnterView = VersionActivity3_0Enum.ActivityId.EnterView,
		ChapterId = DungeonEnum.ChapterId.Main1_11,
		DungeonStore = VersionActivity3_0Enum.ActivityId.DungeonStore,
		Dungeon = VersionActivity3_0Enum.ActivityId.Dungeon,
		Currency = CurrencyEnum.CurrencyType.V3a0Dungeon,
		StoreCellClass = VersionActivity2_8StoreGoodsItem,
		TaskCellClass = VersionActivity2_8TaskItem
	}

	return arg_3_0._moduleConfig
end

function var_0_0.openVersionActivityDungeonMapView(arg_4_0)
	local var_4_0 = arg_4_0:_getModuleConfig()

	VersionActivity2_8DungeonTaskStoreController.instance:openVersionActivityDungeonMapView(var_4_0.EnterView, var_4_0.Dungeon, var_4_0.ChapterId)
end

function var_0_0.openTaskView(arg_5_0)
	VersionActivity2_8DungeonTaskStoreController.instance:openTaskView(arg_5_0:_getModuleConfig())
end

function var_0_0.openStoreView(arg_6_0)
	VersionActivity2_8DungeonTaskStoreController.instance:openStoreView(arg_6_0:_getModuleConfig())
end

var_0_0.instance = var_0_0.New()

return var_0_0
