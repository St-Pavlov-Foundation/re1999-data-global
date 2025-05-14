module("modules.logic.versionactivity1_2.jiexika.view.Activity114EventSelectView", package.seeall)

local var_0_0 = class("Activity114EventSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips")
	arg_1_0._txtbasevalue = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#go_tips/base/#txt_basevalue")
	arg_1_0._txtrealvalue = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#go_tips/need/#txt_realvalue")
	arg_1_0._goattrcontent = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_contentattr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_contentattr/#go_attritem")
	arg_1_0._goattrempty = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_attrEmpty")
	arg_1_0._goattrtotal = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_total")
	arg_1_0._txtattrtotalnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/quality/#go_total/#txt_attrtotalnum")
	arg_1_0._gofeaturecontent = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featurecontent")
	arg_1_0._gofeatureitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featurecontent/#go_featureitem")
	arg_1_0._gofeatureempty = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_featureEmpty")
	arg_1_0._gofeaturetotal = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_total")
	arg_1_0._txtfeaturetotalnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/feature/#go_total/#txt_featuretotalnum")
	arg_1_0._goanswercontent = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answercontent")
	arg_1_0._goansweritem = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answercontent/#go_answeritem")
	arg_1_0._goanswerempty = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_answerEmpty")
	arg_1_0._goanswertotal = gohelper.findChild(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_total")
	arg_1_0._txtanswertotalnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#go_tips/#scroll_content/Viewport/content/answer/#go_total/#txt_answertotalnum")
	arg_1_0._gooption = gohelper.findChild(arg_1_0.viewGO, "right/#go_options")
	arg_1_0._gooptionitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_options/#go_optionitem")
	arg_1_0._btnskipDialog = gohelper.findChildButton(arg_1_0.viewGO, "#btn_skipDialog")
	arg_1_0._btncloseTip = gohelper.findChildButton(arg_1_0.viewGO, "#btn_closeTip")
	arg_1_0._gocontentroot = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskipDialog:AddClickListener(arg_2_0.skipDialog, arg_2_0)
	arg_2_0._btncloseTip:AddClickListener(arg_2_0.closeOptionTip, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskipDialog:RemoveClickListener()
	arg_3_0._btncloseTip:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gofeatureitem, false)
	gohelper.setActive(arg_4_0._gotips, false)
	gohelper.setActive(arg_4_0._btncloseTip.gameObject, false)
	gohelper.setActive(arg_4_0._gooptionitem, false)

	arg_4_0.attrtotalnum = 0
	arg_4_0.featuretotalnum = 0
	arg_4_0.answertotalnum = 0
end

function var_0_0.onUpdateParam(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.items) do
		iter_5_1:destory()
	end

	arg_5_0:_refreshView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0._refreshView(arg_7_0)
	gohelper.setActive(arg_7_0._gooption, true)
	arg_7_0:_initDialog()

	arg_7_0.items = {}

	local var_7_0 = arg_7_0.viewParam.eventCo

	if Activity114Model.instance.serverData.testEventId > 0 then
		for iter_7_0 = 1, 3 do
			arg_7_0.items[iter_7_0] = arg_7_0:_createItem(iter_7_0)
		end

		arg_7_0:updateAnswerItems()
	elseif Activity114Model.instance.serverData.checkEventId > 0 or var_7_0.config.eventType == Activity114Enum.EventType.KeyDay then
		if var_7_0.config.isCheckEvent == 1 or var_7_0.config.testId > 0 then
			local var_7_1 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.FirstCheckEventGuideId)

			Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(var_7_1))

			arg_7_0.items[1] = arg_7_0:_createItem(1)

			arg_7_0:updateCheckItems()
		else
			logError("????!")
			arg_7_0:closeThis()
		end
	else
		logError("????")
		arg_7_0:closeThis()
	end
end

function var_0_0._initDialog(arg_8_0)
	if not arg_8_0._dialogItem then
		arg_8_0._dialogItem = Activity114DialogItem.New()

		arg_8_0._dialogItem:init(arg_8_0._gocontentroot)
		arg_8_0._dialogItem:hideDialog()
	end

	gohelper.setActive(arg_8_0._gocontentroot, false)
end

