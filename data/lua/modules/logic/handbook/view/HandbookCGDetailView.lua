module("modules.logic.handbook.view.HandbookCGDetailView", package.seeall)

slot0 = class("HandbookCGDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._simagecg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_cg")
	slot0._simagezone = gohelper.findChildSingleImage(slot0.viewGO, "#simage_cg/#simage_zone")
	slot0._simagecgold = gohelper.findChildSingleImage(slot0.viewGO, "#simage_cgold")
	slot0._simagezoneold = gohelper.findChildSingleImage(slot0.viewGO, "#simage_cgold/#simage_zoneold")
	slot0._btnprev = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#btn_prev")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#btn_next")
	slot0._txttitleNameEn = gohelper.findChildText(slot0.viewGO, "#go_ui/desc/#txt_titleNameEn")
	slot0._txttitleName = gohelper.findChildText(slot0.viewGO, "#go_ui/desc/#txt_titleName")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_ui/desc/#scroll_desc/Viewport/Content/#txt_desc")
	slot0._txtcurindex = gohelper.findChildText(slot0.viewGO, "#go_ui/page/#txt_curindex")
	slot0._txttotalpage = gohelper.findChildText(slot0.viewGO, "#go_ui/page/#txt_curindex/#txt_totalpage")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#btn_click/#go_drag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnprev:AddClickListener(slot0._btnprevOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnprev:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	slot0:_setUIActive(not slot0._uiActive)
end

function slot0._btnprevOnClick(slot0)
	if not HandbookModel.instance:getPrevCG(slot0._cgId, slot0._cgType) then
		return
	end

	slot0._cgId = slot1.id

	slot0:_refreshUI()
end

function slot0._btnnextOnClick(slot0)
	if not HandbookModel.instance:getNextCG(slot0._cgId, slot0._cgType) then
		return
	end

	slot0._cgId = slot1.id

	slot0:_refreshUI()
end

function slot0._setUIActive(slot0, slot1)
	slot0._uiActive = slot1

	gohelper.setActive(slot0._goui, slot0._uiActive)
end

function slot0._editableInitView(slot0)
	slot0._cimagecg = slot0._simagecg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	slot0._imageZone = gohelper.findChildImage(slot0.viewGO, "#simage_cg/#simage_zone")
	slot0._cimagecgold = slot0._simagecgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	slot0._imageZoneOld = gohelper.findChildImage(slot0.viewGO, "#simage_cgold/#simage_zoneold")

	gohelper.setActive(slot0._simagecg.gameObject, false)
	gohelper.setActive(slot0._simagecgold.gameObject, false)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godrag)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	gohelper.addUIClickAudio(slot0._btnprev.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
	gohelper.addUIClickAudio(slot0._btnnext.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	slot0.loadedCgList = {}
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._startPos = slot2.position.x
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0._startPos < slot2.position.x and slot3 - slot0._startPos >= 100 then
		slot0:_btnprevOnClick()
	elseif slot3 < slot0._startPos and slot0._startPos - slot3 >= 100 then
		slot0:_btnnextOnClick()
	end
end

function slot0.onOpen(slot0)
	slot0._cgId = slot0.viewParam.id
	slot0._cgType = slot0.viewParam.cgType

	slot0:_refreshUI()
end

function slot0.onUpdateParam(slot0)
	slot0._cgId = slot0.viewParam
	slot0._cgType = slot0.viewParam.cgType

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if not HandbookModel.instance:isRead(HandbookEnum.Type.CG, slot0._cgId) then
		HandbookRpc.instance:sendHandbookReadRequest(HandbookEnum.Type.CG, slot0._cgId)
	end

	slot0:_setUIActive(true)
	UIBlockMgr.instance:startBlock("loadZone")

	if StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image) then
		slot0._simagezone:LoadImage(ResUrl.getStoryRes(slot3.path), slot0._onZoneImageLoaded, slot0)
	else
		gohelper.setActive(slot0._simagezone.gameObject, false)

		slot0._cimagecg.vecInSide = Vector4.zero

		slot0:_startLoadOriginImg()
	end

	slot0._txttitleName.text = slot2.name
	slot0._txttitleNameEn.text = slot2.nameEn
	slot0._txtdesc.text = slot2.desc
	slot0._txtcurindex.text = HandbookModel.instance:getCGUnlockIndex(slot0._cgId, slot0._cgType)
	slot0._txttotalpage.text = "/" .. HandbookModel.instance:getCGUnlockCount(nil, slot0._cgType)
end

function slot0._startLoadOriginImg(slot0)
	slot0._simagecg:LoadImage(slot0:getImageName(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType)), slot0.onLoadedImage, slot0)
