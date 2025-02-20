module("modules.logic.explore.controller.ExploreEnum", package.seeall)

slot0 = _M
slot0.RoleMoveDir = {
	None = false,
	Up = Vector2.New(0, 1),
	Down = Vector2.New(0, -1),
	Left = Vector2.New(-1, 0),
	Right = Vector2.New(1, 0)
}
slot0.RoleMoveRotateDirIndex = {
	[slot0.RoleMoveDir.Up] = 0,
	[slot0.RoleMoveDir.Right] = 1,
	[slot0.RoleMoveDir.Down] = 2,
	[slot0.RoleMoveDir.Left] = 3
}
slot4 = -1
slot5 = 0
slot0.RoleMoveRotateDir = {
	[0] = Vector2.New(0, 1),
	Vector2.New(1, 0),
	Vector2.New(0, -1),
	Vector2.New(slot4, slot5)
}
slot0.ItemType = {
	PipePot = 224,
	Magic = 101,
	Currency = 221,
	StoneTable = 217,
	Illuminant = 215,
	Step = 210,
	Bonus = 1,
	PipeEntrance = 222,
	Battle = 3,
	PipeMemory = 226,
	Obstacle = 207,
	DoorOnce = 227,
	Archive = 228,
	BonusScene = 229,
	BagItemReward = 232,
	Ice = 206,
	Pipe = 223,
	Story = 5,
	PipeSensor = 225,
	Reset = 235,
	SceneAudio = 234,
	SequenceCount = 233,
	General = 6,
	Respawn = 7,
	Rune = 212,
	Door = 202,
	Rock = 209,
	LightBall = 216,
	Born = 0,
	Prism = 218,
	Exit = 214,
	LightReceiver = 220,
	Gate = 4,
	Teleport = 213,
	Disjunctor = 236,
	SavePoint = 231,
	GravityGear = 205,
	Spike = 201,
	Buff = 2,
	DichroicPrism = 219,
	Dialogue = 230,
	StepOnce = 211,
	Elevator = 208
}
slot0.ItemTypeToName = {}

for slot4, slot5 in pairs(slot0.ItemType) do
	slot0.ItemTypeToName[slot5] = slot4
end