function var_0_0.updateAnswerItems(arg_9_0)
	local var_9_0 = Activity114Model.instance.serverData
	local var_9_1 = var_9_0.testIds
	local var_9_2 = var_9_0.currentTest
	local var_9_3 = Activity114Config.instance:getAnswerCo(Activity114Model.instance.id, var_9_1[var_9_2])

	if not var_9_3 then
		logError("答题选项配置不存在" .. tostring(var_9_1[var_9_2]))
		arg_9_0:closeThis()

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.HideDialog)
	gohelper.setActive(arg_9_0._gocontentroot, true)
	gohelper.setActive(arg_9_0._gooption, false)
	arg_9_0._dialogItem:showTxt(var_9_3.topic, arg_9_0.showOptions, arg_9_0)

	for iter_9_0 = 1, 3 do
		local var_9_4 = var_9_3["choice" .. iter_9_0]

		arg_9_0.items[iter_9_0]:updateData(Activity114Enum.EventContentType.Normal, var_9_4, arg_9_0.onAnswer, arg_9_0)
	end
end

function var_0_0.skipDialog(arg_10_0)
	arg_10_0:onSelectIndex(-1)

	if arg_10_0._gooption.activeSelf then
		return
	end

	arg_10_0._dialogItem:skipDialog()
end

function var_0_0.closeOptionTip(arg_11_0)
	gohelper.setActive(arg_11_0._gotips, false)
	gohelper.setActive(arg_11_0._btncloseTip.gameObject, false)
end

function var_0_0.showOptions(arg_12_0)
	gohelper.setActive(arg_12_0._gooption, true)
end

function var_0_0.updateCheckItems(arg_13_0)
	local var_13_0 = arg_13_0.viewParam.eventCo

	if var_13_0.config.isCheckEvent ~= 1 then
		arg_13_0.items[1]:updateData(Activity114Enum.EventContentType.Normal, var_13_0.config.checkOptionText, arg_13_0.checkEvent, arg_13_0)
	else
		local var_13_1 = var_13_0.config.disposable == 1 and Activity114Enum.EventContentType.Check_Once or Activity114Enum.EventContentType.Check
		local var_13_2 = arg_13_0:getCheckData(var_13_0)

		arg_13_0.items[1]:updateData(var_13_1, var_13_2, arg_13_0.checkEvent, arg_13_0)
	end

	if not string.nilorempty(var_13_0.config.nonOptionText) then
		arg_13_0.items[2] = arg_13_0:_createItem(2)

		arg_13_0.items[2]:updateData(Activity114Enum.EventContentType.Normal, var_13_0.config.nonOptionText, arg_13_0.noCheckEvent, arg_13_0)
	end
end

function var_0_0._createItem(arg_14_0, arg_14_1)
	local var_14_0 = gohelper.cloneInPlace(arg_14_0._gooptionitem, "Option")

	gohelper.setActive(var_14_0, true)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_14_0, Activity114EventSelectItem, {
		parent = arg_14_0,
		index = arg_14_1
	})
end

