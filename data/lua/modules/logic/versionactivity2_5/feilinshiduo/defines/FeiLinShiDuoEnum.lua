module("modules.logic.versionactivity2_5.feilinshiduo.defines.FeiLinShiDuoEnum", package.seeall)

slot0 = _M
slot0.TestMapId = 101
slot0.GameSceneRootName = "FeiLinShiDuoGame"
slot0.ColorIconName = "colorIcon"
slot0.PlayerMoveSpeed = 250
slot0.PlayerPushBoxSpeed = 125
slot0.SceneMoveSpeed = 0.2
slot0.FallSpeed = 50
slot0.jumpAnimTime = 0.4
slot0.climbSpeed = 150
slot0.MinTimeDeltaTime = 0.04
slot0.SceneDefaultScale = 2
slot0.SlotWidth = 100
slot0.HalfSlotWidth = slot0.SlotWidth / 2
slot0.RoleResPath = "roles/v2a5_act185/act185_ui.prefab"
slot0.PlayerScale = 0.3
slot0.startMoveAddSpeed = 0.5
slot0.endMoveAddSpeed = 1
slot0.touchCheckRange = 4
slot0.touchElementRange = 20
slot0.doorTouchCheckRang = 15
slot0.stairsTouchCheckRange = 40
slot0.BlindnessModeKey = "FeiLinShiDuoBlindnessMode"
slot0.checkDir = {
	Top = 2,
	Right = 3,
	Left = 1,
	Bottom = 4
}
slot0.ObjectType = {
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
slot0.ColorType = {
	Blue = 3,
	Green = 2,
	Red = 1,
	Yellow = 4,
	None = 0
}
slot0.ColorStr = {
	[slot0.ColorType.None] = "#808080",
	[slot0.ColorType.Red] = "#995558",
	[slot0.ColorType.Green] = "#648E83",
	[slot0.ColorType.Blue] = "#5D6D97",
	[slot0.ColorType.Yellow] = "#8E8C64"
}
slot0.playerColor = UnityEngine.Shader.PropertyToID("_Color")
slot0.GroupName = {
	[slot0.ObjectType.Wall] = "Walls",
	[slot0.ObjectType.ColorPlane] = "ColorPlanes",
	[slot0.ObjectType.Box] = "Boxs",
	[slot0.ObjectType.Trap] = "Traps",
	[slot0.ObjectType.Jump] = "Jumps",
	[slot0.ObjectType.Option] = "Options",
	[slot0.ObjectType.Door] = "Doors",
	[slot0.ObjectType.Stairs] = "Stairs",
	[slot0.ObjectType.Start] = "Start",
	[slot0.ObjectType.Target] = "Target"
}
slot0.ParentName = {
	[slot0.ObjectType.Wall] = "wallItem",
	[slot0.ObjectType.ColorPlane] = "colorplaneItem",
	[slot0.ObjectType.Box] = "boxItem",
	[slot0.ObjectType.Trap] = "trapItem",
	[slot0.ObjectType.Jump] = "jumpItem",
	[slot0.ObjectType.Option] = "optionItem",
	[slot0.ObjectType.Door] = "doorItem",
	[slot0.ObjectType.Stairs] = "stairItem",
	[slot0.ObjectType.Start] = "startItem",
	[slot0.ObjectType.Target] = "targetItem"
}
slot0.ItemName = {
	[slot0.ObjectType.Wall] = "wall",
	[slot0.ObjectType.ColorPlane] = "colorplane",
	[slot0.ObjectType.Box] = "box",
	[slot0.ObjectType.Trap] = "trap",
	[slot0.ObjectType.Jump] = "jump",
	[slot0.ObjectType.Option] = "option",
	[slot0.ObjectType.Door] = "door",
	[slot0.ObjectType.Stairs] = "stair",
	[slot0.ObjectType.Start] = "start",
	[slot0.ObjectType.Target] = "target"
}
slot0.GuideDataList = {
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

return slot0
