module("modules.logic.versionactivity1_4.dungeon.model.VersionActivity1_4DungeonModel", package.seeall)

slot0 = class("VersionActivity1_4DungeonModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.setSelectEpisodeId(slot0, slot1)
	slot0._selectEpisodeId = slot1

	VersionActivity1_4DungeonController.instance:dispatchEvent(VersionActivity1_4DungeonEvent.OnSelectEpisodeId)
end

function slot0.getSelectEpisodeId(slot0)
	return slot0._selectEpisodeId
end

function slot0.getEpisodeState(slot0, slot1)
	slot2 = {}

	if GameUtil.splitString2(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), ""), true) then
		for slot8, slot9 in pairs(slot4) do
			slot2[slot9[1]] = slot9[2] or 0
		end
	end

	return slot2[slot1] or 0
end

function slot0.setEpisodeState(slot0, slot1, slot2)
	slot3 = {}

	if GameUtil.splitString2(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), ""), true) then
		for slot9, slot10 in pairs(slot5) do
			slot3[slot10[1]] = slot10[2] or 0
		end
	end

	slot3[slot1] = slot2
	slot6 = {}

	for slot10, slot11 in pairs(slot3) do
		table.insert(slot6, string.format("%s#%s", slot10, slot11))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), table.concat(slot6, "|"))
end

slot0.instance = slot0.New()

return slot0
