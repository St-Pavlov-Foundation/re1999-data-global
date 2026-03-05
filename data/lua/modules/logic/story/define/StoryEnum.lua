-- chunkname: @modules/logic/story/define/StoryEnum.lua

module("modules.logic.story.define.StoryEnum", package.seeall)

local StoryEnum = _M

StoryEnum.StepType = {
	Interaction = 1,
	Normal = 0
}
StoryEnum.ConversationType = {
	ScreenDialog = 5,
	Normal = 1,
	NoInteract = 6,
	IrregularShake = 8,
	BgEffStack = 10,
	NoRole = 3,
	Aside = 2,
	SlideDialog = 7,
	LimitNoInteract = 9,
	Player = 4,
	None = 0
}
StoryEnum.ConversationEffectType = {
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
StoryEnum.HeroPos = {
	Right = 2,
	Middle = 1,
	Left = 0
}
StoryEnum.HeroEffect = {
	SetSkin = "setSkin",
	StyDissolve = "stydissolve",
	SetFlash = "setFlash",
	Gray = "gray",
	KeepAction = "keepAction",
	SetDissolve = "setDissolve"
}
StoryEnum.BgType = {
	Effect = 1,
	Picture = 0
}
StoryEnum.BgTransType = {
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
	SceneLightIn = 33,
	ChangeScene1 = 14,
	RightDarkFade = 6,
	DarkFade = 3,
	MeltIn15 = 27,
	Bloom2 = 32,
	MovieChangeSwitch = 20,
	ChangeScene2 = 15,
	Fragmentate = 7,
	SceneDarkOut = 36,
	TurnPage3 = 25,
	Hard = 1,
	TurnPage2 = 12,
	XiQuKeKe1 = 17,
	MeltOut25 = 28,
	SceneLightOut = 34,
	KaleidoscopeOut = 24,
	ShakeCamera = 30,
	SceneDarkIn = 35,
	TransparencyFade = 2,
	Bloom1 = 31
}
StoryEnum.BgEffectType = {
	BgBlur = 1,
	Sketch = 9,
	FullGray = 6,
	FishEye = 2,
	Opposition = 11,
	BgGray = 5,
	EagleEye = 13,
	FullBlur = 4,
	DiamondLight = 17,
	Filter = 14,
	MoveCurve = 7,
	OutFocus = 16,
	Starburst = 18,
	BgDistress = 20,
	SetLayer = 19,
	Distress = 15,
	BlindFilter = 10,
	Penetration = 22,
	HandCameraShake = 21,
	BgShake = 3,
	Interfere = 8,
	RgbSplit = 12,
	None = 0
}
StoryEnum.BgRgbSplitType = {
	Once = 1,
	LoopStrong = 3,
	LoopWeak = 2,
	Trans = 0
}
StoryEnum.AudioOrderType = {
	Destroy = 2,
	Single = 1,
	SetSwitch = 4,
	Adjust = 3,
	Continuity = 0
}
StoryEnum.AudioInType = {
	FadeIn = 1,
	Hard = 0
}
StoryEnum.AudioOutType = {
	FadeOut = 1,
	Hard = 0
}
StoryEnum.EffectOrderType = {
	Continuity = 0,
	Single = 1,
	ContinuityUnscale = 3,
	SingleUnscale = 4,
	NoSettingFollowBg = 8,
	FollowBg = 7,
	Destroy = 2,
	NoSetting = 5,
	NoSettingUnScale = 6
}
StoryEnum.EffectInType = {
	FadeIn = 1,
	Hard = 0
}
StoryEnum.EffectOutType = {
	FadeOut = 1,
	Hard = 0
}
StoryEnum.EffDegree = {
	High = 3,
	Middle = 2,
	Low = 1,
	None = 0
}
StoryEnum.PictureType = {
	HeroFollow = 5,
	Transparency = 4,
	PicTxt = 3,
	Float = 2,
	FullScreen = 1,
	Normal = 0
}
StoryEnum.PictureOrderType = {
	Destroy = 1,
	Produce = 0
}
StoryEnum.PictureInType = {
	FadeIn = 1,
	TxtFadeIn = 2,
	Hard = 0
}
StoryEnum.PictureOutType = {
	FadeOut = 1,
	Hard = 0
}
StoryEnum.PictureEffectType = {
	Scale = 3,
	FollowBg = 2,
	Shake = 1,
	None = 0
}
StoryEnum.VideoOrderType = {
	Destroy = 1,
	Produce = 0,
	ProduceSkip = 4,
	Restart = 3,
	Pause = 2
}
StoryEnum.OptionFeedbackType = {
	HeroLead = 1,
	None = 0
}
StoryEnum.OptionConditionType = {
	MainSpine = 2,
	NormalLead = 1,
	None = 0
}
StoryEnum.NavigateType = {
	ChapterEnd = 4,
	Map = 1,
	ChapterStart = 3,
	HideBtns = 5,
	ActivityStart = 6,
	Episode = 2,
	StormDeadline = 9,
	StrategyEnd = 11,
	RoleStoryStart = 8,
	StrategyStart = 10,
	ActivityEnd = 7,
	None = 0
}
StoryEnum.StrategyBtnType = {
	CmdPost = 1
}
StoryEnum.SkipType = {
	ChapterEnd = 4,
	InDarkFade = 1,
	OutDarkFade = 2,
	AudioFade = 3,
	None = 0
}
StoryEnum.BorderType = {
	FadeOut = 1,
	Keep = 3,
	FadeIn = 2,
	None = 0
}
StoryEnum.IconResType = {
	IconEff = 1,
	Spine = 0
}
StoryEnum.PicLayer = {
	UpCon1 = 7,
	BetweenHeroAndCon1 = 4,
	BetweenBgAndHero3 = 3,
	UpCon3 = 9,
	Top = 10,
	BetweenHeroAndCon2 = 5,
	UpCon2 = 8,
	BetweenBgAndHero2 = 2,
	BetweenBgAndHero1 = 1,
	BetweenHeroAndCon3 = 6
}
StoryEnum.EffLayer = {
	UpCon1 = 7,
	BetweenHeroAndCon1 = 4,
	BetweenBgAndHero3 = 3,
	UpCon3 = 9,
	Top = 10,
	BetweenHeroAndCon2 = 5,
	UpCon2 = 8,
	BetweenBgAndHero2 = 2,
	BetweenBgAndHero1 = 1,
	BetweenHeroAndCon3 = 6
}
StoryEnum.VideoLayer = {
	BetweenBgAndHero3 = 3,
	BetweenHeroAndCon1 = 4,
	UpCon1 = 7,
	BetweenBgAndHero2 = 2,
	BetweenBgAndHero1 = 1,
	BetweenHeroAndCon3 = 6,
	BetweenHeroAndCon2 = 5
}

return StoryEnum
