module("modules.logic.handbook.view.HandbookCGDetailView", package.seeall)

local var_0_0 = class("HandbookCGDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._simagecg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_cg")
	arg_1_0._simagezone = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_cg/#simage_zone")
	arg_1_0._simagecgold = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_cgold")
	arg_1_0._simagezoneold = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_cgold/#simage_zoneold")
	arg_1_0._btnprev = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#btn_prev")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#btn_next")
	arg_1_0._txttitleNameEn = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/desc/#txt_titleNameEn")
	arg_1_0._txttitleName = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/desc/#txt_titleName")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/desc/#scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._txtcurindex = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/page/#txt_curindex")
	arg_1_0._txttotalpage = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/page/#txt_curindex/#txt_totalpage")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#btn_click/#go_drag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnprev:AddClickListener(arg_2_0._btnprevOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnprev:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	arg_4_0:_setUIActive(not arg_4_0._uiActive)
end

function var_0_0._btnprevOnClick(arg_5_0)
	local var_5_0 = HandbookModel.instance:getPrevCG(arg_5_0._cgId, arg_5_0._cgType)

	if not var_5_0 then
		return
	end

	arg_5_0._cgId = var_5_0.id

	arg_5_0:_refreshUI()
end

function var_0_0._btnnextOnClick(arg_6_0)
	local var_6_0 = HandbookModel.instance:getNextCG(arg_6_0._cgId, arg_6_0._cgType)

	if not var_6_0 then
		return
	end

	arg_6_0._cgId = var_6_0.id

	arg_6_0:_refreshUI()
end

function var_0_0._setUIActive(arg_7_0, arg_7_1)
	arg_7_0._uiActive = arg_7_1

	gohelper.setActive(arg_7_0._goui, arg_7_0._uiActive)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._cimagecg = arg_8_0._simagecg.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	arg_8_0._imageZone = gohelper.findChildImage(arg_8_0.viewGO, "#simage_cg/#simage_zone")
	arg_8_0._cimagecgold = arg_8_0._simagecgold.gameObject:GetComponent(typeof(UnityEngine.UI.CustomImage))
	arg_8_0._imageZoneOld = gohelper.findChildImage(arg_8_0.viewGO, "#simage_cgold/#simage_zoneold")

	gohelper.setActive(arg_8_0._simagecg.gameObject, false)
	gohelper.setActive(arg_8_0._simagecgold.gameObject, false)

	arg_8_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_8_0._godrag)

	arg_8_0._drag:AddDragBeginListener(arg_8_0._onDragBegin, arg_8_0)
	arg_8_0._drag:AddDragEndListener(arg_8_0._onDragEnd, arg_8_0)
	gohelper.addUIClickAudio(arg_8_0._btnprev.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)
	gohelper.addUIClickAudio(arg_8_0._btnnext.gameObject, AudioEnum.UI.play_ui_screenplay_photo_click)

	arg_8_0.loadedCgList = {}
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._startPos = arg_9_2.position.x
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.position.x

	if var_10_0 > arg_10_0._startPos and var_10_0 - arg_10_0._startPos >= 100 then
		arg_10_0:_btnprevOnClick()
	elseif var_10_0 < arg_10_0._startPos and arg_10_0._startPos - var_10_0 >= 100 then
		arg_10_0:_btnnextOnClick()
	end
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._cgId = arg_11_0.viewParam.id
	arg_11_0._cgType = arg_11_0.viewParam.cgType

	arg_11_0:_refreshUI()
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0._cgId = arg_12_0.viewParam
	arg_12_0._cgType = arg_12_0.viewParam.cgType

	arg_12_0:_refreshUI()
end

function var_0_0._refreshUI(arg_13_0)
	if not HandbookModel.instance:isRead(HandbookEnum.Type.CG, arg_13_0._cgId) then
		HandbookRpc.instance:sendHandbookReadRequest(HandbookEnum.Type.CG, arg_13_0._cgId)
	end

	arg_13_0:_setUIActive(true)

	local var_13_0 = HandbookConfig.instance:getCGConfig(arg_13_0._cgId, arg_13_0._cgType)
	local var_13_1 = StoryBgZoneModel.instance:getBgZoneByPath(var_13_0.image)

	UIBlockMgr.instance:startBlock("loadZone")

	if var_13_1 then
		arg_13_0._simagezone:LoadImage(ResUrl.getStoryRes(var_13_1.path), arg_13_0._onZoneImageLoaded, arg_13_0)
	else
		gohelper.setActive(arg_13_0._simagezone.gameObject, false)

		arg_13_0._cimagecg.vecInSide = Vector4.zero

		arg_13_0:_startLoadOriginImg()
	end

	arg_13_0._txttitleName.text = var_13_0.name
	arg_13_0._txttitleNameEn.text = var_13_0.nameEn
	arg_13_0._txtdesc.text = var_13_0.desc
	arg_13_0._txtcurindex.text = HandbookModel.instance:getCGUnlockIndex(arg_13_0._cgId, arg_13_0._cgType)
	arg_13_0._txttotalpage.text = "/" .. HandbookModel.instance:getCGUnlockCount(nil, arg_13_0._cgType)
end

