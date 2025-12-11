module("modules.logic.gm.view.rouge.RougeEditorController", package.seeall)

local var_0_0 = class("RougeEditorController")

function var_0_0._addMapEditorView(arg_1_0)
	local var_1_0 = "RougeMapEditorView"

	if module_views[var_1_0] then
		return
	end

	module_views[var_1_0] = {
		destroy = 0,
		container = "RougeMapEditorViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/gm/rouge/gm_rougemapeditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	ViewName[var_1_0] = var_1_0
end

function var_0_0._addPathSelectMapEditorView(arg_2_0)
	local var_2_0 = "RougePathSelectMapEditorView"

	if module_views[var_2_0] then
		return
	end

	module_views[var_2_0] = {
		destroy = 0,
		container = "RougePathSelectMapEditorViewContainer",
		bgBlur = 0,
		mainRes = "ui/viewres/gm/rouge/gm_rougepathselectmapeditor.prefab",
		layer = "POPUP_TOP",
		viewType = ViewType.Normal,
		anim = ViewAnim.Default
	}
	ViewName[var_2_0] = var_2_0
end

function var_0_0.enterRougeMapEditor(arg_3_0)
	if arg_3_0.flow then
		return
	end

	arg_3_0:_addMapEditorView()

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Rouge then
		local var_3_0 = lua_rouge_middle_layer.configList[1]

		RougeMapModel.instance:init(RougeMapEnum.MapType.Edit)
		RougeMapEditModel.instance:init(var_3_0.id)

		arg_3_0.flow = FlowSequence.New()

		arg_3_0.flow:addWork(OpenSceneWork.New(SceneType.Rouge, 1, var_3_0.id))
		arg_3_0.flow:addWork(OpenViewWorkByViewName.New(ViewName.RougeMapEditorView))
		arg_3_0.flow:registerDoneListener(arg_3_0.onFlowDone, arg_3_0)
		arg_3_0.flow:start()

		return
	end

	if RougeMapModel.instance:isMiddle() then
		ViewMgr.instance:openView(ViewName.RougeMapEditorView)
	else
		RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, arg_3_0.onLoadMapDone, arg_3_0)

		RougeMapModel.instance.isMiddle = true

		local var_3_1 = GameSceneMgr.instance:getCurScene().map
		local var_3_2 = lua_rouge_middle_layer.configList[1]

		var_3_1:switchMap(RougeMapModel.instance:getLayerId(), var_3_2.id)
	end
end

function var_0_0.onFlowDone(arg_4_0)
	arg_4_0.flow = nil
end

function var_0_0.onLoadMapDone(arg_5_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, arg_5_0.onMapLoadDone, arg_5_0)
	ViewMgr.instance:openView(ViewName.RougeMapEditorView)
end

