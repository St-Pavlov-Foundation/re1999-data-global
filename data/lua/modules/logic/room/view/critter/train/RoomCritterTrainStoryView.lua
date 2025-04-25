module("modules.logic.room.view.critter.train.RoomCritterTrainStoryView", package.seeall)

slot0 = class("RoomCritterTrainStoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomask2 = gohelper.findChild(slot0.viewGO, "mask2")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "mask")
	slot0._golefttopbtns = gohelper.findChild(slot0.viewGO, "#go_lefttopbtns")
	slot0._gorighttopbtns = gohelper.findChild(slot0.viewGO, "#go_righttopbtns")
	slot0._btncurrency = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_righttopbtns/#go_container/currency/#btn_currency")
	slot0._imagecurrency = gohelper.findChildImage(slot0.viewGO, "#go_righttopbtns/#go_container/currency/#image")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_righttopbtns/#go_container/currency/#btn_add")
	slot0._txtcurrency = gohelper.findChildText(slot0.viewGO, "#go_righttopbtns/#go_container/currency/content/#txt")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_spine")
	slot0._scrollselect = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_select")
	slot0._golist = gohelper.findChild(slot0.viewGO, "#scroll_select/Viewport/#go_list")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#scroll_select/Viewport/#go_list/selectitem/bgdark/#txt_num")
	slot0._gopcbtn = gohelper.findChild(slot0.viewGO, "#scroll_select/Viewport/#go_list/selectitem/bgdark/#go_pcbtn")
	slot0._goconversation = gohelper.findChild(slot0.viewGO, "#go_conversation")
	slot0._goname = gohelper.findChild(slot0.viewGO, "#go_conversation/#go_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_conversation/#go_name/#txt_nameen")
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "#go_conversation/#go_name/#txt_namecn")
	slot0._gocontents = gohelper.findChild(slot0.viewGO, "#go_conversation/#go_contents")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#go_conversation/#go_contents/#txt_content")
	slot0._gotrainprogress = gohelper.findChild(slot0.viewGO, "#go_trainprogress")
	slot0._imagetotalBarValue = gohelper.findChildImage(slot0.viewGO, "#go_trainprogress/progressbg/#image_totalBarValue")
	slot0._goexittips = gohelper.findChild(slot0.viewGO, "#go_exittips")
	slot0._goexittxt = gohelper.findChild(slot0.viewGO, "#go_exittips/txt")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "#go_attribute")
	slot0._goattributeup = gohelper.findChild(slot0.viewGO, "#go_attributeup")
	slot0._goattributeupitem = gohelper.findChild(slot0.viewGO, "#go_attributeup/attributeup")
	slot0._btntrainstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_trainstart")
	slot0._goattributeupeffect = gohelper.findChild(slot0.viewGO, "#attributeup_effect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncurrency:AddClickListener(slot0._btncurrencyOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btntrainstart:AddClickListener(slot0._btntrainstartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncurrency:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btntrainstart:RemoveClickListener()
end

function slot0._btncurrencyOnClick(slot0)
	slot2 = string.splitToNumber(CritterConfig.instance:getCritterTrainEventCfg(slot0.viewParam.eventId).cost, "#")

	MaterialTipController.instance:showMaterialInfo(slot2[1], slot2[2], false, nil, false)
end

function slot0._btnaddOnClick(slot0)
	RoomCritterController.instance:openExchangeView(string.splitToNumber(CritterConfig.instance:getCritterTrainEventCfg(slot0.viewParam.eventId).cost, "#"))
end

function slot0._btntrainstartOnClick(slot0)
	slot2 = string.splitToNumber(CritterConfig.instance:getCritterTrainEventCfg(slot0.viewParam.eventId).cost, "#")

	if math.floor(ItemModel.instance:getItemQuantity(slot2[1], slot2[2]) / slot2[3]) < RoomTrainCritterModel.instance:getSelectOptionTotalCount() then
		GameFacade.showToast(ToastEnum.RoomCritterTrainCountNotEnoughCurrency, ItemModel.instance:getItemConfig(slot2[1], slot2[2]).name)

		return
	end

	CritterRpc.instance:sendSelectMultiEventOptionRequest(slot0.viewParam.critterUid, slot0.viewParam.eventId, RoomTrainCritterModel.instance:getSelectOptionInfos(), slot0._attributeSelected, slot0)
end

function slot0._attributeSelected(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0:_showEnterBtn(false)
	gohelper.setActive(slot0._goattribute, false)
	gohelper.setActive(slot0._scrollselect.gameObject, false)
	gohelper.setActive(slot0._goconversation, false)
	slot0._critterItem:fadeOut()

	if slot0.viewParam.skipStory then
		slot0.viewContainer:getSetting().viewType = ViewType.Full
	else
		gohelper.setActive(slot0._storyViewGo, true)

		slot0.viewContainer:getSetting().viewType = ViewType.Normal
	end

	for slot7, slot8 in ipairs(slot3.infos) do
		slot9 = {
			optionId = slot8.optionId,
			count = slot8.count
		}
		slot0._optionInfos[slot9.optionId] = slot9
	end

	slot0._attributeItem:playBarAdd(false)
	slot0._viewAnim:Play("close", 0, 0)
	TaskDispatcher.runDelay(slot0._showTrainProgress, slot0, 0.17)
end

function slot0._addEvents(slot0)
	slot0._exitBtn:AddClickListener(slot0._onExitClick, slot0)
	StoryController.instance:registerCallback(StoryEvent.DialogConFinished, slot0._onDialogConFinished, slot0)
	CurrencyController.instance:registerCallback(CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)
	RoomController.instance:registerCallback(RoomEvent.CritterTrainAttributeSelected, slot0._onAttributeSelected, slot0)
	RoomController.instance:registerCallback(RoomEvent.CritterTrainAttributeCancel, slot0._onAttributeCancel, slot0)
	StoryController.instance:registerCallback(StoryEvent.OnReplaceHero, slot0._onStoryReplaceHero, slot0)
end

function slot0._removeEvents(slot0)
	slot0._exitBtn:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, slot0._onDialogConFinished, slot0)
	CurrencyController.instance:unregisterCallback(CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainAttributeSelected, slot0._onAttributeSelected, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.CritterTrainAttributeCancel, slot0._onAttributeCancel, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, slot0._onAttributeStoryFinished, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.OnReplaceHero, slot0._onStoryReplaceHero, slot0)
end

function slot0._onDialogConFinished(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, slot0._onDialogConFinished, slot0)
	slot0:_showAttributeSelect()
end

function slot0._showAttributeSelect(slot0)
	gohelper.setActive(slot0._goattribute, true)
	gohelper.setActive(slot0._scrollselect.gameObject, true)
	gohelper.setActive(slot0._goconversation, true)

	if slot0._storyViewGo then
		gohelper.setActive(slot0._storyViewGo, false)

		slot0.viewContainer:getSetting().viewType = ViewType.Full

		slot0._critterItem:fadeIn()
		slot0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	else
		slot0._critterItem:showByEffectType(slot0._critterMO, CritterEnum.PosType.Middle, false)
		slot0._critterItem:fadeIn()
	end

	StoryController.instance:closeStoryView()
	gohelper.setActive(slot0._gorighttopbtns, true)
	slot0:_refreshCurrency()
	slot0:_refreshAttribute()
	slot0:_refreshSelect()
	slot0:_playConversation()
	slot0._attributeItem:playBarAdd(true, slot0._critterMO.trainInfo:getEventOptions(slot0.viewParam.eventId))
	slot0._viewAnim:Play("open", 0, 0)
end

function slot0._onAttributeSelected(slot0, slot1, slot2)
	RoomTrainCritterModel.instance:addSelectOptionCount(slot1)
	slot0:_refreshAttribute()
	slot0._attributeItem:playBarAdd(true, slot0._critterMO.trainInfo:getEventOptions(slot0.viewParam.eventId))
	slot0:_refreshSelect()
	slot0:_showEnterBtn(true)
end

function slot0._onAttributeCancel(slot0, slot1, slot2)
	RoomTrainCritterModel.instance:cancelSelectOptionCount(slot1)
	slot0:_refreshAttribute()
	slot0._attributeItem:playBarAdd(true, slot0._critterMO.trainInfo:getEventOptions(slot0.viewParam.eventId))
	slot0:_refreshSelect()
	slot0:_showEnterBtn(true)
end

slot1 = {
	[203.0] = "taming3",
	[202.0] = "taming",
	[201.0] = "taming2"
}
slot2 = {
	[203.0] = 3,
	[202.0] = 1,
	[201.0] = 2
}

function slot0._showTrainProgress(slot0)
	slot0.viewContainer:getSetting().viewType = ViewType.Full

	gohelper.setActive(slot0._gospine, true)
	slot0._critterItem:showTamingEffects(true, uv0[slot0.viewParam.eventId])
	slot0._critterItem:setCritterEffectOffset(0, 30)
	slot0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	slot0._critterItem:fadeIn()
	gohelper.setActive(slot0._gotrainprogress, true)
	gohelper.setActive(slot0._gorighttopbtns, false)
	slot0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	slot0._critterItem:playBodyAnim(uv1[slot0.viewParam.eventId], true)

	slot0._progressTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0._progressTime, slot0._progressUpdate, slot0._progressFinished, slot0, nil, EaseType.Linear)
