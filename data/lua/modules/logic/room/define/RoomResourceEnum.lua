module("modules.logic.room.define.RoomResourceEnum", package.seeall)

local var_0_0 = _M

var_0_0.ResourceId = {
	River = 4,
	None = 0,
	Building = 2,
	Road12 = 12,
	Flag = 5,
	Coast = 8,
	Railway = 9,
	Road10 = 10,
	Muddyway = 7,
	Road = 6,
	AirVehicle = 11,
	Plant = 1,
	Sculpture = 3,
	Empty = -1
}
var_0_0.ResourceRoadList = {
	var_0_0.ResourceId.Road,
	var_0_0.ResourceId.Muddyway,
	var_0_0.ResourceId.Coast,
	var_0_0.ResourceId.Railway,
	var_0_0.ResourceId.Road10,
	var_0_0.ResourceId.AirVehicle,
	var_0_0.ResourceId.Road12
}
var_0_0.ResourceIdCount = 4
var_0_0.ResourceLinkGOPath = {
	[var_0_0.ResourceId.Flag] = {
		"connect/001",
		nil,
		"connect/003",
		nil,
		"connect/005"
	}
}
var_0_0.ResourceList = {
	var_0_0.ResourceId.None,
	var_0_0.ResourceId.Plant,
	var_0_0.ResourceId.Building,
	var_0_0.ResourceId.Sculpture,
	var_0_0.ResourceId.River,
	var_0_0.ResourceId.Flag,
	var_0_0.ResourceId.Road,
	var_0_0.ResourceId.Muddyway,
	var_0_0.ResourceId.Coast,
	var_0_0.ResourceId.Railway
}
var_0_0.ResourceRes = {
	[var_0_0.ResourceId.Plant] = "plant",
	[var_0_0.ResourceId.Building] = "stone",
	[var_0_0.ResourceId.Sculpture] = "diaosu",
	[var_0_0.ResourceId.River] = "heliu"
}
var_0_0.ResourceBigIcon = {
	[var_0_0.ResourceId.None] = "fanzhi_icon_qingyuanda",
	[var_0_0.ResourceId.Plant] = "fanzhi_icon_zhibeida",
	[var_0_0.ResourceId.Building] = "fanzhi_icon_feixuda",
	[var_0_0.ResourceId.Sculpture] = "fanzhi_icon_yijida",
	[var_0_0.ResourceId.River] = "fanzhi_icon_shuiyuda"
}
var_0_0.ResourceColor = {
	[var_0_0.ResourceId.None] = "#FFFFFF",
	[var_0_0.ResourceId.Plant] = "#65C479",
	[var_0_0.ResourceId.Building] = "#A686AC",
	[var_0_0.ResourceId.Sculpture] = "#D9C882",
	[var_0_0.ResourceId.River] = "#6182C5"
}
var_0_0.ResourceAudioId = {
	[var_0_0.ResourceId.Empty] = AudioEnum.None,
	[var_0_0.ResourceId.None] = AudioEnum.None,
	[var_0_0.ResourceId.Plant] = AudioEnum.Room.play_amb_home_forest,
	[var_0_0.ResourceId.Building] = AudioEnum.Room.play_amb_home_ruins,
	[var_0_0.ResourceId.Sculpture] = AudioEnum.Room.play_amb_home_sculpture,
	[var_0_0.ResourceId.River] = AudioEnum.Room.play_amb_home_river
}
var_0_0.ResourceAudioPriority = {
	[var_0_0.ResourceId.Empty] = 0,
	[var_0_0.ResourceId.None] = 0,
	[var_0_0.ResourceId.Building] = 1,
	[var_0_0.ResourceId.Sculpture] = 2,
	[var_0_0.ResourceId.Plant] = 3,
	[var_0_0.ResourceId.River] = 4
}
var_0_0.PPVolume = {
	High = "ppassets/profiles/room_profile_high.asset",
	Middle = "ppassets/profiles/room_profile_middle.asset",
	Low = "ppassets/profiles/room_profile_low.asset"
}

for iter_0_0, iter_0_1 in pairs(var_0_0.ResourceId) do
	if iter_0_1 ~= var_0_0.ResourceId.Empty then
		if not var_0_0.ResourceColor[iter_0_1] then
			var_0_0.ResourceColor[iter_0_1] = "#FFFFFF"
		end

		if not var_0_0.ResourceAudioId[iter_0_1] then
			var_0_0.ResourceAudioId[iter_0_1] = AudioEnum.None
		end

		if not var_0_0.ResourceAudioPriority[iter_0_1] then
			var_0_0.ResourceAudioPriority[iter_0_1] = 0
		end

		if not tabletool.indexOf(var_0_0.ResourceList, iter_0_1) then
			table.insert(var_0_0.ResourceList, iter_0_1)
		end
	end
end

var_0_0.Block = {
	NoneList = {
		var_0_0.ResourceId.None
	},
	RiverList = {
		var_0_0.ResourceId.River
	}
}

for iter_0_2, iter_0_3 in pairs(var_0_0.Block) do
	for iter_0_4 = #iter_0_3 + 1, 6 do
		table.insert(iter_0_3, iter_0_3[1] or var_0_0.ResourceId.None)
	end
end

var_0_0.EmptyDefineId = 1
var_0_0.EmptyPrefabPath = "undefined/empty.prefab"

return var_0_0