function var_0_0.getCheckData(arg_15_0, arg_15_1)
	local var_15_0 = {
		desc = arg_15_1.config.checkOptionText
	}
	local var_15_1 = {}

	var_15_0.featureSubs = var_15_1

	local var_15_2 = {}

	var_15_0.attrSubs = var_15_2

	local var_15_3 = 0
	local var_15_4 = string.splitToNumber(arg_15_1.config.checkAttribute, "#")

	if #var_15_4 > 0 then
		for iter_15_0 = 1, #var_15_4 do
			local var_15_5 = var_15_4[iter_15_0]
			local var_15_6 = 0

			if var_15_5 >= Activity114Enum.Attr.End then
				local var_15_7 = lua_activity114_attribute.configDict[Activity114Model.instance.id][var_15_5].attribute

				var_15_6 = Activity114Model.instance.attrDict[var_15_7]
			else
				var_15_6 = Activity114Model.instance.attrDict[var_15_5]
			end

			local var_15_8 = Activity114Config.instance:getAttrVerify(Activity114Model.instance.id, var_15_5, var_15_6)
			local var_15_9 = Activity114Config.instance:getAttrName(Activity114Model.instance.id, var_15_5)
			local var_15_10 = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, var_15_5).attribute

			table.insert(var_15_2, {
				name = var_15_9,
				value = var_15_8,
				attrId = var_15_10
			})

			var_15_3 = var_15_3 + var_15_8
		end
	end

	arg_15_0.attrtotalnum = var_15_3

	local var_15_11 = string.splitToNumber(arg_15_1.config.checkfeatures, "#")

	for iter_15_1, iter_15_2 in pairs(var_15_11) do
		if Activity114Model.instance.featuresDict[iter_15_2] then
			local var_15_12 = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, iter_15_2)

			var_15_3 = var_15_3 + var_15_12.verifyNum

			table.insert(var_15_1, {
				name = var_15_12.features,
				value = var_15_12.verifyNum,
				inheritable = var_15_12.inheritable
			})
		end
	end

	arg_15_0.featuretotalnum = var_15_3 - arg_15_0.attrtotalnum

	if arg_15_0.viewParam.type == Activity114Enum.EventType.KeyDay and arg_15_0.viewParam.eventCo.config.testId > 0 then
		local var_15_13 = Activity114Model.instance.serverData.testScores

		for iter_15_3 = 1, #var_15_13 do
			var_15_3 = var_15_3 + var_15_13[iter_15_3]
		end

		var_15_0.testScore = var_15_13
	end

	arg_15_0.answertotalnum = var_15_3 - arg_15_0.featuretotalnum - arg_15_0.attrtotalnum

	local var_15_14 = math.max(0, arg_15_1.config.threshold - var_15_3)
	local var_15_15 = Activity114Config.instance:getDiceRate(var_15_14)
	local var_15_16, var_15_17 = Activity114Config.instance:getRateDes(var_15_15)
	local var_15_18 = Activity114Enum.RateColor[var_15_17]

	var_15_0.rateDes = string.format("<%s>%s(%d%%)</color>", var_15_18, var_15_16, var_15_15)
	var_15_0.level = var_15_17
	var_15_0.realVerify = var_15_14
	var_15_0.threshold = arg_15_1.config.threshold

	Activity114Model.instance:setEventParams("realVerify", var_15_14)

	return var_15_0
end

