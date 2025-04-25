module("modules.logic.weather.eggs.SceneBaseEgg", package.seeall)

slot0 = class("SceneBaseEgg")

function slot0.ctor(slot0)
end

function slot0.onEnable(slot0)
	slot0:_onEnable()
end

function slot0._onEnable(slot0)
end

function slot0.onDisable(slot0)
	slot0:_onDisable()
end

function slot0._onDisable(slot0)
end

function slot0.onReportChange(slot0, slot1)
	slot0:_onReportChange(slot1)
end

function slot0._onReportChange(slot0, slot1)
end

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0._sceneGo = slot1
	slot0._context = slot4
	slot0._goList = slot2
	slot0._eggConfig = slot3

	slot0:_onInit()
end

function slot0.setGoListVisible(slot0, slot1)
	for slot5, slot6 in pairs(slot0._goList) do
		gohelper.setActive(slot6, slot1)
	end
end

function slot0.playAnim(slot0, slot1)
	for slot5, slot6 in pairs(slot0._goList) do
		gohelper.setActive(slot6, true)

		if slot6 and slot6:GetComponent("Animator") then
			slot7:Play(slot1, 0, 0)
		else
			logError("go has no animator animName:" .. slot1)
		end
	end
end

function slot0._onInit(slot0)
end

function slot0.onSceneClose(slot0)
	slot0._goList = nil

	slot0:_onSceneClose()
end

function slot0._onSceneClose(slot0)
end

return slot0
