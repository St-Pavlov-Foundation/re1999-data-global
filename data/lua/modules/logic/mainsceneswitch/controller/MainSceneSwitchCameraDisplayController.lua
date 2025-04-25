module("modules.logic.mainsceneswitch.controller.MainSceneSwitchCameraDisplayController", package.seeall)

slot0 = class("MainSceneSwitchCameraDisplayController", MainSceneSwitchDisplayController)
slot0.instance = slot0.New()

function slot0.clear(slot0)
	if slot0._loaderMap then
		for slot4, slot5 in pairs(slot0._loaderMap) do
			slot5:dispose()
		end

		tabletool.clear(slot0._loaderMap)
	end

	if slot0._weatherCompMap then
		for slot4, slot5 in pairs(slot0._weatherCompMap) do
			for slot9, slot10 in ipairs(slot5) do
				slot10:onSceneClose()
			end
		end

		tabletool.clear(slot0._weatherCompMap)
	end

	if slot0._sceneNameMap then
		for slot4, slot5 in pairs(slot0._sceneNameMap) do
			gohelper.destroy(slot5)
		end

		tabletool.clear(slot0._sceneNameMap)
	end

	slot0._sceneRoot = nil
	slot0._callback = nil
	slot0._callbackTarget = nil
end

return slot0
