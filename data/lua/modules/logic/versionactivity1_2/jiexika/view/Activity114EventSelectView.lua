module("modules.logic.versionactivity1_2.jiexika.view.Activity114EventSelectView", package.seeall)

slot0 = class("Activity114EventSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotips = gohelper.findChild(slot0.viewGO, "right/#go_tips")
	slot0._txtbasevalue = gohelper.findChildTextMesh(slot0.viewGO, "right/#go_tips/base/#txt_basevalue")
	slot0._txtrealvalue = gohelper.findChildTextMesh(slot0.viewGO, "right/#go_tips/need/#txt_realvalue")
	slot0._goattrcontent = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_contentattr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_contentattr/#go_attritem")
	slot0._goattrempty = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_attrEmpty")
	slot0._goattrtotal = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_total")
	slot0._txtattrtotalnum = gohelper.findChildTextMesh(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_total/#txt_attrtotalnum")
	slot0._gofeaturecontent = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featurecontent")
	slot0._gofeatureitem = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featurecontent/#go_featureitem")
	slot0._gofeatureempty = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featureEmpty")
	slot0._gofeaturetotal = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_total")
	slot0._txtfeaturetotalnum = gohelper.findChildTextMesh(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_total/#txt_featuretotalnum")
	slot0._goanswercontent = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answercontent")
	slot0._goansweritem = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answercontent/#go_answeritem")
	slot0._goanswerempty = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answerEmpty")
	slot0._goanswertotal = gohelper.findChild(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_total")
	slot0._txtanswertotalnum = gohelper.findChildTextMesh(slot0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_total/#txt_answertotalnum")
	slot0._gooption = gohelper.findChild(slot0.viewGO, "right/#go_options")
	slot0._gooptionitem = gohelper.findChild(slot0.viewGO, "right/#go_options/#go_optionitem")
	slot0._btnskipDialog = gohelper.findChildButton(slot0.viewGO, "#btn_skipDialog")
	slot0._btncloseTip = gohelper.findChildButton(slot0.viewGO, "#btn_closeTip")
	slot0._gocontentroot = gohelper.findChild(slot0.viewGO, "#go_contentroot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskipDialog:AddClickListener(slot0.skipDialog, slot0)
	slot0._btncloseTip:AddClickListener(slot0.closeOptionTip, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskipDialog:RemoveClickListener()
	slot0._btncloseTip:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gofeatureitem, false)
	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._btncloseTip.gameObject, false)
	gohelper.setActive(slot0._gooptionitem, false)

	slot0.attrtotalnum = 0
	slot0.featuretotalnum = 0
	slot0.answertotalnum = 0
end

function slot0.onUpdateParam(slot0)
	for slot4, slot5 in pairs(slot0.items) do
		slot5:destory()
	end

	slot0:_refreshView()
end

function slot0.onOpen(slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	gohelper.setActive(slot0._gooption, true)
	slot0:_initDialog()

	slot0.items = {}
	slot1 = slot0.viewParam.eventCo

	if Activity114Model.instance.serverData.testEventId > 0 then
		for slot5 = 1, 3 do
			slot0.items[slot5] = slot0:_createItem(slot5)
		end

		slot0:updateAnswerItems()
	elseif Activity114Model.instance.serverData.checkEventId > 0 or slot1.config.eventType == Activity114Enum.EventType.KeyDay then
		if slot1.config.isCheckEvent == 1 or slot1.config.testId > 0 then
			Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.FirstCheckEventGuideId)))

			slot0.items[1] = slot0:_createItem(1)

			slot0:updateCheckItems()
		else
			logError("????!")
			slot0:closeThis()
		end
	else
		logError("????")
		slot0:closeThis()
	end
end

function slot0._initDialog(slot0)
	if not slot0._dialogItem then
		slot0._dialogItem = Activity114DialogItem.New()

		slot0._dialogItem:init(slot0._gocontentroot)
		slot0._dialogItem:hideDialog()
	end

	gohelper.setActive(slot0._gocontentroot, false)
end

function slot0.updateAnswerItems(slot0)
	slot1 = Activity114Model.instance.serverData

	if not Activity114Config.instance:getAnswerCo(Activity114Model.instance.id, slot1.testIds[slot1.currentTest]) then
		logError("答题选项配置不存在" .. tostring(slot2[slot3]))
		slot0:closeThis()

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)
	gohelper.setActive(slot0._gocontentroot, true)
	gohelper.setActive(slot0._gooption, false)

	slot8 = slot4.topic

	slot0._dialogItem:showTxt(slot8, slot0.showOptions, slot0)

	for slot8 = 1, 3 do
		slot0.items[slot8]:updateData(Activity114Enum.EventContentType.Normal, slot4["choice" .. slot8], slot0.onAnswer, slot0)
	end
end

function slot0.skipDialog(slot0)
	slot0:onSelectIndex(-1)

	if slot0._gooption.activeSelf then
		return
	end

	slot0._dialogItem:skipDialog()
end

function slot0.closeOptionTip(slot0)
	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._btncloseTip.gameObject, false)
end

function slot0.showOptions(slot0)
	gohelper.setActive(slot0._gooption, true)
end

function slot0.updateCheckItems(slot0)
	if slot0.viewParam.eventCo.config.isCheckEvent ~= 1 then
		slot0.items[1]:updateData(Activity114Enum.EventContentType.Normal, slot1.config.checkOptionText, slot0.checkEvent, slot0)
	else
		slot0.items[1]:updateData(slot1.config.disposable == 1 and Activity114Enum.EventContentType.Check_Once or Activity114Enum.EventContentType.Check, slot0:getCheckData(slot1), slot0.checkEvent, slot0)
	end

	if not string.nilorempty(slot1.config.nonOptionText) then
		slot0.items[2] = slot0:_createItem(2)

		slot0.items[2]:updateData(Activity114Enum.EventContentType.Normal, slot1.config.nonOptionText, slot0.noCheckEvent, slot0)
	end
end

function slot0._createItem(slot0, slot1)
	slot2 = gohelper.cloneInPlace(slot0._gooptionitem, "Option")

	gohelper.setActive(slot2, true)

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot2, Activity114EventSelectItem, {
		parent = slot0,
		index = slot1
	})
