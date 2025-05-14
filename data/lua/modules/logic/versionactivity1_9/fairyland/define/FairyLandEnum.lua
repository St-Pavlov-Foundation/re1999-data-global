module("modules.logic.versionactivity1_9.fairyland.define.FairyLandEnum", package.seeall)

local var_0_0 = _M

var_0_0.ElementId = 100701
var_0_0.StartCameraPosX = 228
var_0_0.StartCameraPosY = 199
var_0_0.ElementType = {
	Text = 999,
	NPC = 6,
	Character = 1,
	Rectangle = 5,
	Door = 7,
	Triangle = 4,
	Circle = 2,
	Square = 3
}
var_0_0.ConfigType2ElementType = {
	[0] = var_0_0.ElementType.Character,
	var_0_0.ElementType.Circle,
	var_0_0.ElementType.NPC,
	var_0_0.ElementType.Square,
	var_0_0.ElementType.NPC,
	var_0_0.ElementType.Triangle,
	var_0_0.ElementType.NPC,
	var_0_0.ElementType.Rectangle,
	var_0_0.ElementType.NPC,
	var_0_0.ElementType.Door
}
var_0_0.ShapeState = {
	Hide = 4,
	LockClick = 3,
	CanClick = 1,
	NextCanClick = 2
}
var_0_0.DialogType = {
	Bubble = 1,
	Option = 2
}
var_0_0.Puzzle2ShapeType = {
	1,
	2,
	3,
	[10] = 4
}

return var_0_0
