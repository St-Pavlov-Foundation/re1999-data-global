module("modules.logic.guide.controller.action.impl.GuideActionSetNextStepGOPath", package.seeall)

slot0 = class("GuideActionSetNextStepGOPath", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot4 = string.split(slot3, "#")
	slot0._funcName = slot4[1]

	table.remove(slot4, 1)

	slot0._params = slot4
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if not string.nilorempty(slot0[slot0._funcName](slot0, slot0._params)) then
		GuideModel.instance:setNextStepGOPath(slot0.guideId, slot0.stepId, slot3)
	end

	slot0:onDone(true)
end

function slot0.getCritterMood(slot0, slot1)
	slot2 = tonumber(slot1[1])
	slot4 = nil

	if ManufactureModel.instance:getAllPlacedManufactureBuilding() then
		slot5 = nil

		for slot9, slot10 in ipairs(slot3) do
			if slot10:getCanPlaceCritterCount() > 0 then
				for slot15 = 1, slot11 do
					if slot10:getWorkingCritter(slot15 - 1) and CritterModel.instance:getById(slot16):getMoodValue() <= slot2 then
						slot5 = slot9
						slot4 = string.format("UIRoot/POPUP_TOP/RoomOverView/#go_subView/roommanufactureoverview(Clone)/centerArea/#go_building/#scroll_building/viewport/content/%s/critterInfo/id-%s_i-%s", slot9, slot15 - 1, slot15)
					end
				end
			end

			if slot5 then
				break
			end
		end

		ManufactureController.instance:dispatchEvent(ManufactureEvent.GuideFocusCritter, slot5)
	end

	return slot4
end

function slot0.roomBuilding(slot0, slot1)
	if tonumber(slot1[1]) then
		for slot7, slot8 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
			if slot8.buildingId == slot2 then
				slot10 = GameSceneMgr.instance:getCurScene().buildingmgr and slot9.buildingmgr:getBuildingEntity(slot8.id, SceneTag.RoomBuilding)

				return slot10 and SLFramework.GameObjectHelper.GetPath(slot10.go)
			end
		end
	else
		logError("设置下一步骤GameObject路径，但建筑id未配置 " .. slot0.guideId .. "_" .. slot0.stepId)
	end
end

function slot0.findTalentFirstChess(slot0)
	if not ViewMgr.instance:getContainer(ViewName.CharacterTalentChessView) then
		return
	end

	if not gohelper.findChild(slot1.viewGO, "chessboard/#go_chessContainer") then
		return
	end

	if not slot3.transform:GetChild(0) then
		return
	end

	return SLFramework.GameObjectHelper.GetPath(slot4.gameObject)
end

function slot0.getEquipChapterItem(slot0)
	if DungeonModel.instance:getEquipRemainingNum() > 0 then
		return "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem" .. "1" .. "/anim/#btn_click"
	else
		return slot1 .. tostring(#DungeonChapterListModel.getChapterListByType(false, true, false, nil)) .. slot2
	end
end

function slot0.getRemainStarsElement(slot0)
	slot3 = nil

	for slot7, slot8 in ipairs(WeekWalkModel.instance:getCurMapInfo().battleInfos) do
		if slot8.star ~= 2 then
			slot3 = slot8.battleId

			break
		end
	end

	if not slot3 then
		return
	end

	slot5 = nil

	for slot9, slot10 in ipairs(slot1.elementInfos) do
		if slot10:getType() == WeekWalkEnum.ElementType.Battle and slot10:getBattleId() == slot3 then
			slot5 = slot10

			break
		end
	end

	if slot1:getBattleInfo(slot3).index == 5 then
		return string.format("cameraroot/SceneRoot/WeekWalkMap/%s/elementRoot/%s/s09_rgmy_star1_red(Clone)", slot1.id, slot5.elementId)
	else
		return string.format("cameraroot/SceneRoot/WeekWalkMap/%s/elementRoot/%s/s09_rgmy_star1(Clone)", slot1.id, slot5.elementId)
	end
end

function slot0.getEquipPool(slot0)
	for slot5, slot6 in ipairs(SummonMainModel.getValidPools()) do
		if slot6.id == 10001 then
			return string.format("UIRoot/POPUP_TOP/SummonADView/#go_ui/#go_category/#scroll_category/Viewport/Content/tabitem_%s/#btn_self", slot5)
		end
	end
end

function slot0.getRoomCharacterPlace1(slot0)
	uv0.RoomCharacterPlace1 = nil
	slot2 = RoomCharacterPlaceListModel.instance:getList()[1]

	if RoomCharacterHelper.getRecommendHexPoint(slot2.heroId, slot2.skinId) and RoomCharacterHelper.getGuideRecommendHexPoint(slot3, slot4, slot5.hexPoint) and GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(RoomMapBlockModel.instance:getBlockMO(slot6.hexPoint.x, slot6.hexPoint.y).id, SceneTag.RoomMapBlock) then
		uv0.RoomCharacterPlace1 = SLFramework.GameObjectHelper.GetPath(slot8.go)

		return uv0.RoomCharacterPlace1
	end

	return "no block"
end

function slot0.getRoomCharacterPlace2(slot0)
	if uv0.RoomCharacterPlace1 then
		return uv0.RoomCharacterPlace1
	end

	slot2 = RoomCharacterPlaceListModel.instance:getList()[1]

	if RoomCharacterHelper.getRecommendHexPoint(slot2.heroId, slot2.skinId) and GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(RoomMapBlockModel.instance:getBlockMO(slot5.hexPoint.x, slot5.hexPoint.y).id, SceneTag.RoomMapBlock) then
		return SLFramework.GameObjectHelper.GetPath(slot7.go)
	end

	return uv0:getRoomCharacterPlace1()
end

function slot0.getMoveHeroPath(slot0)
	return string.format("UIRoot/POPUP_TOP/HeroGroupEditView/#go_rolecontainer/#scroll_card/scrollcontent/cell%s", (HeroGroupEditListModel.instance:getMoveHeroIndex() or 1) - 1)
end

function slot0.getConnectPuzzlePipeEntry(slot0)
	return string.format("UIRoot/POPUP_TOP/DungeonPuzzlePipeView/#go_connect/%s_%s", DungeonPuzzlePipeModel.instance._connectEntryX, DungeonPuzzlePipeModel.instance._connectEntryY)
end

function slot0.getMainSceneSkinItem(slot0)
	return string.format("UIRoot/POPUP_TOP/MainSwitchView/#go_container/mainsceneswitchview(Clone)/right/mask/#scroll_card/scrollcontent/cell%s/prefabInst", MainSceneSwitchListModel.instance:getFirstUnlockSceneIndex() - 1)
end

function slot0.getMainSceneBgmObj(slot0)
	return string.format("cameraroot/SceneRoot/MainScene/%s_p(Clone)/s01_obj_a/Anim/Obj/s01_obj_b", MainSceneSwitchModel.instance:getCurSceneResName())
end

function slot0.getFirstNoneExpEquip(slot0)
	slot2 = 1

	for slot6, slot7 in ipairs(CharacterBackpackEquipListModel.instance:getList()) do
		if slot7.config and slot8.isExpEquip ~= 1 and slot8.isSpRefine ~= 1 then
			slot2 = slot6

			break
		end
	end

	return string.format("UIRoot/POPUP_TOP/BackpackView/#go_container/characterbackpackequipview(Clone)/#scroll_equip/viewport/scrollcontent/cell%s/prefabInst", slot2 - 1)
end

function slot0.getRoomResFbChapter(slot0)
	if DungeonModel.instance:getEquipRemainingNum() > 0 then
		return "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem4/anim/#btn_click"
	else
		return "UIRoot/POPUP_TOP/DungeonView/#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent/chapteritem3/anim/#btn_click"
	end
end

function slot0.getSpecificCardPath(slot0)
	return string.format("UIRoot/HUD/FightView/root/handcards/handcards/cardItem%s", GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightSetSpecificCardIndex) or 1)
end

function slot0.getPlayerSoliderChessPath(slot0)
	if TeamChessUnitEntityMgr.instance:getAllEntity() then
		for slot5 = 1, #slot1 do
			if slot1[slot5]._unitMo:getUid() > 0 then
				return string.format("cameraroot/SceneRoot/EliminateSceneView/Unit/%s", slot7)
			end
		end
	end
end

function slot0.getAct178OperHolePath(slot0, slot1)
	slot2 = ""

	if type(slot1) == "table" then
		slot2 = table.concat(slot1, "#")
	end

	return string.format("UIRoot/POPUP_TOP/PinballCityView/#go_buildingui/UI_%s%s", PinballModel.instance.guideHole, slot2)
end

return slot0
