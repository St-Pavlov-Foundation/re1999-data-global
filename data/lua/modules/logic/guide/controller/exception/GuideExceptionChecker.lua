module("modules.logic.guide.controller.exception.GuideExceptionChecker", package.seeall)

local var_0_0 = _M

function var_0_0.checkCurrency(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = string.split(arg_1_2, "_")
	local var_1_1 = tonumber(var_1_0[1])
	local var_1_2 = tonumber(var_1_0[2])
	local var_1_3 = CurrencyModel.instance:getCurrency(var_1_1)

	return var_1_2 <= (var_1_3 and var_1_3.quantity)
end

function var_0_0.checkDungeonUsePower(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = HeroGroupModel.instance.episodeId
	local var_2_1 = DungeonConfig.instance:getEpisodeCO(var_2_0)
	local var_2_2 = string.split(var_2_1.cost, "|")
	local var_2_3 = string.split(var_2_2[1], "#")

	return tonumber(var_2_3[3] or 0) <= CurrencyModel.instance:getPower()
end

function var_0_0.checkBuildingPut(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = tonumber(arg_3_2)
	local var_3_1 = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(var_3_0)

	if var_3_1 and var_3_1:isInMap() then
		return false
	end

	return not RoomInventoryBuildingModel.instance:checkBuildingPut(var_3_0)
end

function var_0_0.checkBuildingPutMatchStep(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = GuideModel.instance:getById(arg_4_0)

	if not var_4_0 then
		return true
	end

	local var_4_1 = tonumber(arg_4_2)

	if #RoomMapBuildingModel.instance:getBuildingMOList() > 0 and var_4_0.serverStepId ~= var_4_1 then
		return false
	end

	return true
end

function var_0_0.checkViewShow(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ViewMgr.instance:getContainer(arg_5_2)

	return not var_5_0 or not var_5_0._isVisible
end

function var_0_0.checkViewNotShow(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ViewMgr.instance:getContainer(arg_6_2)

	return var_6_0 and var_6_0._isVisible
end

function var_0_0.checkViewExist(arg_7_0, arg_7_1, arg_7_2)
	return not ViewMgr.instance:getContainer(arg_7_2)
end

function var_0_0.checkViewNotExist(arg_8_0, arg_8_1, arg_8_2)
	return (ViewMgr.instance:getContainer(arg_8_2))
end

function var_0_0.noRemainStars()
	local var_9_0 = WeekWalkModel.instance:getCurMapInfo()

	if not var_9_0 or var_9_0.isFinish <= 0 then
		return
	end

	local var_9_1, var_9_2 = var_9_0:getCurStarInfo()

	return var_9_1 ~= var_9_2
end

function var_0_0.checkHeroTalent(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = tonumber(arg_10_2)
	local var_10_1 = CharacterController.instance:getTalentHeroId()

	return not (var_10_0 <= HeroModel.instance:getByHeroId(var_10_1).talent)
end

function var_0_0.checkSummon(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = HeroModel.instance:getList()

	return not (var_11_0 and #var_11_0 > 1)
end

function var_0_0.checkAllEquipLevel(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = tonumber(arg_12_2)
	local var_12_1 = EquipModel.instance:getEquips()
	local var_12_2 = false

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		if var_12_0 <= iter_12_1.level then
			var_12_2 = true

			break
		end
	end

	return not var_12_2
end

function var_0_0.noPointReward()
	local var_13_0 = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList]
	local var_13_1 = DungeonMapModel.instance:canGetRewardsList(var_13_0.chapterId)

	return var_13_1 and #var_13_1 > 0
end

function var_0_0.checkScene(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = SceneType[arg_14_2]
	local var_14_1 = GameSceneMgr.instance:getCurSceneType()

	logError("sceneType = " .. var_14_0 .. ", curSceneType = " .. var_14_1)

	return var_14_0 == var_14_1
end

function var_0_0.checkMaterial(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = string.split(arg_15_2, "_")
	local var_15_1 = tonumber(var_15_0[1])
	local var_15_2 = tonumber(var_15_0[2])

	return tonumber(var_15_0[3]) <= ItemModel.instance:getItemQuantity(var_15_1, var_15_2)
end

function var_0_0.checkMaterialNotEnough(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = string.split(arg_16_2, "_")
	local var_16_1 = tonumber(var_16_0[1])
	local var_16_2 = tonumber(var_16_0[2])

	return tonumber(var_16_0[3]) > ItemModel.instance:getItemQuantity(var_16_1, var_16_2)
end

function var_0_0.findTalentFirstChess()
	local var_17_0 = ViewMgr.instance:getContainer(ViewName.CharacterTalentChessView)

	if not var_17_0 then
		return true
	end

	local var_17_1 = var_17_0.viewGO
	local var_17_2 = gohelper.findChild(var_17_1, "chessboard/#go_chessContainer")

	if not var_17_2 then
		return true
	end

	return var_17_2.transform.childCount <= 0
end

function var_0_0.checkTaskFinish(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = tonumber(arg_18_2)

	if var_18_0 then
		local var_18_1 = TaskModel.instance:getTaskById(var_18_0)

		if var_18_1 then
			return TaskModel.instance:isTaskFinish(var_18_1.type, var_18_0)
		else
			return false
		end
	else
		logError("异常处理checkRoomTaskFinish参数错误：" .. arg_18_0 .. "_" .. arg_18_1)

		return false
	end
end

function var_0_0.checkTaskNotFinish(arg_19_0, arg_19_1, arg_19_2)
	return not var_0_0.checkTaskFinish(arg_19_0, arg_19_1, arg_19_2)
end

function var_0_0.checkBlockCountGE(arg_20_0, arg_20_1, arg_20_2)
	return tonumber(arg_20_2) <= RoomMapBlockModel.instance:getFullBlockCount()
end

function var_0_0.checkBlockCountL(arg_21_0, arg_21_1, arg_21_2)
	return tonumber(arg_21_2) > RoomMapBlockModel.instance:getFullBlockCount()
end

function var_0_0.checkRoomCanGetRes(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = tonumber(arg_22_2)

	return #RoomProductionHelper.getCanGainLineIdList(var_22_0) > 0
end

function var_0_0.check1_2DungeonHasNotCollectNote(arg_23_0, arg_23_1, arg_23_2)
	return not VersionActivity1_2NoteModel.instance:isCollectedAllNote()
end

function var_0_0.check1_2DungeonBonusFinish(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = tonumber(arg_24_2)

	return not VersionActivity1_2NoteModel.instance:getBonusFinished(var_24_0)
end

function var_0_0.check1_2DungeonHasNotBonusFinisd(arg_25_0, arg_25_1, arg_25_2)
	return not VersionActivity1_2NoteModel.instance:isAllBonusFinished()
end

function var_0_0.checkRoleStoryCanExchange(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)
	local var_26_1 = RoleStoryModel.instance:getLeftNum()

	return RoleStoryModel.instance:checkTodayCanExchange() and var_26_0 <= var_26_1
end

function var_0_0.checkCurBgmGearStateEqual(arg_27_0, arg_27_1, arg_27_2)
	return tonumber(arg_27_2) == BGMSwitchModel.instance:getMechineGear()
end

function var_0_0.checkCurBgmDeviceNotShowingPPT(arg_28_0, arg_28_1, arg_28_2)
	return not BGMSwitchModel.instance:getEggIsTrigger()
end

function var_0_0.checkCan174EnoughHpToBet(arg_29_0, arg_29_1, arg_29_2)
	return Activity174Model.instance:getActInfo():getGameInfo().hp > 1
end

function var_0_0.checkReturnFalse()
	return false
end

return var_0_0
