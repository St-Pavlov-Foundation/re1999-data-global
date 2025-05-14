module("projbooter.config.GameChannelConfig", package.seeall)

local var_0_0 = class("GameChannelConfig")

var_0_0.SDKType = {
	xfsdk = 2,
	longcheng = 8,
	previewsdk = 5,
	gp_japan = 6,
	efun = 7,
	bilibili = 3,
	slsdk = 1,
	gp_global = 4
}
var_0_0.ServerType = {
	OutDevelop2 = 7,
	OutDevelop5 = 10,
	OutDevelop4 = 9,
	OutDevelop6 = 11,
	OutRelease = 4,
	OutDevelop3 = 8,
	OutExperience = 5,
	OutPreview = 3,
	OutDevelop1 = 6,
	OutDevelop = 2,
	Develop = 1
}
var_0_0._cfg = {
	[var_0_0.SDKType.xfsdk] = {
		gameCode = "ssgame",
		packageName = "com.bluepoch.m.reverse1999",
		channelId = "100",
		packageNamewin = "com.bluepoch.m.reverse1999.win",
		gameId = "50001"
	},
	[var_0_0.SDKType.slsdk] = {
		gameCode = "ssgame",
		packageName = "com.shenlan.m.proj1",
		channelId = "100",
		packageNamewin = "com.shenlan.m.proj1.shenlanwin",
		gameId = "50001"
	},
	[var_0_0.SDKType.bilibili] = {
		gameCode = "ssgame",
		subChannelId = "1",
		channelId = "101",
		packageNamewin = "com.shenlan.m.reverse1999.bilibiliwin",
		gameId = "50001"
	}
}

function var_0_0.isSlsdk()
	return GameConfig:GetCurSDKType() == var_0_0.SDKType.slsdk
end

function var_0_0.isXfsdk()
	return GameConfig:GetCurSDKType() == var_0_0.SDKType.xfsdk
end

function var_0_0.isBilibili()
	return GameConfig:GetCurSDKType() == var_0_0.SDKType.bilibili
end

function var_0_0.isGpGlobal()
	return GameConfig:GetCurSDKType() == var_0_0.SDKType.gp_global
end

function var_0_0.isGpJapan()
	return GameConfig:GetCurSDKType() == var_0_0.SDKType.gp_japan
end

function var_0_0.isLongCheng()
	return GameConfig:GetCurSDKType() == var_0_0.SDKType.longcheng
end

function var_0_0.isEfun()
	return GameConfig:GetCurSDKType() == var_0_0.SDKType.efun
end

function var_0_0._getCurCfg()
	return var_0_0._cfg[GameConfig:GetCurSDKType()]
end

function var_0_0.getGameId()
	return var_0_0._getCurCfg().gameId
end

function var_0_0.getPackageName()
	if BootNativeUtil.isWindows() then
		return var_0_0._getCurCfg().packageNamewin
	end

	return var_0_0._getCurCfg().packageName
end

function var_0_0.getChannelId()
	return var_0_0._getCurCfg().channelId
end

function var_0_0.getSubChannelId()
	if BootNativeUtil.isAndroid() then
		return "1002"
	end

	if BootNativeUtil.isIOS() then
		return "1004"
	end

	if BootNativeUtil.isWindows() then
		return "1003"
	end

	return "1003"
end

function var_0_0.getGameCode()
	return var_0_0._getCurCfg().gameCode
end

function var_0_0.getServerType()
	local var_14_0 = GameConfig:GetCurServerType()

	if var_14_0 == 6 or var_14_0 == 7 then
		var_14_0 = 2
	end

	if var_14_0 == 8 then
		var_14_0 = 5
	end

	return var_14_0
end

function var_0_0.isExternalTest()
	return GameConfig:GetCurServerType() == 6
end

return var_0_0
