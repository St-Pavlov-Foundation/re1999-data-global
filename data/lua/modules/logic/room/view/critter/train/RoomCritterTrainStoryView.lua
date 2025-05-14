module("modules.logic.room.view.critter.train.RoomCritterTrainStoryView", package.seeall)

local var_0_0 = class("RoomCritterTrainStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomask2 = gohelper.findChild(arg_1_0.viewGO, "mask2")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "mask")
	arg_1_0._golefttopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_lefttopbtns")
	arg_1_0._gorighttopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_righttopbtns")
	arg_1_0._btncurrency = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_righttopbtns/#go_container/currency/#btn_currency")
	arg_1_0._imagecurrency = gohelper.findChildImage(arg_1_0.viewGO, "#go_righttopbtns/#go_container/currency/#image")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_righttopbtns/#go_container/currency/#btn_add")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "#go_righttopbtns/#go_container/currency/content/#txt")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spine")
	arg_1_0._scrollselect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_select")
	arg_1_0._golist = gohelper.findChild(arg_1_0.viewGO, "#scroll_select/Viewport/#go_list")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#scroll_select/Viewport/#go_list/selectitem/bgdark/#txt_num")
	arg_1_0._gopcbtn = gohelper.findChild(arg_1_0.viewGO, "#scroll_select/Viewport/#go_list/selectitem/bgdark/#go_pcbtn")
	arg_1_0._goconversation = gohelper.findChild(arg_1_0.viewGO, "#go_conversation")
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "#go_conversation/#go_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_conversation/#go_name/#txt_nameen")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_conversation/#go_name/#txt_namecn")
	arg_1_0._gocontents = gohelper.findChild(arg_1_0.viewGO, "#go_conversation/#go_contents")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#go_conversation/#go_contents/#txt_content")
	arg_1_0._gotrainprogress = gohelper.findChild(arg_1_0.viewGO, "#go_trainprogress")
	arg_1_0._imagetotalBarValue = gohelper.findChildImage(arg_1_0.viewGO, "#go_trainprogress/progressbg/#image_totalBarValue")
	arg_1_0._goexittips = gohelper.findChild(arg_1_0.viewGO, "#go_exittips")
	arg_1_0._goexittxt = gohelper.findChild(arg_1_0.viewGO, "#go_exittips/txt")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "#go_attribute")
	arg_1_0._goattributeup = gohelper.findChild(arg_1_0.viewGO, "#go_attributeup")
	arg_1_0._goattributeupitem = gohelper.findChild(arg_1_0.viewGO, "#go_attributeup/attributeup")
	arg_1_0._btntrainstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_trainstart")
	arg_1_0._goattributeupeffect = gohelper.findChild(arg_1_0.viewGO, "#attributeup_effect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncurrency:AddClickListener(arg_2_0._btncurrencyOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btntrainstart:AddClickListener(arg_2_0._btntrainstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncurrency:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btntrainstart:RemoveClickListener()
end

function var_0_0._btncurrencyOnClick(arg_4_0)
	local var_4_0 = CritterConfig.instance:getCritterTrainEventCfg(arg_4_0.viewParam.eventId)
	local var_4_1 = string.splitToNumber(var_4_0.cost, "#")

	MaterialTipController.instance:showMaterialInfo(var_4_1[1], var_4_1[2], false, nil, false)
end

function var_0_0._btnaddOnClick(arg_5_0)
	local var_5_0 = CritterConfig.instance:getCritterTrainEventCfg(arg_5_0.viewParam.eventId)
	local var_5_1 = string.splitToNumber(var_5_0.cost, "#")

	RoomCritterController.instance:openExchangeView(var_5_1)
end

function var_0_0._btntrainstartOnClick(arg_6_0)
	local var_6_0 = CritterConfig.instance:getCritterTrainEventCfg(arg_6_0.viewParam.eventId)
	local var_6_1 = string.splitToNumber(var_6_0.cost, "#")
	local var_6_2 = math.floor(ItemModel.instance:getItemQuantity(var_6_1[1], var_6_1[2]) / var_6_1[3])
	local var_6_3 = RoomTrainCritterModel.instance:getSelectOptionTotalCount()
	local var_6_4 = ItemModel.instance:getItemConfig(var_6_1[1], var_6_1[2])

	if var_6_2 < var_6_3 then
		GameFacade.showToast(ToastEnum.RoomCritterTrainCountNotEnoughCurrency, var_6_4.name)

		return
	end

	local var_6_5 = RoomTrainCritterModel.instance:getSelectOptionInfos()

	CritterRpc.instance:sendSelectMultiEventOptionRequest(arg_6_0.viewParam.critterUid, arg_6_0.viewParam.eventId, var_6_5, arg_6_0._attributeSelected, arg_6_0)
end

function var_0_0._attributeSelected(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 ~= 0 then
		return
	end

	arg_7_0:_showEnterBtn(false)
	gohelper.setActive(arg_7_0._goattribute, false)
	gohelper.setActive(arg_7_0._scrollselect.gameObject, false)
	gohelper.setActive(arg_7_0._goconversation, false)
	arg_7_0._critterItem:fadeOut()

	if arg_7_0.viewParam.skipStory then
		arg_7_0.viewContainer:getSetting().viewType = ViewType.Full
	else
		gohelper.setActive(arg_7_0._storyViewGo, true)

		arg_7_0.viewContainer:getSetting().viewType = ViewType.Normal
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_3.infos) do
		local var_7_0 = {
			optionId = iter_7_1.optionId,
			count = iter_7_1.count
		}

		arg_7_0._optionInfos[var_7_0.optionId] = var_7_0
	end

	arg_7_0._attributeItem:playBarAdd(false)
	arg_7_0._viewAnim:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_7_0._showTrainProgress, arg_7_0, 0.17)
