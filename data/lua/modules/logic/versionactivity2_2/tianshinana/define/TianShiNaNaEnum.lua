module("modules.logic.versionactivity2_2.tianshinana.define.TianShiNaNaEnum", package.seeall)

slot0 = _M
slot0.Dir = {
	Down = -1,
	Up = 1,
	Right = -2,
	Forward = 3,
	Back = -3,
	Left = 2
}
slot0.OperDir = {
	Left = 1,
	Back = -2,
	Right = -1,
	Forward = 2
}
slot0.ResDirPath = {
	[slot0.OperDir.Left] = "size/dir_4",
	[slot0.OperDir.Right] = "size/dir_6",
	[slot0.OperDir.Forward] = "size/dir_8",
	[slot0.OperDir.Back] = "size/dir_2"
}
slot0.UnitType = {
	Born = 2,
	Obstacle = 5,
	Player = 1,
	NPC = 3,
	Destination = 6,
	Hunter = 4
}
slot0.TianShiNaNaDieReason = {
	Collapse = 1,
	NoCube = 2,
	CantPlace = 3,
	InFog = 5,
	BeHunter = 4
}
slot0.UnitTypeToName = {}

for slot4, slot5 in pairs(slot0.UnitType) do
	slot0.UnitTypeToName[slot5] = slot4
end

slot0.NodeType = {
	Fog = 2,
	Swamp = 3,
	Normal = 1
}
slot0.GridXOffset = 1.0593750000000002
slot0.GridYOffset = 0.6900000000000001
slot0.GridZOffset = 0.005
slot0.OperDragBegin = 10
slot0.OperDragVaild = 0.45
slot0.OperDragMax = 100
slot0.EffectType = {
	Dialog = 4,
	Story = 1,
	Hide = 3,
	Guide = 2,
	Die = 6,
	Win = 5
}
slot0.CurState = {
	SelectDir = 1,
	DoStep = 3,
	Rotate = 2,
	None = 0
}
slot0.CubeType = {
	Type1 = 1,
	Type2 = 2
}
slot0.EpisodeType = {
	Hard = 3,
	Story = 1,
	Normal = 2
}
slot0.StepType = {
	Win = 6,
	Story = 4,
	Guide = 5,
	Die = 7,
	UpdateRound = 1,
	Hide = 3,
	Dialog = 9,
	DialogAndMove = 8,
	Move = 2
}
slot0.StepTypeToName = {}

for slot4, slot5 in pairs(slot0.StepType) do
	slot0.StepTypeToName[slot5] = slot4
end

slot0.OperEffect = {
	[slot0.OperDir.Left] = {
		[slot0.Dir.Left] = slot0.Dir.Down,
		[slot0.Dir.Right] = slot0.Dir.Up,
		[slot0.Dir.Up] = slot0.Dir.Left,
		[slot0.Dir.Down] = slot0.Dir.Right
	},
	[slot0.OperDir.Right] = {
		[slot0.Dir.Left] = slot0.Dir.Up,
		[slot0.Dir.Right] = slot0.Dir.Down,
		[slot0.Dir.Up] = slot0.Dir.Right,
		[slot0.Dir.Down] = slot0.Dir.Left
	},
	[slot0.OperDir.Forward] = {
		[slot0.Dir.Forward] = slot0.Dir.Down,
		[slot0.Dir.Back] = slot0.Dir.Up,
		[slot0.Dir.Up] = slot0.Dir.Forward,
		[slot0.Dir.Down] = slot0.Dir.Back
	},
	[slot0.OperDir.Back] = {
		[slot0.Dir.Forward] = slot0.Dir.Up,
		[slot0.Dir.Back] = slot0.Dir.Down,
		[slot0.Dir.Up] = slot0.Dir.Back,
		[slot0.Dir.Down] = slot0.Dir.Forward
	}
}
slot0.DirToQuaternion = {
	[slot0.Dir.Up] = {
		[slot0.Dir.Back] = Quaternion.Euler(0, 0, 0),
		[slot0.Dir.Left] = Quaternion.Euler(0, 90, 0),
		[slot0.Dir.Right] = Quaternion.Euler(0, -90, 0),
		[slot0.Dir.Forward] = Quaternion.Euler(0, 180, 0)
	},
	[slot0.Dir.Down] = {
		[slot0.Dir.Back] = Quaternion.Euler(-180, 180, 0),
		[slot0.Dir.Left] = Quaternion.Euler(-180, -90, 0),
		[slot0.Dir.Right] = Quaternion.Euler(-180, 90, 0),
		[slot0.Dir.Forward] = Quaternion.Euler(-180, 0, 0)
	},
	[slot0.Dir.Left] = {
		[slot0.Dir.Back] = Quaternion.Euler(0, 0, 90),
		[slot0.Dir.Up] = Quaternion.Euler(90, 0, 90),
		[slot0.Dir.Down] = Quaternion.Euler(270, 0, 90),
		[slot0.Dir.Forward] = Quaternion.Euler(180, 0, 90)
	},
	[slot0.Dir.Right] = {
		[slot0.Dir.Back] = Quaternion.Euler(0, 0, -90),
		[slot0.Dir.Up] = Quaternion.Euler(90, 0, -90),
		[slot0.Dir.Down] = Quaternion.Euler(270, 0, -90),
		[slot0.Dir.Forward] = Quaternion.Euler(180, 0, -90)
	},
	[slot0.Dir.Forward] = {
		[slot0.Dir.Up] = Quaternion.Euler(90, 90, 90),
		[slot0.Dir.Left] = Quaternion.Euler(0, 90, 90),
		[slot0.Dir.Right] = Quaternion.Euler(180, 90, 90),
		[slot0.Dir.Down] = Quaternion.Euler(-90, 90, 90)
	},
	[slot0.Dir.Back] = {
		[slot0.Dir.Up] = Quaternion.Euler(-270, -90, 90),
		[slot0.Dir.Left] = Quaternion.Euler(-180, -90, 90),
		[slot0.Dir.Right] = Quaternion.Euler(0, -90, 90),
		[slot0.Dir.Down] = Quaternion.Euler(-90, -90, 90)
	}
}

return slot0
