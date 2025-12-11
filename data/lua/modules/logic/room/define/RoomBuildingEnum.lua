module("modules.logic.room.define.RoomBuildingEnum", package.seeall)

local var_0_0 = _M

var_0_0.BuildingState = {
	Revert = 4,
	Inventory = 3,
	Temp = 2,
	Map = 1
}
var_0_0.BuildingType = {
	Collect = 1,
	Manufacture = 3,
	FishingStore = 9,
	Interact = 7,
	Process = 2,
	Trade = 5,
	Decoration = 0,
	Rest = 4,
	Fishing = 8,
	Transport = 6
}
var_0_0.BuildingListViewResTabType = {
	All = 1,
	Play = 4,
	Adornment = 2,
	Produce = 3
}
var_0_0.BuildingTypeAreName = {
	[var_0_0.BuildingType.Collect] = "room_area_name_collect",
	[var_0_0.BuildingType.Process] = "room_area_name_process",
	[var_0_0.BuildingType.Manufacture] = "room_area_name_manufacture"
}
var_0_0.BuildingTypeSiteLangKey = {
	[var_0_0.BuildingType.Collect] = "room_building_sitename_collect",
	[var_0_0.BuildingType.Process] = "room_building_sitename_process",
	[var_0_0.BuildingType.Manufacture] = "room_building_sitename_manufacture"
}
var_0_0.BuildingTypeLineIcon = {
	[var_0_0.BuildingType.Collect] = "room_transport_icon_1",
	[var_0_0.BuildingType.Process] = "room_transport_icon_2",
	[var_0_0.BuildingType.Manufacture] = "room_transport_icon_3"
}
var_0_0.CanDateleBuildingType = {
	[var_0_0.BuildingType.Decoration] = true
}
var_0_0.CanClickTouchBuildingType = {
	[var_0_0.BuildingType.Collect] = true,
	[var_0_0.BuildingType.Process] = true,
	[var_0_0.BuildingType.Manufacture] = true,
	[var_0_0.BuildingType.Trade] = true,
	[var_0_0.BuildingType.Rest] = true,
	[var_0_0.BuildingType.Interact] = true
}
var_0_0.BuildingArea = {
	[var_0_0.BuildingType.Collect] = true,
	[var_0_0.BuildingType.Process] = true,
	[var_0_0.BuildingType.Manufacture] = true
}
var_0_0.BuildingMapUiIcon = {
	[var_0_0.BuildingType.Interact] = "critter_buildingicon_5"
}
var_0_0.FormulaBuildingType = {
	Gather = 1,
	ExpTree = 6,
	Machine = 2,
	Trade = 4,
	Change = 3
}
var_0_0.FormulaType = {
	Gather = 4,
	Trade = 3,
	Machine = 1,
	Change = 2
}
var_0_0.EffectType = {
	Reserve = 1,
	Slot = 3,
	Time = 2
}
var_0_0.FormulaOrderType = {
	OrderDown = 6,
	CostTimeUp = 3,
	OrderUp = 5,
	RareDown = 2,
	CostTimeDown = 4,
	RareUp = 1
}
var_0_0.FormulaMaxCountErrorCode = {
	TimeCountLimit = -3,
	HasQuantityLimit = -1,
	FitResourceLimit = -5,
	ReserveCountLimit = -4,
	AccelerateItemMaxCountLimit = -2
}
var_0_0.ConfirmPlaceBuildingErrorCode = {
	InTransportPath = -6,
	ResourceArea = -3,
	NoAreaMainBuilding = -4,
	Foundation = -1,
	OutSizeAreaBuilding = -5,
	ResourceId = -2
}
var_0_0.RareIcon = {
	"bg_jianzudi_2",
	"bg_jianzudi_3",
	"bg_jianzudi_4",
	"bg_jianzudi_5",
	"bg_jianzudi_6"
}
var_0_0.RareFrame = {
	"room_qualityframe_1",
	"room_qualityframe_2",
	"room_qualityframe_3",
	"room_qualityframe_4",
	"room_qualityframe_5"
}
var_0_0.MachineSlotMaxCount = 99
var_0_0.AccelerateItemMaxCount = 999
var_0_0.SpecialStrengthItemId = 190008
var_0_0.BuildingAreaRange = 2
var_0_0.Crossload = {
	[5009] = {
		AnimPath = "",
		AnimStatus = {
			{
				animName = "daqiao_a_close",
				audioId = 20009055,
				animTime = 2.1,
				resId = 6,
				replaceBlockRes = {
					{
						x = 0,
						y = 0,
						resPionts = {
							[0] = 6,
							nil,
							nil,
							6,
							nil,
							nil,
							6
						}
					},
					{
						x = 1,
						y = 0,
						resPionts = {
							[0] = 6,
							nil,
							nil,
							6,
							nil,
							nil,
							6
						}
					}
				}
			},
			{
				animName = "daqiao_a_open",
				audioId = 20009054,
				animTime = 2.1,
				resId = 4,
				replaceBlockRes = {
					{
						x = 0,
						y = 0,
						resPionts = {
							[0] = 0,
							nil,
							nil,
							4,
							nil,
							nil,
							0
						}
					},
					{
						x = 1,
						y = 0,
						resPionts = {
							[0] = 0,
							nil,
							nil,
							0,
							nil,
							nil,
							4
						}
					}
				}
			}
		}
	}
}
var_0_0.AudioExtendType = {
	AnimatorEvent = 2,
	Clock12Hour = 1
}
var_0_0.VehicleInitOffestY = 0.11
var_0_0.VehicleTypeOffestY = {
	var_0_0.VehicleInitOffestY
}
var_0_0.MaxBuildingOccupyNum = 7
var_0_0.NotPlaceBlockAnimDict = {
	[11311] = true
}
var_0_0.AnimName = {
	Open = "open",
	Takeoff = "takeoff",
	Close = "close",
	Produce = "produce",
	Landing = "landing",
	Idel = "idel"
}
var_0_0.TransportBuyTosatDic = {
	[22204] = 220910
}

return var_0_0
