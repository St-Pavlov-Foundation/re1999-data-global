module("modules.logic.settings.defines.SettingsEnum", package.seeall)

local var_0_0 = _M

var_0_0.ShowType = {
	LimitedRoleEffect = 2,
	Push = 4,
	KeyMap = 3,
	RecordVideo = 1
}
var_0_0.CategoryList = {
	{
		name = "key_binding",
		subname = "KEYMAP",
		id = 1,
		openIds = {},
		showIds = {
			var_0_0.ShowType.KeyMap
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
			var_0_0.ShowType.Push
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
			var_0_0.ShowType.RecordVideo,
			var_0_0.ShowType.LimitedRoleEffect
		}
	}
}
var_0_0.PushType = {
	Room_Produce_Upper_Limit = 2,
	Reactivation = 1,
	Allow_Recommend = 3
}
var_0_0.CharVoiceLangPrefsKey = "CharVoiceLang_"

return var_0_0