end

function slot0._progressUpdate(slot0, slot1)
	slot0._imagetotalBarValue.fillAmount = slot1
end

function slot0._progressFinished(slot0)
	slot0._trainShowing = true

	gohelper.setActive(slot0._goexittips, true)
	gohelper.setActive(slot0._goexittxt, false)

	if string.splitToNumber(CritterConfig.instance:getCritterCfg(slot0._critterMO.defineId).eventTimes, "#")[uv0[slot0.viewParam.eventId]] - slot0._progressTime <= 0 then
		slot0:_critterAniFinished()
	else
		TaskDispatcher.runDelay(slot0._critterAniFinished, slot0, slot2)
	end
end

function slot0._critterAniFinished(slot0)
	slot0._critterItem:playBodyAnim(RoomCharacterEnum.CharacterAnimStateName.Idle, true)
	gohelper.setActive(slot0._gotrainprogress, false)
	slot0._critterItem:fadeOut()
	slot0._critterItem:showTamingEffects(false)
	slot0._trainAnim:Play("close", 0, 0)

	slot0._trainShowing = false

	gohelper.setActive(slot0._goexittips, false)
	TaskDispatcher.runDelay(slot0._startAttributeStory, slot0, 0.17)
end

function slot0._startAttributeStory(slot0)
	if slot0.viewParam.skipStory then
		slot0:_onAttributeStoryFinished()
	else
		slot0.viewContainer:getSetting().viewType = ViewType.Normal

		RoomCritterController.instance:startAttributeResult(slot0.viewParam.eventId, slot0.viewParam.critterUid, slot0.viewParam.heroId, slot0.optionId)
		StoryController.instance:registerCallback(StoryEvent.Finish, slot0._onAttributeStoryFinished, slot0)
	end
