module("modules.logic.room.utils.RoomHelper", package.seeall)

local var_0_0 = {
	isFSMState = function(arg_1_0)
		return GameSceneMgr.instance:getCurScene().fsm:getCurStateName() == arg_1_0
	end
}

function var_0_0.isOutCameraFocusCenter(arg_2_0)
	return var_0_0._checkOutCameraFocus(arg_2_0.x, arg_2_0.y, 0.5, 300, 440, 300, 300)
end

function var_0_0.isOutCameraFocus(arg_3_0)
	return var_0_0._checkOutCameraFocus(arg_3_0.x, arg_3_0.y, 3.2, 300, 440, 300, 300)
end

function var_0_0.isOutCameraFocusByPlaceCharacter(arg_4_0, arg_4_1, arg_4_2)
	return var_0_0._checkOutCameraFocus(arg_4_0, arg_4_1, 3.2, 300, arg_4_2 or 440, 300, 300)
end

function var_0_0._checkOutCameraFocus(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	local var_5_0 = GameSceneMgr.instance:getCurScene().camera:getCameraFocus()

	if arg_5_2 < Vector2.Distance(var_5_0, Vector2(arg_5_0, arg_5_1)) then
		return true
	end

	return var_0_0._checkCameraFocusByPadding(arg_5_0, arg_5_1, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
end

function var_0_0._checkCameraFocusByPadding(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0 = Vector3(arg_6_0, 0, arg_6_1)
	local var_6_1 = RoomBendingHelper.worldToBendingSimple(var_6_0)
	local var_6_2 = ViewMgr.instance:getUILayer("HUD").transform
	local var_6_3 = var_6_1.x
	local var_6_4 = var_6_1.z
	local var_6_5 = Vector3(var_6_3, var_6_1.y, var_6_4)
	local var_6_6 = recthelper.worldPosToAnchorPos(var_6_5, var_6_2)
	local var_6_7 = recthelper.getWidth(var_6_2)
	local var_6_8 = recthelper.getHeight(var_6_2)
	local var_6_9 = var_6_6.x
	local var_6_10 = math.abs(arg_6_4) - var_6_7 / 2
	local var_6_11 = var_6_7 / 2 - math.abs(arg_6_5)

	if var_6_9 < var_6_10 or var_6_11 < var_6_9 then
		return true
	end

	local var_6_12 = var_6_6.y
	local var_6_13 = math.abs(arg_6_3) - var_6_8 / 2
	local var_6_14 = var_6_8 / 2 - math.abs(arg_6_2)

	if var_6_12 < var_6_13 or var_6_14 < var_6_12 then
		return true
	end

	return false
end

function var_0_0.getCenterPoint(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		var_7_0 = var_7_0 + iter_7_1.x
		var_7_1 = var_7_1 + iter_7_1.y
	end

	local var_7_2 = var_7_0 / #arg_7_0
	local var_7_3 = var_7_1 / #arg_7_0

	return HexPoint(var_7_2, var_7_3)
end

function var_0_0.getAngle(arg_8_0, arg_8_1)
	local var_8_0 = Vector2.Dot(arg_8_0, arg_8_1)

	if var_8_0 == 0 then
		return 90
	end

	local var_8_1 = Vector2.Magnitude(arg_8_0)
	local var_8_2 = Vector2.Magnitude(arg_8_1)

	if var_8_1 == 0 or var_8_2 == 0 then
		return 0
	end

	local var_8_3 = var_8_0 / var_8_1 / var_8_2

	return Mathf.Acos(var_8_3) * Mathf.Rad2Deg
end

function var_0_0.setGlobalFloat(arg_9_0, arg_9_1)
	if RoomController.instance:isDebugMode() then
		return
	end

	UnityEngine.Shader.SetGlobalFloat(arg_9_0, arg_9_1)
end

function var_0_0.getGlobalFloat(arg_10_0)
	return UnityEngine.Shader.GetGlobalFloat(arg_10_0)
end

function var_0_0.setGlobalColor(arg_11_0, arg_11_1)
	if RoomController.instance:isDebugMode() then
		return
	end

	UnityEngine.Shader.SetGlobalColor(arg_11_0, arg_11_1)
end

function var_0_0.getBlockPrefabName(arg_12_0)
	local var_12_0 = string.split(arg_12_0, "/")

	return string.split(var_12_0[#var_12_0], ".")[1]
end

function var_0_0.hideBlockPackageReddot(arg_13_0)
	local var_13_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBlockPackage)

	if not var_13_0 or not var_13_0.infos then
		return
	end

	local var_13_1 = var_13_0.infos[arg_13_0]

	if not var_13_1 then
		return
	end

	if var_13_1.value > 0 then
		RoomRpc.instance:sendHideBlockPackageReddotRequest(arg_13_0)
	end
end

function var_0_0.getRendererList(arg_14_0)
	local var_14_0 = {}

	if arg_14_0 then
		local var_14_1 = arg_14_0:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

		var_0_0.cArrayToLuaTable(var_14_1, var_14_0)
	end

	return var_14_0
end

function var_0_0.initSceneRootTrs()
	local var_15_0 = CameraMgr.instance:getSceneRoot()
	local var_15_1 = CameraMgr.instance:getCameraRootGO()
	local var_15_2 = {
		var_15_1,
		var_15_0
	}

	if var_15_0 then
		table.insert(var_15_2, gohelper.findChild(var_15_0, "RoomScene"))
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_2) do
		if iter_15_1 then
			local var_15_3 = iter_15_1:GetComponent(typeof(UnityEngine.Animator))

			if var_15_3 then
				var_15_3.enabled = false
			end

			transformhelper.setPos(iter_15_1.transform, 0, 0, 0)
		end
	end
end

local var_0_1 = 0

function var_0_0.logElapse(arg_16_0, arg_16_1)
	local var_16_0 = UnityEngine.Time.realtimeSinceStartup
	local var_16_1 = var_16_0 - var_0_1

	if not arg_16_1 or arg_16_1 < var_16_1 then
		var_0_1 = var_16_0

		logNormal(string.format("小屋加载：%.3f +%.3f ", var_16_0, var_16_1) .. arg_16_0)
	end
end

local var_0_2 = 0

function var_0_0.logStart(arg_17_0)
	var_0_2 = UnityEngine.Time.realtimeSinceStartup
	var_0_1 = UnityEngine.Time.realtimeSinceStartup

	logNormal("小屋加载：" .. arg_17_0)
end

function var_0_0.logEnd(arg_18_0)
	local var_18_0 = UnityEngine.Time.realtimeSinceStartup
	local var_18_1 = var_18_0 - var_0_1

	var_0_1 = var_18_0

	logNormal(string.format("小屋加载：%.3f +%.3f total=%.3f ", var_18_0, var_18_1, var_18_0 - var_0_2) .. arg_18_0)
end

function var_0_0.getGameObjectsByNameInChildren(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2 = arg_19_2 or {}

	if not arg_19_0 or string.nilorempty(arg_19_1) then
		return arg_19_2
	end

	ZProj.AStarPathBridge.FindChildrenByName(arg_19_0, arg_19_1, arg_19_2)

	return arg_19_2
end

function var_0_0.cArrayToLuaTable(arg_20_0, arg_20_1)
	if arg_20_0 then
		local var_20_0 = arg_20_1 or {}

		ZProj.AStarPathBridge.ArrayToLuaTable(arg_20_0, var_20_0)

		return var_20_0
	end
end

function var_0_0.vector3Distance2(arg_21_0, arg_21_1)
	return (arg_21_0.x - arg_21_1.x)^2 + (arg_21_0.y - arg_21_1.y)^2 + (arg_21_0.z - arg_21_1.z)^2
end

function var_0_0.audioExtendTrigger(arg_22_0, arg_22_1)
	local var_22_0 = RoomConfig.instance:getAudioExtendConfig(arg_22_0)

	if not var_22_0 then
		return
	end

	if var_22_0.audioId < 1 then
		logNormal(string.format("export_音效拓展 id[%s] audioId:%s", arg_22_0, var_22_0.audioId))

		return
	end

	if not string.nilorempty(var_22_0.rtpc) then
		AudioMgr.instance:setRTPCValue(var_22_0.rtpc, var_22_0.rtpcValue)
	end

	if not string.nilorempty(var_22_0.switchGroup) then
		if not string.nilorempty(var_22_0.switchState) then
			local var_22_1 = AudioMgr.instance:getIdFromString(var_22_0.switchGroup)
			local var_22_2 = AudioMgr.instance:getIdFromString(var_22_0.switchState)

			AudioMgr.instance:setSwitch(var_22_1, var_22_2, arg_22_1)
			logNormal(string.format("RoomHelper.audioExtendTrigger(audioExtendId,go) groupId[%s] stateId[%s] audioId[%s]", var_22_1, var_22_2, var_22_0.audioId))
		else
			logNormal(string.format("export_音效拓展 id[%s] switchState 字段没配置", arg_22_0))
		end
	end

	AudioMgr.instance:trigger(var_22_0.audioId, arg_22_1)
end

function var_0_0.randomArray(arg_23_0)
	local var_23_0 = #arg_23_0
	local var_23_1
	local var_23_2

	for iter_23_0 = 1, var_23_0 do
		local var_23_3 = math.random(1, var_23_0)

		arg_23_0[iter_23_0], arg_23_0[var_23_3] = arg_23_0[var_23_3], arg_23_0[iter_23_0]
	end
end

function var_0_0.add2KeyValue(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0[arg_24_1] = arg_24_0[arg_24_1] or {}
	arg_24_0[arg_24_1][arg_24_2] = arg_24_3
end

function var_0_0.get2KeyValue(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0[arg_25_1]

	return var_25_0 and var_25_0[arg_25_2]
end

function var_0_0.mergeCfg(arg_26_0, arg_26_1)
	local var_26_0 = {
		__index = function(arg_27_0, arg_27_1)
			local var_27_0 = rawget(arg_27_0, 2)

			if var_27_0 then
				local var_27_1 = var_27_0[arg_27_1]

				if not string.nilorempty(var_27_1) then
					return var_27_1
				end
			end

			local var_27_2 = rawget(arg_27_0, 1)

			if var_27_2 then
				return var_27_2[arg_27_1]
			end
		end,
		__newindex = function(arg_28_0, arg_28_1, arg_28_2)
			logError("Can't modify config field: " .. arg_28_1)
		end
	}
	local var_26_1 = {
		arg_26_0,
		arg_26_1
	}

	setmetatable(var_26_1, var_26_0)

	return var_26_1
end

function var_0_0.getBuildingLevelUpTipsParam(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = {
		desc = luaLang("room_building_level_up_tip")
	}

	table.insert(var_29_0, var_29_1)

	local var_29_2 = RoomMapBuildingModel.instance:getBuildingMOById(arg_29_0)
	local var_29_3 = ManufactureConfig.instance:getBuildingUpgradeGroup(var_29_2.buildingId)

	if var_29_3 and var_29_3 ~= 0 then
		local var_29_4 = {}
		local var_29_5 = {}
		local var_29_6 = var_29_2:getLevel()
		local var_29_7 = ManufactureConfig.instance:getNewManufactureItemList(var_29_3, var_29_6)

		for iter_29_0, iter_29_1 in ipairs(var_29_7) do
			local var_29_8 = ManufactureConfig.instance:getItemId(iter_29_1)

			if not var_29_5[var_29_8] then
				var_29_4[#var_29_4 + 1] = {
					type = MaterialEnum.MaterialType.Item,
					id = var_29_8
				}
				var_29_5[var_29_8] = true
			end
		end

		local var_29_9 = {
			desc = luaLang("room_new_manufacture_item"),
			newItemInfoList = var_29_4
		}

		table.insert(var_29_0, var_29_9)
	end

	return var_29_0
end

function var_0_0.sortBuildingById(arg_30_0, arg_30_1)
	if not arg_30_0 or not arg_30_1 then
		return false
	end

	return arg_30_0.buildingId < arg_30_1.buildingId
end

function var_0_0.getNumberByKey(arg_31_0)
	local var_31_0 = arg_31_0 .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.getNumber(var_31_0, 0)
end

function var_0_0.setNumberByKey(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0 .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.setNumber(var_32_0, arg_32_1)
end

return var_0_0
