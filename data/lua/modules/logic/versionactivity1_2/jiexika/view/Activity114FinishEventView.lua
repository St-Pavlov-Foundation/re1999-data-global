module("modules.logic.versionactivity1_2.jiexika.view.Activity114FinishEventView", package.seeall)

local var_0_0 = class("Activity114FinishEventView", BaseView)
local var_0_1 = "#9EE091"
local var_0_2 = "#e55151"
local var_0_3 = 714

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageblackbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_container/blackbgmask/#simage_blackbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content")
	arg_1_0._goattention = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention")
	arg_1_0._attentionimg0 = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention")
	arg_1_0._attentionimg1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention1")
	arg_1_0._attentionimg2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention2")
	arg_1_0._attentionadd = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#txt_attentionadd")
	arg_1_0._goattr = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attr/#go_attritem")
	arg_1_0._gofeature = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_feature")
	arg_1_0._gofeatureitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_feature/#go_featureitem")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_unlock")
	arg_1_0._gounlockitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_unlock/#go_unlockitem")
	arg_1_0._goscore = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score")
	arg_1_0._txtscoretype = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score/#go_scoreitem/#txt_scoretype")
	arg_1_0._txtscorenum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score/#go_scoreitem/#txt_scorenum")

	gohelper.setActive(arg_1_0._goattritem, false)
	gohelper.setActive(arg_1_0._gofeatureitem, false)
	gohelper.setActive(arg_1_0._gounlockitem, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	arg_4_0._simagebg:LoadImage(ResUrl.getAct114Icon("bg1"))
	arg_4_0._simageblackbg:LoadImage(ResUrl.getAct114Icon("img_bg1"))

	local var_4_0 = arg_4_0.viewParam.resultBonus
	local var_4_1 = var_4_0.addAttr
	local var_4_2 = var_4_0.featuresList

	arg_4_0:updateAttention(var_4_1)
	arg_4_0:updateAttr(var_4_1)
	arg_4_0:updateFeature(var_4_2)
	arg_4_0:updateUnLock(var_4_1)
	arg_4_0:updateScore(var_4_1)
	arg_4_0:refreshContainerHeight()
end

function var_0_0.onClose(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_CloseHouse)
end

function var_0_0.updateAttention(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1[Activity114Enum.AddAttrType.Attention]

	if var_6_0 then
		gohelper.setActive(arg_6_0._goattention, true)

		local var_6_1 = Activity114Model.instance.serverData.attention
		local var_6_2 = var_6_1 - arg_6_0.viewParam.preAttention

		arg_6_0._attentionadd.text = string.format("<%s>%+d</color>", var_6_0 >= 0 and var_0_1 or var_0_2, var_6_2)

		gohelper.setActive(arg_6_0._attentionimg1, var_6_0 >= 0)
		gohelper.setActive(arg_6_0._attentionimg0, var_6_0 < 0)

		arg_6_0._attentionimg0.fillAmount = math.max(var_6_1, arg_6_0.viewParam.preAttention) / 100
		arg_6_0._attentionimg1.fillAmount = math.max(var_6_1, arg_6_0.viewParam.preAttention) / 100
		arg_6_0._attentionimg2.fillAmount = math.min(var_6_1, arg_6_0.viewParam.preAttention) / 100
	else
		gohelper.setActive(arg_6_0._goattention, false)
	end
end

function var_0_0.updateAttr(arg_7_0, arg_7_1)
	local var_7_0 = false

	for iter_7_0 = 1, Activity114Enum.Attr.End - 1 do
		if arg_7_1[iter_7_0] then
			local var_7_1 = gohelper.cloneInPlace(arg_7_0._goattritem)

			gohelper.setActive(var_7_1, true)

			local var_7_2 = Activity114Config.instance:getAttrName(Activity114Model.instance.id, iter_7_0)
			local var_7_3 = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, iter_7_0).attribute
			local var_7_4 = arg_7_1[iter_7_0]

			if arg_7_0.viewParam.type == Activity114Enum.EventType.Edu and Activity114Model.instance.attrAddPermillage[iter_7_0] then
				var_7_4 = Mathf.Round(var_7_4 * (1 + Activity114Model.instance.attrAddPermillage[iter_7_0]))
			end

			local var_7_5 = arg_7_0.viewParam.preAttrs[iter_7_0] + var_7_4
			local var_7_6 = Mathf.Clamp(var_7_5, 0, Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, iter_7_0))
			local var_7_7 = var_7_6 - arg_7_0.viewParam.preAttrs[iter_7_0]
			local var_7_8 = string.format("<%s>%d  (%+d)</color>", var_7_7 >= 0 and var_0_1 or var_0_2, var_7_6, var_7_7)

			gohelper.findChildTextMesh(var_7_1, "#txt_attrName").text = var_7_2
			gohelper.findChildTextMesh(var_7_1, "#txt_attrName/#txt_value").text = var_7_8

			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(var_7_1, "#image_icon"), "icons_" .. var_7_3)

			local var_7_9 = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, iter_7_0, arg_7_0.viewParam.preAttrs[iter_7_0])
			local var_7_10 = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, iter_7_0, var_7_6)

			gohelper.setActive(gohelper.findChild(var_7_1, "#txt_attrlv/#go_uplv"), var_7_9 < var_7_10)
			gohelper.setActive(gohelper.findChild(var_7_1, "#txt_attrlv/#go_downlv"), var_7_10 < var_7_9)

			gohelper.findChildTextMesh(var_7_1, "#txt_attrlv").text = string.format("<%s>%s</color>", arg_7_1[iter_7_0] >= 0 and var_0_1 or var_0_2, "Lv." .. var_7_10)
			var_7_0 = true
		end
	end

	if not var_7_0 then
		gohelper.setActive(arg_7_0._goattr, false)
	else
		gohelper.setActive(arg_7_0._goattr, true)
	end