end

function slot0._onAttributeStoryFinished(slot0)
	slot0.viewContainer:getSetting().viewType = ViewType.Full

	StoryController.instance:unregisterCallback(StoryEvent.Finish, slot0._onAttributeStoryFinished, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.OnReplaceHero, slot0._onStoryReplaceHero, slot0)
	slot0._critterItem:fadeOut()
	TaskDispatcher.runDelay(slot0._startShowResult, slot0, 0.17)
end

function slot0._onExitClick(slot0)
	if slot0._trainShowing then
		if slot0._progressTweenId then
			ZProj.TweenHelper.KillById(slot0._progressTweenId)

			slot0._progressTweenId = nil
		end

		TaskDispatcher.cancelTask(slot0._startAttributeStory, slot0)
		TaskDispatcher.cancelTask(slot0._critterAniFinished, slot0)
		slot0:_critterAniFinished()

		return
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._selectItems = {}
	slot0._optionInfos = {}
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._attributeItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(RoomCritterTrainDetailItem.prefabPath, slot0._goattribute), RoomCritterTrainDetailItem, slot0)
	slot0._critterItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gospine, RoomCritterTrainCritterItem, slot0)

	slot0._critterItem:init(slot0._gospine)

	slot0._goselectitem = gohelper.findChild(slot0.viewGO, "#scroll_select/Viewport/#go_list/selectitem")
	slot0._trainAnim = slot0._gotrainprogress:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._goselectitem, false)

	slot0._exitBtn = gohelper.getClick(slot0._goexittips)

	slot0:_addEvents()
	gohelper.setActive(slot0._goattribute, false)
	gohelper.setActive(slot0._scrollselect.gameObject, false)
	gohelper.setActive(slot0._goconversation, false)
	gohelper.setActive(slot0._goexittips, false)
	gohelper.setActive(slot0._gospine, false)
	gohelper.setActive(slot0._gotrainprogress, false)
	gohelper.setActive(slot0._gorighttopbtns, false)
	gohelper.setActive(slot0._goattributeup, false)
	gohelper.setActive(slot0._goattributeupitem, false)
	slot0:_showEnterBtn(false)

	slot0._progressTime = tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterTrainKeepTime)) / 1000
