module("modules.logic.handbook.view.HandbookWeekWalkSceneView", package.seeall)

local var_0_0 = class("HandbookWeekWalkSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.mapId = arg_6_0.viewParam.id
	arg_6_0.mapCo = WeekWalkConfig.instance:getMapConfig(arg_6_0.mapId)
	arg_6_0.mapBranchCoList = WeekWalkConfig.instance:getMapBranchCoList(1)
	arg_6_0.elementList = arg_6_0:getUserDataTb_()
	arg_6_0.handbookElementList = arg_6_0:getUserDataTb_()

	arg_6_0:createSceneMapNode()
	arg_6_0:loadMap()
	MainCameraMgr.instance:addView(ViewName.HandbookWeekWalkView, arg_6_0.initCamera, nil, arg_6_0)
end

function var_0_0.createSceneMapNode(arg_7_0)
	local var_7_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_7_1 = CameraMgr.instance:getSceneRoot()

	arg_7_0._sceneRoot = UnityEngine.GameObject.New("WeekWalkMap")

	local var_7_2, var_7_3, var_7_4 = transformhelper.getLocalPos(var_7_0)

	transformhelper.setLocalPos(arg_7_0._sceneRoot.transform, 0, var_7_3, 0)
	gohelper.addChild(var_7_1, arg_7_0._sceneRoot)
end

function var_0_0.loadMap(arg_8_0)
	arg_8_0._mapLoader = MultiAbLoader.New()

	arg_8_0._mapLoader:addPath(arg_8_0.mapCo.map)

	arg_8_0._canvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"

	arg_8_0._mapLoader:addPath(arg_8_0._canvasUrl)
	arg_8_0._mapLoader:startLoad(arg_8_0.loadMapCallback, arg_8_0)
end

function var_0_0.loadMapCallback(arg_9_0)
	local var_9_0 = arg_9_0._mapLoader:getAssetItem(arg_9_0.mapCo.map):GetResource(arg_9_0.mapCo.map)

	arg_9_0._sceneGo = gohelper.clone(var_9_0, arg_9_0._sceneRoot, tostring(arg_9_0.mapCo.id))

	gohelper.setActive(arg_9_0._sceneGo, true)

	arg_9_0._sceneTrans = arg_9_0._sceneGo.transform
	arg_9_0._diffuseGo = gohelper.findChild(arg_9_0._sceneGo, "Obj-Plant/all/diffuse")
	arg_9_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(arg_9_0._sceneGo, arg_9_0._elementRoot)
	arg_9_0:refreshScene(1)
end

function var_0_0.refreshScene(arg_10_0, arg_10_1)
	arg_10_0.elementIdList = {}
	arg_10_0.handbookElementIdList = {}

	for iter_10_0, iter_10_1 in ipairs(string.splitToNumber(arg_10_0.mapBranchCoList[arg_10_1].handbookPath)) do
		table.insert(arg_10_0.handbookElementIdList, iter_10_1)
	end

	for iter_10_2, iter_10_3 in ipairs(string.splitToNumber(arg_10_0.mapBranchCoList[arg_10_1].nodePath)) do
		table.insert(arg_10_0.elementIdList, iter_10_3)
	end

	arg_10_0:loadElements()
end

function var_0_0.loadElements(arg_11_0)
	local var_11_0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.elementIdList) do
		local var_11_1 = arg_11_0.elementList[iter_11_1]

		if not var_11_1 then
			var_11_1 = arg_11_0:createElementComp(iter_11_1)
			arg_11_0.elementList[iter_11_1] = var_11_1
		end

		var_11_1:updateInfo(iter_11_1)
		var_11_1:refresh()
	end
end

function var_0_0.createElementComp(arg_12_0, arg_12_1)
	local var_12_0 = UnityEngine.GameObject.New(tostring(arg_12_1))

	gohelper.addChild(arg_12_0._elementRoot, var_12_0)

	return MonoHelper.addLuaComOnceToGo(var_12_0, HandbookWeekWalkMapElement, {
		parentView = arg_12_0,
		diffuseGo = arg_12_0._diffuseGo
	})
end

function var_0_0.loadHandbookElements(arg_13_0)
	return
end

function var_0_0.initCamera(arg_14_0)
	local var_14_0 = CameraMgr.instance:getMainCamera()

	var_14_0.orthographic = true

	transformhelper.setLocalRotation(var_14_0.transform, 0, 0, 0)

	local var_14_1 = GameUtil.getAdapterScale()

	var_14_0.orthographicSize = WeekWalkEnum.orthographicSize * var_14_1
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
