module("modules.logic.versionactivity1_3.chess.controller.Activity1_3ChessGameController", package.seeall)

local var_0_0 = class("Activity1_3ChessGameController", BaseController)

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.release(arg_3_0)
	return
end

function var_0_0.getViewName(arg_4_0)
	return
end

function var_0_0.onInitServerMap(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.act122Sight or arg_5_1.activity122Sights
	local var_5_1 = arg_5_1.act122Fire

	Activity122Model.instance:initSight(var_5_0)
	Activity122Model.instance:initFire(var_5_1)
	arg_5_0:dispatchEvent(Activity1_3ChessEvent.InitGameScene, arg_5_1)
end

function var_0_0.onUpdateServerMap(arg_6_0, arg_6_1)
	Activity122Model.instance:updateSight(arg_6_1.addSights)
	Activity122Model.instance:updateFire(arg_6_1.addFires)
	arg_6_0:dispatchEvent(Activity1_3ChessEvent.UpdateGameScene, arg_6_1)
end

function var_0_0.onInitObjects(arg_7_0)
	local var_7_0 = Va3ChessGameModel.instance:getActId()
	local var_7_1 = Va3ChessGameModel.instance:getMapId()
	local var_7_2 = Activity122Config.instance:getMapCo(var_7_0, var_7_1).decorateObjects

	if not var_7_2 or string.nilorempty(var_7_2) then
		return
	end

	local var_7_3 = cjson.decode(var_7_2)

	for iter_7_0, iter_7_1 in ipairs(var_7_3) do
		local var_7_4 = Va3ChessInteractObject.New()

		iter_7_1.actId = var_7_0

		var_7_4:init(iter_7_1)
		var_7_4:setIgnoreSight(true)

		if var_7_4.config ~= nil then
			Va3ChessGameController.instance.interacts:add(var_7_4)
		end
	end
end

function var_0_0.setSceneCamera(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = CameraMgr.instance:getMainCamera()
		local var_8_1 = CameraMgr.instance:getUnitCamera()

		var_8_1.orthographic = true
		var_8_1.orthographicSize = var_8_0.orthographicSize

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

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
