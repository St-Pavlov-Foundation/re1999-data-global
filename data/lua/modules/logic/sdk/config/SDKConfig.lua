module("modules.logic.sdk.config.SDKConfig", package.seeall)

slot0 = class("SDKConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"const"
	}
end

function slot0.getGuestBindRewards(slot0)
	return CommonConfig.instance:getConstStr(ConstEnum.guestBindRewards)
end

slot0.instance = slot0.New()

return slot0