end

function var_0_0._addEvents(arg_8_0)
	arg_8_0._exitBtn:AddClickListener(arg_8_0._onExitClick, arg_8_0)
	StoryController.instance:registerCallback(StoryEvent.DialogConFinished, arg_8_0._onDialogConFinished, arg_8_0)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, arg_8_0._refreshCurrency, arg_8_0)
	RoomController.instance:registerCallback(RoomEvent.CritterTrainAttributeSelected, arg_8_0._onAttributeSelected, arg_8_0)
	RoomController.instance:registerCallback(RoomEvent.CritterTrainAttributeCancel, arg_8_0._onAttributeCancel, arg_8_0)
	StoryController.instance:registerCallback(StoryEvent.OnReplaceHero, arg_8_0._onStoryReplaceHero, arg_8_0)
end

function var_0_0._removeEvents(arg_9_0)
	arg_9_0._exitBtn:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, arg_9_0._onDialogConFinished, arg_9_0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, arg_9_0._refreshCurrency, arg_9_0)
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainAttributeSelected, arg_9_0._onAttributeSelected, arg_9_0)
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainAttributeCancel, arg_9_0._onAttributeCancel, arg_9_0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_9_0._onAttributeStoryFinished, arg_9_0)
	StoryController.instance:unregisterCallback(StoryEvent.OnReplaceHero, arg_9_0._onStoryReplaceHero, arg_9_0)
end

function var_0_0._onDialogConFinished(arg_10_0)
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, arg_10_0._onDialogConFinished, arg_10_0)
	arg_10_0:_showAttributeSelect()
end

function var_0_0._showAttributeSelect(arg_11_0)
	gohelper.setActive(arg_11_0._goattribute, true)
	gohelper.setActive(arg_11_0._scrollselect.gameObject, true)
	gohelper.setActive(arg_11_0._goconversation, true)

	if arg_11_0._storyViewGo then
		gohelper.setActive(arg_11_0._storyViewGo, false)

		arg_11_0.viewContainer:getSetting().viewType = ViewType.Full

		arg_11_0._critterItem:fadeIn()
		arg_11_0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	else
		arg_11_0._critterItem:showByEffectType(arg_11_0._critterMO, CritterEnum.PosType.Middle, false)
		arg_11_0._critterItem:fadeIn()
	end

	StoryController.instance:closeStoryView()
	gohelper.setActive(arg_11_0._gorighttopbtns, true)
	arg_11_0:_refreshCurrency()
	arg_11_0:_refreshAttribute()
	arg_11_0:_refreshSelect()
	arg_11_0:_playConversation()

	local var_11_0 = arg_11_0._critterMO.trainInfo:getEventOptions(arg_11_0.viewParam.eventId)

	arg_11_0._attributeItem:playBarAdd(true, var_11_0)
	arg_11_0._viewAnim:Play("open", 0, 0)