end

function slot0.getCheckData(slot0, slot1)
	slot2 = {
		desc = slot1.config.checkOptionText,
		featureSubs = {},
		attrSubs = {}
	}
	slot5 = 0

	if #string.splitToNumber(slot1.config.checkAttribute, "#") > 0 then
		for slot10 = 1, #slot6 do
			slot12 = 0
			slot13 = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, slot11, (Activity114Enum.Attr.End > slot6[slot10] or Activity114Model.instance.attrDict[lua_activity114_attribute.configDict[Activity114Model.instance.id][slot11].attribute]) and Activity114Model.instance.attrDict[slot11])

			table.insert(slot4, {
				name = Activity114Config.instance:getAttrName(Activity114Model.instance.id, slot11),
				value = slot13,
				attrId = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, slot11).attribute
			})

			slot5 = slot5 + slot13
		end
	end

	slot0.attrtotalnum = slot5

	for slot11, slot12 in pairs(string.splitToNumber(slot1.config.checkfeatures, "#")) do
		if Activity114Model.instance.featuresDict[slot12] then
			slot13 = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, slot12)
			slot5 = slot5 + slot13.verifyNum

			table.insert(slot3, {
				name = slot13.features,
				value = slot13.verifyNum,
				inheritable = slot13.inheritable
			})
		end
	end

	slot0.featuretotalnum = slot5 - slot0.attrtotalnum

	if slot0.viewParam.type == Activity114Enum.EventType.KeyDay and slot0.viewParam.eventCo.config.testId > 0 then
		for slot12 = 1, #Activity114Model.instance.serverData.testScores do
			slot5 = slot5 + slot8[slot12]
		end

		slot2.testScore = slot8
	end

	slot0.answertotalnum = slot5 - slot0.featuretotalnum - slot0.attrtotalnum
	slot8 = math.max(0, slot1.config.threshold - slot5)
	slot9 = Activity114Config.instance:getDiceRate(slot8)
	slot10, slot11 = Activity114Config.instance:getRateDes(slot9)
	slot2.rateDes = string.format("<%s>%s(%d%%)</color>", Activity114Enum.RateColor[slot11], slot10, slot9)
	slot2.level = slot11
	slot2.realVerify = slot8
	slot2.threshold = slot1.config.threshold

	Activity114Model.instance:setEventParams("realVerify", slot8)

	return slot2
end

function slot0.onSelectIndex(slot0, slot1)
	slot5 = AudioEnum.UI.play_ui_checkpoint_continuemesh

	AudioMgr.instance:trigger(slot5)

	for slot5 = 1, #slot0.items do
		if slot5 ~= slot1 then
			slot0.items[slot5]:setSelect(false)
		end
	end

	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._btncloseTip.gameObject, false)
end

