module("modules.logic.gm.view.GMSubViewRoom", package.seeall)

local var_0_0 = class("GMSubViewRoom", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "荒原"
end

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._isInit then
		return
	end

	arg_2_0._isInit = true

	local var_2_0 = "L1"
	local var_2_1 = {
		"选择时间"
	}

	for iter_2_0 = 1, 24 do
		table.insert(var_2_1, iter_2_0 .. "时")
	end

	arg_2_0._dropRoomClock = arg_2_0:addDropDown(var_2_0, "小屋时\n钟触发", var_2_1, arg_2_0._onRoomClockSelectChanged, arg_2_0)

	local var_2_2, var_2_3 = arg_2_0:_findInitFollowTargetParams()

	arg_2_0._dropFollowTarget = arg_2_0:addDropDown(var_2_0, "乘坐交通", var_2_2, arg_2_0._onFollowTargetSelectChanged, arg_2_0)
	arg_2_0._vehicleIdList = var_2_3

	local var_2_4, var_2_5 = arg_2_0:_findInitFollowCharacterParams()

	arg_2_0._dropFollowCharacter = arg_2_0:addDropDown(var_2_0, "角色镜\n头跟随", var_2_4, arg_2_0._onFollowCharacterSelectChanged, arg_2_0)
	arg_2_0._characterIdList = var_2_5

	local var_2_6 = "L2"

	arg_2_0:addDropDown(var_2_6, "地块用途", {
		"地块用途选择",
		"正常",
		"货运"
	}, arg_2_0._onBlockUseStateSelectChanged, arg_2_0)

	local var_2_7 = "L3"

	arg_2_0:addButton(var_2_7, "mini地图", arg_2_0._onOpenMiniMapView, arg_2_0)
	arg_2_0:addButton(var_2_7, "货运编辑", arg_2_0._onOpenEditPathView, arg_2_0)

	arg_2_0._transporQuickLinkToggle = arg_2_0:addToggle(var_2_7, "调试运输路线【快速绘制】", arg_2_0._ontransporQuickLinkChange, arg_2_0)
	arg_2_0._transporQuickLinkToggle.isOn = RoomTransportPathQuickLinkViewUI._IsShow_ == true

	if RoomController.instance:isEditMode() and GameResMgr.IsFromEditorDir then
		RoomDebugController.instance:getDebugPackageInfo(arg_2_0._onInitDebugMapPackageInfo, arg_2_0)
	end
end

function var_0_0._findInitFollowTargetParams(arg_3_0)
	return arg_3_0:_findObMOList("选择交通", RoomMapVehicleModel.instance:getList(), "config")
end

function var_0_0._findInitFollowCharacterParams(arg_4_0)
	return arg_4_0:_findObMOList("选择角色", RoomCharacterModel.instance:getList(), "skinConfig")
end

function var_0_0._findObMOList(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0:_checkObMode() then
		arg_5_2 = nil
	end

	return arg_5_0:_findMOList(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0._findMOList(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {
		arg_6_1 .. "#id-选择"
	}
	local var_6_1 = {}

	if arg_6_2 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
			if iter_6_1 and iter_6_1[arg_6_3] then
				table.insert(var_6_0, string.format("%s#%s", iter_6_1[arg_6_3].name, iter_6_1.id))
				table.insert(var_6_1, iter_6_1.id)
			end
		end
	end

	return var_6_0, var_6_1
end

function var_0_0._sortCharacterInteractionFunc(arg_7_0, arg_7_1)
	if arg_7_0.behaviour ~= arg_7_1.behaviour then
		return arg_7_0.behaviour < arg_7_1.behaviour
	end
end

function var_0_0._finInitCharacterInteractParams(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(lua_room_character_interaction.configList) do
		local var_8_1 = RoomCharacterModel.instance:getCharacterMOById(iter_8_1.heroId)

		if var_8_1 and var_8_1.characterState == RoomCharacterEnum.CharacterState.Map then
			table.insert(var_8_0, iter_8_1)
		end
	end

	table.sort(var_8_0, GMToolView._sortCharacterInteractionFunc)

	local var_8_2 = {}
	local var_8_3 = {
		[RoomCharacterEnum.InteractionType.Dialog] = "对话",
		[RoomCharacterEnum.InteractionType.Building] = "建筑"
	}

	table.insert(var_8_2, "英雄-交互#id选择")

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		if var_8_3[iter_8_3.behaviour] then
			local var_8_4 = HeroConfig.instance:getHeroCO(iter_8_3.heroId)
			local var_8_5 = string.format("%s-%s#%s", var_8_4.name or iter_8_3.heroId, var_8_3[iter_8_3.behaviour], iter_8_3.id)

			table.insert(var_8_2, var_8_5)
		end
	end

	return var_8_0
end

function var_0_0._onFollowTargetSelectChanged(arg_9_0, arg_9_1)
	if not arg_9_0._vehicleIdList or arg_9_1 == 0 then
		return
	end

	if not arg_9_0:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	GameFacade.showToast(ToastEnum.IconId, "乘坐交通工具")

	local var_9_0 = arg_9_0._vehicleIdList[arg_9_1]
	local var_9_1 = RoomMapVehicleEntity:getTag()
	local var_9_2 = GameSceneMgr.instance:getCurScene()
	local var_9_3 = var_9_2.vehiclemgr:getUnit(var_9_1, var_9_0)

	if var_9_3 then
		var_9_2.cameraFollow:setFollowTarget(var_9_3.cameraFollowTargetComp, true)
	end
end

function var_0_0._onFollowCharacterSelectChanged(arg_10_0, arg_10_1)
	if not arg_10_0._characterIdList or arg_10_1 == 0 then
		return
	end

	if not arg_10_0:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	local var_10_0 = RoomCharacterEntity:getTag()
	local var_10_1 = arg_10_0._characterIdList[arg_10_1]
	local var_10_2 = GameSceneMgr.instance:getCurScene()
	local var_10_3 = var_10_2.charactermgr:getUnit(var_10_0, var_10_1)

	if var_10_3 then
		var_10_2.cameraFollow:setFollowTarget(var_10_3.cameraFollowTargetComp, false)
	end
end

function var_0_0._ontransporQuickLinkChange(arg_11_0)
	RoomTransportPathQuickLinkViewUI._IsShow_ = RoomTransportPathQuickLinkViewUI._IsShow_ ~= true
end

function var_0_0._checkScene(arg_12_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and GameSceneMgr.instance:getCurScene() ~= nil then
		return true
	end

	return false
end

function var_0_0._checkObMode(arg_13_0, arg_13_1)
	return arg_13_0:_checkScene() and RoomController.instance:isObMode()
end

function var_0_0._checkEditMode(arg_14_0, arg_14_1)
	return arg_14_0:_checkScene() and RoomController.instance:isEditMode()
end

function var_0_0._onBlockUseStateSelectChanged(arg_15_0, arg_15_1)
	if arg_15_1 == 0 then
		return
	end

	if not arg_15_0:_checkEditMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")

		return
	end

	local var_15_0 = GameSceneMgr.instance:getCurScene().mapmgr
	local var_15_1 = {}
	local var_15_2 = RoomMapBlockModel.instance:getFullBlockMOList()

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		iter_15_1:setUseState(arg_15_1)

		local var_15_3 = var_15_0:getBlockEntity(iter_15_1.id, SceneTag.RoomMapBlock)

		if var_15_3 then
			table.insert(var_15_1, var_15_3)
		end
	end

	RoomBlockHelper.refreshBlockEntity(var_15_1, "refreshLand")
	GameFacade.showToast(ToastEnum.IconId, string.format("GM index:%s, entityCount:%s blockCount:%s", arg_15_1, #var_15_1, #var_15_2))
end

function var_0_0._onRoomClockSelectChanged(arg_16_0, arg_16_1)
	if arg_16_1 >= 1 or arg_16_1 <= 24 then
		RoomMapController.instance:dispatchEvent(RoomEvent.OnHourReporting, arg_16_1)
	end
end

function var_0_0._onInitDebugMapPackageInfo(arg_17_0, arg_17_1)
	local var_17_0 = {
		"选择需要复制的地图"
	}

	arg_17_0._blockInfosList = {}

	local var_17_1 = RoomConfig.instance

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_2 = {}

		for iter_17_2, iter_17_3 in ipairs(iter_17_1.infos) do
			if var_17_1:getBlock(iter_17_3.blockId) and not var_17_1:getInitBlock(iter_17_3.blockId) then
				table.insert(var_17_2, iter_17_3)
			end
		end

		if #var_17_2 > 1 then
			table.insert(var_17_0, iter_17_1.packageName)
			table.insert(arg_17_0._blockInfosList, var_17_2)
		end
	end

	arg_17_0:addDropDown("L2", "一键复制\n地图地块", var_17_0, arg_17_0._onDropDownMapPackageChanged, arg_17_0)
end

var_0_0.Drop_Down_Map_Package_Changed = "GMSubViewRoom.Drop_Down_Map_Package_Changed"

function var_0_0._onDropDownMapPackageChanged(arg_18_0, arg_18_1)
	if arg_18_1 >= 1 or arg_18_1 <= #arg_18_0._blockInfosList then
		if RoomMapBlockModel.instance:getConfirmBlockCount() > 0 then
			GameFacade.showToast(ToastEnum.IconId, "需要先重置下荒原")

			return
		end

		arg_18_0._waitUseBlockList = {}

		tabletool.addValues(arg_18_0._waitUseBlockList, arg_18_0._blockInfosList[arg_18_1])
		TaskDispatcher.cancelTask(arg_18_0._onWaitUseBlockList, arg_18_0)

		if #arg_18_0._waitUseBlockList > 0 then
			UIBlockMgr.instance:startBlock(var_0_0.Drop_Down_Map_Package_Changed)
			TaskDispatcher.runRepeat(arg_18_0._onWaitUseBlockList, arg_18_0, 0.001, #arg_18_0._waitUseBlockList + 1)
		end
	end
end

function var_0_0._onWaitUseBlockList(arg_19_0)
	if arg_19_0._waitUseBlockList and #arg_19_0._waitUseBlockList > 0 then
		local var_19_0 = arg_19_0._waitUseBlockList[#arg_19_0._waitUseBlockList]

		table.remove(arg_19_0._waitUseBlockList, #arg_19_0._waitUseBlockList)
		RoomMapController.instance:useBlockRequest(var_19_0.blockId, var_19_0.rotate, var_19_0.x, var_19_0.y)
	else
		UIBlockMgr.instance:endBlock(var_0_0.Drop_Down_Map_Package_Changed)
		RoomController.instance:exitRoom(true)
	end
end

function var_0_0._onOpenMiniMapView(arg_20_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
		itemList = {
			{
				itemId = 11921,
				itemType = MaterialEnum.MaterialType.Building
			}
		}
	})
end

function var_0_0._onOpenEditPathView(arg_21_0)
	if arg_21_0:_checkScene() then
		ViewMgr.instance:openView(ViewName.RoomTransportPathView)
		arg_21_0:closeThis()
	else
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")
	end
end

function var_0_0._findCharacterShadow(arg_22_0)
	local var_22_0 = lua_room_character.configList or {}
	local var_22_1 = {}
	local var_22_2 = {
		shadow = true
	}

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if not string.nilorempty(iter_22_1.shadow) and not var_22_2[iter_22_1.shadow] then
			local var_22_3 = SkinConfig.instance:getSkinCo(iter_22_1.skinId)

			if var_22_3 and not string.nilorempty(var_22_3.spine) then
				local var_22_4 = string.split(var_22_3.spine, "/")

				var_22_1[string.format("%s_room", var_22_4[#var_22_4])] = iter_22_1.shadow
			end
		end
	end

	logError(JsonUtil.encode(var_22_1))
end

function var_0_0.onDestroyView(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onWaitUseBlockList, arg_23_0)
end

return var_0_0
