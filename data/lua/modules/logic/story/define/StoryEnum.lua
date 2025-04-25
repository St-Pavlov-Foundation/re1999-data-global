module("modules.logic.story.define.StoryEnum", package.seeall)

slot0 = _M
slot0.StepType = {
	Interaction = 1,
	Normal = 0
}
slot0.ConversationType = {
	ScreenDialog = 5,
	Normal = 1,
	NoInteract = 6,
	IrregularShake = 8,
	NoRole = 3,
	Aside = 2,
	SlideDialog = 7,
	Player = 4,
	None = 0
}
slot0.ConversationEffectType = {
	Hard = 6,
	Magic = 7,
	SoftLight = 8,
	ReshapeMagic = 9,
	TwoLineShow = 5,
	LineByLine = 4,
	WordByWord = 3,
	Shake = 1,
	Fade = 2,
	None = 0
}
slot0.HeroPos = {
	Right = 2,
	Middle = 1,
	Left = 0
}
slot0.HeroEffect = {
	StyDissolve = "stydissolve",
	Gray = "gray"
}
slot0.BgType = {
	Effect = 1,
	Picture = 0
}
slot0.BgTransType = {
	WhiteFade = 4,
	DarkFade = 3,
	TurnPage2 = 12,
	ChangeScene2 = 15,
	TurnPage1 = 11,
	Keep = 0,
	Burn = 13,
	UpDarkFade = 5,
	Distort = 10,
	Filter = 9,
	LeftDarkFade = 16,
	Dissolve = 8,
	XiQuKeKe1 = 17,
	MovieChangeStart = 19,
	HotPixel = 21,
	XiQuKeKe2 = 18,
	ChangeScene1 = 14,
	RightDarkFade = 6,
	MovieChangeSwitch = 20,
	Fragmentate = 7,
	TransparencyFade = 2,
	Hard = 1
}
slot0.BgEffectType = {
	BgBlur = 1,
	FishEye = 2,
	FullGray = 6,
	Shake = 3,
	BgGray = 5,
	FullBlur = 4,
	MoveCurve = 7,
	None = 0
}
slot0.AudioOrderType = {
	Continuity = 0,
	Single = 1,
	Destroy = 2,
	Adjust = 3
}
slot0.AudioInType = {
	FadeIn = 1,
	Hard = 0
}
slot0.AudioOutType = {
	FadeOut = 1,
	Hard = 0
}
slot0.EffectOrderType = {
	Destroy = 2,
	ContinuityUnscale = 3,
	Single = 1,
	SingleUnscale = 4,
	Continuity = 0
}
slot0.EffectInType = {
	FadeIn = 1,
	Hard = 0
}
slot0.EffectOutType = {
	FadeOut = 1,
	Hard = 0
}
slot0.PictureType = {
	PicTxt = 3,
	Float = 2,
	FullScreen = 1,
	Normal = 0
}
slot0.PictureOrderType = {
	Destroy = 1,
	Produce = 0
}
slot0.PictureInType = {
	FadeIn = 1,
	Hard = 0
}
slot0.PictureOutType = {
	FadeOut = 1,
	Hard = 0
}
slot0.PictureEffectType = {
	Scale = 3,
	FollowBg = 2,
	Shake = 1,
	None = 0
}
slot0.VideoOrderType = {
	Destroy = 1,
	Restart = 3,
	Pause = 2,
	Produce = 0
}
slot0.OptionFeedbackType = {
	HeroLead = 1,
	None = 0
}
slot0.OptionConditionType = {
	HeroLead = 1,
	None = 0
}
slot0.NavigateType = {
	ChapterEnd = 4,
	Map = 1,
	ChapterStart = 3,
	HideBtns = 5,
	ActivityStart = 6,
	Episode = 2,
	StormDeadline = 9,
	RoleStoryStart = 8,
	ActivityEnd = 7,
	None = 0
}
slot0.SkipType = {
	ChapterEnd = 4,
	InDarkFade = 1,
	OutDarkFade = 2,
	AudioFade = 3,
	None = 0
}
slot0.BorderType = {
	FadeOut = 1,
	Keep = 3,
	FadeIn = 2,
	None = 0
}

return slot0