end

function var_0_0.updateFeature(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_1 do
		local var_8_0 = gohelper.cloneInPlace(arg_8_0._gofeatureitem)

		gohelper.setActive(var_8_0, true)

		local var_8_1 = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, arg_8_1[iter_8_0])

		UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(var_8_0, "title/#image_titlebg"), var_8_1.inheritable == 1 and "img_shuxing1" or "img_shuxing2")

		gohelper.findChildTextMesh(var_8_0, "title/#txt_name").text = var_8_1.features
		gohelper.findChildTextMesh(var_8_0, "#txt_des").text = var_8_1.desc
	end

	if not next(arg_8_1) then
		gohelper.setActive(arg_8_0._gofeature, false)
	else
		gohelper.setActive(arg_8_0._gofeature, true)
	end
end

function var_0_0.updateUnLock(arg_9_0, arg_9_1)
	local var_9_0 = false

	if arg_9_1[Activity114Enum.AddAttrType.UnLockMeet] then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1[Activity114Enum.AddAttrType.UnLockMeet]) do
			local var_9_1 = Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id)[iter_9_1]
			local var_9_2 = gohelper.cloneInPlace(arg_9_0._gounlockitem)

			gohelper.setActive(var_9_2, true)

			gohelper.findChildTextMesh(var_9_2, "#txt_unlocktype").text = luaLang("versionactivity_1_2_114unlockmeet")
			gohelper.findChildTextMesh(var_9_2, "#txt_unlockname").text = var_9_1.name
			var_9_0 = true
		end
	end

	if arg_9_1[Activity114Enum.AddAttrType.UnLockTravel] then
		for iter_9_2, iter_9_3 in ipairs(arg_9_1[Activity114Enum.AddAttrType.UnLockTravel]) do
			local var_9_3 = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[iter_9_3]
			local var_9_4 = gohelper.cloneInPlace(arg_9_0._gounlockitem)

			gohelper.setActive(var_9_4, true)

			gohelper.findChildTextMesh(var_9_4, "#txt_unlocktype").text = luaLang("versionactivity_1_2_114unlocktravel")
			gohelper.findChildTextMesh(var_9_4, "#txt_unlockname").text = var_9_3.place
			var_9_0 = true
		end
	end

	if not var_9_0 then
		gohelper.setActive(arg_9_0._gounlock, false)
	else
		gohelper.setActive(arg_9_0._gounlock, true)
	end
end

function var_0_0.updateScore(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1[Activity114Enum.AddAttrType.KeyDayScore]
	local var_10_1 = arg_10_1[Activity114Enum.AddAttrType.LastKeyDayScore]
	local var_10_2 = var_10_0 or var_10_1

	if var_10_0 then
		arg_10_0._txtscorenum.text = var_10_0
		arg_10_0._txtscoretype.text = luaLang("v1a2_114finisheventview_keydayscore")
	end

	if var_10_1 then
		arg_10_0._txtscorenum.text = var_10_1
		arg_10_0._txtscoretype.text = luaLang("v1a2_114finisheventview_lastkeydayscore")
	end

	gohelper.setActive(arg_10_0._goscore, var_10_2)
end

function var_0_0.refreshContainerHeight(arg_11_0)
	ZProj.UGUIHelper.RebuildLayout(arg_11_0._gocontent.transform)

	local var_11_0 = recthelper.getHeight(arg_11_0._gocontent.transform)
	local var_11_1 = recthelper.getHeight(arg_11_0._gocontainer.transform)

	recthelper.setHeight(arg_11_0._gocontainer.transform, math.min(var_0_3, var_11_1 + var_11_0))
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagebg:UnLoadImage()
	arg_12_0._simageblackbg:UnLoadImage()
end

return var_0_0
