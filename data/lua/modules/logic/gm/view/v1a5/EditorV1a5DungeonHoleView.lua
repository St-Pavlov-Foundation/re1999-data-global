module("modules.logic.gm.view.v1a5.EditorV1a5DungeonHoleView", package.seeall)

local var_0_0 = class("EditorV1a5DungeonHoleView", UserDataDispose)
local var_0_1 = "ui/viewres/gm/v1a5holeedit.prefab"

function var_0_0.start(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0:__onInit()
	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1._views[7]

	if var_2_0 and not var_2_0.delete then
		var_2_0:onRecycleAllElement()
		var_2_0:onClose()
		var_2_0:onDestroyView()
		var_2_0:__onDispose()

		var_2_0.delete = true
	end

	arg_2_0.viewGO = arg_2_1.viewGO
	arg_2_0.viewContainer = arg_2_1
	arg_2_0.viewName = arg_2_1.viewName
	arg_2_0._godispatcharea = gohelper.findChild(arg_2_0.viewGO, "#go_dispatcharea")
	arg_2_0._goareaitem = gohelper.findChild(arg_2_0.viewGO, "#go_dispatcharea/#go_areaitem")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_3_0)
	gohelper.setActive(arg_3_0._godispatcharea, true)
	gohelper.setActive(arg_3_0._goareaitem, false)

	arg_3_0.transform = arg_3_0._godispatcharea:GetComponent(gohelper.Type_RectTransform)
	arg_3_0.areaItemList = {}
	arg_3_0.shaderParamList = arg_3_0:getUserDataTb_()
	arg_3_0.shaderParamValueList = {}

	for iter_3_0 = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		table.insert(arg_3_0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. iter_3_0))
		table.insert(arg_3_0.shaderParamValueList, Vector4.zero)
	end

	arg_3_0.sceneGo = arg_3_0.viewContainer.mapScene:getSceneGo()
	arg_3_0.sceneTrans = arg_3_0.sceneGo.transform

	local var_3_0 = gohelper.findChild(arg_3_0.sceneGo, "Obj-Plant/FogOfWar/m_s14_hddt_mask")

	if not var_3_0 then
		logError("not found shader mask go, " .. arg_3_0.sceneGo.name)

		return
	end

	arg_3_0.shader = var_3_0:GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial

	arg_3_0:hideAllHoles()
	arg_3_0:changeTestPos(0, 0)
	arg_3_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, arg_3_0.onMapPosChanged, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0.onCloseView, arg_3_0)

	arg_3_0.loader = PrefabInstantiate.Create(arg_3_0.viewGO)

	arg_3_0.loader:startLoad(var_0_1, arg_3_0.onLoadFinish, arg_3_0)
end

function var_0_0.onLoadFinish(arg_4_0)
	arg_4_0.itemList = {}
	arg_4_0.go = arg_4_0.loader:getInstGO()
	arg_4_0.keyList = {
		"X",
		"Y"
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.keyList) do
		arg_4_0:initItem(iter_4_1)
	end

	arg_4_0.closeBtn = gohelper.findChildButtonWithAudio(arg_4_0.go, "closeBtn")

	arg_4_0.closeBtn:AddClickListener(arg_4_0.onClickCloseBtn, arg_4_0)
end

function var_0_0.hideAllHoles(arg_5_0)
	for iter_5_0 = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		local var_5_0 = arg_5_0.shaderParamValueList[iter_5_0]

		var_5_0:Set(VersionActivity1_5DungeonEnum.OutSideAreaPos.X, VersionActivity1_5DungeonEnum.OutSideAreaPos.Y)
		arg_5_0.shader:SetVector(arg_5_0.shaderParamList[iter_5_0], var_5_0)
	end
end

