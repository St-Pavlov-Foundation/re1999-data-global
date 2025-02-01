module("modules.logic.dungeon.model.DungeonChapterListModel", package.seeall)

slot0 = class("DungeonChapterListModel", ListScrollModel)

function slot0.setFbList(slot0)
	slot1 = DungeonModel.instance.curChapterType
	slot0._showNormal, slot3, slot4 = DungeonModel.instance:getChapterListTypes()

	if slot0._showNormal then
		slot0:clear()

		slot6 = {}

		for slot11, slot12 in ipairs(DungeonConfig.instance:getChapterCOListByType(slot1)) do
			if false then
				break
			end

			if not DungeonModel.instance:isSpecialMainPlot(slot12.id) then
				slot7 = DungeonModel.instance:chapterIsLock(slot12.id)
			end

			table.insert(slot6, slot12)
		end

		slot5 = slot6

		if VersionValidator.instance:isInReviewing() then
			slot8 = {}

			for slot13, slot14 in ipairs(slot5) do
				if ResSplitConfig.instance:getAllChapterIds()[slot14.id] then
					table.insert(slot8, slot14)
				end
			end

			slot5 = slot8
		end

		slot0:refreshChaperIndexDict(slot5)
		slot0:setList(slot5)
		DungeonMainStoryModel.instance:setChapterList(slot5)
	else
		slot0._chapterList = {}

		if slot3 then
			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GoldDungeon) then
				tabletool.addValues(slot0._chapterList, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold))
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ExperienceDungeon) then
				tabletool.addValues(slot0._chapterList, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp))
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.EquipDungeon) then
				table.insert(slot0._chapterList, DungeonConfig.instance:getChapterCO(DungeonEnum.EquipDungeonChapterId))
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Buildings) then
				tabletool.addValues(slot0._chapterList, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Buildings))
			end
		elseif slot4 then
			slot0._chapterList = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
		end

		table.sort(slot0._chapterList, uv0._sortChapterList)
	end
end

function slot0.getChapterListByType(slot0, slot1, slot2, slot3)
	if slot0 and slot3 then
		return DungeonConfig.instance:getChapterCOListByType(slot3)
	else
		if slot1 then
			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GoldDungeon) then
				tabletool.addValues({}, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold))
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ExperienceDungeon) then
				tabletool.addValues(slot4, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp))
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.EquipDungeon) then
				table.insert(slot4, DungeonConfig.instance:getChapterCO(DungeonEnum.EquipDungeonChapterId))
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Buildings) then
				tabletool.addValues(slot4, DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Buildings))
			end
		elseif slot2 then
			slot4 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
		end

		table.sort(slot4, uv0._sortChapterList)

		return slot4
	end
end

function slot0._getCount(slot0)
	slot1 = DungeonConfig.instance:getDungeonEveryDayCount(slot0.type)

	return slot1 - DungeonModel.instance:getChapterTypeNum(slot0.type), slot1
end

function slot0._sortChapterList(slot0, slot1)
	slot2, slot3 = uv0._getCount(slot0)
	slot4, slot5 = uv0._getCount(slot1)

	if slot2 ~= slot4 then
		return slot4 < slot2
	end

	if slot3 ~= slot5 then
		return slot3 < slot5
	end

	if DungeonModel.instance:getChapterOpenTimeValid(slot0) == DungeonModel.instance:getChapterOpenTimeValid(slot1) then
		return slot0.id < slot1.id
	end

	if slot6 then
		return true
	end

	return false
end

function slot0.getFbList(slot0)
	if slot0._showNormal then
		return slot0:getList()
	else
		return slot0._chapterList
	end
end

function slot0.getChapterList(slot0, slot1)
	if DungeonConfig.instance:getChapterCO(slot1).type == DungeonEnum.ChapterType.Break then
		return slot0._chapterList
	elseif slot2.type == DungeonEnum.ChapterType.Equip then
		return DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip)
	end

	return {}
end

function slot0.getOpenTimeValidEquipChapterId(slot0, slot1)
	if slot1 then
		if DungeonConfig.instance:getChapterCO(slot1).type ~= DungeonEnum.ChapterType.Equip then
			return slot1
		end

		if DungeonModel.instance:getChapterOpenTimeValid(slot2) then
			return slot1
		end
	end

	for slot6, slot7 in ipairs(DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip)) do
		if DungeonModel.instance:getChapterOpenTimeValid(slot7) then
			return slot7.id
		end
	end

	return slot1
end

function slot0.getSelectedMO(slot0)
	for slot6, slot7 in ipairs(DungeonConfig.instance:getChapterCOListByType(DungeonModel.instance.curChapterType)) do
		if slot7.id == DungeonModel.instance.curLookChapterId then
			return slot7
		end
	end
end

function slot0.getInfoList(slot0, slot1)
	slot0._mixCellInfo = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		slot8 = DungeonEnum.ChapterWidth.Normal

		if DungeonModel.instance:isSpecialMainPlot(slot7.id) then
			slot8 = DungeonEnum.ChapterWidth.Special
		end

		table.insert(slot0._mixCellInfo, SLFramework.UGUI.MixCellInfo.New(slot6, slot8, slot6))
	end

	return slot0._mixCellInfo
end

function slot0.getMixCellPos(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot1 then
			return slot2
		end

		slot2 = slot2 + slot0._mixCellInfo[slot6].lineLength
	end

	return slot2
end

function slot0.getLastUnlockChapterId(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0:getList()) do
		if DungeonModel.instance:chapterIsUnLock(slot6.id) then
			slot1 = slot6.id
		end
	end

	return slot1
end

function slot0.refreshChaperIndexDict(slot0, slot1)
	slot0.chapter2Index = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if not DungeonModel.instance:isSpecialMainPlot(slot7.id) then
				slot0.chapter2Index[slot7.id] = 0 + 1
			end
		end
	end
end

function slot0.getChapterIndex(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0.chapter2Index and slot0.chapter2Index[slot1]
end

slot0.instance = slot0.New()

return slot0