function var_0_0.enterRougeTestMap(arg_6_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Rouge then
		RougeMapModel.instance:init(RougeMapEnum.MapType.Normal)
		GameSceneMgr.instance:startScene(SceneType.Rouge, 1, RougeMapModel.instance:getLayerId())

		return
	end

	GameSceneMgr.instance:getCurScene().map:switchMap(RougeMapModel.instance:getLayerId(), nil)
end

function var_0_0.showNodeClickArea(arg_7_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Rouge then
		return
	end

	if RougeMapModel.instance:getMapType() == RougeMapEnum.MapType.Edit then
		return
	end

	if arg_7_0.loadingText then
		return
	end

	arg_7_0.showing = true

	if arg_7_0.textGo then
		arg_7_0:_showNodeClickArea()
	else
		arg_7_0.loadingText = true

		loadAbAsset(var_0_0.TextPath, false, arg_7_0._onLoadTextCallback, arg_7_0)
	end
end

var_0_0.TextPath = "ui/viewres/gm/rouge/gm_rouge_text.prefab"

function var_0_0._onLoadTextCallback(arg_8_0, arg_8_1)
	if arg_8_1.IsLoadSuccess then
		local var_8_0 = arg_8_0._assetItem

		arg_8_0._assetItem = arg_8_1

		arg_8_0._assetItem:Retain()

		if var_8_0 then
			var_8_0:Release()
		end

		arg_8_0.textGo = arg_8_0._assetItem:GetResource(var_0_0.TextPath)
		arg_8_0.loadingText = false

		arg_8_0:_showNodeClickArea()
	end
end

function var_0_0._showNodeClickArea(arg_9_0)
	if not arg_9_0.showing then
		return
	end

	arg_9_0:createArea()
	RougeMapController.instance:registerCallback(RougeMapEvent.onMapPosChange, arg_9_0.onMapPosChange, arg_9_0, LuaEventSystem.Low)
	TaskDispatcher.runRepeat(arg_9_0.refreshPos, arg_9_0, 0.1)
end

var_0_0.AreaTextColor = Color.New(1, 0, 0, 1)

function var_0_0.createArea(arg_10_0)
	local var_10_0 = ViewMgr.instance:getContainer(ViewName.RougeMapView).viewGO
	local var_10_1 = arg_10_0.textGo
	local var_10_2 = gohelper.findChild(var_10_0, "areaContainer") or gohelper.create2d(var_10_0, "areaContainer")
	local var_10_3 = gohelper.findChild(var_10_0, "centerPointContainer") or gohelper.create2d(var_10_0, "centerPointContainer")
	local var_10_4 = var_10_2:GetComponent(gohelper.Type_RectTransform)
	local var_10_5 = var_10_3:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(var_10_2, true)
	gohelper.setActive(var_10_5, true)

	arg_10_0.goAreaContainer = var_10_2
	arg_10_0.goCenterPointContainer = var_10_3
	arg_10_0.textItemList = {}

	local var_10_6 = RougeMapController.instance:getMapComp():getMapItemList()

	for iter_10_0, iter_10_1 in ipairs(var_10_6) do
		local var_10_7 = gohelper.findChild(var_10_2, iter_10_0) or gohelper.create2d(var_10_2, iter_10_0)

		gohelper.setActive(var_10_7, true)

		local var_10_8 = gohelper.onceAddComponent(var_10_7, gohelper.Type_Image)

		ZProj.UGUIHelper.SetColorAlpha(var_10_8, 0.5)

		var_10_8.raycastTarget = false

		local var_10_9 = iter_10_1:getClickArea()
		local var_10_10 = var_10_9.x
		local var_10_11 = var_10_9.y
		local var_10_12 = var_10_9.z
		local var_10_13 = var_10_9.w
		local var_10_14, var_10_15 = iter_10_1:getUiPos(var_10_4)

		recthelper.setAnchor(var_10_7.transform, var_10_14 + var_10_12, var_10_15 + var_10_13)
		recthelper.setSize(var_10_7.transform, var_10_10, var_10_11)

		local var_10_16 = gohelper.findChild(var_10_3, iter_10_0) or gohelper.create2d(var_10_3, iter_10_0)

		gohelper.setActive(var_10_16, true)

		local var_10_17 = gohelper.onceAddComponent(var_10_16, gohelper.Type_Image)

		var_10_17.color = Color.New(0, 0, 0, 1)
		var_10_17.raycastTarget = false

		recthelper.setSize(var_10_16.transform, 20, 20)
		recthelper.setAnchor(var_10_16.transform, var_10_14, var_10_15)

		local var_10_18 = {}
		local var_10_19 = gohelper.findChild(var_10_7, "text") or gohelper.clone(var_10_1, var_10_7, "text")

		var_10_18.text = var_10_19:GetComponent(gohelper.Type_TextMesh)
		var_10_18.text.color = var_0_0.AreaTextColor
		var_10_18.areaRectTr = var_10_7:GetComponent(gohelper.Type_RectTransform)
		var_10_18.mapItem = iter_10_1

		local var_10_20 = var_10_19:GetComponent(gohelper.Type_RectTransform)

		recthelper.setAnchor(var_10_20, 0, 50)
		table.insert(arg_10_0.textItemList, var_10_18)
		arg_10_0:refreshOnePos(var_10_18)
	end
end

function var_0_0.refreshPos(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.textItemList) do
		if not arg_11_0:refreshOnePos(iter_11_1) then
			TaskDispatcher.cancelTask(arg_11_0.refreshPos, arg_11_0)

			return
		end
	end
end

function var_0_0.refreshOnePos(arg_12_0, arg_12_1)
	if gohelper.isNil(arg_12_1.areaRectTr) then
		return false
	end

	local var_12_0 = recthelper.getWidth(arg_12_1.areaRectTr)
	local var_12_1 = recthelper.getHeight(arg_12_1.areaRectTr)
	local var_12_2, var_12_3 = arg_12_1.mapItem:getUiPos(arg_12_0.goAreaContainer.transform)
	local var_12_4, var_12_5 = recthelper.getAnchor(arg_12_1.areaRectTr)
	local var_12_6 = var_12_4 - var_12_2
	local var_12_7 = var_12_5 - var_12_3

	arg_12_1.text.text = string.format("%s, %s, %s, %s", RougeMapHelper.retain2decimals(var_12_0), RougeMapHelper.retain2decimals(var_12_1), RougeMapHelper.retain2decimals(var_12_6), RougeMapHelper.retain2decimals(var_12_7))

	return true
end

function var_0_0.onMapPosChange(arg_13_0)
	if not arg_13_0.showing then
		return
	end

	arg_13_0:createArea()
end

function var_0_0.hideNodeClickArea(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.refreshPos, arg_14_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMapPosChange, arg_14_0.onMapPosChange, arg_14_0)

	if not arg_14_0.showing then
		return
	end

	if gohelper.isNil(arg_14_0.goAreaContainer) then
		return
	end

	arg_14_0.showing = false

	gohelper.setActive(arg_14_0.goAreaContainer, false)

	local var_14_0 = arg_14_0.goAreaContainer.transform
	local var_14_1 = var_14_0.childCount

	for iter_14_0 = 0, var_14_1 - 1 do
		local var_14_2 = var_14_0:GetChild(iter_14_0)

		gohelper.setActive(var_14_2.gameObject, false)
	end

	gohelper.setActive(arg_14_0.goCenterPointContainer, false)

	local var_14_3 = arg_14_0.goCenterPointContainer.transform
	local var_14_4 = var_14_3.childCount

	for iter_14_1 = 0, var_14_4 - 1 do
		local var_14_5 = var_14_3:GetChild(iter_14_1)

		gohelper.setActive(var_14_5.gameObject, false)
	end
end

function var_0_0.getIsShowing(arg_15_0)
	return arg_15_0.showing
end

function var_0_0.enterPathSelectMapEditorView(arg_16_0)
	if arg_16_0.flow then
		return
	end

	arg_16_0:_addPathSelectMapEditorView()

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Rouge then
		local var_16_0 = {
			mapType = RougeMapEnum.MapType.Middle,
			middleLayerInfo = {
				layerId = 101,
				middleLayerId = 101,
				positionIndex = RougeMapEnum.PathSelectIndex
			},
			HasField = function()
				return false
			end
		}

		RougeMapModel.instance:updateMapInfo(var_16_0)

		arg_16_0.flow = FlowSequence.New()

		arg_16_0.flow:addWork(OpenSceneWork.New(SceneType.Rouge, 1, 101))
		arg_16_0.flow:addWork(OpenViewWorkByViewName.New(ViewName.RougePathSelectMapEditorView))
		arg_16_0.flow:registerDoneListener(arg_16_0.onFlowDone, arg_16_0)
		arg_16_0.flow:start()

		return
	end

	if RougeMapModel.instance:isPathSelect() then
		ViewMgr.instance:openView(ViewName.RougePathSelectMapEditorView)
	end
end

function var_0_0.allowAbortFight(arg_18_0, arg_18_1)
	arg_18_0.allow = arg_18_1
end

function var_0_0.isAllowAbortFight(arg_19_0)
	return arg_19_0.allow and true or false
end

var_0_0.instance = var_0_0.New()

return var_0_0
