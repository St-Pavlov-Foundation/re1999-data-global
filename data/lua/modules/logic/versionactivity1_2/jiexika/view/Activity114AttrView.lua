module("modules.logic.versionactivity1_2.jiexika.view.Activity114AttrView", package.seeall)

slot0 = class("Activity114AttrView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._path = slot1
end

function slot0.onInitView(slot0)
	slot0.go = gohelper.findChild(slot0.viewGO, slot0._path)
	slot0._goattrdetail = gohelper.findChild(slot0.go, "#go_attrdetail")
	slot0._goempty = gohelper.findChild(slot0.go, "#go_attrdetail/#go_empty")
	slot0._scroll = gohelper.findChildScrollRect(slot0.go, "#go_attrdetail/#scroll")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._btnCloseTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tips/#btn_closeTips")
	slot0._gofeaturecontent = gohelper.findChild(slot0.viewGO, "#go_tips/bg/#scroll_feature/Viewport/content")
	slot0._gofeatureitem = gohelper.findChild(slot0.viewGO, "#go_tips/bg/#scroll_feature/Viewport/content/#go_featureitem")
	slot0._radar = gohelper.findChild(slot0.viewGO, "#go_eduSelect/teachAttr/radarChart"):GetComponent(typeof(RadarChart))
	slot0._btnspecialattrtips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_attr/#go_attrdetail/specialattrtitle/#btn_specialattrtips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnCloseTips:AddClickListener(slot0.closeTips, slot0)
	slot0._btnspecialattrtips:AddClickListener(slot0.showFeaturesTips, slot0)
	slot0.viewContainer:registerCallback(Activity114Event.EduSelectAttrChange, slot0.onAttrSelectChange, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttrUpdate, slot0.updateAttr, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.ShowFeaturesTips, slot0.showFeaturesTips, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnNewFeature, slot0.updateFeature, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnCloseTips:RemoveClickListener()
	slot0._btnspecialattrtips:RemoveClickListener()
	slot0.viewContainer:unregisterCallback(Activity114Event.EduSelectAttrChange, slot0.onAttrSelectChange, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttrUpdate, slot0.updateAttr, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.ShowFeaturesTips, slot0.showFeaturesTips, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnNewFeature, slot0.updateFeature, slot0)
end

function slot0._editableInitView(slot0)
	slot0.attrTb = {}

	for slot4 = 1, Activity114Enum.Attr.End - 1 do
		slot5 = slot0:getUserDataTb_()
		slot5.bg = gohelper.findChild(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4 .. "/bg")
		slot5.imageIcon = gohelper.findChildImage(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4 .. "/image_icon")
		slot5.txtValue = gohelper.findChildTextMesh(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4 .. "/#txt_attr/#txt_value")
		slot5.goAddValue = gohelper.findChild(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4 .. "/#txt_attr/#txt_value/#go_addvalue")
		slot5.txtAddValue = gohelper.findChildTextMesh(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4 .. "/#txt_attr/#txt_value/#go_addvalue/#txt_addvalue")
		slot5.gouplevel = gohelper.findChild(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4 .. "/#txt_attr/#txt_value/#go_uplevel")
		slot5.txtLv = gohelper.findChildTextMesh(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4 .. "/#txt_attr/#txt_lv")
		slot5.glowAnim = gohelper.findChildComponent(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4, typeof(UnityEngine.Animator))
		gohelper.findChildTextMesh(slot0.go, "#go_attrdetail/attr/#go_attr" .. slot4 .. "/#txt_attr").text = Activity114Config.instance:getAttrName(Activity114Model.instance.id, slot4)

		UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(slot5.imageIcon, "icons_" .. Activity114Config.instance:getAttrCo(Activity114Model.instance.id, slot4).attribute)
		gohelper.setActive(slot5.bg, slot4 % 2 == 0)

		slot5.txtAddValue.text = ""

		gohelper.setActive(slot5.goAddValue, false)
		gohelper.setActive(slot5.gouplevel, false)

		slot0.attrTb[slot4] = slot5
	end

	slot0._status = 0

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_attrdetail/#scroll/item"), false)

	slot0._scroll = gohelper.findChildScrollRect(slot0.go, "#go_attrdetail/#scroll")
	slot0._txtname = gohelper.findChildText(slot0.go, "#go_attrdetail/#scroll/item/#txt_name")
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_attr/#go_attrdetail/#scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#go_attr/#go_attrdetail/#scroll/item"
	slot2.cellClass = Activity114FeaturesItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = Activity114FeaturesModel.instance:getAllMaxLength(slot0._txtname)
	slot2.cellHeight = 48
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 20.73
	slot2.startSpace = 0
	slot2.frameUpdateMs = 100
	slot0._scrollView = LuaListScrollView.New(Activity114FeaturesModel.instance, slot2)

	slot0:addChildView(slot0._scrollView)
	slot0:updateFeature()
	slot0:closeTips()
end

function slot0.updateFeature(slot0)
	gohelper.setActive(slot0._goempty, #Activity114FeaturesModel.instance:getList() == 0)
end

function slot0.closeTips(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_close)
	gohelper.setActive(slot0._gotips, false)
end

function slot0.onOpen(slot0)
	slot0:updateAttr()
end

function slot0.showFeaturesTips(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	gohelper.setActive(slot0._gotips, true)
	gohelper.CreateObjList(slot0, slot0.setFeatureItem, Activity114FeaturesModel.instance:getList(), slot0._gofeaturecontent, slot0._gofeatureitem)
end

function slot0.setFeatureItem(slot0, slot1, slot2)
	recthelper.setWidth(gohelper.findChildImage(slot1, "title/#icon_feature").transform, Activity114FeaturesModel.instance:getFeaturePreferredLength(gohelper.findChildText(slot1, "title/#icon_feature/#txt_name"), 250, 350))

	slot10 = 250

	transformhelper.setLocalScale(gohelper.findChild(slot1, "title/#icon_feature/line").transform, Mathf.Clamp((slot10 - (slot8 - 250) - ((gohelper.findChild(slot1, "title/#go_inherit").transform.rect.width > 0 and slot9 or 100) - 100)) / slot10, 0, 1), 1, 1)

	slot4.text = slot2.features
	gohelper.findChildText(slot1, "#txt_des").text = slot2.desc

	gohelper.setActive(slot6, slot2.inheritable == 1)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(slot3, slot2.inheritable == 1 and "img_shuxing1" or "img_shuxing2")
end

function slot0.onAttrSelectChange(slot0)
	slot1 = Activity114Model.instance.eduSelectAttr

	for slot5 = 1, Activity114Enum.Attr.End - 1 do
		slot6 = slot0.attrTb[slot5]

		if slot1 == slot5 then
			if Activity114Model.instance.attrAddPermillage[slot1] then
				slot8 = Mathf.Round((Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, slot1) and slot7.successVerify[slot1] or 0) * (1 + Activity114Model.instance.attrAddPermillage[slot1]))
			end

			slot9 = Activity114Model.instance.attrDict[slot5] or 0
			slot8 = math.min(slot8, Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, slot5) - slot9)
			slot6.txtAddValue.text = "+" .. slot8

			gohelper.setActive(slot6.gouplevel, Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, slot5, slot9) ~= Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, slot5, slot9 + slot8))
		else
			gohelper.setActive(slot6.gouplevel, false)

			slot6.txtAddValue.text = ""
		end

		gohelper.setActive(slot6.goAddValue, not string.nilorempty(slot6.txtAddValue.text))
	end
