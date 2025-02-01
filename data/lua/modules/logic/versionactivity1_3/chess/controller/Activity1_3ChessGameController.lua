module("modules.logic.versionactivity1_3.chess.controller.Activity1_3ChessGameController", package.seeall)

slot0 = class("Activity1_3ChessGameController", BaseController)

function slot0.init(slot0)
end

function slot0.reInit(slot0)
end

function slot0.release(slot0)
end

function slot0.getViewName(slot0)
end

function slot0.onInitServerMap(slot0, slot1)
	Activity122Model.instance:initSight(slot1.act122Sight or slot1.activity122Sights)
	Activity122Model.instance:initFire(slot1.act122Fire)
	slot0:dispatchEvent(Activity1_3ChessEvent.InitGameScene, slot1)
end

function slot0.onUpdateServerMap(slot0, slot1)
	Activity122Model.instance:updateSight(slot1.addSights)
	Activity122Model.instance:updateFire(slot1.addFires)
	slot0:dispatchEvent(Activity1_3ChessEvent.UpdateGameScene, slot1)
end

function slot0.onInitObjects(slot0)
	if not Activity122Config.instance:getMapCo(Va3ChessGameModel.instance:getActId(), Va3ChessGameModel.instance:getMapId()).decorateObjects or string.nilorempty(slot4) then
		return
	end

	for slot9, slot10 in ipairs(cjson.decode(slot4)) do
		slot11 = Va3ChessInteractObject.New()
		slot10.actId = slot1

		slot11:init(slot10)
		slot11:setIgnoreSight(true)

		if slot11.config ~= nil then
			Va3ChessGameController.instance.interacts:add(slot11)
		end
	end
end

function slot0.setSceneCamera(slot0, slot1)
	if slot1 then
		slot3 = CameraMgr.instance:getUnitCamera()
		slot3.orthographic = true
		slot3.orthographicSize = CameraMgr.instance:getMainCamera().orthographicSize

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		PostProcessingMgr.instance:setUnitActive(true)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", 0)
	else
		CameraMgr.instance:getUnitCamera().orthographic = false

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)
		PostProcessingMgr.instance:setUnitActive(false)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", true)
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
