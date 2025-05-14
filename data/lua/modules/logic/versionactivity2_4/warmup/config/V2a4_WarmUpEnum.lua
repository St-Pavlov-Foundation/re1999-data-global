module("modules.logic.versionactivity2_4.warmup.config.V2a4_WarmUpEnum", package.seeall)

local var_0_0 = _M

var_0_0.DialogType = {
	ReplyAnsRight = 6,
	Preface = 0,
	AnsTrue = 9,
	AnsFalse = 10,
	ReplyAnsWrong = 5,
	Wait = 3
}
var_0_0.AskType = {
	Text = 1,
	Photo = 2
}
var_0_0.RoundState = {
	ReplyResult = 5,
	Ansed = 4,
	Ask = 2,
	WaitAns = 3,
	__End = 6,
	PreTalk = 1,
	None = 0
}

return var_0_0
