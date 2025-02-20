module("modules.logic.gm.view.v1a5.EditorV1a5DungeonHoleView", package.seeall)

slot0 = class("EditorV1a5DungeonHoleView", UserDataDispose)
slot1 = "ui/viewres/gm/v1a5holeedit.prefab"

function slot0.start(slot0)
	slot1 = uv0.New()

	slot1:__onInit()
	slot1:init(slot0)

	return slot1
end

function slot0.init(slot0, slot1)
	if slot1._views[7] and not slot2.delete then
		slot2:onRecycleAllElement()
		slot2:onClose()
		slot2:onDestroyView()
		slot2:__onDispose()

		slot2.delete = true
	end

	slot0.viewGO = slot1.viewGO
	slot0.viewContainer = slot1
	slot0.viewName = slot1.viewName
	slot0._godispatcharea = gohelper.findChild(slot0.viewGO, "#go_dispatcharea")
	slot0._goareaitem = gohelper.findChild(slot0.viewGO, "#go_dispatcharea/#go_areaitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._godispatcharea, true)
	gohelper.setActive(slot0._goareaitem, false)

	slot4 = gohelper.Type_RectTransform
	slot0.transform = slot0._godispatcharea:GetComponent(slot4)
	slot0.areaItemList = {}
	slot0.shaderParamList = slot0:getUserDataTb_()
	slot0.shaderParamValueList = {}

	for slot4 = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		table.insert(slot0.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. slot4))
		table.insert(slot0.shaderParamValueList, Vector4.zero)
	end

	slot0.sceneGo = slot0.viewContainer.mapScene:getSceneGo()
	slot0.sceneTrans = slot0.sceneGo.transform

	if not gohelper.findChild(slot0.sceneGo, "Obj-Plant/FogOfWar/m_s14_hddt_mask") then
		logError("not found shader mask go, " .. slot0.sceneGo.name)

		return
	end

	slot0.shader = slot1:GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial

	slot0:hideAllHoles()
	slot0:changeTestPos(0, 0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)

	slot0.loader = PrefabInstantiate.Create(slot0.viewGO)

	slot0.loader:startLoad(uv0, slot0.onLoadFinish, slot0)
end

function slot0.onLoadFinish(slot0)
	slot0.itemList = {}
	slot0.go = slot0.loader:getInstGO()
	slot0.keyList = {
		"X",
		"Y"
	}

	for slot4, slot5 in ipairs(slot0.keyList) do
		slot0:initItem(slot5)
	end

	slot0.closeBtn = gohelper.findChildButtonWithAudio(slot0.go, "closeBtn")

	slot0.closeBtn:AddClickListener(slot0.onClickCloseBtn, slot0)
end

function slot0.hideAllHoles(slot0)
	for slot4 = 1, VersionActivity1_5DungeonEnum.MaxHoleNum do
		slot5 = slot0.shaderParamValueList[slot4]

		slot5:Set(VersionActivity1_5DungeonEnum.OutSideAreaPos.X, VersionActivity1_5DungeonEnum.OutSideAreaPos.Y)
		slot0.shader:SetVector(slot0.shaderParamList[slot4], slot5)
	end
end

function slot0.changeTestPos(slot0, slot1, slot2)
	slot0.configPosX = slot1
	slot0.configPosY = slot2

	slot0:onMapPosChanged()
end

function slot0.onMapPosChanged(slot0)
	slot1, slot2 = nil
	slot3, slot4, slot5 = transformhelper.getPos(slot0.sceneTrans)
	slot6 = slot0.shaderParamValueList[1]

	slot6:Set(slot0.configPosX + slot3, slot0.configPosY + slot4)
	slot0.shader:SetVector(slot0.shaderParamList[1], slot6)
	slot0:refreshAreaItem(1)
end

function slot0.refreshAreaItem(slot0, slot1)
	slot2 = slot0.areaItemList[slot1] or slot0:createAreaItem()

	gohelper.setActive(slot2.go, true)

	slot4 = recthelper.worldPosToAnchorPos(slot0.shaderParamValueList[slot1], slot0.transform)

	recthelper.setAnchor(slot2.rectTr, slot4.x, slot4.y + VersionActivity1_5DungeonEnum.AreaItemOffsetY)
end

function slot0.createAreaItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goareaitem)
	slot1.rectTr = slot1.go:GetComponent(gohelper.Type_RectTransform)

	table.insert(slot0.areaItemList, slot1)

	return slot1
end

function slot0.initItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.findChild(slot0.go, "item" .. slot1)

	if not slot2.go then
		logError("not found item " .. tostring(slot1))

		return
	end

	slot2.txtValue = gohelper.findChildText(slot2.go, "value")
	slot2.reduceBtn = gohelper.findChildButtonWithAudio(slot2.go, "reducebtn")
	slot2.addBtn = gohelper.findChildButtonWithAudio(slot2.go, "addbtn")
	slot2.intervalInput = gohelper.findChildTextMeshInputField(slot2.go, "intervalInput")

	slot2.reduceBtn:AddClickListener(slot0.onClickReduceBtn, slot0, slot2)
	slot2.addBtn:AddClickListener(slot0.onClickAddBtn, slot0, slot2)

	slot2.value = 0
	slot2.txtValue.text = slot2.value

	slot2.intervalInput:SetText(1)
	table.insert(slot0.itemList, slot2)

	return slot2
end

function slot0.onClickReduceBtn(slot0, slot1)
	if not tonumber(slot1.intervalInput:GetText()) then
		ToastController.instance:showToastWithString("间隔请输入数字")

		return
	end

	slot1.value = slot1.value - slot2
	slot1.txtValue.text = slot1.value

	slot0:setConfigPos()
end

function slot0.onClickAddBtn(slot0, slot1)
	if not tonumber(slot1.intervalInput:GetText()) then
		ToastController.instance:showToastWithString("间隔请输入数字")

		return
	end

	slot1.value = slot1.value + slot2
	slot1.txtValue.text = slot1.value

	slot0:setConfigPos()
end

function slot0.setConfigPos(slot0)
	slot0:changeTestPos(slot0.itemList[1].value, slot0.itemList[2].value)
end

function slot0.onClickCloseBtn(slot0)
	slot0:close()
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5DungeonMapView then
		slot0:close()
	end
end

function slot0.close(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5.reduceBtn:RemoveClickListener()
		slot5.addBtn:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0.areaItemList) do
		gohelper.destroy(slot5.go)
	end

	slot0.closeBtn:RemoveClickListener()
	gohelper.destroy(slot0.go)
	slot0:__onDispose()
end

return slot0