end

function var_0_0._onAttributeSelected(arg_12_0, arg_12_1, arg_12_2)
	RoomTrainCritterModel.instance:addSelectOptionCount(arg_12_1)
	arg_12_0:_refreshAttribute()

	local var_12_0 = arg_12_0._critterMO.trainInfo:getEventOptions(arg_12_0.viewParam.eventId)

	arg_12_0._attributeItem:playBarAdd(true, var_12_0)
	arg_12_0:_refreshSelect()
	arg_12_0:_showEnterBtn(true)
end

function var_0_0._onAttributeCancel(arg_13_0, arg_13_1, arg_13_2)
	RoomTrainCritterModel.instance:cancelSelectOptionCount(arg_13_1)
	arg_13_0:_refreshAttribute()

	local var_13_0 = arg_13_0._critterMO.trainInfo:getEventOptions(arg_13_0.viewParam.eventId)

	arg_13_0._attributeItem:playBarAdd(true, var_13_0)
	arg_13_0:_refreshSelect()
	arg_13_0:_showEnterBtn(true)
end

local var_0_1 = {
	[203] = "taming3",
	[202] = "taming",
	[201] = "taming2"
}
local var_0_2 = {
	[203] = 3,
	[202] = 1,
	[201] = 2
}

function var_0_0._showTrainProgress(arg_14_0)
	arg_14_0.viewContainer:getSetting().viewType = ViewType.Full

	gohelper.setActive(arg_14_0._gospine, true)
	arg_14_0._critterItem:showTamingEffects(true, var_0_2[arg_14_0.viewParam.eventId])
	arg_14_0._critterItem:setCritterEffectOffset(0, 30)
	arg_14_0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	arg_14_0._critterItem:fadeIn()
	gohelper.setActive(arg_14_0._gotrainprogress, true)
	gohelper.setActive(arg_14_0._gorighttopbtns, false)

	local var_14_0 = var_0_1[arg_14_0.viewParam.eventId]

	arg_14_0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	arg_14_0._critterItem:playBodyAnim(var_14_0, true)

	arg_14_0._progressTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_14_0._progressTime, arg_14_0._progressUpdate, arg_14_0._progressFinished, arg_14_0, nil, EaseType.Linear)
end

function var_0_0._progressUpdate(arg_15_0, arg_15_1)
	arg_15_0._imagetotalBarValue.fillAmount = arg_15_1
end

function var_0_0._progressFinished(arg_16_0)
	arg_16_0._trainShowing = true

	gohelper.setActive(arg_16_0._goexittips, true)
	gohelper.setActive(arg_16_0._goexittxt, false)

	local var_16_0 = string.splitToNumber(CritterConfig.instance:getCritterCfg(arg_16_0._critterMO.defineId).eventTimes, "#")[var_0_2[arg_16_0.viewParam.eventId]] - arg_16_0._progressTime

	if var_16_0 <= 0 then
		arg_16_0:_critterAniFinished()
	else
		TaskDispatcher.runDelay(arg_16_0._critterAniFinished, arg_16_0, var_16_0)
	end
end

function var_0_0._critterAniFinished(arg_17_0)
	arg_17_0._critterItem:playBodyAnim(RoomCharacterEnum.CharacterAnimStateName.Idle, true)
	gohelper.setActive(arg_17_0._gotrainprogress, false)
	arg_17_0._critterItem:fadeOut()
	arg_17_0._critterItem:showTamingEffects(false)
	arg_17_0._trainAnim:Play("close", 0, 0)

	arg_17_0._trainShowing = false

	gohelper.setActive(arg_17_0._goexittips, false)
	TaskDispatcher.runDelay(arg_17_0._startAttributeStory, arg_17_0, 0.17)
end

