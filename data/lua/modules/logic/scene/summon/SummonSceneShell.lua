module("modules.logic.scene.summon.SummonSceneShell", package.seeall)

slot0 = class("SummonSceneShell")
slot1 = {
	Prepared = 3,
	Close = 1,
	Start = 2
}

function slot0.init(slot0, slot1, slot2)
	slot0._curSceneId = slot1
	slot0._curLevelId = slot2
	slot0._curStep = uv0.Close
	slot0._allComps = {}

	slot0:registClz()

	for slot6, slot7 in ipairs(slot0._allComps) do
		if slot7.onInit then
			slot7:onInit()
		end
	end
end

function slot0.registClz(slot0)
	slot0:_addComp("director", SummonSceneDirector)
	slot0:_addComp("view", SummonSceneViewComp)
	slot0:_addComp("bgm", SummonSceneBgmComp)
	slot0:_addComp("cameraAnim", SummonSceneCameraComp)
	slot0:_addComp("preloader", SummonScenePreloader)
	slot0:_addComp("selector", SummonSceneSelector)
end

function slot0._addComp(slot0, slot1, slot2)
	slot3 = slot2.New(slot0)
	slot0[slot1] = slot3

	table.insert(slot0._allComps, slot3)
end

function slot0.onStart(slot0, slot1, slot2)
	if slot0._curStep ~= uv0.Close then
		return
	end

	slot0._curStep = uv0.Start

	logNormal("summmon start")

	for slot6, slot7 in ipairs(slot0._allComps) do
		if slot7.onSceneStart and not slot7.isOnStarted then
			slot7:onSceneStart(slot1, slot2)
		end
	end
end

function slot0.onPrepared(slot0)
	if slot0._curStep ~= uv0.Start then
		return
	end

	slot0._curStep = uv0.Prepared

	logNormal("summmon onPrepared")

	for slot4, slot5 in ipairs(slot0._allComps) do
		if slot5.onScenePrepared then
			slot5:onScenePrepared(slot0._curSceneId, slot0._curLevelId)
		end
	end

	SummonController.instance:dispatchEvent(SummonEvent.onSummonScenePrepared)
end

function slot0.onClose(slot0)
	if slot0._curStep == uv0.Close then
		return
	end

	slot0._curStep = uv0.Close

	logNormal("summmon close")

	slot0._isClosing = true

	for slot4, slot5 in ipairs(slot0._allComps) do
		if slot5.onSceneClose then
			slot5:onSceneClose()
		end
	end

	slot0._isClosing = false
end

function slot0.onHide(slot0)
	if slot0._curStep == uv0.Close then
		return
	end

	slot0._curStep = uv0.Close

	logNormal("summmon hide")

	for slot4, slot5 in ipairs(slot0._allComps) do
		if slot5.onSceneHide then
			slot5:onSceneHide()
		end
	end
end

function slot0.getSceneContainerGO(slot0)
	return VirtualSummonScene.instance:getRootGO()
end

return slot0
