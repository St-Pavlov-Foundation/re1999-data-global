module("modules.logic.rouge.map.view.map.RougeMapLayerRightView", package.seeall)

slot0 = class("RougeMapLayerRightView", BaseView)

function slot0.onInitView(slot0)
	slot0.goLayerRight = gohelper.findChild(slot0.viewGO, "#go_layer_right")
	slot0.simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_layer_right/RightBG2/#simage_newrightbg")
	slot0.simagelayerbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_layer_right/#simage_picbg")
	slot0.simagelayerpic = gohelper.findChildSingleImage(slot0.viewGO, "#go_layer_right/#simage_pic")
	slot0._txtChapterName = gohelper.findChildText(slot0.viewGO, "#go_layer_right/Title/#txt_ChapterName")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_layer_right/#txt_Desc")
	slot0._btnNext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_layer_right/Title/#btn_next")
	slot0._btnLast = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_layer_right/Title/#btn_last")
	slot0._btnMove = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_layer_right/#btn_MoveBtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnNext:AddClickListener(slot0._btnNextOnClick, slot0)
	slot0._btnLast:AddClickListener(slot0._btnLastOnClick, slot0)
	slot0._btnMove:AddClickListener(slot0._btnMoveOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnNext:RemoveClickListener()
	slot0._btnLast:RemoveClickListener()
	slot0._btnMove:RemoveClickListener()
end

function slot0._btnLastOnClick(slot0)
	if slot0.curSelectIndex <= 1 then
		return
	end

	slot0.curSelectIndex = slot0.curSelectIndex - 1

	slot0:changeSelectLayer()
end

function slot0._btnNextOnClick(slot0)
	if slot0.nextLayerLen <= slot0.curSelectIndex then
		return
	end

	slot0.curSelectIndex = slot0.curSelectIndex + 1

	slot0:changeSelectLayer()
end

function slot0.changeSelectLayer(slot0)
	RougeMapModel.instance:updateSelectLayerId(slot0.nextLayerList[slot0.curSelectIndex])
end

function slot0._btnMoveOnClick(slot0)
	RougeRpc.instance:sendRougeLeaveMiddleLayerRequest(slot0.layerCo.id)
end

function slot0._editableInitView(slot0)
	slot0.simagerightbg:LoadImage("singlebg/rouge/map/rouge_map_detailbg2.png")
	slot0.simagelayerbg:LoadImage("singlebg/rouge/map/rouge_map_detailbg3.png")

	slot0.goNextBtn = slot0._btnNext.gameObject
	slot0.goLastBtn = slot0._btnLast.gameObject
	slot0.layerAnimator = slot0.goLayerRight:GetComponent(gohelper.Type_Animator)

	slot0:hide()
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLayerChange, slot0.onSelectLayerChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, slot0.onPathSelectMapFocusDone, slot0)
end

function slot0.onChangeMapInfo(slot0)
	if not RougeMapModel.instance:isPathSelect() then
		slot0:hide()

		return
	end

	slot0:initData()
end

function slot0.onSelectLayerChange(slot0, slot1)
	slot0.layerCo = lua_rouge_layer.configDict[slot1]

	slot0:updateSelectIndex()
	slot0.layerAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(slot0.refresh, slot0)
	TaskDispatcher.runDelay(slot0.refresh, slot0, RougeMapEnum.WaitMapRightRefreshTime)
end

function slot0.onOpen(slot0)
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	slot0:initData()
end

function slot0.initData(slot0)
	slot0.nextLayerList = RougeMapModel.instance:getNextLayerList()
	slot0.nextLayerLen = #slot0.nextLayerList
	slot0.layerCo = lua_rouge_layer.configDict[RougeMapModel.instance:getSelectLayerId()]

	slot0:updateSelectIndex()
end

function slot0.updateSelectIndex(slot0)
	slot0.curSelectIndex = 1

	for slot4, slot5 in ipairs(slot0.nextLayerList) do
		if slot0.layerCo.id == slot5 then
			slot0.curSelectIndex = slot4
		end
	end
end

function slot0.onPathSelectMapFocusDone(slot0)
	slot0:refresh()
end

function slot0.refresh(slot0)
	slot0:show()
	slot0:refreshLayerInfo()
	slot0:refreshArrow()
	slot0:refreshImage()
end

function slot0.refreshLayerInfo(slot0)
	slot0._txtChapterName.text = slot0.layerCo.name
	slot0._txtDesc.text = slot0.layerCo.desc
end

function slot0.refreshArrow(slot0)
	gohelper.setActive(slot0.goNextBtn, slot0.curSelectIndex < slot0.nextLayerLen)
	gohelper.setActive(slot0.goLastBtn, slot0.curSelectIndex > 1)
end

function slot0.refreshImage(slot0)
	if string.nilorempty(slot0.layerCo.iconRes) then
		return
	end

	slot0.simagelayerpic:LoadImage(string.format("singlebg/rouge/mapdetail/%s.png", slot1))
end

function slot0.show(slot0)
	gohelper.setActive(slot0.goLayerRight, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.goLayerRight, false)
end

function slot0.onDestroyView(slot0)
	slot0.simagerightbg:UnLoadImage()
	slot0.simagelayerbg:UnLoadImage()
	slot0.simagelayerpic:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.refresh, slot0)
end

return slot0