function var_0_0._startAttributeStory(arg_18_0)
	if arg_18_0.viewParam.skipStory then
		arg_18_0:_onAttributeStoryFinished()
	else
		arg_18_0.viewContainer:getSetting().viewType = ViewType.Normal

		RoomCritterController.instance:startAttributeResult(arg_18_0.viewParam.eventId, arg_18_0.viewParam.critterUid, arg_18_0.viewParam.heroId, arg_18_0.optionId)
		StoryController.instance:registerCallback(StoryEvent.Finish, arg_18_0._onAttributeStoryFinished, arg_18_0)
	end
end

function var_0_0._onAttributeStoryFinished(arg_19_0)
	arg_19_0.viewContainer:getSetting().viewType = ViewType.Full

	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_19_0._onAttributeStoryFinished, arg_19_0)
	StoryController.instance:unregisterCallback(StoryEvent.OnReplaceHero, arg_19_0._onStoryReplaceHero, arg_19_0)
	arg_19_0._critterItem:fadeOut()
	TaskDispatcher.runDelay(arg_19_0._startShowResult, arg_19_0, 0.17)
end

function var_0_0._onExitClick(arg_20_0)
	if arg_20_0._trainShowing then
		if arg_20_0._progressTweenId then
			ZProj.TweenHelper.KillById(arg_20_0._progressTweenId)

			arg_20_0._progressTweenId = nil
		end

		TaskDispatcher.cancelTask(arg_20_0._startAttributeStory, arg_20_0)
		TaskDispatcher.cancelTask(arg_20_0._critterAniFinished, arg_20_0)
		arg_20_0:_critterAniFinished()

		return
	end

	arg_20_0:closeThis()
end

function var_0_0._editableInitView(arg_21_0)
	arg_21_0._selectItems = {}
	arg_21_0._optionInfos = {}
	arg_21_0._viewAnim = arg_21_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_21_0 = arg_21_0:getResInst(RoomCritterTrainDetailItem.prefabPath, arg_21_0._goattribute)

	arg_21_0._attributeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_0, RoomCritterTrainDetailItem, arg_21_0)
	arg_21_0._critterItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_21_0._gospine, RoomCritterTrainCritterItem, arg_21_0)

	arg_21_0._critterItem:init(arg_21_0._gospine)

	arg_21_0._goselectitem = gohelper.findChild(arg_21_0.viewGO, "#scroll_select/Viewport/#go_list/selectitem")
	arg_21_0._trainAnim = arg_21_0._gotrainprogress:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_21_0._goselectitem, false)

	arg_21_0._exitBtn = gohelper.getClick(arg_21_0._goexittips)

	arg_21_0:_addEvents()
	gohelper.setActive(arg_21_0._goattribute, false)
	gohelper.setActive(arg_21_0._scrollselect.gameObject, false)
	gohelper.setActive(arg_21_0._goconversation, false)
	gohelper.setActive(arg_21_0._goexittips, false)
	gohelper.setActive(arg_21_0._gospine, false)
	gohelper.setActive(arg_21_0._gotrainprogress, false)
	gohelper.setActive(arg_21_0._gorighttopbtns, false)
	gohelper.setActive(arg_21_0._goattributeup, false)
	gohelper.setActive(arg_21_0._goattributeupitem, false)
	arg_21_0:_showEnterBtn(false)

	arg_21_0._progressTime = tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterTrainKeepTime)) / 1000
end

function var_0_0.onUpdateParam(arg_22_0)
	arg_22_0._critterMO = CritterModel.instance:getCritterMOByUid(arg_22_0.viewParam.critterUid)
end

function var_0_0._refreshAttribute(arg_23_0)
	local var_23_0 = RoomTrainSlotListModel.instance:getSlotMOByCritterUi(arg_23_0.viewParam.critterUid)

	arg_23_0._attributeItem:onUpdateMO(var_23_0.critterMO)
end

