module("modules.logic.scene.room.comp.RoomSceneInitComp", package.seeall)

slot0 = class("RoomSceneInitComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._originalCameraTransparencySortModeList = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0:_setTransparencySortMode()
	RoomMapController.instance:initMap()
	RoomHelper.initSceneRootTrs()
end

function slot0.onSceneClose(slot0)
	slot0:_revertTransparencySortMode()

	if GameSceneMgr.instance:getNextSceneType() ~= SceneType.Room and RoomController.instance:isObMode() then
		-- Nothing
	end

	RoomMapController.instance:clearMap()
end

function slot0._setTransparencySortMode(slot0)
	slot0._originalCameraTransparencySortModeList = {}

	slot0:_setTransparencySortModeSingleCamera(CameraMgr.instance:getMainCamera())
	slot0:_setTransparencySortModeSingleCamera(CameraMgr.instance:getUnitCamera())
	slot0:_setTransparencySortModeSingleCamera(CameraMgr.instance:getOrthCamera())
end

function slot0._setTransparencySortModeSingleCamera(slot0, slot1)
	if not slot1 then
		return
	end

	table.insert(slot0._originalCameraTransparencySortModeList, {
		camera = slot1,
		originalTransparencySortMode = slot1.transparencySortMode
	})

	slot1.transparencySortMode = UnityEngine.TransparencySortMode.Default
end

function slot0._revertTransparencySortMode(slot0)
	if not slot0._originalCameraTransparencySortModeList then
		return
	end

	for slot4, slot5 in ipairs(slot0._originalCameraTransparencySortModeList) do
		slot5.camera.transparencySortMode = slot5.originalTransparencySortMode
	end
end

return slot0
