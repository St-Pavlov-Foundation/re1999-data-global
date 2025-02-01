module("modules.logic.versionactivity1_2.jiexika.view.Activity114FinishEventView", package.seeall)

slot0 = class("Activity114FinishEventView", BaseView)
slot1 = "#9EE091"
slot2 = "#e55151"
slot3 = 714

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageblackbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_container/blackbgmask/#simage_blackbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content")
	slot0._goattention = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention")
	slot0._attentionimg0 = gohelper.findChildImage(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention")
	slot0._attentionimg1 = gohelper.findChildImage(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention1")
	slot0._attentionimg2 = gohelper.findChildImage(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#image_attention2")
	slot0._attentionadd = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attention/attentionBar/#txt_attentionadd")
	slot0._goattr = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_attr/#go_attritem")
	slot0._gofeature = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_feature")
	slot0._gofeatureitem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_feature/#go_featureitem")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_unlock")
	slot0._gounlockitem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_unlock/#go_unlockitem")
	slot0._goscore = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score")
	slot0._txtscoretype = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score/#go_scoreitem/#txt_scoretype")
	slot0._txtscorenum = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/#scroll_event/Viewport/#go_content/#go_score/#go_scoreitem/#txt_scorenum")

	gohelper.setActive(slot0._goattritem, false)
	gohelper.setActive(slot0._gofeatureitem, false)
	gohelper.setActive(slot0._gounlockitem, false)
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	slot0._simagebg:LoadImage(ResUrl.getAct114Icon("bg1"))
	slot0._simageblackbg:LoadImage(ResUrl.getAct114Icon("img_bg1"))

	slot1 = slot0.viewParam.resultBonus
	slot2 = slot1.addAttr

	slot0:updateAttention(slot2)
	slot0:updateAttr(slot2)
	slot0:updateFeature(slot1.featuresList)
	slot0:updateUnLock(slot2)
	slot0:updateScore(slot2)
	slot0:refreshContainerHeight()
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_CloseHouse)
end

function slot0.updateAttention(slot0, slot1)
	if slot1[Activity114Enum.AddAttrType.Attention] then
		gohelper.setActive(slot0._goattention, true)

		slot0._attentionadd.text = string.format("<%s>%+d</color>", slot2 >= 0 and uv0 or uv1, Activity114Model.instance.serverData.attention - slot0.viewParam.preAttention)

		gohelper.setActive(slot0._attentionimg1, slot2 >= 0)
		gohelper.setActive(slot0._attentionimg0, slot2 < 0)

		slot0._attentionimg0.fillAmount = math.max(slot3, slot0.viewParam.preAttention) / 100
		slot0._attentionimg1.fillAmount = math.max(slot3, slot0.viewParam.preAttention) / 100
		slot0._attentionimg2.fillAmount = math.min(slot3, slot0.viewParam.preAttention) / 100
	else
		gohelper.setActive(slot0._goattention, false)
	end
end

function slot0.updateAttr(slot0, slot1)
	slot2 = false

	for slot6 = 1, Activity114Enum.Attr.End - 1 do
		if slot1[slot6] then
			gohelper.setActive(gohelper.cloneInPlace(slot0._goattritem), true)

			slot8 = Activity114Config.instance:getAttrName(Activity114Model.instance.id, slot6)
			slot9 = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, slot6).attribute

			if slot0.viewParam.type == Activity114Enum.EventType.Edu and Activity114Model.instance.attrAddPermillage[slot6] then
				slot10 = Mathf.Round(slot1[slot6] * (1 + Activity114Model.instance.attrAddPermillage[slot6]))
			end

			gohelper.findChildTextMesh(slot7, "#txt_attrName").text = slot8
			gohelper.findChildTextMesh(slot7, "#txt_attrName/#txt_value").text = string.format("<%s>%d  (%+d)</color>", Mathf.Clamp(slot0.viewParam.preAttrs[slot6] + slot10, 0, Activity114Config.instance:getAttrMaxValue(Activity114Model.instance.id, slot6)) - slot0.viewParam.preAttrs[slot6] >= 0 and uv0 or uv1, slot11, slot10)

			UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(slot7, "#image_icon"), "icons_" .. slot9)
			gohelper.setActive(gohelper.findChild(slot7, "#txt_attrlv/#go_uplv"), Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, slot6, slot0.viewParam.preAttrs[slot6]) < Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, slot6, slot11))
			gohelper.setActive(gohelper.findChild(slot7, "#txt_attrlv/#go_downlv"), slot14 < slot13)

			gohelper.findChildTextMesh(slot7, "#txt_attrlv").text = string.format("<%s>%s</color>", slot1[slot6] >= 0 and uv0 or uv1, "Lv." .. slot14)
			slot2 = true
		end
	end

	if not slot2 then
		gohelper.setActive(slot0._goattr, false)
	else
		gohelper.setActive(slot0._goattr, true)
	end