end

function slot0.onUpdateParam(slot0)
	slot0._critterMO = CritterModel.instance:getCritterMOByUid(slot0.viewParam.critterUid)
end

function slot0._refreshAttribute(slot0)
	slot0._attributeItem:onUpdateMO(RoomTrainSlotListModel.instance:getSlotMOByCritterUi(slot0.viewParam.critterUid).critterMO)
end

function slot0._refreshSelect(slot0)
	for slot5 = 1, #slot0._critterMO.trainInfo:getEventOptions(slot0.viewParam.eventId) do
		if not slot0._selectItems[slot5] then
			slot0._selectItems[slot5] = RoomCritterTrainStorySelectItem.New()

			slot0._selectItems[slot5]:init(slot0._goselectitem, slot5)
		end

		slot0._selectItems[slot5]:show(slot1[slot5].optionId, slot0._critterMO, slot0.viewParam.eventId, RoomTrainCritterModel.instance:getSelectOptionCount(slot1[slot5].optionId))
	end
end

function slot0._playConversation(slot0)
	slot1 = HeroConfig.instance:getHeroCO(slot0.viewParam.heroId)
	slot0._txtnameen.text = slot1.nameEn
	slot0._txtnamecn.text = slot1.name
	slot2 = CritterConfig.instance:getCritterTrainEventCfg(slot0.viewParam.eventId)
	slot0._txtcontent.text = string.format(slot2.content, slot0._critterMO.trainInfo:getEvents(slot0.viewParam.eventId).remainCount, string.format("%s <sprite=0>", string.splitToNumber(slot2.cost, "#")[3]))

	slot0:_showEnterBtn(true)
end

function slot0._showEnterBtn(slot0, slot1)
	gohelper.setActive(slot0._btntrainstart, slot1 and RoomTrainCritterModel.instance:getSelectOptionTotalCount() > 0)
end

function slot0._refreshCurrency(slot0)
	slot2 = string.splitToNumber(CritterConfig.instance:getCritterTrainEventCfg(slot0.viewParam.eventId).cost, "#")[2]
	slot0._txtcurrency.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(slot2).quantity)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecurrency, CurrencyConfig.instance:getCurrencyCo(slot2).icon .. "_1")
end

function slot0._onStoryReplaceHero(slot0, slot1)
	gohelper.setLayer(slot0._gomask, UnityLayer.UI, true)
	gohelper.setLayer(slot0._gomask2, UnityLayer.UI, true)
	gohelper.setActive(slot0._gospine, true)

	if slot1.effs[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] == "" then
		slot0._critterItem:setEffectByType(0)
		slot0._critterItem:hideEffects()
	else
		slot7 = "#"

		for slot7, slot8 in ipairs(GameUtil.splitString2(slot2, false, "|", slot7)) do
			slot0._critterItem:setEffectByName(slot8[2])
			slot0._critterItem:setCritterEffectOffset(tonumber(slot8[3]), tonumber(slot8[4]))
			slot0._critterItem:setCritterEffectScale(tonumber(slot8[5]))
		end
	end

	if slot0._critterItem:getCritterPos() ~= slot1.heroDir + 1 then
		slot0._critterItem:fadeIn()
	end

	slot0._critterItem:setCritterPos(slot1.heroDir + 1, true)
end