function slot0.showTips(slot0, slot1, slot2)
	if slot0._gotips.activeSelf then
		gohelper.setActive(slot0._gotips, false)
		gohelper.setActive(slot0._btncloseTip.gameObject, false)
	else
		gohelper.setActive(slot0._gotips, true)
		gohelper.setActive(slot0._btncloseTip.gameObject, true)

		slot0._gotips.transform.position = slot2
		slot0._txtbasevalue.text = slot1.threshold
		slot0._txtrealvalue.text = string.format("%s%s%s%s%s", slot1.threshold, slot0.attrtotalnum > 0 and slot0:_getNumShowTxt(slot0.attrtotalnum) or "", slot0.featuretotalnum > 0 and slot0:_getNumShowTxt(slot0.featuretotalnum) or "", slot0.answertotalnum > 0 and slot0:_getNumShowTxt(slot0.answertotalnum) or "", slot1.threshold ~= slot1.realVerify and string.format(" = <color=#E19C60>%s</color>", slot1.realVerify) or "")
		slot0._txtattrtotalnum.text = slot0:_getNumShowTxt(slot0.attrtotalnum)
		slot0._txtfeaturetotalnum.text = slot0:_getNumShowTxt(slot0.featuretotalnum)
		slot0._txtanswertotalnum.text = slot0:_getNumShowTxt(slot0.answertotalnum)

		gohelper.setActive(slot0._goattrempty, GameUtil.getTabLen(slot1.attrSubs) == 0)
		gohelper.setActive(slot0._goattrtotal, GameUtil.getTabLen(slot1.attrSubs) > 0)
		gohelper.setActive(slot0._goattrcontent, GameUtil.getTabLen(slot1.attrSubs) > 0)
		gohelper.setActive(slot0._gofeatureempty, GameUtil.getTabLen(slot1.featureSubs) == 0)
		gohelper.setActive(slot0._gofeaturetotal, GameUtil.getTabLen(slot1.featureSubs) > 0)
		gohelper.setActive(slot0._gofeaturecontent, GameUtil.getTabLen(slot1.featureSubs) > 0)
		gohelper.setActive(slot0._goanswerempty, GameUtil.getTabLen(slot1.testScore) == 0)
		gohelper.setActive(slot0._goanswertotal, GameUtil.getTabLen(slot1.testScore) > 0)
		gohelper.CreateObjList(slot0, slot0.setAttrItem, slot1.attrSubs, slot0._goattrcontent, slot0._goattritem)
		gohelper.CreateObjList(slot0, slot0.setFeatureItem, slot1.featureSubs, slot0._gofeaturecontent, slot0._gofeatureitem)
		gohelper.setActive(slot0._goanswercontent, slot1.testScore)

		if slot1.testScore then
			gohelper.CreateObjList(slot0, slot0.setAnswerItem, slot1.testScore, slot0._goanswercontent, slot0._goansweritem)
		end
	end
end

function slot0.setAttrItem(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(slot1, "#image_icon"), "icons_" .. slot2.attrId)

	gohelper.findChildTextMesh(slot1, "#txt_name").text = slot2.name
	gohelper.findChildTextMesh(slot1, "#txt_value").text = slot0:_getNumShowTxt(slot2.value)
end

function slot0.setFeatureItem(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(slot1, "#image_bg"), slot2.inheritable == 1 and "img_shuxing1" or "img_shuxing2")

	gohelper.findChildTextMesh(slot1, "#txt_name").text = slot2.name
	gohelper.findChildTextMesh(slot1, "#txt_value").text = slot0:_getNumShowTxt(slot2.value)
end

function slot0.setAnswerItem(slot0, slot1, slot2, slot3)
	gohelper.findChildTextMesh(slot1, "#txt_name").text = string.format(luaLang("v1a2_114eventselectview_question"), GameUtil.getNum2Chinese(slot3))
	gohelper.findChildTextMesh(slot1, "#txt_value").text = slot0:_getNumShowTxt(slot2)
end

function slot0._getNumShowTxt(slot0, slot1)
	if slot1 == 0 then
		return "-0"
	end

	return string.format("%+d", -slot1)
end

function slot0.onAnswer(slot0, slot1)
	Activity114Rpc.instance:answerRequest(Activity114Model.instance.id, slot1, slot0.onAnswerReply, slot0)
end

function slot0.onAnswerReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 and slot3.successStatus == Activity114Enum.Result.NoFinish then
		slot0:onSelectIndex(-1)
		slot0:updateAnswerItems()
	end
end

function slot0.checkEvent(slot0)
	Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, true)
end

function slot0.noCheckEvent(slot0)
	if slot0.viewParam.type == Activity114Enum.EventType.KeyDay then
		logError("关键天还能不检定？？？？？")

		return
	end

	Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, false)
end

function slot0.showHideDiceTips(slot0)
	gohelper.setActive(slot0._gotips, not slot0._gotips.activeSelf)
	gohelper.setActive(slot0._btncloseTip.gameObject, not slot0._gotips.activeSelf)
end

function slot0.onClose(slot0)
	if slot0.items then
		for slot4, slot5 in pairs(slot0.items) do
			slot5:destory()
		end
	end

	if slot0._dialogItem then
		slot0._dialogItem:destroy()

		slot0._dialogItem = nil
	end
end

return slot0
