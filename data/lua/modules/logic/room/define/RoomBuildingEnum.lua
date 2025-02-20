module("modules.logic.room.define.RoomBuildingEnum", package.seeall)

slot0 = _M
slot0.BuildingState = {
	Revert = 4,
	Inventory = 3,
	Temp = 2,
	Map = 1
}
slot0.BuildingType = {
	Manufacture = 3,
	Collect = 1,
	Decoration = 0,
	Rest = 4,
	Interact = 7,
	Process = 2,
	Trade = 5,
	Transport = 6
}
slot0.BuildingListViewResTabType = {
	All = 1,
	Play = 4,
	Adornment = 2,
	Produce = 3
}
slot0.BuildingTypeAreName = {
	[slot0.BuildingType.Collect] = "room_area_name_collect",
	[slot0.BuildingType.Process] = "room_area_name_process",
	[slot0.BuildingType.Manufacture] = "room_area_name_manufacture"
}
slot0.BuildingTypeSiteLangKey = {
	[slot0.BuildingType.Collect] = "room_building_sitename_collect",
	[slot0.BuildingType.Process] = "room_building_sitename_process",
	[slot0.BuildingType.Manufacture] = "room_building_sitename_manufacture"
}
slot0.BuildingTypeLineIcon = {
	[slot0.BuildingType.Collect] = "room_transport_icon_1",
	[slot0.BuildingType.Process] = "room_transport_icon_2",
	[slot0.BuildingType.Manufacture] = "room_transport_icon_3"
}
slot0.CanDateleBuildingType = {
	[slot0.BuildingType.Decoration] = true
}
slot0.CanClickTouchBuildingType = {
	[slot0.BuildingType.Collect] = true,
	[slot0.BuildingType.Process] = true,
	[slot0.BuildingType.Manufacture] = true,
	[slot0.BuildingType.Trade] = true,
	[slot0.BuildingType.Rest] = true,
	[slot0.BuildingType.Interact] = true
}
slot0.BuildingArea = {
	[slot0.BuildingType.Collect] = true,
	[slot0.BuildingType.Process] = true,
	[slot0.BuildingType.Manufacture] = true
}
slot0.BuildingMapUiIcon = {
	[slot0.BuildingType.Interact] = "critter_buildingicon_5"
}
slot0.FormulaBuildingType = {
	Gather = 1,
	ExpTree = 6,
	Machine = 2,
	Trade = 4,
	Change = 3
}
slot0.FormulaType = {
	Gather = 4,
	Trade = 3,
	Machine = 1,
	Change = 2
}
slot0.EffectType = {
	Reserve = 1,
	Slot = 3,
	Time = 2
}
slot0.FormulaOrderType = {
	OrderDown = 6,
	CostTimeUp = 3,
	OrderUp = 5,
	RareDown = 2,
	CostTimeDown = 4,
	RareUp = 1
}
slot0.FormulaMaxCountErrorCode = {
	TimeCountLimit = -3,
	HasQuantityLimit = -1,
	FitResourceLimit = -5,
	ReserveCountLimit = -4,
	AccelerateItemMaxCountLimit = -2
}
slot0.ConfirmPlaceBuildingErrorCode = {
	InTransportPath = -6,
	ResourceArea = -3,
	NoAreaMainBuilding = -4,
	Foundation = -1,
	OutSizeAreaBuilding = -5,
	ResourceId = -2
}
slot0.RareIcon = {
	"bg_jianzudi_2",
	"bg_jianzudi_3",
	"bg_jianzudi_4",
	"bg_jianzudi_5",
	"bg_jianzudi_6"
}
slot0.RareFrame = {
	"room_qualityframe_1",
	"room_qualityframe_2",
	"room_qualityframe_3",
	"room_qualityframe_4",
	"room_qualityframe_5"
}
slot0.MachineSlotMaxCount = 99
slot0.AccelerateItemMaxCount = 999
slot0.SpecialStrengthItemId = 190008
slot0.BuildingAreaRange = 2
slot0.Crossload = {
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
slot0.AudioExtendType = {
	AnimatorEvent = 2,
	Clock12Hour = 1
}
slot0.VehicleInitOffestY = 0.11
slot0.VehicleTypeOffestY = {
	slot0.VehicleInitOffestY
}
slot0.MaxBuildingOccupyNum = 7
slot0.NotPlaceBlockAnimDict = {
	[11311.0] = true
}
slot0.AnimName = {
	Open = "open",
	Takeoff = "takeoff",
	Close = "close",
	Produce = "produce",
	Landing = "landing",
	Idel = "idel"
}
slot0.TransportBuyTosatDic = {
	[22204.0] = 220910
}

return slot0
