module("modules.logic.turnback.invitation.config.TurnBackInvitationConfig", package.seeall)

slot0 = class("TurnBackInvitationConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._turnBackH5ChannelConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"turnback_h5_channel"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "turnback_h5_channel" then
		slot0._turnBackH5ChannelConfig = slot2

		slot0:_initTurnBackH5Config()
	end
end

function slot0._initTurnBackH5Config(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._turnBackH5ChannelConfig.configList) do
		if slot1[slot6.channelId] == nil then
			slot1[slot6.channelId] = slot6.url
		end
	end

	slot0._channelUrlDic = slot1
end

function slot0.getChannelConfig(slot0, slot1)
	return slot0._turnBackH5ChannelConfig.configDict[slot1]
end

function slot0.getUrlByChannelId(slot0, slot1)
	return slot0._channelUrlDic[slot1]
end

slot0.instance = slot0.New()

return slot0
