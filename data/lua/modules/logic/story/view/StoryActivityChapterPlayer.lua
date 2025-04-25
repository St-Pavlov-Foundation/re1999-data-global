module("modules.logic.story.view.StoryActivityChapterPlayer", package.seeall)

slot0 = class("StoryActivityChapterPlayer", UserDataDispose)
slot0.StoryType = {
	Close = 2,
	Open = 1
}
slot0.VersionSetting = {
	{
		[slot0.StoryType.Open] = "StoryActivityChapterOpen1_1",
		[slot0.StoryType.Close] = "StoryActivityChapterClose1_1"
	},
	{
		[slot0.StoryType.Open] = "StoryActivityChapterOpen1_2",
		[slot0.StoryType.Close] = "StoryActivityChapterClose1_2"
	},
	{
		[slot0.StoryType.Open] = "StoryActivityChapterOpen1_3",
		[slot0.StoryType.Close] = "StoryActivityChapterClose1_3"
	},
	[5] = {
		[slot0.StoryType.Open] = "StoryActivityChapterOpen1_5",
		[slot0.StoryType.Close] = "StoryActivityChapterClose1_5"
	},
	[6] = {
		[slot0.StoryType.Open] = "StoryActivityChapterOpen1_6",
		[slot0.StoryType.Close] = "StoryActivityChapterClose1_6"
	},
	[8] = {
		[slot0.StoryType.Open] = "StoryActivityChapterOpen1_8",
		[slot0.StoryType.Close] = "StoryActivityChapterClose1_8"
	},
	[20] = {
		[slot0.StoryType.Open] = "StoryActivityChapterOpen2_0",
		[slot0.StoryType.Close] = "StoryActivityChapterClose2_0"
	},
	[21] = {
		[slot0.StoryType.Open] = "StoryActivityChapterOpen2_1",
		[slot0.StoryType.Close] = "StoryActivityChapterClose2_1"
	},
	[23] = {
		[slot0.StoryType.Open] = "StoryActivityChapterOpen2_3",
		[slot0.StoryType.Close] = "StoryActivityChapterClose2_3"
	},
	[24] = {
		[slot0.StoryType.Open] = "StoryActivityChapterOpen2_4",
		[slot0.StoryType.Close] = "StoryActivityChapterClose2_4"
	},
	[25] = {
		[slot0.StoryType.Open] = "StoryActivityChapterOpen2_5",
		[slot0.StoryType.Close] = "StoryActivityChapterClose2_5"
	}
}

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1
	slot0.logicItems = {}
end

function slot0.getLogic(slot0, slot1, slot2)
	return slot0:getLogicByName(uv0.VersionSetting[slot1][slot2])
end

function slot0.getLogicByName(slot0, slot1)
	if not slot0.logicItems[slot1] then
		slot0.logicItems[slot1] = _G[slot1].New(slot0.viewGO)
	end

	return slot0.logicItems[slot1]
end

function slot0.playStart(slot0, slot1)
	gohelper.setActive(slot0.viewGO, true)

	slot4 = slot2[2] or 1

	slot0:getLogic(string.splitToNumber(slot1.navigateChapterEn, "#")[1] or 1, uv0.StoryType.Open):setData(slot1)
end

function slot0.loadStartImg(slot0, slot1, slot2)
	if slot0[string.format("loadStartImg" .. slot1)] then
		slot3(slot0, slot1, slot2)
	end
end

function slot0.playEnd(slot0, slot1)
	gohelper.setActive(slot0.viewGO, true)

	if string.nilorempty(slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]) then
		slot2 = slot1.navigateChapterEn
	end

	slot3, slot4 = nil

	if tonumber(slot2) then
		slot4 = tonumber(slot2)
	elseif string.split(slot2, "#")[1] and slot5[2] then
		slot4 = slot5[1]
		slot3 = slot5[2]
	else
		slot3 = slot5[1]
	end

	slot0:getLogic(tonumber(slot4 or 1), uv0.StoryType.Close):setData(slot3)
end

function slot0.playRoleStoryStart(slot0, slot1)
	gohelper.setActive(slot0.viewGO, true)
	slot0:getLogicByName("RoleStoryChapterOpen"):setData(slot1)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.viewGO, false)

	if slot0.logicItems then
		for slot4, slot5 in pairs(slot0.logicItems) do
			slot5:hide()
		end
	end
end

function slot0.dispose(slot0)
	if slot0.logicItems then
		for slot4, slot5 in pairs(slot0.logicItems) do
			slot5:onDestory()
		end
	end

	slot0:__onDispose()
end

return slot0
