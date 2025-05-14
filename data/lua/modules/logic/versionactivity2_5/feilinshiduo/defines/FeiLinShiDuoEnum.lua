module("modules.logic.versionactivity2_5.feilinshiduo.defines.FeiLinShiDuoEnum", package.seeall)

local var_0_0 = _M

var_0_0.TestMapId = 101
var_0_0.GameSceneRootName = "FeiLinShiDuoGame"
var_0_0.ColorIconName = "colorIcon"
var_0_0.PlayerMoveSpeed = 250
var_0_0.PlayerPushBoxSpeed = 125
var_0_0.SceneMoveSpeed = 0.2
var_0_0.FallSpeed = 50
var_0_0.jumpAnimTime = 0.4
var_0_0.climbSpeed = 150
var_0_0.MinTimeDeltaTime = 0.04
var_0_0.SceneDefaultScale = 2
var_0_0.SlotWidth = 100
var_0_0.HalfSlotWidth = var_0_0.SlotWidth / 2
var_0_0.RoleResPath = "roles/v2a5_act185/act185_ui.prefab"
var_0_0.PlayerScale = 0.3
var_0_0.startMoveAddSpeed = 0.5
var_0_0.endMoveAddSpeed = 1
var_0_0.touchCheckRange = 4
var_0_0.touchElementRange = 20
var_0_0.doorTouchCheckRang = 15
var_0_0.stairsTouchCheckRange = 40
var_0_0.BlindnessModeKey = "FeiLinShiDuoBlindnessMode"
var_0_0.checkDir = {
	Top = 2,
	Right = 3,
	Left = 1,
	Bottom = 4
}
var_0_0.ObjectType = {
	Option = 6,
	ColorPlane = 2,
	Door = 7,
	Target = 10,
	Wall = 1,
	Trap = 4,
	Start = 9,
	Box = 3,
	Jump = 5,
	Stairs = 8
}
var_0_0.ColorType = {
	Blue = 3,
	Green = 2,
	Red = 1,
	Yellow = 4,
	None = 0
}
var_0_0.ColorStr = {
	[var_0_0.ColorType.None] = "#808080",
	[var_0_0.ColorType.Red] = "#995558",
	[var_0_0.ColorType.Green] = "#648E83",
	[var_0_0.ColorType.Blue] = "#5D6D97",
	[var_0_0.ColorType.Yellow] = "#8E8C64"
}
var_0_0.playerColor = UnityEngine.Shader.PropertyToID("_Color")
var_0_0.GroupName = {
	[var_0_0.ObjectType.Wall] = "Walls",
	[var_0_0.ObjectType.ColorPlane] = "ColorPlanes",
	[var_0_0.ObjectType.Box] = "Boxs",
	[var_0_0.ObjectType.Trap] = "Traps",
	[var_0_0.ObjectType.Jump] = "Jumps",
	[var_0_0.ObjectType.Option] = "Options",
	[var_0_0.ObjectType.Door] = "Doors",
	[var_0_0.ObjectType.Stairs] = "Stairs",
	[var_0_0.ObjectType.Start] = "Start",
	[var_0_0.ObjectType.Target] = "Target"
}
var_0_0.ParentName = {
	[var_0_0.ObjectType.Wall] = "wallItem",
	[var_0_0.ObjectType.ColorPlane] = "colorplaneItem",
	[var_0_0.ObjectType.Box] = "boxItem",
	[var_0_0.ObjectType.Trap] = "trapItem",
	[var_0_0.ObjectType.Jump] = "jumpItem",
	[var_0_0.ObjectType.Option] = "optionItem",
	[var_0_0.ObjectType.Door] = "doorItem",
	[var_0_0.ObjectType.Stairs] = "stairItem",
	[var_0_0.ObjectType.Start] = "startItem",
	[var_0_0.ObjectType.Target] = "targetItem"
}
var_0_0.ItemName = {
	[var_0_0.ObjectType.Wall] = "wall",
	[var_0_0.ObjectType.ColorPlane] = "colorplane",
	[var_0_0.ObjectType.Box] = "box",
	[var_0_0.ObjectType.Trap] = "trap",
	[var_0_0.ObjectType.Jump] = "jump",
	[var_0_0.ObjectType.Option] = "option",
	[var_0_0.ObjectType.Door] = "door",
	[var_0_0.ObjectType.Stairs] = "stair",
	[var_0_0.ObjectType.Start] = "start",
	[var_0_0.ObjectType.Target] = "target"
}
var_0_0.GuideDataList = {
	{
		mapId = 101,
		guideId = 25101,
		guideList = {
			{
				rangeX = 20,
				id = 1,
				posY = 200,
				rangeY = 10,
				posX = -253
			},
			{
				rangeX = 100,
				id = 2,
				posY = -400,
				rangeY = 10,
				posX = -200
			},
			{
				rangeX = 90,
				id = 3,
				posY = -400,
				rangeY = 10,
				posX = 612
			}
		}
	},
	{
		mapId = 103,
		guideId = 25102,
		guideList = {
			{
				rangeX = 150,
				id = 4,
				posY = -500,
				rangeY = 10,
				posX = -380
			}
		}
	},
	{
		mapId = 105,
		guideId = 25103,
		guideList = {
			{
				rangeX = 100,
				id = 5,
				posY = -500,
				rangeY = 10,
				posX = 530
			}
		}
	}
}

return var_0_0
