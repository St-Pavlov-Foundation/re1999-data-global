module("modules.logic.story.define.StoryEnum", package.seeall)

local var_0_0 = _M

var_0_0.StepType = {
	Interaction = 1,
	Normal = 0
}
var_0_0.ConversationType = {
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
var_0_0.ConversationEffectType = {
	Hard = 6,
	Magic = 7,
	SoftLight = 8,
	ReshapeMagic = 9,
	TwoLineShow = 5,
	Glitch = 10,
	LineByLine = 4,
	WordByWord = 3,
	Shake = 1,
	Fade = 2,
	None = 0
}
var_0_0.HeroPos = {
	Right = 2,
	Middle = 1,
	Left = 0
}
var_0_0.HeroEffect = {
	StyDissolve = "stydissolve",
	KeepAction = "keepAction",
	Gray = "gray"
}
var_0_0.BgType = {
	Effect = 1,
	Picture = 0
}
var_0_0.BgTransType = {
	WhiteFade = 4,
	KaleidoscopeIn = 23,
	MovieChangeStart = 19,
	HotPixel2 = 22,
	MeltOut15 = 26,
	LeftDarkFade = 16,
	Distort = 10,
	UpDarkFade = 5,
	MeltIn25 = 29,
	TurnPage1 = 11,
	Burn = 13,
	Dissolve = 8,
	Keep = 0,
	HotPixel1 = 21,
	Filter = 9,
	XiQuKeKe2 = 18,
	ChangeScene2 = 15,
	ChangeScene1 = 14,
	RightDarkFade = 6,
	DarkFade = 3,
	MeltIn15 = 27,
	Bloom2 = 32,
	MovieChangeSwitch = 20,
	Fragmentate = 7,
	TurnPage3 = 25,
	Hard = 1,
	TurnPage2 = 12,
	XiQuKeKe1 = 17,
	MeltOut25 = 28,
	KaleidoscopeOut = 24,
	ShakeCamera = 30,
	TransparencyFade = 2,
	Bloom1 = 31
}
var_0_0.BgEffectType = {
	BgGray = 5,
	BgBlur = 1,
	FullGray = 6,
	FishEye = 2,
	Opposition = 11,
	BlindFilter = 10,
	EagleEye = 13,
	FullBlur = 4,
	Sketch = 9,
	MoveCurve = 7,
	Shake = 3,
	Interfere = 8,
	RgbSplit = 12,
	None = 0
}
var_0_0.BgRgbSplitType = {
	Once = 1,
	LoopStrong = 3,
	LoopWeak = 2,
	Trans = 0
}
var_0_0.AudioOrderType = {
	Destroy = 2,
	Single = 1,
	SetSwitch = 4,
	Adjust = 3,
	Continuity = 0
}
var_0_0.AudioInType = {
	FadeIn = 1,
	Hard = 0
}
var_0_0.AudioOutType = {
	FadeOut = 1,
	Hard = 0
}
var_0_0.EffectOrderType = {
	Destroy = 2,
	ContinuityUnscale = 3,
	Single = 1,
	SingleUnscale = 4,
	NoSettingUnScale = 6,
	NoSetting = 5,
	Continuity = 0,
	FollowBg = 7
}
var_0_0.EffectInType = {
	FadeIn = 1,
	Hard = 0
}
var_0_0.EffectOutType = {
	FadeOut = 1,
	Hard = 0
}
var_0_0.PictureType = {
	Transparency = 4,
	PicTxt = 3,
	Float = 2,
	FullScreen = 1,
	Normal = 0
}
var_0_0.PictureOrderType = {
	Destroy = 1,
	Produce = 0
}
var_0_0.PictureInType = {
	FadeIn = 1,
	TxtFadeIn = 2,
	Hard = 0
}
var_0_0.PictureOutType = {
	FadeOut = 1,
	Hard = 0
}
var_0_0.PictureEffectType = {
	Scale = 3,
	FollowBg = 2,
	Shake = 1,
	None = 0
}
var_0_0.VideoOrderType = {
	Destroy = 1,
	Restart = 3,
	Pause = 2,
	Produce = 0
}
var_0_0.OptionFeedbackType = {
	HeroLead = 1,
	None = 0
}
var_0_0.OptionConditionType = {
	MainSpine = 2,
	NormalLead = 1,
	None = 0
}
var_0_0.NavigateType = {
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
var_0_0.SkipType = {
	ChapterEnd = 4,
	InDarkFade = 1,
	OutDarkFade = 2,
	AudioFade = 3,
	None = 0
}
var_0_0.BorderType = {
	FadeOut = 1,
	Keep = 3,
	FadeIn = 2,
	None = 0
}
var_0_0.IconResType = {
	IconEff = 1,
	Spine = 0
}

return var_0_0