function var_0_0.changeTestPos(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.configPosX = arg_6_1
	arg_6_0.configPosY = arg_6_2

	arg_6_0:onMapPosChanged()
end

function var_0_0.onMapPosChanged(arg_7_0)
	local var_7_0
	local var_7_1
	local var_7_2, var_7_3, var_7_4 = transformhelper.getPos(arg_7_0.sceneTrans)
	local var_7_5 = arg_7_0.configPosX + var_7_2
	local var_7_6 = arg_7_0.configPosY + var_7_3
	local var_7_7 = arg_7_0.shaderParamValueList[1]

	var_7_7:Set(var_7_5, var_7_6)
	arg_7_0.shader:SetVector(arg_7_0.shaderParamList[1], var_7_7)
	arg_7_0:refreshAreaItem(1)
end

function var_0_0.refreshAreaItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.areaItemList[arg_8_1] or arg_8_0:createAreaItem()

	gohelper.setActive(var_8_0.go, true)

	local var_8_1 = arg_8_0.shaderParamValueList[arg_8_1]
	local var_8_2 = recthelper.worldPosToAnchorPos(var_8_1, arg_8_0.transform)

	recthelper.setAnchor(var_8_0.rectTr, var_8_2.x, var_8_2.y + VersionActivity1_5DungeonEnum.AreaItemOffsetY)
end

function var_0_0.createAreaItem(arg_9_0)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = gohelper.cloneInPlace(arg_9_0._goareaitem)
	var_9_0.rectTr = var_9_0.go:GetComponent(gohelper.Type_RectTransform)

	table.insert(arg_9_0.areaItemList, var_9_0)

	return var_9_0
end

function var_0_0.initItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getUserDataTb_()

	var_10_0.go = gohelper.findChild(arg_10_0.go, "item" .. arg_10_1)

	if not var_10_0.go then
		logError("not found item " .. tostring(arg_10_1))

		return
	end

	var_10_0.txtValue = gohelper.findChildText(var_10_0.go, "value")
	var_10_0.reduceBtn = gohelper.findChildButtonWithAudio(var_10_0.go, "reducebtn")
	var_10_0.addBtn = gohelper.findChildButtonWithAudio(var_10_0.go, "addbtn")
	var_10_0.intervalInput = gohelper.findChildTextMeshInputField(var_10_0.go, "intervalInput")

	var_10_0.reduceBtn:AddClickListener(arg_10_0.onClickReduceBtn, arg_10_0, var_10_0)
	var_10_0.addBtn:AddClickListener(arg_10_0.onClickAddBtn, arg_10_0, var_10_0)

	var_10_0.value = 0
	var_10_0.txtValue.text = var_10_0.value

	var_10_0.intervalInput:SetText(1)
	table.insert(arg_10_0.itemList, var_10_0)

	return var_10_0
end

function var_0_0.onClickReduceBtn(arg_11_0, arg_11_1)
	local var_11_0 = tonumber(arg_11_1.intervalInput:GetText())

	if not var_11_0 then
		ToastController.instance:showToastWithString("间隔请输入数字")

		return
	end

	arg_11_1.value = arg_11_1.value - var_11_0
	arg_11_1.txtValue.text = arg_11_1.value

	arg_11_0:setConfigPos()
end

function var_0_0.onClickAddBtn(arg_12_0, arg_12_1)
	local var_12_0 = tonumber(arg_12_1.intervalInput:GetText())

	if not var_12_0 then
		ToastController.instance:showToastWithString("间隔请输入数字")

		return
	end

	arg_12_1.value = arg_12_1.value + var_12_0
	arg_12_1.txtValue.text = arg_12_1.value

	arg_12_0:setConfigPos()
end

function var_0_0.setConfigPos(arg_13_0)
	local var_13_0 = arg_13_0.itemList[1].value
	local var_13_1 = arg_13_0.itemList[2].value

	arg_13_0:changeTestPos(var_13_0, var_13_1)
end

function var_0_0.onClickCloseBtn(arg_14_0)
	arg_14_0:close()
end

function var_0_0.onCloseView(arg_15_0, arg_15_1)
	if arg_15_1 == ViewName.VersionActivity1_5DungeonMapView then
		arg_15_0:close()
	end
end

function var_0_0.close(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.itemList) do
		iter_16_1.reduceBtn:RemoveClickListener()
		iter_16_1.addBtn:RemoveClickListener()
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.areaItemList) do
		gohelper.destroy(iter_16_3.go)
	end

	arg_16_0.closeBtn:RemoveClickListener()
	gohelper.destroy(arg_16_0.go)
	arg_16_0:__onDispose()
end

return var_0_0
