-- chunkname: @modules/logic/sdk/config/SDKConfig.lua

module("modules.logic.sdk.config.SDKConfig", package.seeall)

local SDKConfig = class("SDKConfig", BaseConfig)

function SDKConfig:ctor()
	return
end

function SDKConfig:reqConfigNames()
	return {
		"const"
	}
end

function SDKConfig:getGuestBindRewards()
	return CommonConfig.instance:getConstStr(ConstEnum.guestBindRewards)
end

SDKConfig.instance = SDKConfig.New()

return SDKConfig
