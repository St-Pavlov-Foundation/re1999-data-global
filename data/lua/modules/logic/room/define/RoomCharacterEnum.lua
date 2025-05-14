module("modules.logic.room.define.RoomCharacterEnum", package.seeall)

local var_0_0 = _M

var_0_0.CharacterState = {
	Revert = 3,
	Temp = 2,
	Map = 1
}
var_0_0.CharacterMoveState = {
	BirthdayIdle = 5,
	Sleep = 6,
	Idle = 1,
	Stuck = 4,
	MaxMoodEating = 7,
	SpecialIdle = 3,
	Move = 2
}
var_0_0.SourceState = {
	Place = 1,
	Train = 2
}
var_0_0.CharacterAnimStateName = {
	BirthdayLoop = "idle_birthday_loop",
	SleepStart = "sleep_start",
	Eat = "eat",
	BirthdayUp = "idle_birthday_up",
	SleepEnd = "sleep_end",
	Produce = "produce",
	SpecialIdle = "idle_room",
	Touch = "click",
	Sleep = "sleep",
	Collect = "collect",
	Idle = "idle",
	Stuck = "stuck",
	Taming = "taming",
	Taming2 = "taming2",
	Taming3 = "taming3",
	Walk = "walk"
}
var_0_0.CharacterTamingAnimList = {
	var_0_0.CharacterAnimStateName.Taming,
	var_0_0.CharacterAnimStateName.Taming2,
	var_0_0.CharacterAnimStateName.Taming3
}
var_0_0.CharacterLoopAnimState = {
	[var_0_0.CharacterMoveState.Idle] = true,
	[var_0_0.CharacterMoveState.Move] = true
}
var_0_0.LoopAnimState = {
	[var_0_0.CharacterAnimStateName.Idle] = true,
	[var_0_0.CharacterAnimStateName.BirthdayLoop] = true,
	[var_0_0.CharacterAnimStateName.Sleep] = true
}
var_0_0.CharacterNextAnimNameDict = {
	[var_0_0.CharacterMoveState.Idle] = {
		[var_0_0.CharacterAnimStateName.SleepEnd] = var_0_0.CharacterAnimStateName.Idle,
		[var_0_0.CharacterAnimStateName.Eat] = var_0_0.CharacterAnimStateName.Idle
	},
	[var_0_0.CharacterMoveState.MaxMoodEating] = {
		[var_0_0.CharacterAnimStateName.SleepEnd] = var_0_0.CharacterAnimStateName.Eat,
		[var_0_0.CharacterAnimStateName.Eat] = var_0_0.CharacterAnimStateName.Idle
	},
	[var_0_0.CharacterMoveState.BirthdayIdle] = {
		[var_0_0.CharacterAnimStateName.BirthdayUp] = var_0_0.CharacterAnimStateName.BirthdayLoop
	},
	[var_0_0.CharacterMoveState.Sleep] = {
		[var_0_0.CharacterAnimStateName.SleepEnd] = var_0_0.CharacterAnimStateName.Eat,
		[var_0_0.CharacterAnimStateName.Eat] = var_0_0.CharacterAnimStateName.SleepStart,
		[var_0_0.CharacterAnimStateName.SleepStart] = var_0_0.CharacterAnimStateName.Sleep
	}
}
var_0_0.XingTiIdleAnimStateName = "idle_special"
var_0_0.CharacterAnimalAnimStateName = {
	Idle = "idle",
	Jump = "jump"
}
var_0_0.CharacterAnimState = {
	[var_0_0.CharacterMoveState.Idle] = var_0_0.CharacterAnimStateName.Idle,
	[var_0_0.CharacterMoveState.Move] = var_0_0.CharacterAnimStateName.Walk,
	[var_0_0.CharacterMoveState.SpecialIdle] = var_0_0.CharacterAnimStateName.SpecialIdle,
	[var_0_0.CharacterMoveState.Stuck] = var_0_0.CharacterAnimStateName.Stuck,
	[var_0_0.CharacterMoveState.BirthdayIdle] = var_0_0.CharacterAnimStateName.BirthdayUp
}
var_0_0.maskInteractAnim = {
	interact3 = true,
	interact2 = true,
	interact = true
}
var_0_0.CharacterOrderType = {
	FaithUp = 3,
	RareDown = 2,
	FaithDown = 4,
	RareUp = 1
}
var_0_0.SyncOperate = {
	Delete = 3,
	Update = 1,
	Overwrite = 2
}
var_0_0.ErrorTryPlaceCharacter = {
	MaxCount = -1
}
var_0_0.MaterialPath = "spine/xiaowu_character.mat"
var_0_0.MoveStraightAngleLimitStrict = 25
var_0_0.MoveStraightAngleLimit = 30
var_0_0.MoveThroughBridge = 40
var_0_0.CharacterHeightOffset = 0.109
var_0_0.AnimalDuration = 2
var_0_0.ClickTimes = 4
var_0_0.ClickInterval = 3
var_0_0.WaitingTimeAfterTouch = 1
var_0_0.DialogClickCDTime = 0.5
var_0_0.InteractionType = {
	Animal = 3,
	Building = 1,
	Dialog = 2
}
var_0_0.InteractionState = {
	Complete = 3,
	Start = 2,
	None = 1
}
var_0_0.ShowTimeFaithOp = {
	FaithOne = 2,
	FaithAll = 3,
	None = 1
}
var_0_0.CameraFocus = {
	MoreShowList = 2,
	Normal = 1
}
var_0_0.CharacterIdleAnimReplaceName = {
	[3025] = var_0_0.XingTiIdleAnimStateName
}
var_0_0.CommonEffect = {
	CritterAngry = 10001,
	CritterHighQuality = 10002,
	RightFoot = "common/v1a8_xuedijiaoyin_r",
	LeftFoot = "common/v1a8_xuedijiaoyin_l"
}
var_0_0.TooNearDistance = 0.25
var_0_0.BloomMaskDistance = 2
var_0_0.BuilingInteractionNodeRadius = 0.2

return var_0_0
