module("modules.logic.versionactivity1_3.act125.config.Activity125Config", package.seeall)

slot0 = class("Activity125Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._configTab = nil
	slot0._channelValueList = {}
	slot0._episodeCount = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity125"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("on%sConfigLoaded", slot1)] then
		slot4(slot0, slot1, slot2)
	end
end

function slot0.onactivity125ConfigLoaded(slot0, slot1, slot2)
	if not slot0._configTab then
		slot0._configTab = {}
	end

	slot0._configTab[slot1] = slot2.configDict
end

function slot0.getActConfig(slot0, slot1, slot2)
	if slot1 and slot2 and slot0._configTab and slot0._configTab[slot1] then
		return slot0._configTab[slot1][slot2]
	end

	return nil
end

function slot0.getAct125Config(slot0, slot1)
	return slot0:getActConfig("activity125", slot1)
end

function slot0.getEpisodeConfig(slot0, slot1, slot2)
	return slot0:getAct125Config(slot1)[slot2]
end

slot0.ChannelCfgType = {
	Range = "Range",
	Point = "Point"
}

function slot0.parseChannelCfg(slot0, slot1, slot2)
	slot4 = {
		[slot11] = {}
	}
	slot7 = nil

	for slot11 = 1, #GameUtil.splitString2(slot1, false, "|", "#") do
		slot12 = slot3[slot11]
		slot4[slot11].startIndex = tonumber(slot12[1])
		slot4[slot11].startValue = slot12[2]

		if #slot12 == 2 then
			slot4[slot11].lastIndex = 0
			slot5 = slot4[slot11].startIndex
			slot4[slot11].type = uv0.ChannelCfgType.Point
		elseif slot13 == 4 then
			slot4[slot11].endIndex = tonumber(slot12[3])
			slot4[slot11].endValue = slot12[4]
			slot5 = slot4[slot11].endIndex
			slot4[slot11].type = uv0.ChannelCfgType.Range
		else
			logError("config error")
		end

		slot7 = slot7 or slot0:getRealFrequencyValue(slot2, slot4[slot11].startIndex, slot4[slot11].startValue, slot4[slot11].endIndex, slot4[slot11].endValue) or slot7
	end

	slot4.targetFrequencyValue = slot7
	slot4.wholeEndIndex = slot5
	slot4.wholeStartIndex = slot4[1].startIndex

	return slot4
end

function slot0.getChannelParseResult(slot0, slot1, slot2)
	if not (slot0._channelValueList and slot0._channelValueList[slot2]) then
		slot0._channelValueList[slot2] = uv0.instance:parseChannelCfg(slot0:getEpisodeConfig(slot1, slot2).frequency, slot0:getEpisodeConfig(slot1, slot2).targetFrequency)
		slot3 = slot0._channelValueList[slot2]
	end

	return slot3
end

function slot0.getRealFrequencyValue(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot4 or not slot5 then
		return slot1 == slot2 and slot3 or nil
	end

	if slot1 < slot2 or slot4 < slot1 then
		return nil
	end

	return (slot5 - slot3) / (slot4 - slot2) * (slot1 - slot2) + slot3
end

function slot0.getChannelIndexRange(slot0, slot1, slot2)
	return slot0:getChannelParseResult(slot1, slot2).wholeStartIndex, slot0:getChannelParseResult(slot1, slot2).wholeEndIndex
end

function slot0.getEpisodeCount(slot0, slot1)
	slot2 = slot0._episodeCount or tabletool.len(slot0:getAct125Config(slot1))
	slot0._episodeCount = slot2

	return slot2
end

slot0.instance = slot0.New()

return slot0