end

function slot0.updateFeature(slot0, slot1)
	for slot5 = 1, #slot1 do
		slot6 = gohelper.cloneInPlace(slot0._gofeatureitem)

		gohelper.setActive(slot6, true)
		UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(slot6, "title/#image_titlebg"), Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, slot1[slot5]).inheritable == 1 and "img_shuxing1" or "img_shuxing2")

		gohelper.findChildTextMesh(slot6, "title/#txt_name").text = slot7.features
		gohelper.findChildTextMesh(slot6, "#txt_des").text = slot7.desc
	end

	if not next(slot1) then
		gohelper.setActive(slot0._gofeature, false)
	else
		gohelper.setActive(slot0._gofeature, true)
	end
end

function slot0.updateUnLock(slot0, slot1)
	slot2 = false

	if slot1[Activity114Enum.AddAttrType.UnLockMeet] then
		for slot6, slot7 in ipairs(slot1[Activity114Enum.AddAttrType.UnLockMeet]) do
			slot9 = gohelper.cloneInPlace(slot0._gounlockitem)

			gohelper.setActive(slot9, true)

			gohelper.findChildTextMesh(slot9, "#txt_unlocktype").text = luaLang("versionactivity_1_2_114unlockmeet")
			gohelper.findChildTextMesh(slot9, "#txt_unlockname").text = Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id)[slot7].name
			slot2 = true
		end
	end

	if slot1[Activity114Enum.AddAttrType.UnLockTravel] then
		for slot6, slot7 in ipairs(slot1[Activity114Enum.AddAttrType.UnLockTravel]) do
			slot9 = gohelper.cloneInPlace(slot0._gounlockitem)

			gohelper.setActive(slot9, true)

			gohelper.findChildTextMesh(slot9, "#txt_unlocktype").text = luaLang("versionactivity_1_2_114unlocktravel")
			gohelper.findChildTextMesh(slot9, "#txt_unlockname").text = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[slot7].place
			slot2 = true
		end
	end

	if not slot2 then
		gohelper.setActive(slot0._gounlock, false)
	else
		gohelper.setActive(slot0._gounlock, true)
	end
end

function slot0.updateScore(slot0, slot1)
	slot4 = slot1[Activity114Enum.AddAttrType.KeyDayScore] or slot1[Activity114Enum.AddAttrType.LastKeyDayScore]

	if slot2 then
		slot0._txtscorenum.text = slot2
		slot0._txtscoretype.text = luaLang("v1a2_114finisheventview_keydayscore")
	end

	if slot3 then
		slot0._txtscorenum.text = slot3
		slot0._txtscoretype.text = luaLang("v1a2_114finisheventview_lastkeydayscore")
	end

	gohelper.setActive(slot0._goscore, slot4)
end

function slot0.refreshContainerHeight(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._gocontent.transform)
	recthelper.setHeight(slot0._gocontainer.transform, math.min(uv0, recthelper.getHeight(slot0._gocontainer.transform) + recthelper.getHeight(slot0._gocontent.transform)))
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageblackbg:UnLoadImage()
end

return slot0
