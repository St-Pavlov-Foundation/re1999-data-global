module("modules.logic.main.model.MainBannerModel", package.seeall)

slot0 = class("MainBannerModel", BaseModel)

function slot0.onInit(slot0)
	slot0._notShowIds = {}

	for slot6, slot7 in pairs(string.split(PlayerPrefsHelper.getString(PlayerPrefsKey.BannersNotShow, ""), "#")) do
		if slot7 ~= nil and slot7 ~= "" then
			table.insert(slot0._notShowIds, tonumber(slot7))
		end
	end
end

function slot0.addNotShowid(slot0, slot1)
	for slot5, slot6 in pairs(slot0._notShowIds) do
		if slot6 == slot1 then
			return
		end
	end

	table.insert(slot0._notShowIds, slot1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.BannersNotShow, table.concat(slot0._notShowIds, "#"))
end

function slot0.getBannerInfo(slot0)
	return slot0._notShowIds
end

slot0.instance = slot0.New()

return slot0
