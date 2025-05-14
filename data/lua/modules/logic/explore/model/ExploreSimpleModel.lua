module("modules.logic.explore.model.ExploreSimpleModel", package.seeall)

local var_0_0 = class("ExploreSimpleModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.nowMapId = 0
	arg_1_0.chapterInfos = {}
	arg_1_0.mapInfos = {}
	arg_1_0.unLockMaps = {}
	arg_1_0.unLockChapters = {}
	arg_1_0.localData = nil
	arg_1_0.taskRed = nil
	arg_1_0.isShowBag = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.onGetInfo(arg_3_0, arg_3_1)
	arg_3_0.nowMapId = arg_3_1.lastMapId
	arg_3_0.isShowBag = arg_3_1.isShowBag

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.chapterSimple) do
		local var_3_0 = ExploreChapterSimpleMo.New()

		var_3_0:init(iter_3_1)

		arg_3_0.chapterInfos[iter_3_1.chapterId] = var_3_0
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.unlockMapIds) do
		arg_3_0.unLockMaps[iter_3_3] = true

		local var_3_1 = ExploreConfig.instance:getMapIdConfig(iter_3_3)

		if var_3_1 then
			arg_3_0.unLockChapters[var_3_1.chapterId] = true
		end
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_1.mapSimple) do
		local var_3_2 = ExploreMapSimpleMo.New()

		var_3_2:init(iter_3_5)

		arg_3_0.mapInfos[iter_3_5.mapId] = var_3_2
	end
end

function var_0_0.setShowBag(arg_4_0)
	if not arg_4_0.isShowBag then
		arg_4_0.isShowBag = true

		if isDebugBuild then
			ExploreController.instance:dispatchEvent(ExploreEvent.ShowBagBtn)
		end
	end
end

