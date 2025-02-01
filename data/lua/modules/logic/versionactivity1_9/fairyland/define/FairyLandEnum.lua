module("modules.logic.versionactivity1_9.fairyland.define.FairyLandEnum", package.seeall)

slot0 = _M
slot0.ElementId = 100701
slot0.StartCameraPosX = 228
slot0.StartCameraPosY = 199
slot0.ElementType = {
	Text = 999,
	NPC = 6,
	Character = 1,
	Rectangle = 5,
	Door = 7,
	Triangle = 4,
	Circle = 2,
	Square = 3
}
slot0.ConfigType2ElementType = {
	[0] = slot0.ElementType.Character,
	slot0.ElementType.Circle,
	slot0.ElementType.NPC,
	slot0.ElementType.Square,
	slot0.ElementType.NPC,
	slot0.ElementType.Triangle,
	slot0.ElementType.NPC,
	slot0.ElementType.Rectangle,
	slot0.ElementType.NPC,
	slot0.ElementType.Door
}
slot0.ShapeState = {
	Hide = 4,
	LockClick = 3,
	CanClick = 1,
	NextCanClick = 2
}
slot0.DialogType = {
	Bubble = 1,
	Option = 2
}
slot0.Puzzle2ShapeType = {
	1,
	2,
	3,
	[10.0] = 4
}

return slot0