function var_0_0._startLoadOriginImg(arg_14_0)
	local var_14_0 = HandbookConfig.instance:getCGConfig(arg_14_0._cgId, arg_14_0._cgType)

	arg_14_0._simagecg:LoadImage(arg_14_0:getImageName(var_14_0), arg_14_0.onLoadedImage, arg_14_0)
end

function var_0_0._onZoneImageLoaded(arg_15_0)
	arg_15_0._imageZone:SetNativeSize()
	arg_15_0:_startLoadOriginImg()
end

function var_0_0.getImageName(arg_16_0, arg_16_1)
	if not tabletool.indexOf(arg_16_0.loadedCgList, arg_16_1.id) then
		table.insert(arg_16_0.loadedCgList, arg_16_1.id)
	end

	arg_16_0.lastLoadImageId = arg_16_1.id

	local var_16_0 = StoryBgZoneModel.instance:getBgZoneByPath(arg_16_1.image)

	if var_16_0 then
		return ResUrl.getStoryRes(var_16_0.sourcePath)
	end

	return ResUrl.getStoryBg(arg_16_1.image)
end

function var_0_0.onLoadedImage(arg_17_0)
	local var_17_0 = HandbookConfig.instance:getCGConfig(arg_17_0._cgId, arg_17_0._cgType)
	local var_17_1 = StoryBgZoneModel.instance:getBgZoneByPath(var_17_0.image)

	if var_17_1 then
		gohelper.setActive(arg_17_0._simagezone.gameObject, true)
		transformhelper.setLocalPosXY(arg_17_0._simagezone.gameObject.transform, var_17_1.offsetX, var_17_1.offsetY)

		local var_17_2 = HandbookConfig.instance:getCGConfig(arg_17_0._cgId, arg_17_0._cgType)
		local var_17_3 = StoryBgZoneModel.instance:getBgZoneByPath(var_17_2.image)
		local var_17_4 = Vector4(recthelper.getWidth(arg_17_0._imageZone.transform), recthelper.getHeight(arg_17_0._imageZone.transform), var_17_3.offsetX, var_17_3.offsetY)

		arg_17_0._cimagecg.vecInSide = var_17_4

		arg_17_0:_loadOldZoneImage()
	else
		gohelper.setActive(arg_17_0._simagezoneold.gameObject, false)
		arg_17_0:_startLoadOldImg()
	end

	gohelper.setActive(arg_17_0._simagecg.gameObject, true)

	if #arg_17_0.loadedCgList <= 10 then
		return
	end

	arg_17_0.loadedCgList = {
		arg_17_0.lastLoadImageId
	}

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, arg_17_0)
end

function var_0_0._loadOldZoneImage(arg_18_0)
	local var_18_0 = HandbookConfig.instance:getCGConfig(arg_18_0._cgId, arg_18_0._cgType)
	local var_18_1 = StoryBgZoneModel.instance:getBgZoneByPath(var_18_0.image)

	if var_18_1 then
		arg_18_0._simagezoneold:LoadImage(ResUrl.getStoryRes(var_18_1.path), arg_18_0._onZoneImageOldLoaded, arg_18_0)
	else
		gohelper.setActive(arg_18_0._simagezoneold.gameObject, false)

		arg_18_0._cimagecgold.vecInSide = Vector4.zero

		arg_18_0:_startLoadOldImg()
	end
end

function var_0_0._onZoneImageOldLoaded(arg_19_0)
	arg_19_0._imageZoneOld:SetNativeSize()
	arg_19_0:_startLoadOldImg()
end

function var_0_0._startLoadOldImg(arg_20_0)
	local var_20_0 = HandbookConfig.instance:getCGConfig(arg_20_0._cgId, arg_20_0._cgType)

	arg_20_0._simagecgold:LoadImage(arg_20_0:getImageName(var_20_0), arg_20_0._onLoadOldFinished, arg_20_0)
end

function var_0_0._onLoadOldFinished(arg_21_0)
	UIBlockMgr.instance:endBlock("loadZone")

	local var_21_0 = HandbookConfig.instance:getCGConfig(arg_21_0._cgId, arg_21_0._cgType)
	local var_21_1 = StoryBgZoneModel.instance:getBgZoneByPath(var_21_0.image)

	if var_21_1 then
		gohelper.setActive(arg_21_0._simagezoneold.gameObject, true)
		transformhelper.setLocalPosXY(arg_21_0._simagezoneold.gameObject.transform, var_21_1.offsetX, var_21_1.offsetY)

		local var_21_2 = HandbookConfig.instance:getCGConfig(arg_21_0._cgId, arg_21_0._cgType)
		local var_21_3 = StoryBgZoneModel.instance:getBgZoneByPath(var_21_2.image)
		local var_21_4 = Vector4(recthelper.getWidth(arg_21_0._imageZoneOld.transform), recthelper.getHeight(arg_21_0._imageZoneOld.transform), var_21_3.offsetX, var_21_3.offsetY)

		arg_21_0._cimagecgold.vecInSide = var_21_4
	end

	gohelper.setActive(arg_21_0._simagecg.gameObject, false)
	gohelper.setActive(arg_21_0._simagecgold.gameObject, true)
end

function var_0_0.onClose(arg_22_0)
	UIBlockMgr.instance:endBlock("loadZone")
	arg_22_0._drag:RemoveDragBeginListener()
	arg_22_0._drag:RemoveDragEndListener()
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0._simagecg:UnLoadImage()
end

return var_0_0
