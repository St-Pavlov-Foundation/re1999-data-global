module("modules.logic.rouge.view.RougeCollectionFilterView", package.seeall)

slot0 = class("RougeCollectionFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gobase = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base")
	slot0._gobaseContainer = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer")
	slot0._gorareItem = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer/#go_rareItem")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer/#go_rareItem/#image_icon")
	slot0._goextra = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra")
	slot0._goextraContainer = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra/#go_extraContainer")
	slot0._goextraItem = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra/#go_extraContainer/#go_extraItem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_reset")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnresetOnClick(slot0)
	tabletool.clear(slot0._baseBtnSelectMap)
	tabletool.clear(slot0._extraBtnSelectMap)
	slot0:BuildCollectionTagList()
	slot0:BuildCollectionTypeList()
end

function slot0._btnconfirmOnClick(slot0)
	if slot0.viewParam.confirmCallback then
		slot1(slot0.viewParam and slot0.viewParam.confirmCallbackObj, slot0._baseBtnSelectMap, slot0._extraBtnSelectMap)
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._extraBtnMap = slot0:getUserDataTb_()
	slot0._baseBtnMap = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:onInit()
end

function slot0.onInit(slot0)
	slot0:BuildSelectMap()
	slot0:BuildCollectionTagList()
	slot0:BuildCollectionTypeList()
end

function slot0.BuildSelectMap(slot0)
	if slot0.viewParam.baseSelectMap then
		slot0._baseBtnSelectMap = slot0.viewParam.baseSelectMap
	else
		slot0._baseBtnSelectMap = {}
	end

	if slot0.viewParam.extraSelectMap then
		slot0._extraBtnSelectMap = slot0.viewParam.extraSelectMap
	else
		slot0._extraBtnSelectMap = {}
	end
end

function slot0.BuildCollectionTagList(slot0)
	GoHelperExtend.CreateObjList(slot0, slot0.refreshBaseTagBtn, RougeCollectionConfig.instance:getCollectionBaseTags(), slot0._gobaseContainer, slot0._gorareItem)
end

slot1 = "#B6B2A8"
slot2 = "#ECA373"

function slot0.refreshBaseTagBtn(slot0, slot1, slot2, slot3)
	if not slot0._baseBtnMap[slot3] then
		slot0._baseBtnMap[slot3] = slot0:getUserDataTb_()
		slot0._baseBtnMap[slot3].tagId = slot2.id
		slot0._baseBtnMap[slot3].goUnselected = gohelper.findChild(slot1, "unselected")
		slot0._baseBtnMap[slot3].goselected = gohelper.findChild(slot1, "selected")
		slot0._baseBtnMap[slot3].txtname = gohelper.findChildText(slot1, "tagText")
		slot0._baseBtnMap[slot3].imagetagicon = gohelper.findChildImage(slot1, "#image_icon")
		slot0._baseBtnMap[slot3].btnclick = gohelper.findChildButtonWithAudio(slot1, "click")

		slot0._baseBtnMap[slot3].btnclick:AddClickListener(slot0.onClickBaseBtnItem, slot0, slot0._baseBtnMap[slot3])
	end

	slot4 = slot0._baseBtnSelectMap[slot2.id] or false

	gohelper.setActive(slot0._baseBtnMap[slot3].goUnselected, not slot4)
	gohelper.setActive(slot0._baseBtnMap[slot3].goselected, slot4)

	slot0._baseBtnMap[slot3].txtname.text = tostring(slot2.name)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._baseBtnMap[slot3].txtname, slot4 and uv0 or uv1)
	UISpriteSetMgr.instance:setRougeSprite(slot0._baseBtnMap[slot3].imagetagicon, slot2.iconUrl)
end

function slot0.onClickBaseBtnItem(slot0, slot1)
	slot0._baseBtnSelectMap[slot1.tagId] = not (slot0._baseBtnSelectMap[slot1.tagId] or false) and true or nil

	gohelper.setActive(slot1.goUnselected, not slot2)
	gohelper.setActive(slot1.goselected, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot1.txtname, slot2 and uv0 or uv1)
end

function slot0.BuildCollectionTypeList(slot0)
	GoHelperExtend.CreateObjList(slot0, slot0.refreshExtraTagBtn, RougeCollectionConfig.instance:getCollectionExtraTags(), slot0._goextraContainer, slot0._goextraItem)
end

function slot0.refreshExtraTagBtn(slot0, slot1, slot2, slot3)
	if not slot0._extraBtnMap[slot3] then
		slot0._extraBtnMap[slot3] = slot0:getUserDataTb_()
		slot0._extraBtnMap[slot3].typeId = slot2.id
		slot0._extraBtnMap[slot3].goUnselected = gohelper.findChild(slot1, "unselected")
		slot0._extraBtnMap[slot3].goselected = gohelper.findChild(slot1, "selected")
		slot0._extraBtnMap[slot3].txtname = gohelper.findChildText(slot1, "tagText")
		slot0._extraBtnMap[slot3].imagetagicon = gohelper.findChildImage(slot1, "#image_icon")
		slot0._extraBtnMap[slot3].btnclick = gohelper.findChildButtonWithAudio(slot1, "click")

		slot0._extraBtnMap[slot3].btnclick:AddClickListener(slot0.onClickExtraBtnItem, slot0, slot0._extraBtnMap[slot3])
	end

	slot4 = slot0._extraBtnSelectMap[slot2.id] or false

	gohelper.setActive(slot0._extraBtnMap[slot3].goUnselected, not slot4)
	gohelper.setActive(slot0._extraBtnMap[slot3].goselected, slot4)

	slot0._extraBtnMap[slot3].txtname.text = tostring(slot2.name)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._extraBtnMap[slot3].txtname, slot4 and uv0 or uv1)
	UISpriteSetMgr.instance:setRougeSprite(slot0._extraBtnMap[slot3].imagetagicon, slot2.iconUrl)
end

function slot0.onClickExtraBtnItem(slot0, slot1)
	slot0._extraBtnSelectMap[slot1.typeId] = not slot0._extraBtnSelectMap[slot1.typeId] and true or nil

	gohelper.setActive(slot1.goUnselected, not slot2)
	gohelper.setActive(slot1.goselected, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot1.txtname, slot2 and uv0 or uv1)
end

function slot0.releaseAllClickListeners(slot0)
	if slot0._baseBtnMap then
		for slot4, slot5 in pairs(slot0._baseBtnMap) do
			slot5.btnclick:RemoveClickListener()
		end
	end

	if slot0._extraBtnMap then
		for slot4, slot5 in pairs(slot0._extraBtnMap) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:releaseAllClickListeners()
end

return slot0