function slot0._startShowResult(slot0)
	RoomTrainCritterModel.instance:setEventTrainStoryPlayed(slot0.viewParam.heroId)
	gohelper.setActive(slot0._gospine, true)
	gohelper.setActive(slot0._goexittips, true)
	gohelper.setActive(slot0._goexittxt, true)
	gohelper.setActive(slot0._goattributeup, true)
	gohelper.setActive(slot0._goattribute, true)
	gohelper.setActive(slot0._goattributeupeffect, true)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_peixun)
	slot0._critterItem:fadeIn()
	slot0._critterItem:showTamingEffects(false)
	slot0._critterItem:setEffectByType(3)
	slot0._critterItem:setCritterEffectOffset(0, 30)
	slot0._critterItem:setCritterPos(CritterEnum.PosType.Middle, false)
	slot0._critterItem:playBodyAnim(RoomCharacterEnum.CharacterAnimStateName.Idle, true)

	slot4 = 0
	slot5 = 0

	slot0._viewAnim:Play("open", slot4, slot5)

	slot0._resultAttributeMOs = {}

	for slot4, slot5 in pairs(slot0._optionInfos) do
		slot6 = slot5.optionId
		slot7 = slot0._critterMO.trainInfo:getEventOptionMOByOptionId(slot0.viewParam.eventId, slot6).addAttriButes
		slot0._resultAttributeMOs[slot6] = LuaUtil.deepCopy(slot7[1])
		slot0._resultAttributeMOs[slot6].value = slot5.count * slot7[1].value
	end

	slot0._attributeItem:playLevelUp(slot0._resultAttributeMOs)

	slot0._repeatCount = 0

	TaskDispatcher.runRepeat(slot0._showAttribute, slot0, 0.3, #slot0._resultAttributeMOs)
end

function slot0._showAttribute(slot0)
	slot0._repeatCount = slot0._repeatCount + 1
	slot2 = gohelper.clone(slot0._goattributeupitem)

	gohelper.addChild(gohelper.findChild(slot0._goattributeup, tostring(slot0._repeatCount)), slot2)

	slot3 = gohelper.findChildText(slot2, "up/#txt_up")
	slot4 = CritterConfig.instance:getCritterAttributeCfg(slot0._resultAttributeMOs[slot0._repeatCount].attributeId).name

	if slot0._resultAttributeMOs[slot0._repeatCount].value <= 0 then
		gohelper.setActive(slot2, false)

		return
	end

	gohelper.setActive(slot2, true)

	slot3.text = string.format("%s + %s", slot4, slot5)
end

slot3 = 2223

function slot0.onOpen(slot0)
	slot0._critterMO = CritterModel.instance:getCritterMOByUid(slot0.viewParam.critterUid)

	StoryModel.instance:setReplaceHero(uv0, ResUrl.getSpineUIPrefab(CritterConfig.instance:getCritterSkinCfg(slot0._critterMO:getSkinId()).spine))
	gohelper.setActive(slot0._gospine, true)

	if slot0.viewParam.skipStory then
		slot0:_showAttributeSelect()
	else
		slot0._storyViewGo = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

		slot0._critterItem:showByEffectName(slot0._critterMO, CritterEnum.PosType.Right, true)
		slot0._critterItem:fadeIn()
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterTrainStarted)
end

function slot0._onCurrencyChanged(slot0)
end

function slot0.onClose(slot0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterTrainFinished)
	RoomCritterController.instance:endTrain(slot0.viewParam.eventId)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0._startAttributeStory, slot0)
	TaskDispatcher.cancelTask(slot0._showTrainProgress, slot0)
	TaskDispatcher.cancelTask(slot0._startShowResult, slot0)
	TaskDispatcher.cancelTask(slot0._showAttribute, slot0)
	TaskDispatcher.cancelTask(slot0._critterAniFinished, slot0)

	if slot0._selectItems then
		for slot4, slot5 in pairs(slot0._selectItems) do
			slot5:destroy()
		end

		slot0._selectItems = nil
	end

	slot0._attributeItem:onDestroy()

	if slot0._critterItem then
		slot0._critterItem:onDestroy()

		slot0._critterItem = nil
	end

	if slot0._progressTweenId then
		ZProj.TweenHelper.KillById(slot0._progressTweenId)

		slot0._progressTweenId = nil
	end
end

return slot0
