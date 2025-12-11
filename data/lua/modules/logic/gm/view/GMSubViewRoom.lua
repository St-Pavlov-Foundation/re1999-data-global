module("modules.logic.gm.view.GMSubViewRoom", package.seeall)

local var_0_0 = class("GMSubViewRoom", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "荒原"
end

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._isInit then
		return
	end

	arg_2_0:_initL1()
	arg_2_0:_initL2()
	arg_2_0:_initL3()
	arg_2_0:_initL4()
	arg_2_0:_initL5()
	arg_2_0:_initL6()
	arg_2_0:_initL7()
	arg_2_0:_initL8()
	arg_2_0:_initL9()

	arg_2_0._isInit = true
end

function var_0_0._initL1(arg_3_0)
	local var_3_0 = "L1"

	arg_3_0:addButton(var_3_0, "小屋观察", arg_3_0._onClickBtnRoomOb, arg_3_0)
	arg_3_0:addButton(var_3_0, "小屋编辑", arg_3_0._onClickBtnRoomMap, arg_3_0)
	arg_3_0:addButton(var_3_0, "小屋Debug", arg_3_0._onClickBtnRoomDebug, arg_3_0)
	arg_3_0:addButton(var_3_0, "小屋建筑占地", arg_3_0._onClickRoomDebugBuildingArea, arg_3_0)
end

function var_0_0._onClickBtnRoomOb(arg_4_0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
end

function var_0_0._onClickBtnRoomMap(arg_5_0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
end

function var_0_0._onClickBtnRoomDebug(arg_6_0)
	ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
end

function var_0_0._onClickRoomDebugBuildingArea(arg_7_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomDebugController.instance:openBuildingAreaView()
	else
		GameFacade.showToast(94, "GM需要进入小屋后使用。")
	end
end

function var_0_0._initL2(arg_8_0)
	local var_8_0 = "L2"
	local var_8_1 = arg_8_0:addSlider(var_8_0, "QE灵敏度", arg_8_0._onRoomRotateSpeedChange, arg_8_0, {
		w = 610
	})

	arg_8_0._txtRoomRotateSpeed = var_8_1[3]

	local var_8_2 = (RoomController.instance.rotateSpeed - 0.2) / 1.8

	var_8_1[1]:SetValue(var_8_2)
	arg_8_0:_onRoomRotateSpeedChange(nil, var_8_2)

	local var_8_3 = arg_8_0:addSlider(var_8_0, "WASD灵敏度", arg_8_0._onRoomMoveSpeedChange, arg_8_0, {
		w = 685
	})

	arg_8_0._txtRoomMoveSpeed = var_8_3[3]

	local var_8_4 = (RoomController.instance.moveSpeed - 0.2) / 1.8

	var_8_3[1]:SetValue(var_8_4)
	arg_8_0:_onRoomMoveSpeedChange(nil, var_8_4)
end

function var_0_0._initL3(arg_9_0)
	local var_9_0 = "L3"
	local var_9_1 = arg_9_0:addSlider(var_9_0, "RF灵敏度", arg_9_0._onRoomScaleSpeedChange, arg_9_0, {
		w = 610
	})

	arg_9_0._txtRoomScaleSpeed = var_9_1[3]

	local var_9_2 = (RoomController.instance.scaleSpeed - 0.2) / 1.8

	var_9_1[1]:SetValue(var_9_2)
	arg_9_0:_onRoomScaleSpeedChange(nil, var_9_2)

	local var_9_3 = arg_9_0:addSlider(var_9_0, "滑屏灵敏度", arg_9_0._onRoomTouchSpeedChange, arg_9_0, {
		w = 685
	})

	arg_9_0._txtRoomTouchSpeed = var_9_3[3]

	local var_9_4 = (RoomController.instance.touchMoveSpeed - 0.2) / 1.8

	var_9_3[1]:SetValue((RoomController.instance.touchMoveSpeed - 0.2) / 1.8)
	arg_9_0:_onRoomTouchSpeedChange(nil, var_9_4)
end

function var_0_0._onRoomRotateSpeedChange(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0.2 + 1.8 * arg_10_2

	RoomController.instance.rotateSpeed = var_10_0
	arg_10_0._txtRoomRotateSpeed.text = string.format("%.2f", var_10_0)
end

function var_0_0._onRoomMoveSpeedChange(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = 0.2 + 1.8 * arg_11_2

	RoomController.instance.moveSpeed = var_11_0
	arg_11_0._txtRoomMoveSpeed.text = string.format("%.2f", var_11_0)
end

function var_0_0._onRoomScaleSpeedChange(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = 0.2 + 1.8 * arg_12_2

	RoomController.instance.scaleSpeed = var_12_0
	arg_12_0._txtRoomScaleSpeed.text = string.format("%.2f", var_12_0)
end

function var_0_0._onRoomTouchSpeedChange(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = 0.2 + 1.8 * arg_13_2

	RoomController.instance.touchMoveSpeed = var_13_0
	arg_13_0._txtRoomTouchSpeed.text = string.format("%.2f", var_13_0)
end

function var_0_0._sortCharacterInteractionFunc(arg_14_0, arg_14_1)
	if arg_14_0.behaviour ~= arg_14_1.behaviour then
		return arg_14_0.behaviour < arg_14_1.behaviour
	end
end

function var_0_0._initL4(arg_15_0)
	local var_15_0 = "L4"

	if not arg_15_0.characterInteractionList then
		arg_15_0.characterInteractionList = {}

		for iter_15_0, iter_15_1 in ipairs(lua_room_character_interaction.configList) do
			local var_15_1 = RoomCharacterModel.instance:getCharacterMOById(iter_15_1.heroId)

			if var_15_1 and var_15_1.characterState == RoomCharacterEnum.CharacterState.Map then
				table.insert(arg_15_0.characterInteractionList, iter_15_1)
			end
		end

		table.sort(arg_15_0.characterInteractionList, var_0_0._sortCharacterInteractionFunc)
	end

	local var_15_2 = {}
	local var_15_3 = {
		[RoomCharacterEnum.InteractionType.Dialog] = "对话",
		[RoomCharacterEnum.InteractionType.Building] = "建筑"
	}

	table.insert(var_15_2, "英雄-交互#id选择")

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.characterInteractionList) do
		if var_15_3[iter_15_3.behaviour] then
			local var_15_4 = HeroConfig.instance:getHeroCO(iter_15_3.heroId)
			local var_15_5 = string.format("%s-%s#%s", var_15_4.name or iter_15_3.heroId, var_15_3[iter_15_3.behaviour], iter_15_3.id)

			table.insert(var_15_2, var_15_5)
		end
	end

	arg_15_0:addDropDown(var_15_0, "小屋角色交互", var_15_2, arg_15_0._onRoomInteractionSelectChanged, arg_15_0, {
		tempH = 450,
		total_w = 650,
		drop_w = 415
	})
	arg_15_0:addButton(var_15_0, "确定", arg_15_0._onClickRoomInteractionOk, arg_15_0)

	local var_15_6 = {
		"选择时间"
	}

	for iter_15_4 = 1, 24 do
		table.insert(var_15_6, iter_15_4 .. "时")
	end

	arg_15_0:addDropDown(var_15_0, "小屋时钟触发", var_15_6, arg_15_0._onRoomClockSelectChanged, arg_15_0, {
		total_w = 600,
		tempH = 450
	})
end

function var_0_0._onRoomInteractionSelectChanged(arg_16_0, arg_16_1)
	if not arg_16_0.characterInteractionList then
		return
	end

	if arg_16_1 == 0 then
		arg_16_0.selectCharacterInteractionCfg = nil

		return
	end

	arg_16_0.selectCharacterInteractionCfg = arg_16_0.characterInteractionList[arg_16_1]
end

function var_0_0._onClickRoomInteractionOk(arg_17_0)
	if #arg_17_0.characterInteractionList < 1 then
		GameFacade.showToast(94, "GM需要进入小屋并放置可交互角色。")
	end

	if not arg_17_0.selectCharacterInteractionCfg then
		return
	end

	local var_17_0 = RoomCharacterModel.instance:getCharacterMOById(arg_17_0.selectCharacterInteractionCfg.heroId)

	if not var_17_0 or var_17_0.characterState ~= RoomCharacterEnum.CharacterState.Map then
		GameFacade.showToast(94, "GM 需要放置角色后可交互。")

		return
	end

	if arg_17_0.selectCharacterInteractionCfg.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		GameFacade.showToast(94, string.format("GM %s 触发交互", var_17_0.heroConfig.name))
		var_17_0:setCurrentInteractionId(arg_17_0.selectCharacterInteractionCfg.id)
		RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
	elseif arg_17_0.selectCharacterInteractionCfg.behaviour == RoomCharacterEnum.InteractionType.Building then
		local var_17_1 = RoomMapInteractionModel.instance:getBuildingInteractionMO(arg_17_0.selectCharacterInteractionCfg.id)
		local var_17_2 = RoomConfig.instance:getBuildingConfig(arg_17_0.selectCharacterInteractionCfg.buildingId)
		local var_17_3 = var_17_2 and var_17_2.name or arg_17_0.selectCharacterInteractionCfg.buildingId

		if not var_17_1 then
			GameFacade.showToast(94, string.format("GM 场景无【%s】建筑，【%s】无发交互", var_17_3, var_17_0.heroConfig.name))

			return
		end

		if not RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) then
			GameFacade.showToast(94, string.format("GM 当场景状态机非[%s]", RoomEnum.FSMObState.Idle))

			return
		end

		if not RoomInteractionController.instance:showTimeByInteractionMO(var_17_1) then
			GameFacade.showToast(94, string.format("GM【%s】不在【%s】交互点范围内", var_17_0.heroConfig.name, var_17_3))

			return
		end

		arg_17_0:closeThis()
		logNormal(string.format("GM【%s】【%s】触发角色建筑交互", var_17_0.heroConfig.name, var_17_3))
	end
end

function var_0_0._onRoomClockSelectChanged(arg_18_0, arg_18_1)
	if arg_18_1 >= 1 or arg_18_1 <= 24 then
		RoomMapController.instance:dispatchEvent(RoomEvent.OnHourReporting, arg_18_1)
	end
end

function var_0_0._checkScene(arg_19_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and GameSceneMgr.instance:getCurScene() ~= nil then
		return true
	end

	return false
end

function var_0_0._checkObMode(arg_20_0, arg_20_1)
	return arg_20_0:_checkScene() and RoomController.instance:isObMode()
end

function var_0_0._checkEditMode(arg_21_0, arg_21_1)
	return arg_21_0:_checkScene() and RoomController.instance:isEditMode()
end

function var_0_0._findObMOList(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not arg_22_0:_checkObMode() then
		arg_22_2 = nil
	end

	return arg_22_0:_findMOList(arg_22_1, arg_22_2, arg_22_3)
end

function var_0_0._findMOList(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = {
		arg_23_1 .. "#id-选择"
	}
	local var_23_1 = {}

	if arg_23_2 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_2) do
			if iter_23_1 and iter_23_1[arg_23_3] then
				table.insert(var_23_0, string.format("%s#%s", iter_23_1[arg_23_3].name, iter_23_1.id))
				table.insert(var_23_1, iter_23_1.id)
			end
		end
	end

	return var_23_0, var_23_1
end

function var_0_0._initL5(arg_24_0)
	local var_24_0 = "L5"
	local var_24_1, var_24_2 = arg_24_0:_findInitFollowCharacterParams()

	arg_24_0._dropFollowCharacter = arg_24_0:addDropDown(var_24_0, "角色镜头跟随", var_24_1, arg_24_0._onFollowCharacterSelectChanged, arg_24_0, {
		total_w = 650,
		drop_w = 415
	})
	arg_24_0._characterIdList = var_24_2

	arg_24_0:addButton(var_24_0, "小屋交互镜头", arg_24_0._onClickRoomBuildingCamera, arg_24_0)
	arg_24_0:addButton(var_24_0, "清空角色交互数据", arg_24_0._onClickRoomClearInteractionData, arg_24_0)
end

function var_0_0._findInitFollowCharacterParams(arg_25_0)
	return arg_25_0:_findObMOList("选择角色", RoomCharacterModel.instance:getList(), "skinConfig")
end

function var_0_0._onFollowCharacterSelectChanged(arg_26_0, arg_26_1)
	if not arg_26_0._characterIdList or arg_26_1 == 0 then
		return
	end

	if not arg_26_0:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	local var_26_0 = RoomCharacterEntity:getTag()
	local var_26_1 = arg_26_0._characterIdList[arg_26_1]
	local var_26_2 = GameSceneMgr.instance:getCurScene()
	local var_26_3 = var_26_2.charactermgr:getUnit(var_26_0, var_26_1)

	if var_26_3 then
		var_26_2.cameraFollow:setFollowTarget(var_26_3.cameraFollowTargetComp, false)
	end
end

function var_0_0._onClickRoomBuildingCamera(arg_27_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomDebugController.instance:openBuildingCamerView()
		arg_27_0:closeThis()
	else
		GameFacade.showToast(94, "GM需要进入小屋后使用。")
	end
end

local var_0_1 = 46

function var_0_0._onClickRoomClearInteractionData(arg_28_0)
	local var_28_0 = lua_gm_command.configDict[var_0_1]

	if var_28_0 then
		local var_28_1 = var_28_0.command

		GameFacade.showToast(ToastEnum.IconId, var_28_1)
		GMRpc.instance:sendGMRequest(var_28_1)
	end
end

function var_0_0._initL6(arg_29_0)
	local var_29_0 = "L6"
	local var_29_1, var_29_2 = arg_29_0:_findInitFollowTargetParams()

	arg_29_0._dropFollowTarget = arg_29_0:addDropDown(var_29_0, "乘坐交通", var_29_1, arg_29_0._onFollowTargetSelectChanged, arg_29_0, {
		total_w = 650,
		drop_w = 415
	})
	arg_29_0._vehicleIdList = var_29_2

	arg_29_0:addDropDown(var_29_0, "地块用途", {
		"地块用途选择",
		"正常",
		"货运"
	}, arg_29_0._onBlockUseStateSelectChanged, arg_29_0, {
		total_w = 600,
		drop_w = 415
	})
end

function var_0_0._findInitFollowTargetParams(arg_30_0)
	return arg_30_0:_findObMOList("选择交通", RoomMapVehicleModel.instance:getList(), "config")
end

function var_0_0._onFollowTargetSelectChanged(arg_31_0, arg_31_1)
	if not arg_31_0._vehicleIdList or arg_31_1 == 0 then
		return
	end

	if not arg_31_0:_checkObMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后观察模式下使用。")

		return
	end

	GameFacade.showToast(ToastEnum.IconId, "乘坐交通工具")

	local var_31_0 = arg_31_0._vehicleIdList[arg_31_1]
	local var_31_1 = RoomMapVehicleEntity:getTag()
	local var_31_2 = GameSceneMgr.instance:getCurScene()
	local var_31_3 = var_31_2.vehiclemgr:getUnit(var_31_1, var_31_0)

	if var_31_3 then
		var_31_2.cameraFollow:setFollowTarget(var_31_3.cameraFollowTargetComp, true)
	end
end

function var_0_0._onBlockUseStateSelectChanged(arg_32_0, arg_32_1)
	if arg_32_1 == 0 then
		return
	end

	if not arg_32_0:_checkEditMode() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")

		return
	end

	local var_32_0 = GameSceneMgr.instance:getCurScene().mapmgr
	local var_32_1 = {}
	local var_32_2 = RoomMapBlockModel.instance:getFullBlockMOList()

	for iter_32_0, iter_32_1 in ipairs(var_32_2) do
		iter_32_1:setUseState(arg_32_1)

		local var_32_3 = var_32_0:getBlockEntity(iter_32_1.id, SceneTag.RoomMapBlock)

		if var_32_3 then
			table.insert(var_32_1, var_32_3)
		end
	end

	RoomBlockHelper.refreshBlockEntity(var_32_1, "refreshLand")
	GameFacade.showToast(ToastEnum.IconId, string.format("GM index:%s, entityCount:%s blockCount:%s", arg_32_1, #var_32_1, #var_32_2))
end

function var_0_0._initL7(arg_33_0)
	local var_33_0 = "L7"

	arg_33_0:addButton(var_33_0, "交通工具测试", arg_33_0._onClickTestVehicle, arg_33_0)
	arg_33_0:addButton(var_33_0, "mini地图", arg_33_0._onOpenMiniMapView, arg_33_0)
	arg_33_0:addButton(var_33_0, "货运编辑", arg_33_0._onOpenEditPathView, arg_33_0)

	arg_33_0._transporQuickLinkToggle = arg_33_0:addToggle(var_33_0, "调试运输路线【快速绘制】", arg_33_0._ontransporQuickLinkChange, arg_33_0)
	arg_33_0._transporQuickLinkToggle.isOn = RoomTransportPathQuickLinkViewUI._IsShow_ == true
end

function var_0_0._onClickTestVehicle(arg_34_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and RoomController.instance:isObMode() then
		local var_34_0 = RoomMapVehicleEntity:getTag()
		local var_34_1 = RoomMapVehicleModel.instance:getList()
		local var_34_2 = GameSceneMgr.instance:getCurScene()

		for iter_34_0, iter_34_1 in ipairs(var_34_1) do
			local var_34_3 = var_34_2.vehiclemgr:getUnit(var_34_0, iter_34_1.id)

			if var_34_3 then
				var_34_2.cameraFollow:setFollowTarget(var_34_3.cameraFollowTargetComp)

				return
			end
		end

		GameFacade.showToast(94, "GM交通工具数量：" .. #var_34_1)
	else
		GameFacade.showToast(94, "GM需要进入小屋后观察模式下使用。")
	end
end

function var_0_0._onOpenMiniMapView(arg_35_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
		itemList = {
			{
				itemId = 11921,
				itemType = MaterialEnum.MaterialType.Building
			}
		}
	})
end

function var_0_0._onOpenEditPathView(arg_36_0)
	if arg_36_0:_checkScene() then
		ViewMgr.instance:openView(ViewName.RoomTransportPathView)
		arg_36_0:closeThis()
	else
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋后编辑模式下使用。")
	end
end

function var_0_0._ontransporQuickLinkChange(arg_37_0)
	RoomTransportPathQuickLinkViewUI._IsShow_ = RoomTransportPathQuickLinkViewUI._IsShow_ ~= true
end

function var_0_0._initL8(arg_38_0)
	local var_38_0 = "L8"

	arg_38_0.roomWeatherIdList = {}

	local var_38_1 = RoomConfig.instance:getSceneAmbientConfigList()

	for iter_38_0, iter_38_1 in ipairs(var_38_1) do
		table.insert(arg_38_0.roomWeatherIdList, iter_38_1.id)
	end

	local var_38_2 = {
		"请选择天气"
	}

	tabletool.addValues(var_38_2, arg_38_0.roomWeatherIdList)
	arg_38_0:addDropDown(var_38_0, "小屋天气", var_38_2, arg_38_0._onRoomWeatherSelectChanged, arg_38_0, {
		total_w = 500,
		drop_w = 330
	})

	if RoomController.instance:isEditMode() and GameResMgr.IsFromEditorDir then
		RoomDebugController.instance:getDebugPackageInfo(arg_38_0._onInitDebugMapPackageInfo, arg_38_0, var_38_0)
	end
end

function var_0_0._onRoomWeatherSelectChanged(arg_39_0, arg_39_1)
	if not arg_39_0.roomWeatherIdList then
		return
	end

	if arg_39_1 == 0 then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		local var_39_0 = GameSceneMgr.instance:getCurScene()

		if var_39_0 and var_39_0.ambient then
			local var_39_1 = arg_39_0.roomWeatherIdList[arg_39_1]

			var_39_0.ambient:tweenToAmbientId(var_39_1)
			GameFacade.showToast(94, string.format("GM切换小屋天气:%s", var_39_1))
			arg_39_0:closeThis()
		end
	else
		GameFacade.showToast(94, "GM需要进入小屋可使用。")
	end
end

function var_0_0._onInitDebugMapPackageInfo(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {
		"选择需要复制的地图"
	}

	arg_40_0._blockInfosList = {}

	local var_40_1 = RoomConfig.instance

	for iter_40_0, iter_40_1 in ipairs(arg_40_1) do
		local var_40_2 = {}

		for iter_40_2, iter_40_3 in ipairs(iter_40_1.infos) do
			local var_40_3 = HexPoint(iter_40_3.x, iter_40_3.y)
			local var_40_4 = RoomBlockHelper.isInBoundary(var_40_3)

			if var_40_1:getBlock(iter_40_3.blockId) and not var_40_1:getInitBlock(iter_40_3.blockId) and var_40_4 then
				table.insert(var_40_2, iter_40_3)
			end
		end

		if #var_40_2 > 1 then
			table.insert(var_40_0, iter_40_1.packageName)
			table.insert(arg_40_0._blockInfosList, var_40_2)
		end
	end

	arg_40_0:addDropDown(arg_40_2, "一键复制地图地块", var_40_0, arg_40_0._onDropDownMapPackageChanged, arg_40_0, {
		total_w = 750,
		drop_w = 450
	})
end

var_0_0.Drop_Down_Map_Package_Changed = "GMSubViewRoom.Drop_Down_Map_Package_Changed"

function var_0_0._onDropDownMapPackageChanged(arg_41_0, arg_41_1)
	if arg_41_1 >= 1 or arg_41_1 <= #arg_41_0._blockInfosList then
		if RoomMapBlockModel.instance:getConfirmBlockCount() > 0 then
			GameFacade.showToast(ToastEnum.IconId, "需要先重置下荒原")

			return
		end

		arg_41_0._waitUseBlockList = {}

		tabletool.addValues(arg_41_0._waitUseBlockList, arg_41_0._blockInfosList[arg_41_1])
		TaskDispatcher.cancelTask(arg_41_0._onWaitUseBlockList, arg_41_0)

		if #arg_41_0._waitUseBlockList > 0 then
			UIBlockMgr.instance:startBlock(var_0_0.Drop_Down_Map_Package_Changed)
			TaskDispatcher.runRepeat(arg_41_0._onWaitUseBlockList, arg_41_0, 0.001, #arg_41_0._waitUseBlockList + 1)
		end
	end
end

function var_0_0._onWaitUseBlockList(arg_42_0)
	if arg_42_0._waitUseBlockList and #arg_42_0._waitUseBlockList > 0 then
		local var_42_0 = arg_42_0._waitUseBlockList[#arg_42_0._waitUseBlockList]

		table.remove(arg_42_0._waitUseBlockList, #arg_42_0._waitUseBlockList)
		RoomMapController.instance:useBlockRequest(var_42_0.blockId, var_42_0.rotate, var_42_0.x, var_42_0.y)
	else
		UIBlockMgr.instance:endBlock(var_0_0.Drop_Down_Map_Package_Changed)
		RoomController.instance:exitRoom(true)
	end
end

function var_0_0._findCharacterShadow(arg_43_0)
	local var_43_0 = lua_room_character.configList or {}
	local var_43_1 = {}
	local var_43_2 = {
		shadow = true
	}

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if not string.nilorempty(iter_43_1.shadow) and not var_43_2[iter_43_1.shadow] then
			local var_43_3 = SkinConfig.instance:getSkinCo(iter_43_1.skinId)

			if var_43_3 and not string.nilorempty(var_43_3.spine) then
				local var_43_4 = string.split(var_43_3.spine, "/")

				var_43_1[string.format("%s_room", var_43_4[#var_43_4])] = iter_43_1.shadow
			end
		end
	end

	logError(JsonUtil.encode(var_43_1))
end

function var_0_0._initL9(arg_44_0)
	local var_44_0 = "L9"
	local var_44_1 = {
		"换色选择",
		"地块换色",
		"建筑换色"
	}

	arg_44_0:addDropDown(var_44_0, "小屋换色", var_44_1, arg_44_0._onRoomChangeMeshReaderColorChanged, arg_44_0, {
		total_w = 500,
		drop_w = 330
	})
end

function var_0_0._onRoomChangeMeshReaderColorChanged(arg_45_0, arg_45_1)
	if not arg_45_0:_checkScene() then
		GameFacade.showToast(ToastEnum.IconId, "GM需要进入小屋下使用。")

		return
	end

	local var_45_0 = {
		RoomEnum.EffectKey.BlockLandKey,
		RoomEnum.EffectKey.BlockRiverFloorKey,
		RoomEnum.EffectKey.BlockRiverKey
	}

	tabletool.addValues(var_45_0, RoomEnum.EffectKey.BlockFloorBKeys)
	tabletool.addValues(var_45_0, RoomEnum.EffectKey.BlockFloorBKeys)

	local var_45_1 = {
		RoomEnum.EffectKey.BuildingGOKey
	}
	local var_45_2 = {}
	local var_45_3 = {}
	local var_45_4 = GameSceneMgr.instance:getCurScene()

	LuaUtil.insertDict(var_45_2, var_45_4.mapmgr:getTagUnitDict(SceneTag.RoomMapBlock))
	LuaUtil.insertDict(var_45_3, var_45_4.buildingmgr:getTagUnitDict(SceneTag.RoomBuilding))
	arg_45_0:_setEntityListByEffectKeyList(var_45_2, var_45_0, arg_45_1 == 1)
	arg_45_0:_setEntityListByEffectKeyList(var_45_3, var_45_1, arg_45_1 == 2)
end

local var_0_2 = UnityEngine.Shader
local var_0_3 = "_ENABLE_CHANGE_COLOR"
local var_0_4 = {
	enableChangeColor = var_0_2.PropertyToID("_EnableChangeColor"),
	hue = var_0_2.PropertyToID("_Hue"),
	saturation = var_0_2.PropertyToID("_Saturation"),
	brightness = var_0_2.PropertyToID("_Brightness")
}

function var_0_0._setEntityListByEffectKeyList(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = GameSceneMgr.instance:getCurScene().mapmgr:getPropertyBlock()

	var_46_0:Clear()

	local var_46_1 = lua_room_block_color_param.configList
	local var_46_2 = #var_46_1
	local var_46_3 = 0

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		if arg_46_3 then
			var_46_3 = var_46_3 + 1

			if var_46_3 > #var_46_1 then
				var_46_3 = 1
			end

			local var_46_4 = var_46_1[var_46_3]
			local var_46_5 = math.floor(iter_46_0 % 200) * 0.01 - 1

			var_46_0:SetFloat(var_0_4.enableChangeColor, 1)
			var_46_0:SetFloat(var_0_4.hue, var_46_4.hue)
			var_46_0:SetFloat(var_0_4.saturation, var_46_4.saturation)
			var_46_0:SetFloat(var_0_4.brightness, var_46_4.brightness)
		end

		for iter_46_2, iter_46_3 in ipairs(arg_46_2) do
			arg_46_0:_setMeshReaderColor(iter_46_1.effect:getComponentsByPath(iter_46_3, RoomEnum.ComponentName.MeshRenderer, "mesh"), var_46_0, open)
		end
	end
end

function var_0_0._setMeshReaderColor(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	if arg_47_1 then
		for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
			iter_47_1:SetPropertyBlock(arg_47_2)
		end
	end
end

function var_0_0.onDestroyView(arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._onWaitUseBlockList, arg_48_0)
end

return var_0_0
