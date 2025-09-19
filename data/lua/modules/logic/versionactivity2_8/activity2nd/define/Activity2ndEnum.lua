module("modules.logic.versionactivity2_8.activity2nd.define.Activity2ndEnum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityId = {
	V2a8_PVPopupReward = 12881,
	SkinCuffActivity = 12867,
	ActiveActivity = 12864,
	MailActivty = 12866,
	TakePhotosActivity = 12865,
	AnnualReview = 12879,
	welfareActivity = 12863
}
var_0_0.ActivityOrder = {
	var_0_0.ActivityId.AnnualReview,
	var_0_0.ActivityId.SkinCuffActivity,
	var_0_0.ActivityId.TakePhotosActivity,
	var_0_0.ActivityId.welfareActivity,
	var_0_0.ActivityId.ActiveActivity
}
var_0_0.ShowTipsType = {
	Error = "anniversary_typingtips_5",
	HeroName = "anniversary_typingtips_2",
	DungeonName = "anniversary_typingtips_3",
	FirstEnter = "anniversary_typingtips_1",
	SocialMedia = "anniversary_typingtips_4",
	HasGetReward = "anniversary_typingtips_6"
}
var_0_0.RandomType = {
	var_0_0.ShowTipsType.FirstEnter,
	var_0_0.ShowTipsType.HeroName,
	var_0_0.ShowTipsType.DungeonName,
	var_0_0.ShowTipsType.SocialMedia
}
var_0_0.StatButtonName = {
	[var_0_0.ActivityId.MailActivty] = "act_yearly_letter",
	[var_0_0.ActivityId.AnnualReview] = "act_yearly_report",
	[var_0_0.ActivityId.SkinCuffActivity] = "act_skin_collection",
	[var_0_0.ActivityId.TakePhotosActivity] = "act_shooting",
	[var_0_0.ActivityId.welfareActivity] = "act_free_role",
	[var_0_0.ActivityId.ActiveActivity] = "act_28summon"
}
var_0_0.ActivityViewName = {
	ViewName.Activity2ndMailView,
	ViewName.Activity2ndTakePhotosView,
	ViewName.Activity197View,
	ViewName.V2a8_SelfSelectCharacterView,
	ViewName.Activity2ndShowSkinView
}
var_0_0.DISPLAY_SKIN_COUNT = 4
var_0_0.Index2GoodsId = {
	nil,
	5102801,
	5102802,
	5102803
}
var_0_0.ShowSkin4 = 304002

return var_0_0
