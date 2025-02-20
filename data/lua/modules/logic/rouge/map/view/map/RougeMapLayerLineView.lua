module("modules.logic.rouge.map.view.map.RougeMapLayerLineView", package.seeall)

slot0 = class("RougeMapLayerLineView", BaseView)

function slot0.onInitView(slot0)
	slot0.goLineContainer = gohelper.findChild(slot0.viewGO, "#go_linecontainer")
	slot0.goLineIconItem = gohelper.findChild(slot0.viewGO, "#go_linecontainer/#go_lineitem")
	slot0.goLine = gohelper.findChild(slot0.viewGO, "#go_linecontainer/#go_line")
	slot0.goStart = gohelper.findChild(slot0.viewGO, "#go_linecontainer/#go_start")
	slot0.goEnd = gohelper.findChild(slot0.viewGO, "#go_linecontainer/#go_end")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0.goLineIconItem, false)
	gohelper.setActive(slot0.goLine, false)

	slot0.rectTrStart = slot0.goStart:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrEnd = slot0.goEnd:GetComponent(gohelper.Type_RectTransform)

	slot0:hide()

	slot0.lineItemList = {}

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLayerChange, slot0.onSelectLayerChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, slot0.onPathSelectMapFocusDone, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
end

function slot0.onChangeMapInfo(slot0)
	if not RougeMapModel.instance:isPathSelect() then
		slot0:hide()

		return
	end

	slot0:initData()
end

function slot0.onSelectLayerChange(slot0, slot1)
	slot0.selectLayerId = slot1

	slot0:refreshLayerSelect()
end

function slot0.onOpen(slot0)
	slot0:hide()

	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	slot0:initData()
end

function slot0.initData(slot0)
	slot0.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	slot0.nextLayerList = RougeMapModel.instance:getNextLayerList()
	slot0.selectLayerId = RougeMapModel.instance:getSelectLayerId()
end

function slot0.onPathSelectMapFocusDone(slot0)
	slot0:show()
	slot0:refreshLayer()
end

function slot0.refreshLayer(slot0)
	slot1, slot2 = RougeMapHelper.getPos(slot0.pathSelectCo.startPos)

	recthelper.setAnchor(slot0.rectTrStart, slot1, slot2)

	slot6, slot7 = RougeMapHelper.getPos(slot0.pathSelectCo.endPos)

	recthelper.setAnchor(slot0.rectTrEnd, slot6, slot7)

	for slot6, slot7 in ipairs(slot0.nextLayerList) do
		slot8 = lua_rouge_layer.configDict[slot7]
		slot9 = slot0.lineItemList[slot6] or slot0:createLineItem(slot8)

		gohelper.setActive(slot9.lineContainer, true)

		slot9.lineContainer.name = slot8.id

		slot9.simageLine:LoadImage(slot8.pathRes, slot0.onLoadImageDone, slot9)

		slot10 = slot8.name
		slot9.txtSelectLayerName.text = slot10
		slot9.txtUnSelectLayerName.text = slot10
		slot9.layerCo = slot8
		slot11, slot12 = RougeMapHelper.getPos(slot8.pathPos)

		recthelper.setAnchor(slot9.rectLine, slot11, slot12)

		slot11, slot12 = RougeMapHelper.getPos(slot8.iconPos)

		recthelper.setAnchor(slot9.rectLineIcon, slot11, slot12)

		slot11 = slot9.layerCo.id == slot0.selectLayerId

		slot9.animator:Play(slot11 and "select_open" or "unselect_open")
		ZProj.UGUIHelper.SetColorAlpha(slot9.imageLine, slot11 and 1 or 0.33)
	end

	for slot6 = #slot0.nextLayerList + 1, #slot0.lineItemList do
		gohelper.setActive(slot0.lineItemList[slot6].lineContainer, false)
	end
end

function slot0.refreshLayerSelect(slot0)
	for slot4, slot5 in ipairs(slot0.lineItemList) do
		slot6 = slot5.layerCo.id == slot0.selectLayerId

		slot5.animator:Play(slot6 and "select" or "unselect")
		ZProj.UGUIHelper.SetColorAlpha(slot5.imageLine, slot6 and 1 or 0.33)
	end
end

function slot0.createLineItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot2 = gohelper.create2d(slot0.goLineContainer)
	slot3 = gohelper.clone(slot0.goLine, slot2, "line")
	slot4 = gohelper.clone(slot0.goLineIconItem, slot2, "lineIcon")

	gohelper.setActive(slot3, true)
	gohelper.setActive(slot4, true)

	slot1.lineContainer = slot2
	slot1.rectLine = slot3:GetComponent(gohelper.Type_RectTransform)
	slot1.rectLineIcon = slot4:GetComponent(gohelper.Type_RectTransform)
	slot1.simageLine = SLFramework.UGUI.SingleImage.Get(slot3)
	slot1.imageLine = slot3:GetComponent(gohelper.Type_Image)
	slot1.iconSelect = gohelper.findChild(slot4, "select")
	slot1.txtSelectLayerName = gohelper.findChildText(slot4, "select/#txt_line")
	slot1.iconUnSelect = gohelper.findChild(slot4, "unselect")
	slot1.txtUnSelectLayerName = gohelper.findChildText(slot4, "unselect/#txt_line")
	slot1.animator = slot4:GetComponent(gohelper.Type_Animator)
	slot1.click = gohelper.getClickWithDefaultAudio(slot4)

	slot1.click:AddClickListener(slot0.onClickLine, slot0, slot1)
	gohelper.setActive(slot1.iconSelect, true)
	gohelper.setActive(slot1.iconUnSelect, true)
	table.insert(slot0.lineItemList, slot1)

	return slot1
end

function slot0.onClickLine(slot0, slot1)
	RougeMapModel.instance:updateSelectLayerId(slot1.layerCo.id)
end

function slot0.onLoadImageDone(slot0)
	slot0.imageLine:SetNativeSize()
end

function slot0.show(slot0)
	gohelper.setActive(slot0.goLineContainer, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.goLineContainer, false)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.lineItemList) do
		slot5.simageLine:UnLoadImage()
		slot5.click:RemoveClickListener()
	end

	slot0.lineItemList = nil
end

return slot0