function var_0_0.getChapterIndex(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 or not arg_5_2 then
		return 1, 1
	end

	local var_5_0 = DungeonConfig.instance:getExploreChapterList()

	for iter_5_0 = #var_5_0, 1, -1 do
		local var_5_1 = DungeonConfig.instance:getChapterEpisodeCOList(var_5_0[iter_5_0].id)

		for iter_5_1 = #var_5_1, 1, -1 do
			if not arg_5_1 or not arg_5_2 then
				local var_5_2 = lua_explore_scene.configDict[var_5_0[iter_5_0].id][var_5_1[iter_5_1].id]

				if arg_5_0:getMapIsUnLock(var_5_2.id) then
					return iter_5_0, iter_5_1, var_5_0[iter_5_0].id, var_5_1[iter_5_1].id
				end
			elseif var_5_0[iter_5_0].id == arg_5_1 and var_5_1[iter_5_1].id == arg_5_2 then
				return iter_5_0, iter_5_1, arg_5_1, arg_5_2
			end
		end
	end

	return 1, 1
end

function var_0_0.getMapIsUnLock(arg_6_0, arg_6_1)
	return arg_6_0.unLockMaps[arg_6_1] or false
end

function var_0_0.setNowMapId(arg_7_0, arg_7_1)
	arg_7_0.nowMapId = arg_7_1
end

function var_0_0.onGetArchive(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getMapConfig()

	if not var_8_0 then
		logError("没有地图数据？？")

		return
	end

	if not arg_8_0.chapterInfos[var_8_0.chapterId] then
		return
	end

	arg_8_0:markArchive(var_8_0.chapterId, true, arg_8_1)
	arg_8_0.chapterInfos[var_8_0.chapterId]:onGetArchive(arg_8_1)
end

function var_0_0.getChapterMo(arg_9_0, arg_9_1)
	return arg_9_0.chapterInfos[arg_9_1]
end

function var_0_0.isChapterFinish(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getChapterMo(arg_10_1)

	return var_10_0 and var_10_0.isFinish or false
end

function var_0_0.onGetBonus(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getMapConfig()

	if not var_11_0 then
		logError("没有地图数据？？")

		return
	end

	if not arg_11_0.chapterInfos[var_11_0.chapterId] then
		return
	end

	arg_11_0.chapterInfos[var_11_0.chapterId]:onGetBonus(arg_11_1, arg_11_2)
end

function var_0_0.onGetCoin(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ExploreModel.instance:getMapId()

	if not arg_12_0.mapInfos[var_12_0] then
		arg_12_0.mapInfos[var_12_0] = ExploreMapSimpleMo.New()
	end

	arg_12_0.mapInfos[var_12_0]:onGetCoin(arg_12_1, arg_12_2)
end

function var_0_0.getMapConfig(arg_13_0)
	return (ExploreConfig.instance:getMapIdConfig(ExploreModel.instance:getMapId()))
end

function var_0_0.getBonusIsGet(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.mapInfos[arg_14_1] then
		return false
	end

	return arg_14_0.mapInfos[arg_14_1].bonusIds[arg_14_2] or false
end

function var_0_0.setBonusIsGet(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0.mapInfos[arg_15_1] then
		arg_15_0.mapInfos[arg_15_1] = ExploreMapSimpleMo.New()
	end

	arg_15_0.mapInfos[arg_15_1].bonusIds[arg_15_2] = true
end

function var_0_0.getCoinCountByMapId(arg_16_0, arg_16_1)
	local var_16_0 = 0
	local var_16_1 = 0
	local var_16_2 = 0
	local var_16_3 = 0
	local var_16_4 = 0
	local var_16_5 = 0
	local var_16_6 = arg_16_0.mapInfos[arg_16_1]

	if var_16_6 then
		var_16_0 = var_16_6.bonusNum
		var_16_1 = var_16_6.goldCoin
		var_16_2 = var_16_6.purpleCoin
		var_16_3 = var_16_6.bonusNumTotal
		var_16_4 = var_16_6.goldCoinTotal
		var_16_5 = var_16_6.purpleCoinTotal
	end

	return var_16_0, var_16_1, var_16_2, var_16_3, var_16_4, var_16_5
end

function var_0_0.getChapterCoinCount(arg_17_0, arg_17_1)
	local var_17_0 = ExploreConfig.instance:getMapIdsByChapter(arg_17_1)
	local var_17_1 = 0
	local var_17_2 = 0
	local var_17_3 = 0
	local var_17_4 = 0
	local var_17_5 = 0
	local var_17_6 = 0

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		local var_17_7 = arg_17_0.mapInfos[iter_17_1]

		if var_17_7 then
			var_17_1 = var_17_1 + var_17_7.bonusNum
			var_17_2 = var_17_2 + var_17_7.goldCoin
			var_17_3 = var_17_3 + var_17_7.purpleCoin
			var_17_4 = var_17_4 + var_17_7.bonusNumTotal
			var_17_5 = var_17_5 + var_17_7.goldCoinTotal
			var_17_6 = var_17_6 + var_17_7.purpleCoinTotal
		end
	end

	return var_17_1, var_17_2, var_17_3, var_17_4, var_17_5, var_17_6
end

function var_0_0.isChapterCoinFull(arg_18_0, arg_18_1)
	local var_18_0, var_18_1, var_18_2, var_18_3, var_18_4, var_18_5 = arg_18_0:getChapterCoinCount(arg_18_1)

	return var_18_0 == var_18_3 and var_18_1 == var_18_4 and var_18_2 == var_18_5
end

function var_0_0.getMapCoinCount(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or ExploreModel.instance:getMapId()

	local var_19_0 = arg_19_0.mapInfos[arg_19_1]

	if not var_19_0 then
		return 0, 0, 0, 0, 0, 0
	end

	return var_19_0.bonusNum, var_19_0.goldCoin, var_19_0.purpleCoin, var_19_0.bonusNumTotal, var_19_0.goldCoinTotal, var_19_0.purpleCoinTotal
end

function var_0_0.getChapterIsUnLock(arg_20_0, arg_20_1)
	return arg_20_0.unLockChapters[arg_20_1] or false
end

function var_0_0.checkTaskRed(arg_21_0)
	arg_21_0.taskRed = {}

	local var_21_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Explore)

	if not var_21_0 then
		return
	end

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		local var_21_1 = lua_task_explore.configDict[iter_21_1.id]

		if var_21_1 and iter_21_1.progress >= var_21_1.maxProgress and iter_21_1.finishCount <= 0 then
			local var_21_2 = string.splitToNumber(var_21_1.listenerParam, "#")

			arg_21_0.taskRed[var_21_2[1]] = arg_21_0.taskRed[var_21_2[1]] or {}
			arg_21_0.taskRed[var_21_2[1]][var_21_2[2]] = true
		end
	end
end

function var_0_0.getTaskRed(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0.taskRed and arg_22_0.taskRed[arg_22_1] and arg_22_0.taskRed[arg_22_1][arg_22_2] or false
end

function var_0_0.markChapterNew(arg_23_0, arg_23_1)
	arg_23_0:_getLocalData()

	if arg_23_0:getChapterIsNew(arg_23_1) then
		local var_23_0 = tostring(arg_23_1)

		if arg_23_0.localData[var_23_0] then
			arg_23_0.localData[var_23_0].isMark = true
		else
			arg_23_0.localData[var_23_0] = {
				isMark = true
			}
		end

		arg_23_0:savePrefData()
	end
end

function var_0_0.markChapterShowUnlock(arg_24_0, arg_24_1)
	arg_24_0:_getLocalData()

	if not arg_24_0:getChapterIsShowUnlock(arg_24_1) then
		local var_24_0 = tostring(arg_24_1)

		if arg_24_0.localData[var_24_0] then
			arg_24_0.localData[var_24_0].isShowUnlock = true
		else
			arg_24_0.localData[var_24_0] = {
				isShowUnlock = true
			}
		end

		arg_24_0:savePrefData()
	end
end

function var_0_0.markEpisodeShowUnlock(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:_getLocalData()

	if not arg_25_0:getEpisodeIsShowUnlock(arg_25_1, arg_25_2) then
		local var_25_0 = tostring(arg_25_1)
		local var_25_1 = arg_25_0.localData[var_25_0]

		if not var_25_1 then
			var_25_1 = {}
			arg_25_0.localData[var_25_0] = var_25_1
		end

		if not var_25_1.unLockEpisodes then
			var_25_1.unLockEpisodes = {}
		end

		table.insert(var_25_1.unLockEpisodes, arg_25_2)
		arg_25_0:savePrefData()
	end
end

function var_0_0.markArchive(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0:_getLocalData()

	if arg_26_2 or not arg_26_2 and arg_26_0:getHaveNewArchive(arg_26_1) ~= arg_26_2 then
		local var_26_0 = tostring(arg_26_1)

		if arg_26_2 then
			arg_26_0.localData[var_26_0] = arg_26_0.localData[var_26_0] or {}
			arg_26_0.localData[var_26_0].archive = arg_26_0.localData[var_26_0].archive or {}

			table.insert(arg_26_0.localData[var_26_0].archive, arg_26_3)
		elseif arg_26_0.localData[var_26_0] then
			arg_26_0.localData[var_26_0].archive = nil
		end

		arg_26_0:savePrefData()
	end
end

function var_0_0.getChapterIsNew(arg_27_0, arg_27_1)
	if not arg_27_0:getChapterIsUnLock(arg_27_1) then
		return false
	end

	arg_27_0:_getLocalData()

	local var_27_0 = tostring(arg_27_1)

	return not arg_27_0.localData[var_27_0] or not arg_27_0.localData[var_27_0].isMark
end

function var_0_0.getChapterIsShowUnlock(arg_28_0, arg_28_1)
	if not arg_28_0:getChapterIsUnLock(arg_28_1) then
		return false
	end

	arg_28_0:_getLocalData()

	local var_28_0 = tostring(arg_28_1)

	return arg_28_0.localData[var_28_0] and arg_28_0.localData[var_28_0].isShowUnlock
end

function var_0_0.getEpisodeIsShowUnlock(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0:getChapterIsUnLock(arg_29_1) then
		return false
	end

	arg_29_0:_getLocalData()

	local var_29_0 = tostring(arg_29_1)
	local var_29_1 = arg_29_0.localData[var_29_0]

	if not var_29_1 or not var_29_1.unLockEpisodes then
		return false
	end

	return tabletool.indexOf(var_29_1.unLockEpisodes, arg_29_2) and true or false
end

function var_0_0.getCollectFullIsShow(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if not arg_30_0:getChapterIsUnLock(arg_30_1) then
		return false
	end

	arg_30_0:_getLocalData()

	local var_30_0 = tostring(arg_30_1)
	local var_30_1 = arg_30_0.localData[var_30_0]

	if var_30_1 and arg_30_3 then
		var_30_1 = var_30_1[tostring(arg_30_3)]
	end

	if not var_30_1 then
		return false
	end

	arg_30_2 = string.format("collect%d", arg_30_2)

	return var_30_1[arg_30_2] or false
end

function var_0_0.markCollectFullIsShow(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if not arg_31_0:getChapterIsUnLock(arg_31_1) then
		return false
	end

	if not arg_31_0:getCollectFullIsShow(arg_31_1, arg_31_2, arg_31_3) then
		local var_31_0 = tostring(arg_31_1)
		local var_31_1 = arg_31_0.localData[var_31_0]

		if not var_31_1 then
			var_31_1 = {}
			arg_31_0.localData[var_31_0] = {}
		end

		arg_31_2 = string.format("collect%d", arg_31_2)

		if arg_31_3 then
			arg_31_3 = tostring(arg_31_3)
			var_31_1 = arg_31_0.localData[var_31_0][arg_31_3]

			if not var_31_1 then
				var_31_1 = {}
				arg_31_0.localData[var_31_0][arg_31_3] = var_31_1
			end
		end

		var_31_1[arg_31_2] = true

		arg_31_0:savePrefData()
	end
end

function var_0_0.getLastSelectMap(arg_32_0)
	arg_32_0:_getLocalData()

	local var_32_0 = arg_32_0.localData.lastChapterId
	local var_32_1 = arg_32_0.localData.lastEpisodeId

	return var_32_0, var_32_1
end

function var_0_0.setLastSelectMap(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0:_getLocalData()

	arg_33_0.localData.lastChapterId, arg_33_0.localData.lastEpisodeId = arg_33_1, arg_33_2

	arg_33_0:savePrefData()
end

function var_0_0.getHaveNewArchive(arg_34_0, arg_34_1)
	arg_34_0:_getLocalData()

	local var_34_0 = tostring(arg_34_1)

	return arg_34_0.localData[var_34_0] and arg_34_0.localData[var_34_0].archive or false
end

function var_0_0.getNewArchives(arg_35_0, arg_35_1)
	arg_35_0:_getLocalData()

	local var_35_0 = tostring(arg_35_1)

	return arg_35_0.localData[var_35_0] and arg_35_0.localData[var_35_0].archive or {}
end

function var_0_0._getLocalData(arg_36_0)
	if not arg_36_0.localData then
		local var_36_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId(), "")

		if string.nilorempty(var_36_0) then
			arg_36_0.localData = {}
		else
			arg_36_0.localData = cjson.decode(var_36_0)
		end
	end

	return arg_36_0.localData
end

function var_0_0.setDelaySave(arg_37_0, arg_37_1)
	arg_37_0._delaySave = arg_37_1

	if not arg_37_0._delaySave then
		arg_37_0:savePrefData()
	end
end

function var_0_0.savePrefData(arg_38_0)
	if arg_38_0._delaySave then
		return
	end

	local var_38_0 = cjson.encode(arg_38_0.localData)

	PlayerPrefsHelper.setString(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId(), var_38_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
