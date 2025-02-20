module("modules.logic.room.utils.RoomHelper", package.seeall)

slot1 = 0
slot2 = 0

return {
	isFSMState = function (slot0)
		return GameSceneMgr.instance:getCurScene().fsm:getCurStateName() == slot0
	end,
	isOutCameraFocusCenter = function (slot0)
		return uv0._checkOutCameraFocus(slot0.x, slot0.y, 0.5, 300, 440, 300, 300)
	end,
	isOutCameraFocus = function (slot0)
		return uv0._checkOutCameraFocus(slot0.x, slot0.y, 3.2, 300, 440, 300, 300)
	end,
	isOutCameraFocusByPlaceCharacter = function (slot0, slot1, slot2)
		return uv0._checkOutCameraFocus(slot0, slot1, 3.2, 300, slot2 or 440, 300, 300)
	end,
	_checkOutCameraFocus = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		if slot2 < Vector2.Distance(GameSceneMgr.instance:getCurScene().camera:getCameraFocus(), Vector2(slot0, slot1)) then
			return true
		end

		return uv0._checkCameraFocusByPadding(slot0, slot1, slot3, slot4, slot5, slot6)
	end,
	_checkCameraFocusByPadding = function (slot0, slot1, slot2, slot3, slot4, slot5)
		slot7 = RoomBendingHelper.worldToBendingSimple(Vector3(slot0, 0, slot1))
		slot9 = ViewMgr.instance:getUILayer("HUD").transform
		slot14 = recthelper.getWidth(slot9)
		slot15 = recthelper.getHeight(slot9)

		if recthelper.worldPosToAnchorPos(Vector3(slot7.x, slot7.y, slot7.z), slot9).x < math.abs(slot4) - slot14 / 2 or slot14 / 2 - math.abs(slot5) < slot16 then
			return true
		end

		if slot13.y < math.abs(slot3) - slot15 / 2 or slot15 / 2 - math.abs(slot2) < slot19 then
			return true
		end

		return false
	end,
	getCenterPoint = function (slot0)
		for slot6, slot7 in ipairs(slot0) do
			slot1 = 0 + slot7.x
			slot2 = 0 + slot7.y
		end

		return HexPoint(slot1 / #slot0, slot2 / #slot0)
	end,
	getAngle = function (slot0, slot1)
		if Vector2.Dot(slot0, slot1) == 0 then
			return 90
		end

		slot4 = Vector2.Magnitude(slot1)

		if Vector2.Magnitude(slot0) == 0 or slot4 == 0 then
			return 0
		end

		return Mathf.Acos(slot2 / slot3 / slot4) * Mathf.Rad2Deg
	end,
	setGlobalFloat = function (slot0, slot1)
		if RoomController.instance:isDebugMode() then
			return
		end

		UnityEngine.Shader.SetGlobalFloat(slot0, slot1)
	end,
	getGlobalFloat = function (slot0)
		return UnityEngine.Shader.GetGlobalFloat(slot0)
	end,
	setGlobalColor = function (slot0, slot1)
		if RoomController.instance:isDebugMode() then
			return
		end

		UnityEngine.Shader.SetGlobalColor(slot0, slot1)
	end,
	getBlockPrefabName = function (slot0)
		slot1 = string.split(slot0, "/")

		return string.split(slot1[#slot1], ".")[1]
	end,
	hideBlockPackageReddot = function (slot0)
		if not RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBlockPackage) or not slot1.infos then
			return
		end

		if not slot1.infos[slot0] then
			return
		end

		if slot2.value > 0 then
			RoomRpc.instance:sendHideBlockPackageReddotRequest(slot0)
		end
	end,
	getRendererList = function (slot0)
		slot1 = {}

		if slot0 then
			uv0.cArrayToLuaTable(slot0:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true), slot1)
		end

		return slot1
	end,
	initSceneRootTrs = function ()
		slot0 = CameraMgr.instance:getSceneRoot()
		slot2 = {
			CameraMgr.instance:getCameraRootGO(),
			slot0
		}

		if slot0 then
			table.insert(slot2, gohelper.findChild(slot0, "RoomScene"))
		end

		for slot6, slot7 in ipairs(slot2) do
			if slot7 then
				if slot7:GetComponent(typeof(UnityEngine.Animator)) then
					slot8.enabled = false
				end

				transformhelper.setPos(slot7.transform, 0, 0, 0)
			end
		end
	end,
	logElapse = function (slot0, slot1)
		slot3 = UnityEngine.Time.realtimeSinceStartup - uv0

		if not slot1 or slot1 < slot3 then
			uv0 = slot2

			logNormal(string.format("小屋加载：%.3f +%.3f ", slot2, slot3) .. slot0)
		end
	end,
	logStart = function (slot0)
		uv0 = UnityEngine.Time.realtimeSinceStartup
		uv1 = UnityEngine.Time.realtimeSinceStartup

		logNormal("小屋加载：" .. slot0)
	end,
	logEnd = function (slot0)
		slot1 = UnityEngine.Time.realtimeSinceStartup
		uv0 = slot1

		logNormal(string.format("小屋加载：%.3f +%.3f total=%.3f ", slot1, slot1 - uv0, slot1 - uv1) .. slot0)
	end,
	getGameObjectsByNameInChildren = function (slot0, slot1, slot2)
		slot2 = slot2 or {}

		if not slot0 or string.nilorempty(slot1) then
			return slot2
		end

		ZProj.AStarPathBridge.FindChildrenByName(slot0, slot1, slot2)

		return slot2
	end,
	cArrayToLuaTable = function (slot0, slot1)
		if slot0 then
			slot2 = slot1 or {}

			ZProj.AStarPathBridge.ArrayToLuaTable(slot0, slot2)

			return slot2
		end
	end,
	vector3Distance2 = function (slot0, slot1)
		return (slot0.x - slot1.x)^2 + (slot0.y - slot1.y)^2 + (slot0.z - slot1.z)^2
	end,
	audioExtendTrigger = function (slot0, slot1)
		if not RoomConfig.instance:getAudioExtendConfig(slot0) then
			return
		end

		if slot2.audioId < 1 then
			logNormal(string.format("export_音效拓展 id[%s] audioId:%s", slot0, slot2.audioId))

			return
		end

		if not string.nilorempty(slot2.rtpc) then
			AudioMgr.instance:setRTPCValue(slot2.rtpc, slot2.rtpcValue)
		end

		if not string.nilorempty(slot2.switchGroup) then
			if not string.nilorempty(slot2.switchState) then
				slot3 = AudioMgr.instance:getIdFromString(slot2.switchGroup)
				slot4 = AudioMgr.instance:getIdFromString(slot2.switchState)

				AudioMgr.instance:setSwitch(slot3, slot4, slot1)
				logNormal(string.format("RoomHelper.audioExtendTrigger(audioExtendId,go) groupId[%s] stateId[%s] audioId[%s]", slot3, slot4, slot2.audioId))
			else
				logNormal(string.format("export_音效拓展 id[%s] switchState 字段没配置", slot0))
			end
		end

		AudioMgr.instance:trigger(slot2.audioId, slot1)
	end,
	randomArray = function (slot0)
		slot2, slot3 = nil

		for slot7 = 1, #slot0 do
			slot3 = math.random(1, slot1)
			slot0[slot3] = slot0[slot7]
			slot0[slot7] = slot0[slot3]
		end
	end,
	add2KeyValue = function (slot0, slot1, slot2, slot3)
		slot0[slot1] = slot0[slot1] or {}
		slot0[slot1][slot2] = slot3
	end,
	get2KeyValue = function (slot0, slot1, slot2)
		return slot0[slot1] and slot3[slot2]
	end,
	mergeCfg = function (slot0, slot1)
		slot3 = {
			slot0,
			slot1
		}

		setmetatable(slot3, {
			__index = function (slot0, slot1)
				if rawget(slot0, 2) and not string.nilorempty(slot2[slot1]) then
					return slot3
				end

				if rawget(slot0, 1) then
					return slot3[slot1]
				end
			end,
			__newindex = function (slot0, slot1, slot2)
				logError("Can't modify config field: " .. slot1)
			end
		})

		return slot3
	end,
	getBuildingLevelUpTipsParam = function (slot0)
		table.insert({}, {
			desc = luaLang("room_building_level_up_tip")
		})

		if ManufactureConfig.instance:getBuildingUpgradeGroup(RoomMapBuildingModel.instance:getBuildingMOById(slot0).buildingId) and slot4 ~= 0 then
			slot5 = {}
			slot6 = {}
			slot12 = slot3:getLevel()

			for slot12, slot13 in ipairs(ManufactureConfig.instance:getNewManufactureItemList(slot4, slot12)) do
				if not slot6[ManufactureConfig.instance:getItemId(slot13)] then
					slot5[#slot5 + 1] = {
						type = MaterialEnum.MaterialType.Item,
						id = slot14
					}
					slot6[slot14] = true
				end
			end

			table.insert(slot1, {
				desc = luaLang("room_new_manufacture_item"),
				newItemInfoList = slot5
			})
		end

		return slot1
	end,
	sortBuildingById = function (slot0, slot1)
		if not slot0 or not slot1 then
			return false
		end

		return slot0.buildingId < slot1.buildingId
	end,
	getNumberByKey = function (slot0)
		return PlayerPrefsHelper.getNumber(slot0 .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), 0)
	end,
	setNumberByKey = function (slot0, slot1)
		return PlayerPrefsHelper.setNumber(slot0 .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId), slot1)
	end
}
