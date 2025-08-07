module("modules.logic.room.define.RoomBlockGiftEnum", package.seeall)

local var_0_0 = _M

var_0_0.SubType = {
	MaterialEnum.MaterialType.BlockPackage,
	MaterialEnum.MaterialType.Building
}
var_0_0.SubTypeInfo = {
	[MaterialEnum.MaterialType.BlockPackage] = {
		NumSortTxt = "p_roomblockpackageview_filtrate",
		SubType = 1,
		ListModel = RoomBlockGiftListModel,
		AllColloctToast = ToastEnum.RoomBlockAllCollectBlock,
		CellSize = {
			298,
			360
		},
		CellSpacing = {
			40,
			10
		}
	},
	[MaterialEnum.MaterialType.Building] = {
		NumSortTxt = "roombuildinggift_placingrange",
		SubType = 2,
		ListModel = RoomBuildingGiftListModel,
		AllColloctToast = ToastEnum.RoomBlockAllCollectBuilding,
		CellSize = {
			400,
			234
		},
		CellSpacing = {
			35,
			0
		}
	}
}
var_0_0.SortType = {
	Reverse = 2,
	Order = 1,
	None = 0
}

return var_0_0
