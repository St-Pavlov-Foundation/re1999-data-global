module("modules.logic.handbook.view.HandbookWeekWalkSceneView", package.seeall)

slot0 = class("HandbookWeekWalkSceneView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.mapId = slot0.viewParam.id
	slot0.mapCo = WeekWalkConfig.instance:getMapConfig(slot0.mapId)
	slot0.mapBranchCoList = WeekWalkConfig.instance:getMapBranchCoList(1)
	slot0.elementList = slot0:getUserDataTb_()
	slot0.handbookElementList = slot0:getUserDataTb_()

	slot0:createSceneMapNode()
	slot0:loadMap()
	MainCameraMgr.instance:addView(ViewName.HandbookWeekWalkView, slot0.initCamera, nil, slot0)
end

function slot0.createSceneMapNode(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("WeekWalkMap")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.loadMap(slot0)
	slot0._mapLoader = MultiAbLoader.New()

	slot0._mapLoader:addPath(slot0.mapCo.map)

	slot0._canvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"

	slot0._mapLoader:addPath(slot0._canvasUrl)
	slot0._mapLoader:startLoad(slot0.loadMapCallback, slot0)
end

function slot0.loadMapCallback(slot0)
	slot0._sceneGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot0.mapCo.map):GetResource(slot0.mapCo.map), slot0._sceneRoot, tostring(slot0.mapCo.id))

	gohelper.setActive(slot0._sceneGo, true)

	slot0._sceneTrans = slot0._sceneGo.transform
	slot0._diffuseGo = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse")
	slot0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(slot0._sceneGo, slot0._elementRoot)
	slot0:refreshScene(1)
end

function slot0.refreshScene(slot0, slot1)
	slot0.elementIdList = {}
	slot0.handbookElementIdList = {}
	slot6 = slot0.mapBranchCoList[slot1].handbookPath

	for slot5, slot6 in ipairs(string.splitToNumber(slot6)) do
		table.insert(slot0.handbookElementIdList, slot6)
	end

	slot6 = slot0.mapBranchCoList[slot1].nodePath

	for slot5, slot6 in ipairs(string.splitToNumber(slot6)) do
		table.insert(slot0.elementIdList, slot6)
	end

	slot0:loadElements()
end

function slot0.loadElements(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.elementIdList) do
		if not slot0.elementList[slot6] then
			slot0.elementList[slot6] = slot0:createElementComp(slot6)
		end

		slot1:updateInfo(slot6)
		slot1:refresh()
	end
end

function slot0.createElementComp(slot0, slot1)
	slot2 = UnityEngine.GameObject.New(tostring(slot1))

	gohelper.addChild(slot0._elementRoot, slot2)

	return MonoHelper.addLuaComOnceToGo(slot2, HandbookWeekWalkMapElement, {
		parentView = slot0,
		diffuseGo = slot0._diffuseGo
	})
end

function slot0.loadHandbookElements(slot0)
end

function slot0.initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true

	transformhelper.setLocalRotation(slot1.transform, 0, 0, 0)

	slot1.orthographicSize = WeekWalkEnum.orthographicSize * GameUtil.getAdapterScale()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