slot0.WhirlType = {
	Rune = 1
}
slot0.RuneTriggerType = {
	ItemActive = 1,
	RuneActive = 2,
	None = 0
}
slot0.BackPackItemType = {
	Rune = 2,
	Normal = 1
}
slot0.TriggerDir = {
	Down = 4,
	Up = 3,
	Right = 2,
	Left = 1
}
slot0.TriggerEvent = {
	CatchUnit = 30,
	MiniGame = 17,
	ChangeInteractActive = 21,
	StoneTable = 26,
	SetInteractDisabled = 2,
	DoorOpen = -1,
	ChangeCamera = 18,
	Award = 15,
	Disappear = 1,
	OpenArchiveView = -3,
	HeroPlayAnim = 35,
	MoveCamera = 10,
	SwitchActive = 37,
	ShowUnitGroup = 39,
	TriggerUnit = 14,
	Story = 16,
	Guide = 20,
	ChangeElevator = 19,
	Reset = 38,
	Battle = 0,
	GetExploreCurrency = 29,
	Rune = 23,
	Rotate = 27,
	SetInteractEnabled = 3,
	Audio = 33,
	Exit = 25,
	ChangeIcon = 40,
	ItemUnit = -2,
	Teleport = 24,
	ExplorePipeEntrance = 32,
	MarkFinish = 36,
	Spike = 28,
	Counter = 22,
	Buff = 9,
	Dialogue = 31,
	BubbleDialogue = 34
}
slot0.ServerTriggerType = {
	[slot0.ItemType.Door] = 1,
	[slot0.ItemType.Step] = 1,
	[slot0.ItemType.StepOnce] = 1,
	[slot0.ItemType.Currency] = 1,
	[slot0.ItemType.GravityGear] = 1,
	[slot0.ItemType.Ice] = 1,
	[slot0.ItemType.Obstacle] = 1,
	[slot0.ItemType.Elevator] = 1,
	[slot0.ItemType.LightReceiver] = 1,
	[slot0.ItemType.Rock] = 1,
	[slot0.ItemType.LightBall] = 1,
	[slot0.ItemType.BonusScene] = 1
}
slot0.ItemEffect = {
	CreateUnit2 = "3",
	CreateUnit = "1",
	Fix = "4",
	Active = "2"
}
slot0.ItemEffectRange = {
	Round = 1
}
slot0.EnterMode = {
	Normal = 2,
	Battle = 3,
	First = 1
}
slot0.ProgressType = {
	[slot0.ItemType.Battle] = true,
	[slot0.ItemType.Bonus] = true
}
slot0.InteractIndex = {
	InteractEnabled = 2,
	IsFinish = 4,
	ActiveState = 3,
	IsEnter = 1
}
slot0.LightRecvType = {
	Photic = 2,
	Barricade = 1,
	Custom = 3
}
slot0.RuneStatus = {
	Inactive = 0,
	Active = 1
}
slot0.ExplorePipePotHangType = {
	UnCarry = 2,
	Put = 4,
	Carry = 1,
	Pick = 3
}
slot0.SceneCheckMode = {
	Rage = 0,
	Planes = 2,
	Camera = 1
}
slot0.PipeColor = {
	Color3 = 4,
	Color2 = 2,
	Color1 = 1,
	None = 0
}
slot5 = 0.16775
slot0.PipeColorDef = {
	[slot0.PipeColor.None] = Color.New(),
	[slot0.PipeColor.Color1] = Color.New(0.7735849, 0.2799217, 0.2152901),
	[slot0.PipeColor.Color2] = Color.New(0.199134, 0.4504557, 0.851),
	[slot0.PipeColor.Color3] = Color.New(slot5, 0.61, 0.2614471)
}
slot0.PipeGoNode = {
	Pipe4 = 5,
	Pipe3 = 4,
	Pipe2 = 3,
	Pipe1 = 2,
	Center = 1
}
slot0.PipeGoNodeName = {
	[slot0.PipeGoNode.Center] = "#go_center",
	[slot0.PipeGoNode.Pipe1] = "#go_pipe1",
	[slot0.PipeGoNode.Pipe2] = "#go_pipe2",
	[slot0.PipeGoNode.Pipe3] = "#go_pipe3",
	[slot0.PipeGoNode.Pipe4] = "#go_pipe4"
}
slot0.PipeShape = {
	Shape5 = 5,
	Shape6 = 6,
	Shape2 = 2,
	Shape3 = 3,
	Shape4 = 4,
	Shape1 = 1
}
slot0.PipeDirMatchMode = {
	All = 3,
	Single = 1,
	Both = 2
}
slot0.MapStatus = {
	RotateUnit = 3,
	UseItem = 1,
	MoveUnit = 2,
	Normal = 0
}
slot0.PipeTypes = {
	[slot0.ItemType.PipeEntrance] = true,
	[slot0.ItemType.Pipe] = true,
	[slot0.ItemType.PipeSensor] = true,
	[slot0.ItemType.PipeMemory] = true
}
slot0.PrismTypes = {
	[slot0.ItemType.Prism] = true,
	[slot0.ItemType.DichroicPrism] = true
}
slot0.StepType = {
	ResetBegin = -7,
	ArchiveClient = -4,
	DelUnit = 3,
	Rotate = 13,
	Archive = 16,
	Battle = 12,
	UpdateCoin = 5,
	Success = 11,
	UpdateUnit = 2,
	ShowArea = 14,
	HideArea = 15,
	RoleMove = 1,
	AddMaterial = 4,
	UseItem = 10,
	CheckCounter = -6,
	BonusScene = 17,
	CameraMoveBack = -2,
	Story = 6,
	CameraMove = -1,
	Spike = 7,
	Transfer = 8,
	ResetEnd = -8,
	BonusSceneClient = -5,
	Dialogue = -3,
	Elevator = 9,
	TriggerAudio = -9
}
slot0.MustDoStep = {
	[slot0.StepType.UpdateCoin] = true,
	[slot0.StepType.Archive] = true,
	[slot0.StepType.BonusScene] = true
}
slot0.StepTypeToName = {}

for slot4, slot5 in pairs(slot0.StepType) do
	slot0.StepTypeToName[slot5] = slot4
end

slot0.MapCompType = {
	Pipe = 4,
	Whirl = 3,
	Light = 2,
	Map = 1
}
slot0.CoinType = {
	GoldCoin = 1,
	Bonus = 0,
	PurpleCoin = 2
}
slot0.HeroLock = {
	Spike = 8,
	Rune = 6,
	Teleport = 12,
	CatchUnit = 3,
	HeroAnim = 4,
	BeginInteract = 13,
	UnitIdLock = 1000000,
	All = 0,
	MoveCamera = 7,
	UseItem = 9,
	Ice = 5,
	Pipe = 15,
	WaitUnitAnim = 10,
	PlayTriggerAnim = 14,
	Guide = 1,
	ShowArea = 2,
	Reset = 11
}
slot0.WalkAudioType = {
	Normal = 1,
	Ice = 2,
	None = 0
}
slot0.NodeType = {
	Ice = 2,
	Obstacle = 3,
	Normal = 1
}

return slot0
