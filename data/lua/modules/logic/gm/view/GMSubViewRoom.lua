module("modules.logic.gm.view.GMSubViewRoom", package.seeall)

slot0 = class("GMSubViewRoom", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "荒原"
end

function slot0.initViewContent(slot0)
	if slot0._isInit then
		return
	end

	slot0._isInit = true
	slot1 = "L1"
	slot2 = {
		"选择时间"
	}

	for slot6 = 1, 24 do
		table.insert(slot2, slot6 .. "时")
	end

	slot0._dropRoomClock = slot0:addDropDown(slot1, "小屋时\n钟触发", slot2, slot0._onRoomClockSelectChanged, slot0)
	slot3, slot0._vehicleIdList = slot0:_findInitFollowTargetParams()
	slot0._dropFollowTarget = slot0:addDropDown(slot1, "乘坐交通", slot3, slot0._onFollowTargetSelectChanged, slot0)
	slot5, slot0._characterIdList = slot0:_findInitFollowCharacterParams()
	slot0._dropFollowCharacter = slot0:addDropDown(slot1, "角色镜\n头跟随", slot5, slot0._onFollowCharacterSelectChanged, slot0)

	slot0:addDropDown("L2", "地块用途", {
		"地块用途选择",
		"正常",
		"货运"
	}, slot0._onBlockUseStateSelectChanged, slot0)

	slot1 = "L3"

	slot0:addButton(slot1, "mini地图", slot0._onOpenMiniMapView, slot0)
	slot0:addButton(slot1, "货运编辑", slot0._onOpenEditPathView, slot0)

	slot0._transporQuickLinkToggle = slot0:addToggle(slot1, "调试运输路线【快速绘制】", slot0._ontransporQuickLinkChange, slot0)
	slot0._transporQuickLinkToggle.isOn = RoomTransportPathQuickLinkViewUI._IsShow_ == true
end

function slot0._findInitFollowTargetParams(slot0)
	return slot0:_findObMOList("选择交通", RoomMapVehicleModel.instance:getList(), "config")
end

function slot0._findInitFollowCharacterParams(slot0)
	return slot0:_findObMOList("选择角色", RoomCharacterModel.instance:getList(), "skinConfig")
end

function slot0._findObMOList(slot0, slot1, slot2, slot3)
	if not slot0:_checkObMode() then
		slot2 = nil
	end

	return slot0:_findMOList(slot1, slot2, slot3)
end

function slot0._findMOList(slot0, slot1, slot2, slot3)
	slot4 = {
		slot1 .. "#id-选择"
	}
	slot5 = {}

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			if slot10 and slot10[slot3] then
				table.insert(slot4, string.format("%s#%s", slot10[slot3].name, slot10.id))
				table.insert(slot5, slot10.id)
			end
		end
	end

	return slot4, slot5
end

function slot0._sortCharacterInteractionFunc(slot0, slot1)
	if slot0.behaviour ~= slot1.behaviour then
		return slot0.behaviour < slot1.behaviour
	end
end

function slot0._finInitCharacterInteractParams(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_room_character_interaction.configList) do
		if RoomCharacterModel.instance:getCharacterMOById(slot6.heroId) and slot7.characterState == RoomCharacterEnum.CharacterState.Map then
			table.insert(slot1, slot6)
		end
	end

	table.sort(slot1, GMToolView._sortCharacterInteractionFunc)

	slot3 = {
		[RoomCharacterEnum.InteractionType.Dialog] = "对话",
		[RoomCharacterEnum.InteractionType.Building] = "建筑"
	}
	slot7 = "英雄-交互#id选择"

	table.insert({}, slot7)

	for slot7, slot8 in ipairs(slot1) do
		if slot3[slot8.behaviour] then
			table.insert(slot2, string.format("%s-%s#%s", HeroConfig.instance:getHeroCO(slot8.heroId).name or slot8.heroId, slot3[slot8.behaviour], slot8.id))
		end
	end

	return slot1
end

function slot0._onFollowTargetSelectChanged(slot0, slot1)
	if not slot0._vehicleIdList or slot1 == 0 then
		return
	end

	if not slot0:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	GameFacade.showToast(ToastEnum.IconId, "乘坐交通工具")

	if GameSceneMgr.instance:getCurScene().vehiclemgr:getUnit(RoomMapVehicleEntity:getTag(), slot0._vehicleIdList[slot1]) then
		slot4.cameraFollow:setFollowTarget(slot5.cameraFollowTargetComp, true)
	end
end

function slot0._onFollowCharacterSelectChanged(slot0, slot1)
	if not slot0._characterIdList or slot1 == 0 then
		return
	end

	if not slot0:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	if GameSceneMgr.instance:getCurScene().charactermgr:getUnit(RoomCharacterEntity:getTag(), slot0._characterIdList[slot1]) then
		slot4.cameraFollow:setFollowTarget(slot5.cameraFollowTargetComp, false)
	end
end

function slot0._ontransporQuickLinkChange(slot0)
	RoomTransportPathQuickLinkViewUI._IsShow_ = RoomTransportPathQuickLinkViewUI._IsShow_ ~= true
end

function slot0._checkScene(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and GameSceneMgr.instance:getCurScene() ~= nil then
		return true
	end

	return false
end

function slot0._checkObMode(slot0, slot1)
	return slot0:_checkScene() and RoomController.instance:isObMode()
end

function slot0._checkEditMode(slot0, slot1)
	return slot0:_checkScene() and RoomController.instance:isEditMode()
end

function slot0._onBlockUseStateSelectChanged(slot0, slot1)
	if slot1 == 0 then
		return
	end

	if not slot0:_checkEditMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")

		return
	end

	slot4 = {}

	for slot9, slot10 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
		slot10:setUseState(slot1)

		if GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(slot10.id, SceneTag.RoomMapBlock) then
			table.insert(slot4, slot11)
		end
	end

	RoomBlockHelper.refreshBlockEntity(slot4, "refreshLand")
	GameFacade.showToast(ToastEnum.IconId, string.format("GM index:%s, entityCount:%s blockCount:%s", slot1, #slot4, #slot5))
end

function slot0._onRoomClockSelectChanged(slot0, slot1)
	if slot1 >= 1 or slot1 <= 24 then
		RoomMapController.instance:dispatchEvent(RoomEvent.OnHourReporting, slot1)
	end
end

function slot0._onOpenMiniMapView(slot0)
	if CritterModel.instance:getMaturityCritters() and #slot1 > 0 then
		RoomCritterController.instance:openTrainReporView(slot1[1].uid, 3025)
	end

	for slot6, slot7 in ipairs(CritterModel.instance:getCultivatingCritters()) do
		slot8 = slot7.trainInfo

		logError(string.format("uid:%s,sTime:%s,eTime:%s,fTime:%s,curTime:%s", slot7.uid, slot8.startTime, slot8.endTime, slot8.fastForwardTime, ServerTime.now()))
	end
end

function slot0._onOpenEditPathView(slot0)
	if slot0:_checkScene() then
		ViewMgr.instance:openView(ViewName.RoomTransportPathView)
		slot0:closeThis()
	else
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")
	end
end

function slot0._findCharacterShadow(slot0)
	for slot7, slot8 in ipairs(lua_room_character.configList or {}) do
		if not string.nilorempty(slot8.shadow) and not ({
			shadow = true
		})[slot8.shadow] and SkinConfig.instance:getSkinCo(slot8.skinId) and not string.nilorempty(slot9.spine) then
			slot10 = string.split(slot9.spine, "/")
		end
	end

	logError(JsonUtil.encode({
		[string.format("%s_room", slot10[#slot10])] = slot8.shadow
	}))
end

function slot0.onDestroyView(slot0)
end

return slot0
