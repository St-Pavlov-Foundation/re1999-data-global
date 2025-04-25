module("modules.logic.act201.config.Activity201Config", package.seeall)

slot0 = class("Activity201Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"turnback_sp_h5_channel",
		"turnback_sp_h5_roletype"
	}
end

function slot1(slot0)
	return lua_turnback_sp_h5_roletype.configDict[slot0]
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "turnback_sp_h5_channel" then
		slot0:_initTurnBackH5Config(slot2)
	end
end

function slot0._initTurnBackH5Config(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if slot2[slot7.channelId] == nil then
			slot2[slot7.channelId] = slot7.url
		end
	end

	slot0._channelUrlDic = slot2
end

function slot0.getChannelConfig(slot0, slot1)
	return lua_turnback_sp_h5_channel.configDict[slot1]
end

function slot0.getUrlByChannelId(slot0, slot1)
	return slot0._channelUrlDic[slot1]
end

function slot0.getRoleTypeStr(slot0, slot1)
	slot2 = uv0(slot1 or 1) or uv0(1)

	return gohelper.getRichColorText(slot2.name, slot2.nameHexColor)
end

slot0.instance = slot0.New()

return slot0