end

function slot0.updateAttr(slot0)
	if Activity114Model.instance.attrChangeDict then
		for slot4 = 1, Activity114Enum.Attr.End - 1 do
			if Activity114Model.instance.attrChangeDict[slot4] then
				slot0.attrTb[slot4].glowAnim:Play(UIAnimationName.Open, 0, 0)
			end
		end

		Activity114Model.instance.attrChangeDict = nil
	end

	slot1 = {
		[slot5] = Activity114Model.instance.attrDict[slot5] / Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, slot5)
	}

	for slot5 = 1, Activity114Enum.Attr.End - 1 do
		slot6 = Activity114Model.instance.attrDict[slot5] or 0
		slot0.attrTb[slot5].txtValue.text = slot6
		slot0.attrTb[slot5].txtLv.text = "Lv." .. Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, slot5, slot6)
	end

	if Activity114Model.instance.eduSelectAttr then
		if Activity114Model.instance.attrAddPermillage[slot2] then
			slot4 = Mathf.Round((Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, slot2) and slot3.successVerify[slot2] or 0) * (1 + Activity114Model.instance.attrAddPermillage[slot2]))
		end

		slot5 = Activity114Model.instance.attrDict[slot2] or 0

		gohelper.setActive(slot0.attrTb[slot2].gouplevel, Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, slot2, slot5) ~= Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, slot2, slot5 + slot4))
	end

	slot0._radar:setRate(slot1[1], slot1[5], slot1[4], slot1[3], slot1[2])
end

return slot0
