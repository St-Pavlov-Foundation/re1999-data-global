module("modules.logic.room.define.RoomCharacterEnum", package.seeall)

slot0 = _M
slot0.CharacterState = {
	Revert = 3,
	Temp = 2,
	Map = 1
}
slot0.CharacterMoveState = {
	BirthdayIdle = 5,
	Sleep = 6,
	Idle = 1,
	Stuck = 4,
	MaxMoodEating = 7,
	SpecialIdle = 3,
	Move = 2
}
slot0.SourceState = {
	Place = 1,
	Train = 2
}
slot0.CharacterAnimStateName = {
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
slot0.CharacterTamingAnimList = {
	slot0.CharacterAnimStateName.Taming,
	slot0.CharacterAnimStateName.Taming2,
	slot0.CharacterAnimStateName.Taming3
}
slot0.CharacterLoopAnimState = {
	[slot0.CharacterMoveState.Idle] = true,
	[slot0.CharacterMoveState.Move] = true
}
slot0.LoopAnimState = {
	[slot0.CharacterAnimStateName.Idle] = true,
	[slot0.CharacterAnimStateName.BirthdayLoop] = true,
	[slot0.CharacterAnimStateName.Sleep] = true
}
slot0.CharacterNextAnimNameDict = {
	[slot0.CharacterMoveState.Idle] = {
		[slot0.CharacterAnimStateName.SleepEnd] = slot0.CharacterAnimStateName.Idle,
		[slot0.CharacterAnimStateName.Eat] = slot0.CharacterAnimStateName.Idle
	},
	[slot0.CharacterMoveState.MaxMoodEating] = {
		[slot0.CharacterAnimStateName.SleepEnd] = slot0.CharacterAnimStateName.Eat,
		[slot0.CharacterAnimStateName.Eat] = slot0.CharacterAnimStateName.Idle
	},
	[slot0.CharacterMoveState.BirthdayIdle] = {
		[slot0.CharacterAnimStateName.BirthdayUp] = slot0.CharacterAnimStateName.BirthdayLoop
	},
	[slot0.CharacterMoveState.Sleep] = {
		[slot0.CharacterAnimStateName.SleepEnd] = slot0.CharacterAnimStateName.Eat,
		[slot0.CharacterAnimStateName.Eat] = slot0.CharacterAnimStateName.SleepStart,
		[slot0.CharacterAnimStateName.SleepStart] = slot0.CharacterAnimStateName.Sleep
	}
}
slot0.XingTiIdleAnimStateName = "idle_special"
slot0.CharacterAnimalAnimStateName = {
	Idle = "idle",
	Jump = "jump"
}
slot0.CharacterAnimState = {
	[slot0.CharacterMoveState.Idle] = slot0.CharacterAnimStateName.Idle,
	[slot0.CharacterMoveState.Move] = slot0.CharacterAnimStateName.Walk,
	[slot0.CharacterMoveState.SpecialIdle] = slot0.CharacterAnimStateName.SpecialIdle,
	[slot0.CharacterMoveState.Stuck] = slot0.CharacterAnimStateName.Stuck,
	[slot0.CharacterMoveState.BirthdayIdle] = slot0.CharacterAnimStateName.BirthdayUp
}
slot0.maskInteractAnim = {
	interact3 = true,
	interact2 = true,
	interact = true
}
slot0.CharacterOrderType = {
	FaithUp = 3,
	RareDown = 2,
	FaithDown = 4,
	RareUp = 1
}
slot0.SyncOperate = {
	Delete = 3,
	Update = 1,
	Overwrite = 2
}
slot0.ErrorTryPlaceCharacter = {
	MaxCount = -1
}
slot0.MaterialPath = "spine/xiaowu_character.mat"
slot0.MoveStraightAngleLimitStrict = 25
slot0.MoveStraightAngleLimit = 30
slot0.MoveThroughBridge = 40
slot0.CharacterHeightOffset = 0.109
slot0.AnimalDuration = 2
slot0.ClickTimes = 4
slot0.ClickInterval = 3
slot0.WaitingTimeAfterTouch = 1
slot0.DialogClickCDTime = 0.5
slot0.InteractionType = {
	Animal = 3,
	Building = 1,
	Dialog = 2
}
slot0.InteractionState = {
	Complete = 3,
	Start = 2,
	None = 1
}
slot0.ShowTimeFaithOp = {
	FaithOne = 2,
	FaithAll = 3,
	None = 1
}
slot0.CameraFocus = {
	MoreShowList = 2,
	Normal = 1
}
slot0.CharacterIdleAnimReplaceName = {
	[3025] = slot0.XingTiIdleAnimStateName
}
slot0.CommonEffect = {
	CritterAngry = 10001,
	CritterHighQuality = 10002,
	RightFoot = "common/v1a8_xuedijiaoyin_r",
	LeftFoot = "common/v1a8_xuedijiaoyin_l"
}
slot0.TooNearDistance = 0.25
slot0.BloomMaskDistance = 2
slot0.BuilingInteractionNodeRadius = 0.2

return slot0