function var_0_0._refreshSelect(arg_24_0)
	local var_24_0 = arg_24_0._critterMO.trainInfo:getEventOptions(arg_24_0.viewParam.eventId)

	for iter_24_0 = 1, #var_24_0 do
		if not arg_24_0._selectItems[iter_24_0] then
			arg_24_0._selectItems[iter_24_0] = RoomCritterTrainStorySelectItem.New()

			arg_24_0._selectItems[iter_24_0]:init(arg_24_0._goselectitem, iter_24_0)
		end

		local var_24_1 = RoomTrainCritterModel.instance:getSelectOptionCount(var_24_0[iter_24_0].optionId)

		arg_24_0._selectItems[iter_24_0]:show(var_24_0[iter_24_0].optionId, arg_24_0._critterMO, arg_24_0.viewParam.eventId, var_24_1)
	end
end

function var_0_0._playConversation(arg_25_0)
	local var_25_0 = HeroConfig.instance:getHeroCO(arg_25_0.viewParam.heroId)

	arg_25_0._txtnameen.text = var_25_0.nameEn
	arg_25_0._txtnamecn.text = var_25_0.name

	local var_25_1 = CritterConfig.instance:getCritterTrainEventCfg(arg_25_0.viewParam.eventId)
	local var_25_2 = string.splitToNumber(var_25_1.cost, "#")[3]
	local var_25_3 = arg_25_0._critterMO.trainInfo:getEvents(arg_25_0.viewParam.eventId)

	arg_25_0._txtcontent.text = string.format(var_25_1.content, var_25_3.remainCount, string.format("%s <sprite=0>", var_25_2))

	arg_25_0:_showEnterBtn(true)
end

function var_0_0._showEnterBtn(arg_26_0, arg_26_1)
	local var_26_0 = RoomTrainCritterModel.instance:getSelectOptionTotalCount()
	local var_26_1 = arg_26_1 and var_26_0 > 0

	gohelper.setActive(arg_26_0._btntrainstart, var_26_1)
end

function var_0_0._refreshCurrency(arg_27_0)
	local var_27_0 = CritterConfig.instance:getCritterTrainEventCfg(arg_27_0.viewParam.eventId)
	local var_27_1 = string.splitToNumber(var_27_0.cost, "#")[2]
	local var_27_2 = CurrencyModel.instance:getCurrency(var_27_1)
	local var_27_3 = CurrencyConfig.instance:getCurrencyCo(var_27_1)

	arg_27_0._txtcurrency.text = GameUtil.numberDisplay(var_27_2.quantity)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_27_0._imagecurrency, var_27_3.icon .. "_1")
end

