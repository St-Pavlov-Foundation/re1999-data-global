module("projbooter.config.GameChannelConfig", package.seeall)

slot0 = class("GameChannelConfig")
slot0.SDKType = {
	xfsdk = 2,
	longcheng = 8,
	previewsdk = 5,
	gp_japan = 6,
	efun = 7,
	bilibili = 3,
	slsdk = 1,
	gp_global = 4
}
slot0.ServerType = {
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
slot0._cfg = {
	[slot0.SDKType.xfsdk] = {
		gameCode = "ssgame",
		packageName = "com.bluepoch.m.reverse1999",
		channelId = "100",
		packageNamewin = "com.bluepoch.m.reverse1999.win",
		gameId = "50001"
	},
	[slot0.SDKType.slsdk] = {
		gameCode = "ssgame",
		packageName = "com.shenlan.m.proj1",
		channelId = "100",
		packageNamewin = "com.shenlan.m.proj1.shenlanwin",
		gameId = "50001"
	},
	[slot0.SDKType.bilibili] = {
		gameCode = "ssgame",
		subChannelId = "1",
		channelId = "101",
		packageNamewin = "com.shenlan.m.reverse1999.bilibiliwin",
		gameId = "50001"
	}
}

function slot0.isSlsdk()
	return GameConfig:GetCurSDKType() == uv0.SDKType.slsdk
end

function slot0.isXfsdk()
	return GameConfig:GetCurSDKType() == uv0.SDKType.xfsdk
end

function slot0.isBilibili()
	return GameConfig:GetCurSDKType() == uv0.SDKType.bilibili
end

function slot0.isGpGlobal()
	return GameConfig:GetCurSDKType() == uv0.SDKType.gp_global
end

function slot0.isGpJapan()
	return GameConfig:GetCurSDKType() == uv0.SDKType.gp_japan
end

function slot0.isLongCheng()
	return GameConfig:GetCurSDKType() == uv0.SDKType.longcheng
end

function slot0.isEfun()
	return GameConfig:GetCurSDKType() == uv0.SDKType.efun
end

function slot0._getCurCfg()
	return uv0._cfg[GameConfig:GetCurSDKType()]
end

function slot0.getGameId()
	return uv0._getCurCfg().gameId
end

function slot0.getPackageName()
	if BootNativeUtil.isWindows() then
		return uv0._getCurCfg().packageNamewin
	end

	return uv0._getCurCfg().packageName
end

function slot0.getChannelId()
	return uv0._getCurCfg().channelId
end

function slot0.getSubChannelId()
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

function slot0.getGameCode()
	return uv0._getCurCfg().gameCode
end

function slot0.getServerType()
	if GameConfig:GetCurServerType() == 6 or slot0 == 7 then
		slot0 = 2
	end

	if slot0 == 8 then
		slot0 = 5
	end

	return slot0
end

function slot0.isExternalTest()
	return GameConfig:GetCurServerType() == 6
end

return slot0
