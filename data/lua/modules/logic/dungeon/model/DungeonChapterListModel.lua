module("modules.logic.dungeon.model.DungeonChapterListModel", package.seeall)

local var_0_0 = class("DungeonChapterListModel", ListScrollModel)

function var_0_0.setFbList(arg_1_0)
	local var_1_0 = DungeonModel.instance.curChapterType
	local var_1_1, var_1_2, var_1_3 = DungeonModel.instance:getChapterListTypes()

	arg_1_0._showNormal = var_1_1

	if arg_1_0._showNormal then
		local var_1_4 = DungeonConfig.instance:getChapterCOListByType(var_1_0)

		arg_1_0:clear()

		local var_1_5 = {}
		local var_1_6 = false

		for iter_1_0, iter_1_1 in ipairs(var_1_4) do
			if var_1_6 then
				break
			end

			if not DungeonModel.instance:isSpecialMainPlot(iter_1_1.id) then
				var_1_6 = DungeonModel.instance:chapterIsLock(iter_1_1.id)
			end

			table.insert(var_1_5, iter_1_1)
		end

		local var_1_7 = var_1_5

		if VersionValidator.instance:isInReviewing() then
			local var_1_8 = {}
			local var_1_9 = ResSplitConfig.instance:getAllChapterIds()

			for iter_1_2, iter_1_3 in ipairs(var_1_7) do
				if var_1_9[iter_1_3.id] then
					table.insert(var_1_8, iter_1_3)
				end
			end

			var_1_7 = var_1_8
		end

		arg_1_0:refreshChaperIndexDict(var_1_7)
		arg_1_0:setList(var_1_7)
		DungeonMainStoryModel.instance:setChapterList(var_1_7)
	else
		arg_1_0._chapterList = {}

		if var_1_2 then
			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GoldDungeon) then
				local var_1_10 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold)

				tabletool.addValues(arg_1_0._chapterList, var_1_10)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ExperienceDungeon) then
				local var_1_11 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp)

				tabletool.addValues(arg_1_0._chapterList, var_1_11)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.EquipDungeon) then
				local var_1_12 = DungeonConfig.instance:getChapterCO(DungeonEnum.EquipDungeonChapterId)

				table.insert(arg_1_0._chapterList, var_1_12)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Buildings) then
				local var_1_13 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Buildings)

				tabletool.addValues(arg_1_0._chapterList, var_1_13)
			end
		elseif var_1_3 then
			arg_1_0._chapterList = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
		end

		table.sort(arg_1_0._chapterList, var_0_0._sortChapterList)
	end
end

function var_0_0.getChapterListByType(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0 and arg_2_3 then
		return (DungeonConfig.instance:getChapterCOListByType(arg_2_3))
	else
		local var_2_0 = {}

		if arg_2_1 then
			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GoldDungeon) then
				local var_2_1 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Gold)

				tabletool.addValues(var_2_0, var_2_1)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ExperienceDungeon) then
				local var_2_2 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Exp)

				tabletool.addValues(var_2_0, var_2_2)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.EquipDungeon) then
				local var_2_3 = DungeonConfig.instance:getChapterCO(DungeonEnum.EquipDungeonChapterId)

				table.insert(var_2_0, var_2_3)
			end

			if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Buildings) then
				local var_2_4 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Buildings)

				tabletool.addValues(var_2_0, var_2_4)
			end
		elseif arg_2_2 then
			var_2_0 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Break)
		end

		table.sort(var_2_0, var_0_0._sortChapterList)

		return var_2_0
	end
end

function var_0_0._getCount(arg_3_0)
	local var_3_0 = DungeonConfig.instance:getDungeonEveryDayCount(arg_3_0.type)

	return var_3_0 - DungeonModel.instance:getChapterTypeNum(arg_3_0.type), var_3_0
end

function var_0_0._sortChapterList(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = var_0_0._getCount(arg_4_0)
	local var_4_2, var_4_3 = var_0_0._getCount(arg_4_1)

	if var_4_0 ~= var_4_2 then
		return var_4_2 < var_4_0
	end

	if var_4_1 ~= var_4_3 then
		return var_4_1 < var_4_3
	end

	local var_4_4 = DungeonModel.instance:getChapterOpenTimeValid(arg_4_0)

	if var_4_4 == DungeonModel.instance:getChapterOpenTimeValid(arg_4_1) then
		return arg_4_0.id < arg_4_1.id
	end

	if var_4_4 then
		return true
	end

	return false
end

function var_0_0.getFbList(arg_5_0)
	if arg_5_0._showNormal then
		return arg_5_0:getList()
	else
		return arg_5_0._chapterList
	end
end

function var_0_0.getChapterList(arg_6_0, arg_6_1)
	local var_6_0 = DungeonConfig.instance:getChapterCO(arg_6_1)

	if var_6_0.type == DungeonEnum.ChapterType.Break then
		return arg_6_0._chapterList
	elseif var_6_0.type == DungeonEnum.ChapterType.Equip then
		return (DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip))
	end

	return {}
end

function var_0_0.getOpenTimeValidEquipChapterId(arg_7_0, arg_7_1)
	if arg_7_1 then
		local var_7_0 = DungeonConfig.instance:getChapterCO(arg_7_1)

		if var_7_0.type ~= DungeonEnum.ChapterType.Equip then
			return arg_7_1
		end

		if DungeonModel.instance:getChapterOpenTimeValid(var_7_0) then
			return arg_7_1
		end
	end

	local var_7_1 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Equip)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if DungeonModel.instance:getChapterOpenTimeValid(iter_7_1) then
			return iter_7_1.id
		end
	end

	return arg_7_1
end

function var_0_0.getSelectedMO(arg_8_0)
	local var_8_0 = DungeonModel.instance.curChapterType
	local var_8_1 = DungeonConfig.instance:getChapterCOListByType(var_8_0)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1.id == DungeonModel.instance.curLookChapterId then
			return iter_8_1
		end
	end
end

function var_0_0.getInfoList(arg_9_0, arg_9_1)
	arg_9_0._mixCellInfo = {}

	local var_9_0 = arg_9_0:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = DungeonEnum.ChapterWidth.Normal

		if DungeonModel.instance:isSpecialMainPlot(iter_9_1.id) then
			var_9_1 = DungeonEnum.ChapterWidth.Special
		end

		local var_9_2 = SLFramework.UGUI.MixCellInfo.New(iter_9_0, var_9_1, iter_9_0)

		table.insert(arg_9_0._mixCellInfo, var_9_2)
	end

	return arg_9_0._mixCellInfo
end

function var_0_0.getMixCellPos(arg_10_0, arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0:getList()) do
		if iter_10_1.id == arg_10_1 then
			return var_10_0
		end

		var_10_0 = var_10_0 + arg_10_0._mixCellInfo[iter_10_0].lineLength
	end

	return var_10_0
end

function var_0_0.getLastUnlockChapterId(arg_11_0)
	local var_11_0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0:getList()) do
		if DungeonModel.instance:chapterIsUnLock(iter_11_1.id) then
			var_11_0 = iter_11_1.id
		end
	end

	return var_11_0
end

function var_0_0.refreshChaperIndexDict(arg_12_0, arg_12_1)
	arg_12_0.chapter2Index = {}

	if arg_12_1 then
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
			if not DungeonModel.instance:isSpecialMainPlot(iter_12_1.id) then
				var_12_0 = var_12_0 + 1
				arg_12_0.chapter2Index[iter_12_1.id] = var_12_0
			end
		end
	end
end

function var_0_0.getChapterIndex(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	return arg_13_0.chapter2Index and arg_13_0.chapter2Index[arg_13_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
