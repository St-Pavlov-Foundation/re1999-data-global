module("modules.logic.main.config.MainBannerConfig", package.seeall)

slot0 = class("MainBannerConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.bannerconfig = nil
	slot0.nowbanner = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"main_banner"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "main_banner" then
		slot0.bannerconfig = slot2
	end
end

function slot0.getbannerCO(slot0, slot1)
	return slot0.bannerconfig.configDict[slot1]
end

function slot0.getBannersCo(slot0)
	return slot0.bannerconfig.configDict
end

function slot0.getNowBanner(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0.bannerconfig.configDict) do
		if slot7.startEnd ~= "" then
			slot8 = {}

			for slot13, slot14 in pairs(string.split(slot7.startEnd, "#")) do
				table.insert(slot8, TimeUtil.stringToTimestamp(slot14))
			end

			if slot8[1] < slot1 and slot1 < slot8[2] then
				table.insert(slot2, slot7.id)
			end
		else
			table.insert(slot2, slot7.id)
		end
	end

	slot2 = slot0:_checkid(slot0:_cleckCondition(slot2))

	table.sort(slot2, function (slot0, slot1)
		if uv0.bannerconfig.configDict[slot0].sortId == uv0.bannerconfig.configDict[slot1].sortId then
			return slot0 < slot1
		else
			return slot2 < slot3
		end
	end)

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		if slot7 <= 3 then
			table.insert(slot3, slot8)
		end
	end

	slot0.nowbanner = slot3

	return slot3
end

function slot0._cleckCondition(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		if slot0.bannerconfig.configDict[slot7].appearanceRole ~= "" then
			if string.split(slot8, "#")[1] == "1" and tonumber(slot9[2]) < tonumber(PlayerModel.instance:getPlayinfo().lastEpisodeId) then
				table.insert(slot2, slot7)
			end
		else
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0._checkid(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		if not slot0:_clecknum(slot7) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0._clecknum(slot0, slot1)
	for slot6, slot7 in pairs(MainBannerModel.instance:getBannerInfo()) do
		if slot7 == slot1 then
			return true
		end
	end
end

function slot0.getNearTime(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		if slot0.bannerconfig.configDict[slot8].startEnd ~= "" and slot1 <= TimeUtil.stringToTimestamp(string.split(slot0.bannerconfig.configDict[slot8].startEnd, "#")[2]) then
			table.insert(slot3, {
				time = slot10,
				id = slot8
			})
		end
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.time < slot1.time
	end)

	return slot3[1]
end

slot0.instance = slot0.New()

return slot0
