module("modules.logic.versionactivity1_2.jiexika.view.Activity114AttrView", package.seeall)

local var_0_0 = class("Activity114AttrView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._path = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.go = gohelper.findChild(arg_2_0.viewGO, arg_2_0._path)
	arg_2_0._goattrdetail = gohelper.findChild(arg_2_0.go, "#go_attrdetail")
	arg_2_0._goempty = gohelper.findChild(arg_2_0.go, "#go_attrdetail/#go_empty")
	arg_2_0._scroll = gohelper.findChildScrollRect(arg_2_0.go, "#go_attrdetail/#scroll")
	arg_2_0._gotips = gohelper.findChild(arg_2_0.viewGO, "#go_tips")
	arg_2_0._btnCloseTips = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_tips/#btn_closeTips")
	arg_2_0._gofeaturecontent = gohelper.findChild(arg_2_0.viewGO, "#go_tips/bg/#scroll_feature/Viewport/content")
	arg_2_0._gofeatureitem = gohelper.findChild(arg_2_0.viewGO, "#go_tips/bg/#scroll_feature/Viewport/content/#go_featureitem")
	arg_2_0._radar = gohelper.findChild(arg_2_0.viewGO, "#go_eduSelect/teachAttr/radarChart"):GetComponent(typeof(RadarChart))
	arg_2_0._btnspecialattrtips = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_attr/#go_attrdetail/specialattrtitle/#btn_specialattrtips")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnCloseTips:AddClickListener(arg_3_0.closeTips, arg_3_0)
	arg_3_0._btnspecialattrtips:AddClickListener(arg_3_0.showFeaturesTips, arg_3_0)
	arg_3_0.viewContainer:registerCallback(Activity114Event.EduSelectAttrChange, arg_3_0.onAttrSelectChange, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttrUpdate, arg_3_0.updateAttr, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.ShowFeaturesTips, arg_3_0.showFeaturesTips, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnNewFeature, arg_3_0.updateFeature, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnCloseTips:RemoveClickListener()
	arg_4_0._btnspecialattrtips:RemoveClickListener()
	arg_4_0.viewContainer:unregisterCallback(Activity114Event.EduSelectAttrChange, arg_4_0.onAttrSelectChange, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttrUpdate, arg_4_0.updateAttr, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.ShowFeaturesTips, arg_4_0.showFeaturesTips, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnNewFeature, arg_4_0.updateFeature, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.attrTb = {}

	for iter_5_0 = 1, Activity114Enum.Attr.End - 1 do
		local var_5_0 = arg_5_0:getUserDataTb_()
		local var_5_1 = Activity114Config.instance:getAttrName(Activity114Model.instance.id, iter_5_0)
		local var_5_2 = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, iter_5_0).attribute

		var_5_0.bg = gohelper.findChild(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0 .. "/bg")
		var_5_0.imageIcon = gohelper.findChildImage(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0 .. "/image_icon")
		var_5_0.txtValue = gohelper.findChildTextMesh(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0 .. "/#txt_attr/#txt_value")
		var_5_0.goAddValue = gohelper.findChild(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0 .. "/#txt_attr/#txt_value/#go_addvalue")
		var_5_0.txtAddValue = gohelper.findChildTextMesh(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0 .. "/#txt_attr/#txt_value/#go_addvalue/#txt_addvalue")
		var_5_0.gouplevel = gohelper.findChild(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0 .. "/#txt_attr/#txt_value/#go_uplevel")
		var_5_0.txtLv = gohelper.findChildTextMesh(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0 .. "/#txt_attr/#txt_lv")
		var_5_0.glowAnim = gohelper.findChildComponent(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0, typeof(UnityEngine.Animator))
		gohelper.findChildTextMesh(arg_5_0.go, "#go_attrdetail/attr/#go_attr" .. iter_5_0 .. "/#txt_attr").text = var_5_1

		UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(var_5_0.imageIcon, "icons_" .. var_5_2)
		gohelper.setActive(var_5_0.bg, iter_5_0 % 2 == 0)

		var_5_0.txtAddValue.text = ""

		gohelper.setActive(var_5_0.goAddValue, false)
		gohelper.setActive(var_5_0.gouplevel, false)

		arg_5_0.attrTb[iter_5_0] = var_5_0
	end

	arg_5_0._status = 0

	gohelper.setActive(gohelper.findChild(arg_5_0.viewGO, "#go_attrdetail/#scroll/item"), false)

	arg_5_0._scroll = gohelper.findChildScrollRect(arg_5_0.go, "#go_attrdetail/#scroll")
	arg_5_0._txtname = gohelper.findChildText(arg_5_0.go, "#go_attrdetail/#scroll/item/#txt_name")

	local var_5_3 = Activity114FeaturesModel.instance:getAllMaxLength(arg_5_0._txtname)
	local var_5_4 = ListScrollParam.New()

	var_5_4.scrollGOPath = "#go_attr/#go_attrdetail/#scroll"
	var_5_4.prefabType = ScrollEnum.ScrollPrefabFromView
	var_5_4.prefabUrl = "#go_attr/#go_attrdetail/#scroll/item"
	var_5_4.cellClass = Activity114FeaturesItem
	var_5_4.scrollDir = ScrollEnum.ScrollDirV
	var_5_4.lineCount = 1
	var_5_4.cellWidth = var_5_3
	var_5_4.cellHeight = 48
	var_5_4.cellSpaceH = 0
	var_5_4.cellSpaceV = 20.73
	var_5_4.startSpace = 0
	var_5_4.frameUpdateMs = 100
	arg_5_0._scrollView = LuaListScrollView.New(Activity114FeaturesModel.instance, var_5_4)

	arg_5_0:addChildView(arg_5_0._scrollView)
	arg_5_0:updateFeature()
	arg_5_0:closeTips()
end

function var_0_0.updateFeature(arg_6_0)
	gohelper.setActive(arg_6_0._goempty, #Activity114FeaturesModel.instance:getList() == 0)
end

function var_0_0.closeTips(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_close)
	gohelper.setActive(arg_7_0._gotips, false)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:updateAttr()
end

function var_0_0.showFeaturesTips(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	gohelper.setActive(arg_9_0._gotips, true)
	gohelper.CreateObjList(arg_9_0, arg_9_0.setFeatureItem, Activity114FeaturesModel.instance:getList(), arg_9_0._gofeaturecontent, arg_9_0._gofeatureitem)
end

function var_0_0.setFeatureItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = gohelper.findChildImage(arg_10_1, "title/#icon_feature")
	local var_10_1 = gohelper.findChildText(arg_10_1, "title/#icon_feature/#txt_name")
	local var_10_2 = gohelper.findChildText(arg_10_1, "#txt_des")
	local var_10_3 = gohelper.findChild(arg_10_1, "title/#go_inherit")
	local var_10_4 = gohelper.findChild(arg_10_1, "title/#icon_feature/line")
	local var_10_5 = Activity114FeaturesModel.instance:getFeaturePreferredLength(var_10_1, 250, 350)

	recthelper.setWidth(var_10_0.transform, var_10_5)

	local var_10_6 = var_10_3.transform.rect.width

	var_10_6 = var_10_6 > 0 and var_10_6 or 100

	local var_10_7 = 250
	local var_10_8 = (var_10_7 - (var_10_5 - 250) - (var_10_6 - 100)) / var_10_7
	local var_10_9 = Mathf.Clamp(var_10_8, 0, 1)

	transformhelper.setLocalScale(var_10_4.transform, var_10_9, 1, 1)

	var_10_1.text = arg_10_2.features
	var_10_2.text = arg_10_2.desc

	gohelper.setActive(var_10_3, arg_10_2.inheritable == 1)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(var_10_0, arg_10_2.inheritable == 1 and "img_shuxing1" or "img_shuxing2")
end

function var_0_0.onAttrSelectChange(arg_11_0)
	local var_11_0 = Activity114Model.instance.eduSelectAttr

	for iter_11_0 = 1, Activity114Enum.Attr.End - 1 do
		local var_11_1 = arg_11_0.attrTb[iter_11_0]

		if var_11_0 == iter_11_0 then
			local var_11_2 = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, var_11_0)
			local var_11_3 = var_11_2 and var_11_2.successVerify[var_11_0] or 0

			if Activity114Model.instance.attrAddPermillage[var_11_0] then
				var_11_3 = Mathf.Round(var_11_3 * (1 + Activity114Model.instance.attrAddPermillage[var_11_0]))
			end

			local var_11_4 = Activity114Model.instance.attrDict[iter_11_0] or 0
			local var_11_5 = Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, iter_11_0)
			local var_11_6 = math.min(var_11_3, var_11_5 - var_11_4)

			var_11_1.txtAddValue.text = "+" .. var_11_6

			local var_11_7 = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, iter_11_0, var_11_4)
			local var_11_8 = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, iter_11_0, var_11_4 + var_11_6)

			gohelper.setActive(var_11_1.gouplevel, var_11_7 ~= var_11_8)
		else
			gohelper.setActive(var_11_1.gouplevel, false)

			var_11_1.txtAddValue.text = ""
		end

		gohelper.setActive(var_11_1.goAddValue, not string.nilorempty(var_11_1.txtAddValue.text))
	end
