module("modules.common.global.gamestate.GameTimeMgr", package.seeall)

local var_0_0 = class("GameTimeMgr")

var_0_0.TimeScaleType = {
	FightKillEnemy = "FightKillEnemy",
	GM = "GM",
	AutoChess = "AutoChess",
	StoryPv = "StoryPv",
	FightTLEventSpeed = "FightTLEventSpeed"
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._timeScaleDict = {}
end

function var_0_0.init(arg_2_0)
	arg_2_0._timeScaleDict = {}
end

function var_0_0.setTimeScale(arg_3_0, arg_3_1, arg_3_2)
	if var_0_0.TimeScaleType[arg_3_1] then
		arg_3_0._timeScaleDict[arg_3_1] = arg_3_2 or 1
	else
		logError("没有定义时间缩放类型, timeScaleType: " .. tostring(arg_3_1))
	end

	local var_3_0 = 1

	for iter_3_0, iter_3_1 in pairs(arg_3_0._timeScaleDict) do
		var_3_0 = var_3_0 * iter_3_1
	end

	if math.abs(Time.timeScale - var_3_0) > 0.01 then
		logNormal("游戏速度变更: " .. tostring(var_3_0))
	end

	Time.timeScale = var_3_0

	return var_3_0
end

function var_0_0.getTimeScale(arg_4_0, arg_4_1)
	return arg_4_0._timeScaleDict[arg_4_1] or 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
