module("modules.logic.scene.common.CommonSceneCtrlComp", package.seeall)

slot0 = class("CommonSceneCtrlComp", BaseSceneComp)
slot0.CtrlComp = {
	DynamicShadow = SceneLuaCompSpineDynamicShadow
}

function slot0.onInit(slot0)
	slot0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.onSceneStart(slot0, slot1, slot2)
end

function slot0.onSceneClose(slot0)
end

function slot0._onLevelLoaded(slot0, slot1)
	slot4 = slot1 and lua_scene_level.configDict[slot1]

	if slot4 and lua_scene_ctrl.configDict[slot4.resName] and not gohelper.isNil(slot0:getCurScene().level and slot2:getSceneGo()) then
		for slot9, slot10 in pairs(slot5) do
			if uv0.CtrlComp[slot10.ctrlName] then
				MonoHelper.addLuaComOnceToGo(slot3, slot11, {
					slot10.param1,
					slot10.param2,
					slot10.param3,
					slot10.param4
				})
			else
				logError("ctrlComp not exist: " .. slot10.ctrlName)
			end
		end
	end
end

return slot0
