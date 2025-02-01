module("modules.logic.dungeon.view.map.DungeonMapEquipEntryItem", package.seeall)

slot0 = class("DungeonMapEquipEntryItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._index = slot1[1]
	slot0._chapterId = slot1[2]
	slot0._readyChapterId = nil
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_num")
	slot0._imagefull = gohelper.findChildImage(slot0.viewGO, "progress/#image_full")
	slot0._txtprogressNum = gohelper.findChildText(slot0.viewGO, "progress/#txt_progressNum")

	slot0._simageicon:LoadImage(ResUrl.getDungeonIcon(string.format("entry/bg_fuben_tesurukou_%s", lua_equip_chapter.configDict[slot0._chapterId].group)))

	slot4 = DungeonConfig.instance:getChapterEpisodeCOList(slot0._chapterId)
	slot5 = #slot4

	for slot10, slot11 in ipairs(slot4) do
		if DungeonModel.instance:hasPassLevel(slot11.id) and DungeonModel.instance:getEpisodeInfo(slot11.id).challengeCount == 1 then
			slot6 = 0 + 1
		else
			slot0._readyChapterId = slot11.id

			break
		end
	end

	slot0._txtprogressNum.text = string.format("%s/%s", slot6, slot5)
	slot0._txtnum.text = "0" .. slot0._index
	slot0._imagefull.fillAmount = slot6 / slot5
end

function slot0.addEventListeners(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onClick(slot0)
	DungeonController.instance:openDungeonEquipEntryView(slot0._chapterId)
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
end

return slot0
