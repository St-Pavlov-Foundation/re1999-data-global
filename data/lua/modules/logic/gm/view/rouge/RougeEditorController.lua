module("modules.logic.gm.view.rouge.RougeEditorController", package.seeall)

slot0 = class("RougeEditorController")

function slot0._addMapEditorView(slot0)
	if module_views.RougeMapEditorView then
		return
	end

	module_views[slot1] = {
		destroy = 0,
		container = "RougeMapEditorViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/gm/rouge/gm_rougemapeditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	ViewName[slot1] = slot1
end

function slot0._addPathSelectMapEditorView(slot0)
	if module_views.RougePathSelectMapEditorView then
		return
	end

	module_views[slot1] = {
		destroy = 0,
		container = "RougePathSelectMapEditorViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/gm/rouge/gm_rougepathselectmapeditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	ViewName[slot1] = slot1
end

function slot0.enterRougeMapEditor(slot0)
	if slot0.flow then
		return
	end

	slot0:_addMapEditorView()

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Rouge then
		slot2 = lua_rouge_middle_layer.configList[1]

		RougeMapModel.instance:init(RougeMapEnum.MapType.Edit)
		RougeMapEditModel.instance:init(slot2.id)

		slot0.flow = FlowSequence.New()

		slot0.flow:addWork(OpenSceneWork.New(SceneType.Rouge, 1, slot2.id))
		slot0.flow:addWork(OpenViewWorkByViewName.New(ViewName.RougeMapEditorView))
		slot0.flow:registerDoneListener(slot0.onFlowDone, slot0)
		slot0.flow:start()

		return
	end

	if RougeMapModel.instance:isMiddle() then
		ViewMgr.instance:openView(ViewName.RougeMapEditorView)
	else
		RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, slot0.onLoadMapDone, slot0)

		RougeMapModel.instance.isMiddle = true

		GameSceneMgr.instance:getCurScene().map:switchMap(RougeMapModel.instance:getLayerId(), lua_rouge_middle_layer.configList[1].id)
	end
end

function slot0.onFlowDone(slot0)
	slot0.flow = nil
end

function slot0.onLoadMapDone(slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, slot0.onMapLoadDone, slot0)
	ViewMgr.instance:openView(ViewName.RougeMapEditorView)
end

function slot0.enterRougeTestMap(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Rouge then
		RougeMapModel.instance:init(RougeMapEnum.MapType.Normal)
		GameSceneMgr.instance:startScene(SceneType.Rouge, 1, RougeMapModel.instance:getLayerId())

		return
	end

	GameSceneMgr.instance:getCurScene().map:switchMap(RougeMapModel.instance:getLayerId(), nil)
end

function slot0.showNodeClickArea(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Rouge then
		return
	end

	if RougeMapModel.instance:getMapType() == RougeMapEnum.MapType.Edit then
		return
	end

	if slot0.loadingText then
		return
	end

	slot0.showing = true

	if slot0.textGo then
		slot0:_showNodeClickArea()
	else
		slot0.loadingText = true

		loadAbAsset(uv0.TextPath, false, slot0._onLoadTextCallback, slot0)
	end
end

slot0.TextPath = "ui/viewres/gm/rouge/gm_rouge_text.prefab"

function slot0._onLoadTextCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0._assetItem = slot1

		slot0._assetItem:Retain()

		slot0.textGo = slot0._assetItem:GetResource(uv0.TextPath)
		slot0.loadingText = false

		slot0:_showNodeClickArea()
	end
end

function slot0._showNodeClickArea(slot0)
	if not slot0.showing then
		return
	end

	slot0:createArea()
	RougeMapController.instance:registerCallback(RougeMapEvent.onMapPosChange, slot0.onMapPosChange, slot0, LuaEventSystem.Low)
	TaskDispatcher.runRepeat(slot0.refreshPos, slot0, 0.1)
end

slot0.AreaTextColor = Color.New(1, 0, 0, 1)

function slot0.createArea(slot0)
	slot4 = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.RougeMapView).viewGO, "areaContainer") or gohelper.create2d(slot2, "areaContainer")
	slot5 = gohelper.findChild(slot2, "centerPointContainer") or gohelper.create2d(slot2, "centerPointContainer")

	gohelper.setActive(slot4, true)
	gohelper.setActive(slot5:GetComponent(gohelper.Type_RectTransform), true)

	slot0.goAreaContainer = slot4
	slot0.goCenterPointContainer = slot5
	slot0.textItemList = {}

	for slot13, slot14 in ipairs(RougeMapController.instance:getMapComp():getMapItemList()) do
		slot15 = gohelper.findChild(slot4, slot13) or gohelper.create2d(slot4, slot13)

		gohelper.setActive(slot15, true)

		slot16 = gohelper.onceAddComponent(slot15, gohelper.Type_Image)

		ZProj.UGUIHelper.SetColorAlpha(slot16, 0.5)

		slot16.raycastTarget = false
		slot17 = slot14:getClickArea()
		slot22, slot23 = slot14:getUiPos(slot4:GetComponent(gohelper.Type_RectTransform))

		recthelper.setAnchor(slot15.transform, slot22 + slot17.z, slot23 + slot17.w)
		recthelper.setSize(slot15.transform, slot17.x, slot17.y)

		slot24 = gohelper.findChild(slot5, slot13) or gohelper.create2d(slot5, slot13)

		gohelper.setActive(slot24, true)

		slot16 = gohelper.onceAddComponent(slot24, gohelper.Type_Image)
		slot16.color = Color.New(0, 0, 0, 1)
		slot16.raycastTarget = false

		recthelper.setSize(slot24.transform, 20, 20)
		recthelper.setAnchor(slot24.transform, slot22, slot23)

		slot25 = {
			text = slot26:GetComponent(gohelper.Type_TextMesh)
		}
		slot25.text.color = uv0.AreaTextColor
		slot25.areaRectTr = slot15:GetComponent(gohelper.Type_RectTransform)
		slot25.mapItem = slot14

		recthelper.setAnchor((gohelper.findChild(slot15, "text") or gohelper.clone(slot0.textGo, slot15, "text")):GetComponent(gohelper.Type_RectTransform), 0, 50)
		table.insert(slot0.textItemList, slot25)
		slot0:refreshOnePos(slot25)
	end
end

function slot0.refreshPos(slot0)
	for slot4, slot5 in ipairs(slot0.textItemList) do
		if not slot0:refreshOnePos(slot5) then
			TaskDispatcher.cancelTask(slot0.refreshPos, slot0)

			return
		end
	end
end

function slot0.refreshOnePos(slot0, slot1)
	if gohelper.isNil(slot1.areaRectTr) then
		return false
	end

	slot4, slot5 = slot1.mapItem:getUiPos(slot0.goAreaContainer.transform)
	slot6, slot7 = recthelper.getAnchor(slot1.areaRectTr)
	slot1.text.text = string.format("%s, %s, %s, %s", RougeMapHelper.retain2decimals(recthelper.getWidth(slot1.areaRectTr)), RougeMapHelper.retain2decimals(recthelper.getHeight(slot1.areaRectTr)), RougeMapHelper.retain2decimals(slot6 - slot4), RougeMapHelper.retain2decimals(slot7 - slot5))

	return true
end

function slot0.onMapPosChange(slot0)
	if not slot0.showing then
		return
	end

	slot0:createArea()
end

function slot0.hideNodeClickArea(slot0)
	TaskDispatcher.cancelTask(slot0.refreshPos, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMapPosChange, slot0.onMapPosChange, slot0)

	if not slot0.showing then
		return
	end

	if gohelper.isNil(slot0.goAreaContainer) then
		return
	end

	slot0.showing = false

	gohelper.setActive(slot0.goAreaContainer, false)

	for slot6 = 0, slot0.goAreaContainer.transform.childCount - 1 do
		gohelper.setActive(slot1:GetChild(slot6).gameObject, false)
	end

	gohelper.setActive(slot0.goCenterPointContainer, false)

	for slot6 = 0, slot0.goCenterPointContainer.transform.childCount - 1 do
		gohelper.setActive(slot1:GetChild(slot6).gameObject, false)
	end
end

function slot0.getIsShowing(slot0)
	return slot0.showing
end

function slot0.enterPathSelectMapEditorView(slot0)
	if slot0.flow then
		return
	end

	slot0:_addPathSelectMapEditorView()

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Rouge then
		RougeMapModel.instance:updateMapInfo({
			mapType = RougeMapEnum.MapType.Middle,
			middleLayerInfo = {
				layerId = 101,
				middleLayerId = 101,
				positionIndex = RougeMapEnum.PathSelectIndex
			},
			HasField = function ()
				return false
			end
		})

		slot0.flow = FlowSequence.New()

		slot0.flow:addWork(OpenSceneWork.New(SceneType.Rouge, 1, 101))
		slot0.flow:addWork(OpenViewWorkByViewName.New(ViewName.RougePathSelectMapEditorView))
		slot0.flow:registerDoneListener(slot0.onFlowDone, slot0)
		slot0.flow:start()

		return
	end

	if RougeMapModel.instance:isPathSelect() then
		ViewMgr.instance:openView(ViewName.RougePathSelectMapEditorView)
	end
end

function slot0.allowAbortFight(slot0, slot1)
	slot0.allow = slot1
end

function slot0.isAllowAbortFight(slot0)
	return slot0.allow and true or false
end

slot0.instance = slot0.New()

return slot0