function var_0_0.onSelectIndex(arg_16_0, arg_16_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	for iter_16_0 = 1, #arg_16_0.items do
		if iter_16_0 ~= arg_16_1 then
			arg_16_0.items[iter_16_0]:setSelect(false)
		end
	end

	gohelper.setActive(arg_16_0._gotips, false)
	gohelper.setActive(arg_16_0._btncloseTip.gameObject, false)
end

function var_0_0.showTips(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._gotips.activeSelf then
		gohelper.setActive(arg_17_0._gotips, false)
		gohelper.setActive(arg_17_0._btncloseTip.gameObject, false)
	else
		gohelper.setActive(arg_17_0._gotips, true)
		gohelper.setActive(arg_17_0._btncloseTip.gameObject, true)

		arg_17_0._gotips.transform.position = arg_17_2
		arg_17_0._txtbasevalue.text = arg_17_1.threshold

		local var_17_0 = arg_17_0.attrtotalnum > 0 and arg_17_0:_getNumShowTxt(arg_17_0.attrtotalnum) or ""
		local var_17_1 = arg_17_0.featuretotalnum > 0 and arg_17_0:_getNumShowTxt(arg_17_0.featuretotalnum) or ""
		local var_17_2 = arg_17_0.answertotalnum > 0 and arg_17_0:_getNumShowTxt(arg_17_0.answertotalnum) or ""
		local var_17_3 = arg_17_1.threshold ~= arg_17_1.realVerify and string.format(" = <color=#E19C60>%s</color>", arg_17_1.realVerify) or ""

		arg_17_0._txtrealvalue.text = string.format("%s%s%s%s%s", arg_17_1.threshold, var_17_0, var_17_1, var_17_2, var_17_3)
		arg_17_0._txtattrtotalnum.text = arg_17_0:_getNumShowTxt(arg_17_0.attrtotalnum)
		arg_17_0._txtfeaturetotalnum.text = arg_17_0:_getNumShowTxt(arg_17_0.featuretotalnum)
		arg_17_0._txtanswertotalnum.text = arg_17_0:_getNumShowTxt(arg_17_0.answertotalnum)

		gohelper.setActive(arg_17_0._goattrempty, GameUtil.getTabLen(arg_17_1.attrSubs) == 0)
		gohelper.setActive(arg_17_0._goattrtotal, GameUtil.getTabLen(arg_17_1.attrSubs) > 0)
		gohelper.setActive(arg_17_0._goattrcontent, GameUtil.getTabLen(arg_17_1.attrSubs) > 0)
		gohelper.setActive(arg_17_0._gofeatureempty, GameUtil.getTabLen(arg_17_1.featureSubs) == 0)
		gohelper.setActive(arg_17_0._gofeaturetotal, GameUtil.getTabLen(arg_17_1.featureSubs) > 0)
		gohelper.setActive(arg_17_0._gofeaturecontent, GameUtil.getTabLen(arg_17_1.featureSubs) > 0)
		gohelper.setActive(arg_17_0._goanswerempty, GameUtil.getTabLen(arg_17_1.testScore) == 0)
		gohelper.setActive(arg_17_0._goanswertotal, GameUtil.getTabLen(arg_17_1.testScore) > 0)
		gohelper.CreateObjList(arg_17_0, arg_17_0.setAttrItem, arg_17_1.attrSubs, arg_17_0._goattrcontent, arg_17_0._goattritem)
		gohelper.CreateObjList(arg_17_0, arg_17_0.setFeatureItem, arg_17_1.featureSubs, arg_17_0._gofeaturecontent, arg_17_0._gofeatureitem)
		gohelper.setActive(arg_17_0._goanswercontent, arg_17_1.testScore)

		if arg_17_1.testScore then
			gohelper.CreateObjList(arg_17_0, arg_17_0.setAnswerItem, arg_17_1.testScore, arg_17_0._goanswercontent, arg_17_0._goansweritem)
		end
	end
end

function var_0_0.setAttrItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(arg_18_1, "#image_icon"), "icons_" .. arg_18_2.attrId)

	gohelper.findChildTextMesh(arg_18_1, "#txt_name").text = arg_18_2.name
	gohelper.findChildTextMesh(arg_18_1, "#txt_value").text = arg_18_0:_getNumShowTxt(arg_18_2.value)
end

function var_0_0.setFeatureItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(gohelper.findChildImage(arg_19_1, "#image_bg"), arg_19_2.inheritable == 1 and "img_shuxing1" or "img_shuxing2")

	gohelper.findChildTextMesh(arg_19_1, "#txt_name").text = arg_19_2.name
	gohelper.findChildTextMesh(arg_19_1, "#txt_value").text = arg_19_0:_getNumShowTxt(arg_19_2.value)
end

function var_0_0.setAnswerItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	gohelper.findChildTextMesh(arg_20_1, "#txt_name").text = string.format(luaLang("v1a2_114eventselectview_question"), GameUtil.getNum2Chinese(arg_20_3))
	gohelper.findChildTextMesh(arg_20_1, "#txt_value").text = arg_20_0:_getNumShowTxt(arg_20_2)
end

function var_0_0._getNumShowTxt(arg_21_0, arg_21_1)
	if arg_21_1 == 0 then
		return "-0"
	end

	return string.format("%+d", -arg_21_1)
end

function var_0_0.onAnswer(arg_22_0, arg_22_1)
	Activity114Rpc.instance:answerRequest(Activity114Model.instance.id, arg_22_1, arg_22_0.onAnswerReply, arg_22_0)
end

function var_0_0.onAnswerReply(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 == 0 and arg_23_3.successStatus == Activity114Enum.Result.NoFinish then
		arg_23_0:onSelectIndex(-1)
		arg_23_0:updateAnswerItems()
	end
end

function var_0_0.checkEvent(arg_24_0)
	Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, true)
end

function var_0_0.noCheckEvent(arg_25_0)
	if arg_25_0.viewParam.type == Activity114Enum.EventType.KeyDay then
		logError("关键天还能不检定？？？？？")

		return
	end

	Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, false)
end

function var_0_0.showHideDiceTips(arg_26_0)
	gohelper.setActive(arg_26_0._gotips, not arg_26_0._gotips.activeSelf)
	gohelper.setActive(arg_26_0._btncloseTip.gameObject, not arg_26_0._gotips.activeSelf)
end

function var_0_0.onClose(arg_27_0)
	if arg_27_0.items then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.items) do
			iter_27_1:destory()
		end
	end

	if arg_27_0._dialogItem then
		arg_27_0._dialogItem:destroy()

		arg_27_0._dialogItem = nil
	end
end

return var_0_0
