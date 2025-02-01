module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapScene", package.seeall)

slot0 = class("JiaLaBoNaMapScene", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.onScreenResize, slot0)
	slot0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.MapSceneActvie, slot0._onMapSceneActivie, slot0)
end

function slot0.setSceneActive(slot0, slot1)
	if slot0._sceneRoot then
		gohelper.setActive(slot0._sceneRoot, slot1)
	end
end

function slot0.onClose(slot0)
	slot0:resetCamera()
end

function slot0._onMapSceneActivie(slot0, slot1)
	slot0:setSceneActive(slot1)
end

function slot0.onScreenResize(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function slot0.resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false
end

function slot0.switchPage(slot0, slot1)
	if not JiaLaBoNaEnum.MapSceneRes[slot1] then
		return
	end

	if slot0._chapterSceneUdtbDict then
		slot0._curChaperId = slot1

		slot0:_createChapterScene(slot1)

		for slot5, slot6 in pairs(slot0._chapterSceneUdtbDict) do
			gohelper.setActive(slot6.go, slot6.chapterId == slot1)
		end

		slot0:refreshInteract()
	end
end

function slot0.playSceneAnim(slot0, slot1)
	if not string.nilorempty(slot1) and slot0._chapterSceneUdtbDict[slot0._curChaperId] and slot2.animator then
		slot2.animator:Play(slot1)
	end
end

function slot0._createChapterScene(slot0, slot1)
	if slot0._chapterSceneUdtbDict and not slot0._chapterSceneUdtbDict[slot1] then
		slot2 = slot0:getResInst(JiaLaBoNaEnum.MapSceneRes[slot1], slot0._sceneRoot)

		transformhelper.setLocalPos(slot2.transform, 0, 0, 0)

		slot3 = slot0:getUserDataTb_()
		slot3.go = slot2
		slot3.chapterId = slot1
		slot3.animator = slot2:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
		slot0._chapterSceneUdtbDict[slot1] = slot3

		slot0:_findInactGo(slot2, slot1)
	end
end

function slot0._findInactGo(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(Activity120Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act306)) do
		if slot9.chapterId == slot2 and not string.nilorempty(slot9.inactPaths) then
			slot0._chapterInactsTbDict[slot9.id] = slot0:getUserDataTb_()

			for slot15, slot16 in ipairs(string.split(slot9.inactPaths, "|") or {}) do
				if not gohelper.isNil(not string.nilorempty(slot16) and gohelper.findChild(slot1, slot16)) then
					slot19 = slot0:getUserDataTb_()
					slot19.go = slot18
					slot19.animator = slot18:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

					table.insert(slot11, slot19)
				elseif not slot17 then
					logError(string.format("export_尘埃与星的边界活动关卡 activityId：%s id:% inactPaths:%s下标错误", slot3, slot9.id, slot15))
				end
			end
		end
	end
end

function slot0.refreshInteract(slot0, slot1)
	for slot7, slot8 in ipairs(Activity120Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act306)) do
		slot0:_refreshInteractById(slot8.id, slot8.id == slot1)
	end
end

function slot0._refreshInteractById(slot0, slot1, slot2)
	if slot0._chapterInactsTbDict[slot1] and #slot3 > 0 then
		for slot8, slot9 in ipairs(slot3) do
			gohelper.setActive(slot9.go, Activity120Model.instance:isEpisodeClear(slot1))

			if slot2 and slot9.animator then
				slot9.animator:Play("open", 0, 0)
			end
		end
	end
end

function slot0._editableInitView(slot0)
	slot0._pageIds = {
		JiaLaBoNaEnum.Chapter.One,
		JiaLaBoNaEnum.Chapter.Two
	}
	slot0._chapterSceneUdtbDict = {}
	slot0._chapterInactsTbDict = {}

	slot0:onScreenResize()

	slot0._sceneRoot = UnityEngine.GameObject.New("JiaLaBoNaMap")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.onDestroyView(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end

	if slot0._chapterSceneUdtbDict then
		slot0._chapterSceneUdtbDict = nil
	end
end

return slot0
