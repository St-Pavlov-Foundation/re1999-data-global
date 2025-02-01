module("modules.logic.room.define.RoomResourceEnum", package.seeall)

slot0 = _M
slot0.ResourceId = {
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
slot0.ResourceRoadList = {
	slot0.ResourceId.Road,
	slot0.ResourceId.Muddyway,
	slot0.ResourceId.Coast,
	slot0.ResourceId.Railway,
	slot0.ResourceId.Road10,
	slot0.ResourceId.AirVehicle,
	slot0.ResourceId.Road12
}
slot0.ResourceIdCount = 4
slot0.ResourceLinkGOPath = {
	[slot0.ResourceId.Flag] = {
		"connect/001",
		nil,
		"connect/003",
		nil,
		"connect/005"
	}
}
slot0.ResourceList = {
	slot0.ResourceId.None,
	slot0.ResourceId.Plant,
	slot0.ResourceId.Building,
	slot0.ResourceId.Sculpture,
	slot0.ResourceId.River,
	slot0.ResourceId.Flag,
	slot0.ResourceId.Road,
	slot0.ResourceId.Muddyway,
	slot0.ResourceId.Coast,
	slot0.ResourceId.Railway
}
slot0.ResourceRes = {
	[slot0.ResourceId.Plant] = "plant",
	[slot0.ResourceId.Building] = "stone",
	[slot0.ResourceId.Sculpture] = "diaosu",
	[slot0.ResourceId.River] = "heliu"
}
slot0.ResourceBigIcon = {
	[slot0.ResourceId.None] = "fanzhi_icon_qingyuanda",
	[slot0.ResourceId.Plant] = "fanzhi_icon_zhibeida",
	[slot0.ResourceId.Building] = "fanzhi_icon_feixuda",
	[slot0.ResourceId.Sculpture] = "fanzhi_icon_yijida",
	[slot0.ResourceId.River] = "fanzhi_icon_shuiyuda"
}
slot0.ResourceColor = {
	[slot0.ResourceId.None] = "#FFFFFF",
	[slot0.ResourceId.Plant] = "#65C479",
	[slot0.ResourceId.Building] = "#A686AC",
	[slot0.ResourceId.Sculpture] = "#D9C882",
	[slot0.ResourceId.River] = "#6182C5"
}
slot0.ResourceAudioId = {
	[slot0.ResourceId.Empty] = AudioEnum.None,
	[slot0.ResourceId.None] = AudioEnum.None,
	[slot0.ResourceId.Plant] = AudioEnum.Room.play_amb_home_forest,
	[slot0.ResourceId.Building] = AudioEnum.Room.play_amb_home_ruins,
	[slot0.ResourceId.Sculpture] = AudioEnum.Room.play_amb_home_sculpture,
	[slot0.ResourceId.River] = AudioEnum.Room.play_amb_home_river
}
slot0.ResourceAudioPriority = {
	[slot0.ResourceId.Empty] = 0,
	[slot0.ResourceId.None] = 0,
	[slot0.ResourceId.Building] = 1,
	[slot0.ResourceId.Sculpture] = 2,
	[slot0.ResourceId.Plant] = 3,
	[slot0.ResourceId.River] = 4
}

for slot4, slot5 in pairs(slot0.ResourceId) do
	if slot5 ~= slot0.ResourceId.Empty then
		if not slot0.ResourceColor[slot5] then
			slot0.ResourceColor[slot5] = "#FFFFFF"
		end

		if not slot0.ResourceAudioId[slot5] then
			slot0.ResourceAudioId[slot5] = AudioEnum.None
		end

		if not slot0.ResourceAudioPriority[slot5] then
			slot0.ResourceAudioPriority[slot5] = 0
		end

		if not tabletool.indexOf(slot0.ResourceList, slot5) then
			table.insert(slot0.ResourceList, slot5)
		end
	end
end

slot0.Block = {
	NoneList = {
		slot0.ResourceId.None
	},
	RiverList = {
		slot0.ResourceId.River
	}
}

for slot4, slot5 in pairs(slot0.Block) do
	for slot9 = #slot5 + 1, 6 do
		table.insert(slot5, slot5[1] or slot0.ResourceId.None)
	end
end

slot0.EmptyDefineId = 1
slot0.EmptyPrefabPath = "undefined/empty.prefab"

return slot0
