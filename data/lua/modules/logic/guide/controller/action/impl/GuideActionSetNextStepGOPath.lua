module("modules.logic.guide.controller.action.impl.GuideActionSetNextStepGOPath", package.seeall)

local var_0_0 = class("GuideActionSetNextStepGOPath", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = string.split(arg_1_3, "#")

	arg_1_0._funcName = var_1_0[1]

	table.remove(var_1_0, 1)

	arg_1_0._params = var_1_0
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0[arg_2_0._funcName](arg_2_0, arg_2_0._params)

	if not string.nilorempty(var_2_0) then
		GuideModel.instance:setNextStepGOPath(arg_2_0.guideId, arg_2_0.stepId, var_2_0)
	end

	arg_2_0:onDone(true)
end

function var_0_0.getCritterMood(arg_3_0, arg_3_1)
	local var_3_0 = tonumber(arg_3_1[1])
	local var_3_1 = ManufactureModel.instance:getAllPlacedManufactureBuilding()
	local var_3_2

	if var_3_1 then
		local var_3_3

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			local var_3_4 = iter_3_1:getCanPlaceCritterCount()

			if var_3_4 > 0 then
				for iter_3_2 = 1, var_3_4 do
					local var_3_5 = iter_3_1:getWorkingCritter(iter_3_2 - 1)

					if var_3_5 and var_3_0 >= CritterModel.instance:getById(var_3_5):getMoodValue() then
						var_3_3 = iter_3_0
						var_3_2 = string.format("UIRoot/POPUP_TOP/RoomOverView/#go_subView/roommanufactureoverview(Clone)/centerArea/#go_building/#scroll_building/viewport/content/%s/critterInfo/id-%s_i-%s", iter_3_0, iter_3_2 - 1, iter_3_2)
					end
				end
			end

			if var_3_3 then
				break
			end
		end

		ManufactureController.instance:dispatchEvent(ManufactureEvent.GuideFocusCritter, var_3_3)
	end

	return var_3_2
end

function var_0_0.roomBuilding(arg_4_0, arg_4_1)
	local var_4_0 = tonumber(arg_4_1[1])

	if var_4_0 then
		local var_4_1 = RoomMapBuildingModel.instance:getBuildingMOList()

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			if iter_4_1.buildingId == var_4_0 then
				local var_4_2 = GameSceneMgr.instance:getCurScene()
				local var_4_3 = var_4_2.buildingmgr and var_4_2.buildingmgr:getBuildingEntity(iter_4_1.id, SceneTag.RoomBuilding)

				return var_4_3 and SLFramework.GameObjectHelper.GetPath(var_4_3.go)
			end
		end
	else
		logError("设置下一步骤GameObject路径，但建筑id未配置 " .. arg_4_0.guideId .. "_" .. arg_4_0.stepId)
	end
end

function var_0_0.findTalentFirstChess(arg_5_0)
	local var_5_0 = ViewMgr.instance:getContainer(ViewName.CharacterTalentChessView)

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0.viewGO
	local var_5_2 = gohelper.findChild(var_5_1, "chessboard/#go_chessContainer")

	if not var_5_2 then
		return
	end

	local var_5_3 = var_5_2.transform:GetChild(0)

	if not var_5_3 then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(var_5_3.gameObject)
end

function var_0_0.getEquipChapterItem(arg_6_0)
	local var_6_0 = "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem"
	local var_6_1 = "/anim/#btn_click"

	if DungeonModel.instance:getEquipRemainingNum() > 0 then
		return var_6_0 .. "1" .. var_6_1
	else
		local var_6_2 = DungeonChapterListModel.getChapterListByType(false, true, false, nil)

		return var_6_0 .. tostring(#var_6_2) .. var_6_1
	end
end

function var_0_0.getRemainStarsElement(arg_7_0)
	local var_7_0 = WeekWalkModel.instance:getCurMapInfo()
	local var_7_1 = var_7_0.battleInfos
	local var_7_2

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.star ~= 2 then
			var_7_2 = iter_7_1.battleId

			break
		end
	end

	if not var_7_2 then
		return
	end

	local var_7_3 = var_7_0.elementInfos
	local var_7_4

	for iter_7_2, iter_7_3 in ipairs(var_7_3) do
		if iter_7_3:getType() == WeekWalkEnum.ElementType.Battle and iter_7_3:getBattleId() == var_7_2 then
			var_7_4 = iter_7_3

			break
		end
	end

	if var_7_0:getBattleInfo(var_7_2).index == 5 then
		return string.format("cameraroot/SceneRoot/WeekWalkMap/%s/elementRoot/%s/s09_rgmy_star1_red(Clone)", var_7_0.id, var_7_4.elementId)
	else
		return string.format("cameraroot/SceneRoot/WeekWalkMap/%s/elementRoot/%s/s09_rgmy_star1(Clone)", var_7_0.id, var_7_4.elementId)
	end
end

function var_0_0.getEquipPool(arg_8_0)
	local var_8_0 = SummonMainModel.getValidPools()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1.id == 10001 then
			return (string.format("UIRoot/POPUP_TOP/SummonADView/#go_ui/#go_category/#scroll_category/Viewport/Content/tabitem_%s/#btn_self", iter_8_0))
		end
	end
end

function var_0_0.getRoomCharacterPlace1(arg_9_0)
	var_0_0.RoomCharacterPlace1 = nil

	local var_9_0 = RoomCharacterPlaceListModel.instance:getList()[1]
	local var_9_1 = var_9_0.heroId
	local var_9_2 = var_9_0.skinId
	local var_9_3 = RoomCharacterHelper.getRecommendHexPoint(var_9_1, var_9_2)

	if var_9_3 then
		local var_9_4 = RoomCharacterHelper.getGuideRecommendHexPoint(var_9_1, var_9_2, var_9_3.hexPoint)

		if var_9_4 then
			local var_9_5 = RoomMapBlockModel.instance:getBlockMO(var_9_4.hexPoint.x, var_9_4.hexPoint.y)
			local var_9_6 = GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(var_9_5.id, SceneTag.RoomMapBlock)

			if var_9_6 then
				var_0_0.RoomCharacterPlace1 = SLFramework.GameObjectHelper.GetPath(var_9_6.go)

				return var_0_0.RoomCharacterPlace1
			end
		end
	end

	return "no block"
end

function var_0_0.getRoomCharacterPlace2(arg_10_0)
	if var_0_0.RoomCharacterPlace1 then
		return var_0_0.RoomCharacterPlace1
	end

	local var_10_0 = RoomCharacterPlaceListModel.instance:getList()[1]
	local var_10_1 = var_10_0.heroId
	local var_10_2 = var_10_0.skinId
	local var_10_3 = RoomCharacterHelper.getRecommendHexPoint(var_10_1, var_10_2)

	if var_10_3 then
		local var_10_4 = RoomMapBlockModel.instance:getBlockMO(var_10_3.hexPoint.x, var_10_3.hexPoint.y)
		local var_10_5 = GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(var_10_4.id, SceneTag.RoomMapBlock)

		if var_10_5 then
			return SLFramework.GameObjectHelper.GetPath(var_10_5.go)
		end
	end

	return var_0_0:getRoomCharacterPlace1()
end

function var_0_0.getMoveHeroPath(arg_11_0)
	local var_11_0 = HeroGroupEditListModel.instance:getMoveHeroIndex() or 1

	return string.format("UIRoot/POPUP_TOP/HeroGroupEditView/#go_rolecontainer/#scroll_card/scrollcontent/cell%s", var_11_0 - 1)
end

function var_0_0.getConnectPuzzlePipeEntry(arg_12_0)
	local var_12_0 = DungeonPuzzlePipeModel.instance._connectEntryX
	local var_12_1 = DungeonPuzzlePipeModel.instance._connectEntryY

	return string.format("UIRoot/POPUP_TOP/DungeonPuzzlePipeView/#go_connect/%s_%s", var_12_0, var_12_1)
end

function var_0_0.getMainSceneSkinItem(arg_13_0)
	local var_13_0 = MainSceneSwitchListModel.instance:getFirstUnlockSceneIndex()

	return string.format("UIRoot/POPUP_TOP/MainSwitchView/#go_container/mainswitchclassifyview(Clone)/root/mainsceneswitchnewview(Clone)/right/mask/#scroll_card/scrollcontent/cell%s/prefabInst", var_13_0 - 1)
end

function var_0_0.getMainSceneBgmObj(arg_14_0)
	local var_14_0 = MainSceneSwitchModel.instance:getCurSceneResName()

	return string.format("cameraroot/SceneRoot/MainScene/%s_p(Clone)/s01_obj_a/Anim/Obj/s01_obj_b", var_14_0)
end

function var_0_0.getFirstNoneExpEquip(arg_15_0)
	local var_15_0 = CharacterBackpackEquipListModel.instance:getList()
	local var_15_1 = 1

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = iter_15_1.config

		if var_15_2 and var_15_2.isExpEquip ~= 1 and var_15_2.isSpRefine ~= 1 then
			var_15_1 = iter_15_0

			break
		end
	end

	return string.format("UIRoot/POPUP_TOP/BackpackView/#go_container/characterbackpackequipview(Clone)/#scroll_equip/viewport/scrollcontent/cell%s/prefabInst", var_15_1 - 1)
end

function var_0_0.getRoomResFbChapter(arg_16_0)
	if DungeonModel.instance:getEquipRemainingNum() > 0 then
		return "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem4/anim/#btn_click"
	else
		return "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem3/anim/#btn_click"
	end
end

function var_0_0.getSpecificCardPath(arg_17_0)
	local var_17_0 = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightSetSpecificCardIndex)

	return string.format("UIRoot/HUD/FightView/root/handcards/handcards/cardItem%s", var_17_0 or 1)
end

function var_0_0.getPlayerSoliderChessPath(arg_18_0)
	local var_18_0 = TeamChessUnitEntityMgr.instance:getAllEntity()

	if var_18_0 then
		for iter_18_0 = 1, #var_18_0 do
			local var_18_1 = var_18_0[iter_18_0]._unitMo:getUid()

			if var_18_1 > 0 then
				return string.format("cameraroot/SceneRoot/EliminateSceneView/Unit/%s", var_18_1)
			end
		end
	end
end

function var_0_0.getAct178OperHolePath(arg_19_0, arg_19_1)
	local var_19_0 = ""

	if type(arg_19_1) == "table" then
		var_19_0 = table.concat(arg_19_1, "#")
	end

	local var_19_1 = PinballModel.instance.guideHole

	return string.format("UIRoot/POPUP_TOP/PinballCityView/#go_buildingui/UI_%s%s", var_19_1, var_19_0)
end

function var_0_0.findSurvivalSpBlockPath(arg_20_0)
	if not SurvivalMapModel.instance.guideSpBlockPos then
		return ""
	end

	local var_20_0 = SurvivalMapModel.instance.guideSpBlockPos
	local var_20_1 = Vector3.New(SurvivalHelper.instance:hexPointToWorldPoint(var_20_0.q, var_20_0.r))

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, var_20_1, 0.3)

	return string.format("cameraroot/SceneRoot/SurvivalScene/SPBlockRoot/%s", tostring(var_20_0))
end

function var_0_0.getBossTowerFirstBossPath(arg_21_0)
	local var_21_0 = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	if #var_21_0 > 1 then
		table.sort(var_21_0, TowerAssistBossModel.sortBossList)
	end

	local var_21_1 = var_21_0[1] and var_21_0[1].id or 1

	return string.format("UIRoot/POPUP_TOP/TowerBossSelectView/root/#scroll_boss/Viewport/#go_bossContent/boss%s/towerbossselectitem(Clone)/click", var_21_1)
end

function var_0_0.getNecrologistStoryLastItemPath(arg_22_0)
	local var_22_0 = ViewMgr.instance:getContainer(ViewName.NecrologistStoryView)

	if not var_22_0 then
		return
	end

	local var_22_1 = var_22_0:getLastItem()

	if not var_22_1 then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(var_22_1.viewGO)
end

return var_0_0
