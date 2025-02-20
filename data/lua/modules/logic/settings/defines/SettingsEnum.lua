module("modules.logic.settings.defines.SettingsEnum", package.seeall)

slot0 = _M
slot0.ShowType = {
	LimitedRoleEffect = 2,
	Push = 4,
	KeyMap = 3,
	RecordVideo = 1
}
slot0.CategoryList = {
	{
		name = "key_binding",
		subname = "KEYMAP",
		id = 1,
		openIds = {},
		showIds = {
			slot0.ShowType.KeyMap
		}
	},
	{
		id = 2,
		name = "account",
		subname = "ACCOUNT",
		openIds = {}
	},
	{
		name = "graphic",
		subname = "GRAPHIC",
		id = 3,
		hideOnGamepadModle = true,
		openIds = {}
	},
	{
		id = 4,
		name = "sound",
		subname = "SOUND",
		openIds = {}
	},
	{
		name = "settings_push",
		subname = "PUSH",
		id = 5,
		openIds = {},
		showIds = {
			slot0.ShowType.Push
		}
	},
	{
		id = 6,
		name = "language",
		subname = "LANGUAGE",
		openIds = {
			OpenEnum.UnlockFunc.SettingsVoiceLang,
			OpenEnum.UnlockFunc.SettingsTxtLang,
			OpenEnum.UnlockFunc.SettingsStroyVoiceLang
		}
	},
	{
		name = "settings_game",
		subname = "GAME",
		id = 7,
		openIds = {},
		showIds = {
			slot0.ShowType.RecordVideo,
			slot0.ShowType.LimitedRoleEffect
		}
	}
}
slot0.PushType = {
	Room_Produce_Upper_Limit = 2,
	Reactivation = 1,
	Allow_Recommend = 3
}
slot0.CharVoiceLangPrefsKey = "CharVoiceLang_"

return slot0