end

function slot0._onZoneImageLoaded(slot0)
	slot0._imageZone:SetNativeSize()
	slot0:_startLoadOriginImg()
end

function slot0.getImageName(slot0, slot1)
	if not tabletool.indexOf(slot0.loadedCgList, slot1.id) then
		table.insert(slot0.loadedCgList, slot1.id)
	end

	slot0.lastLoadImageId = slot1.id

	if StoryBgZoneModel.instance:getBgZoneByPath(slot1.image) then
		return ResUrl.getStoryRes(slot2.sourcePath)
	end

	return ResUrl.getStoryBg(slot1.image)
end

function slot0.onLoadedImage(slot0)
	if StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image) then
		gohelper.setActive(slot0._simagezone.gameObject, true)
		transformhelper.setLocalPosXY(slot0._simagezone.gameObject.transform, slot2.offsetX, slot2.offsetY)

		slot4 = StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image)
		slot0._cimagecg.vecInSide = Vector4(recthelper.getWidth(slot0._imageZone.transform), recthelper.getHeight(slot0._imageZone.transform), slot4.offsetX, slot4.offsetY)

		slot0:_loadOldZoneImage()
	else
		gohelper.setActive(slot0._simagezoneold.gameObject, false)
		slot0:_startLoadOldImg()
	end

	gohelper.setActive(slot0._simagecg.gameObject, true)

	if #slot0.loadedCgList <= 10 then
		return
	end

	slot0.loadedCgList = {
		slot0.lastLoadImageId
	}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)
end

function slot0._loadOldZoneImage(slot0)
	if StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image) then
		slot0._simagezoneold:LoadImage(ResUrl.getStoryRes(slot2.path), slot0._onZoneImageOldLoaded, slot0)
	else
		gohelper.setActive(slot0._simagezoneold.gameObject, false)

		slot0._cimagecgold.vecInSide = Vector4.zero

		slot0:_startLoadOldImg()
	end
end

function slot0._onZoneImageOldLoaded(slot0)
	slot0._imageZoneOld:SetNativeSize()
	slot0:_startLoadOldImg()
end

function slot0._startLoadOldImg(slot0)
	slot0._simagecgold:LoadImage(slot0:getImageName(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType)), slot0._onLoadOldFinished, slot0)
end

function slot0._onLoadOldFinished(slot0)
	UIBlockMgr.instance:endBlock("loadZone")

	if StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image) then
		gohelper.setActive(slot0._simagezoneold.gameObject, true)
		transformhelper.setLocalPosXY(slot0._simagezoneold.gameObject.transform, slot2.offsetX, slot2.offsetY)

		slot4 = StoryBgZoneModel.instance:getBgZoneByPath(HandbookConfig.instance:getCGConfig(slot0._cgId, slot0._cgType).image)
		slot0._cimagecgold.vecInSide = Vector4(recthelper.getWidth(slot0._imageZoneOld.transform), recthelper.getHeight(slot0._imageZoneOld.transform), slot4.offsetX, slot4.offsetY)
	end

	gohelper.setActive(slot0._simagecg.gameObject, false)
	gohelper.setActive(slot0._simagecgold.gameObject, true)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("loadZone")
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
end

function slot0.onDestroyView(slot0)
	slot0._simagecg:UnLoadImage()
end

return slot0
