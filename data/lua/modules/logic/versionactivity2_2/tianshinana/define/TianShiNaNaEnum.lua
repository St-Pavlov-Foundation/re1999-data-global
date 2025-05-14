module("modules.logic.versionactivity2_2.tianshinana.define.TianShiNaNaEnum", package.seeall)

local var_0_0 = _M

var_0_0.Dir = {
	Down = -1,
	Up = 1,
	Right = -2,
	Forward = 3,
	Back = -3,
	Left = 2
}
var_0_0.OperDir = {
	Left = 1,
	Back = -2,
	Right = -1,
	Forward = 2
}
var_0_0.ResDirPath = {
	[var_0_0.OperDir.Left] = "size/dir_4",
	[var_0_0.OperDir.Right] = "size/dir_6",
	[var_0_0.OperDir.Forward] = "size/dir_8",
	[var_0_0.OperDir.Back] = "size/dir_2"
}
var_0_0.UnitType = {
	Born = 2,
	Obstacle = 5,
	Player = 1,
	NPC = 3,
	Destination = 6,
	Hunter = 4
}
var_0_0.TianShiNaNaDieReason = {
	Collapse = 1,
	NoCube = 2,
	CantPlace = 3,
	InFog = 5,
	BeHunter = 4
}
var_0_0.UnitTypeToName = {}

for iter_0_0, iter_0_1 in pairs(var_0_0.UnitType) do
	var_0_0.UnitTypeToName[iter_0_1] = iter_0_0
end

var_0_0.NodeType = {
	Fog = 2,
	Swamp = 3,
	Normal = 1
}
var_0_0.GridXOffset = 1.0593750000000002
var_0_0.GridYOffset = 0.6900000000000001
var_0_0.GridZOffset = 0.005
var_0_0.OperDragBegin = 10
var_0_0.OperDragVaild = 0.45
var_0_0.OperDragMax = 100
var_0_0.EffectType = {
	Dialog = 4,
	Story = 1,
	Hide = 3,
	Guide = 2,
	Die = 6,
	Win = 5
}
var_0_0.CurState = {
	SelectDir = 1,
	DoStep = 3,
	Rotate = 2,
	None = 0
}
var_0_0.CubeType = {
	Type1 = 1,
	Type2 = 2
}
var_0_0.EpisodeType = {
	Hard = 3,
	Story = 1,
	Normal = 2
}
var_0_0.StepType = {
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
var_0_0.StepTypeToName = {}

for iter_0_2, iter_0_3 in pairs(var_0_0.StepType) do
	var_0_0.StepTypeToName[iter_0_3] = iter_0_2
end

var_0_0.OperEffect = {
	[var_0_0.OperDir.Left] = {
		[var_0_0.Dir.Left] = var_0_0.Dir.Down,
		[var_0_0.Dir.Right] = var_0_0.Dir.Up,
		[var_0_0.Dir.Up] = var_0_0.Dir.Left,
		[var_0_0.Dir.Down] = var_0_0.Dir.Right
	},
	[var_0_0.OperDir.Right] = {
		[var_0_0.Dir.Left] = var_0_0.Dir.Up,
		[var_0_0.Dir.Right] = var_0_0.Dir.Down,
		[var_0_0.Dir.Up] = var_0_0.Dir.Right,
		[var_0_0.Dir.Down] = var_0_0.Dir.Left
	},
	[var_0_0.OperDir.Forward] = {
		[var_0_0.Dir.Forward] = var_0_0.Dir.Down,
		[var_0_0.Dir.Back] = var_0_0.Dir.Up,
		[var_0_0.Dir.Up] = var_0_0.Dir.Forward,
		[var_0_0.Dir.Down] = var_0_0.Dir.Back
	},
	[var_0_0.OperDir.Back] = {
		[var_0_0.Dir.Forward] = var_0_0.Dir.Up,
		[var_0_0.Dir.Back] = var_0_0.Dir.Down,
		[var_0_0.Dir.Up] = var_0_0.Dir.Back,
		[var_0_0.Dir.Down] = var_0_0.Dir.Forward
	}
}
var_0_0.DirToQuaternion = {
	[var_0_0.Dir.Up] = {
		[var_0_0.Dir.Back] = Quaternion.Euler(0, 0, 0),
		[var_0_0.Dir.Left] = Quaternion.Euler(0, 90, 0),
		[var_0_0.Dir.Right] = Quaternion.Euler(0, -90, 0),
		[var_0_0.Dir.Forward] = Quaternion.Euler(0, 180, 0)
	},
	[var_0_0.Dir.Down] = {
		[var_0_0.Dir.Back] = Quaternion.Euler(-180, 180, 0),
		[var_0_0.Dir.Left] = Quaternion.Euler(-180, -90, 0),
		[var_0_0.Dir.Right] = Quaternion.Euler(-180, 90, 0),
		[var_0_0.Dir.Forward] = Quaternion.Euler(-180, 0, 0)
	},
	[var_0_0.Dir.Left] = {
		[var_0_0.Dir.Back] = Quaternion.Euler(0, 0, 90),
		[var_0_0.Dir.Up] = Quaternion.Euler(90, 0, 90),
		[var_0_0.Dir.Down] = Quaternion.Euler(270, 0, 90),
		[var_0_0.Dir.Forward] = Quaternion.Euler(180, 0, 90)
	},
	[var_0_0.Dir.Right] = {
		[var_0_0.Dir.Back] = Quaternion.Euler(0, 0, -90),
		[var_0_0.Dir.Up] = Quaternion.Euler(90, 0, -90),
		[var_0_0.Dir.Down] = Quaternion.Euler(270, 0, -90),
		[var_0_0.Dir.Forward] = Quaternion.Euler(180, 0, -90)
	},
	[var_0_0.Dir.Forward] = {
		[var_0_0.Dir.Up] = Quaternion.Euler(90, 90, 90),
		[var_0_0.Dir.Left] = Quaternion.Euler(0, 90, 90),
		[var_0_0.Dir.Right] = Quaternion.Euler(180, 90, 90),
		[var_0_0.Dir.Down] = Quaternion.Euler(-90, 90, 90)
	},
	[var_0_0.Dir.Back] = {
		[var_0_0.Dir.Up] = Quaternion.Euler(-270, -90, 90),
		[var_0_0.Dir.Left] = Quaternion.Euler(-180, -90, 90),
		[var_0_0.Dir.Right] = Quaternion.Euler(0, -90, 90),
		[var_0_0.Dir.Down] = Quaternion.Euler(-90, -90, 90)
	}
}

return var_0_0