function var_0_0._onStoryReplaceHero(arg_28_0, arg_28_1)
	gohelper.setLayer(arg_28_0._gomask, UnityLayer.UI, true)
	gohelper.setLayer(arg_28_0._gomask2, UnityLayer.UI, true)
	gohelper.setActive(arg_28_0._gospine, true)

	local var_28_0 = arg_28_1.effs[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_28_0 == "" then
		arg_28_0._critterItem:setEffectByType(0)
		arg_28_0._critterItem:hideEffects()
	else
		local var_28_1 = GameUtil.splitString2(var_28_0, false, "|", "#")

		for iter_28_0, iter_28_1 in ipairs(var_28_1) do
			arg_28_0._critterItem:setEffectByName(iter_28_1[2])
			arg_28_0._critterItem:setCritterEffectOffset(tonumber(iter_28_1[3]), tonumber(iter_28_1[4]))
			arg_28_0._critterItem:setCritterEffectScale(tonumber(iter_28_1[5]))
		end
	end

	if arg_28_0._critterItem:getCritterPos() ~= arg_28_1.heroDir + 1 then
		arg_28_0._critterItem:fadeIn()
	end

	arg_28_0._critterItem:setCritterPos(arg_28_1.heroDir + 1, true)
end

function var_0_0._startShowResult(arg_29_0)
	RoomTrainCritterModel.instance:setEventTrainStoryPlayed(arg_29_0.viewParam.heroId)
	gohelper.setActive(arg_29_0._gospine, true)
	gohelper.setActive(arg_29_0._goexittips, true)
	gohelper.setActive(arg_29_0._goexittxt, true)
	gohelper.setActive(arg_29_0._goattributeup, true)
	gohelper.setActive(arg_29_0._goattribute, true)
	gohelper.setActive(arg_29_0._goattributeupeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_peixun)
	arg_29_0._critterItem:fadeIn()
	arg_29_0._critterItem:showTamingEffects(false)
	arg_29_0._critterItem:setEffectByType(3)
	arg_29_0._critterItem:setCritterEffectOffset(0, 30)
	arg_29_0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	arg_29_0._critterItem:playBodyAnim(RoomCharacterEnum.CharacterAnimStateName.Idle, true)
	arg_29_0._viewAnim:Play("open", 0, 0)

	arg_29_0._resultAttributeMOs = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0._optionInfos) do
		local var_29_0 = iter_29_1.optionId
		local var_29_1 = arg_29_0._critterMO.trainInfo:getEventOptionMOByOptionId(arg_29_0.viewParam.eventId, var_29_0).addAttriButes

		arg_29_0._resultAttributeMOs[var_29_0] = LuaUtil.deepCopy(var_29_1[1])
		arg_29_0._resultAttributeMOs[var_29_0].value = iter_29_1.count * var_29_1[1].value
	end

	arg_29_0._attributeItem:playLevelUp(arg_29_0._resultAttributeMOs)

	arg_29_0._repeatCount = 0

	TaskDispatcher.runRepeat(arg_29_0._showAttribute, arg_29_0, 0.3, #arg_29_0._resultAttributeMOs)
end

function var_0_0._showAttribute(arg_30_0)
	arg_30_0._repeatCount = arg_30_0._repeatCount + 1

	local var_30_0 = gohelper.findChild(arg_30_0._goattributeup, tostring(arg_30_0._repeatCount))
	local var_30_1 = gohelper.clone(arg_30_0._goattributeupitem)

	gohelper.addChild(var_30_0, var_30_1)

	local var_30_2 = gohelper.findChildText(var_30_1, "up/#txt_up")
	local var_30_3 = CritterConfig.instance:getCritterAttributeCfg(arg_30_0._resultAttributeMOs[arg_30_0._repeatCount].attributeId).name
	local var_30_4 = arg_30_0._resultAttributeMOs[arg_30_0._repeatCount].value

	if var_30_4 <= 0 then
		gohelper.setActive(var_30_1, false)

		return
	end

	gohelper.setActive(var_30_1, true)

	var_30_2.text = string.format("%s + %s", var_30_3, var_30_4)
end

local var_0_3 = 2223

function var_0_0.onOpen(arg_31_0)
	arg_31_0._critterMO = CritterModel.instance:getCritterMOByUid(arg_31_0.viewParam.critterUid)

	local var_31_0 = CritterConfig.instance:getCritterSkinCfg(arg_31_0._critterMO:getSkinId())
	local var_31_1 = ResUrl.getSpineUIPrefab(var_31_0.spine)

	StoryModel.instance:setReplaceHero(var_0_3, var_31_1)
	gohelper.setActive(arg_31_0._gospine, true)

	if arg_31_0.viewParam.skipStory then
		arg_31_0:_showAttributeSelect()
	else
		arg_31_0._storyViewGo = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

		arg_31_0._critterItem:showByEffectName(arg_31_0._critterMO, CritterEnum.PosType.Right, true)
		arg_31_0._critterItem:fadeIn()
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterTrainStarted)
end

function var_0_0._onCurrencyChanged(arg_32_0)
	return
end

function var_0_0.onClose(arg_33_0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterTrainFinished)
	RoomCritterController.instance:endTrain(arg_33_0.viewParam.eventId)
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_34_0._startAttributeStory, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._showTrainProgress, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._startShowResult, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._showAttribute, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._critterAniFinished, arg_34_0)

	if arg_34_0._selectItems then
		for iter_34_0, iter_34_1 in pairs(arg_34_0._selectItems) do
			iter_34_1:destroy()
		end

		arg_34_0._selectItems = nil
	end

	arg_34_0._attributeItem:onDestroy()

	if arg_34_0._critterItem then
		arg_34_0._critterItem:onDestroy()

		arg_34_0._critterItem = nil
	end

	if arg_34_0._progressTweenId then
		ZProj.TweenHelper.KillById(arg_34_0._progressTweenId)

		arg_34_0._progressTweenId = nil
	end
end

return var_0_0