end

function var_0_0.updateAttr(arg_12_0)
	if Activity114Model.instance.attrChangeDict then
		for iter_12_0 = 1, Activity114Enum.Attr.End - 1 do
			if Activity114Model.instance.attrChangeDict[iter_12_0] then
				arg_12_0.attrTb[iter_12_0].glowAnim:Play(UIAnimationName.Open, 0, 0)
			end
		end

		Activity114Model.instance.attrChangeDict = nil
	end

	local var_12_0 = {}

	for iter_12_1 = 1, Activity114Enum.Attr.End - 1 do
		local var_12_1 = Activity114Model.instance.attrDict[iter_12_1] or 0

		arg_12_0.attrTb[iter_12_1].txtValue.text = var_12_1
		arg_12_0.attrTb[iter_12_1].txtLv.text = "Lv." .. Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, iter_12_1, var_12_1)
		var_12_0[iter_12_1] = Activity114Model.instance.attrDict[iter_12_1] / Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, iter_12_1)
	end

	local var_12_2 = Activity114Model.instance.eduSelectAttr

	if var_12_2 then
		local var_12_3 = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, var_12_2)
		local var_12_4 = var_12_3 and var_12_3.successVerify[var_12_2] or 0

		if Activity114Model.instance.attrAddPermillage[var_12_2] then
			var_12_4 = Mathf.Round(var_12_4 * (1 + Activity114Model.instance.attrAddPermillage[var_12_2]))
		end

		local var_12_5 = Activity114Model.instance.attrDict[var_12_2] or 0
		local var_12_6 = arg_12_0.attrTb[var_12_2]
		local var_12_7 = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, var_12_2, var_12_5)
		local var_12_8 = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, var_12_2, var_12_5 + var_12_4)

		gohelper.setActive(var_12_6.gouplevel, var_12_7 ~= var_12_8)
	end

	arg_12_0._radar:setRate(var_12_0[1], var_12_0[5], var_12_0[4], var_12_0[3], var_12_0[2])
end

return var_0_0
