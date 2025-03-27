module("modules.logic.versionactivity2_4.pinball.view.PinballMapSelectView", package.seeall)

slot0 = class("PinballMapSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_name")
	slot0._txtdesc1 = gohelper.findChildTextMesh(slot0.viewGO, "Right/#scroll_dec/Viewport/Content/#txt_dec1")
	slot0._txtdesc2 = gohelper.findChildTextMesh(slot0.viewGO, "Right/#scroll_dec/Viewport/Content/#txt_dec2")
	slot0._txtdesc3 = gohelper.findChildTextMesh(slot0.viewGO, "Right/#scroll_dec/Viewport/Content/go_item/#txt_dec3")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "Right/#scroll_dec/Viewport/Content/go_item")
	slot0._icontype = gohelper.findChildImage(slot0.viewGO, "Right/#scroll_dec/Viewport/Content/go_item/#txt_dec3/#image_icon")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_start")
	slot0._txtCost = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_start/#txt_cost")
	slot0._topCurrencyRoot = gohelper.findChild(slot0.viewGO, "#go_topright")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStart:AddClickListener(slot0._onStartClick, slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0.updateCost, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStart:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0.updateCost, slot0)
end

function slot0._editableInitView(slot0)
	slot0._items = slot0:getUserDataTb_()
	slot0._itemSelects = slot0:getUserDataTb_()

	for slot4 = 1, 4 do
		slot0._items[slot4] = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_item" .. slot4)
		slot0._itemSelects[slot4] = gohelper.findChild(slot0._items[slot4].gameObject, "#go_select")
		gohelper.findChildTextMesh(slot0._items[slot4].gameObject, "txt_name").text = PinballConfig.instance:getRandomEpisode(slot4).name

		slot0:addClickCb(slot0._items[slot4], slot0.onClickSelect, slot0, slot4)
	end

	slot0:onClickSelect(1)
end

function slot0.onOpen(slot0)
	slot0:createCurrencyItem()
	slot0:updateCost()

	if not slot0._enough and not PinballModel.instance.isGuideAddGrain then
		GuideController.instance:dispatchEvent(GuideEvent.TriggerActive, GuideEnum.EventTrigger.Act178FoodNotEnough)
	end
end

function slot0.updateCost(slot0)
	if PinballModel.instance:getResNum(PinballEnum.ResType.Food) < math.max(0, PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.EpisodeCost) - PinballModel.instance:getCostDec()) then
		slot0._enough = false
		slot0._txtCost.text = string.format("<color=#FC8A6A>-%d", slot1)
	else
		slot0._enough = true
		slot0._txtCost.text = string.format("-%d", slot1)
	end
end

function slot0.createCurrencyItem(slot0)
	for slot5, slot6 in ipairs({
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone,
		PinballEnum.ResType.Food
	}) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.currency, slot0._topCurrencyRoot), PinballCurrencyItem):setCurrencyType(slot6)
	end
end

slot1 = {
	PinballEnum.ResType.Stone,
	PinballEnum.ResType.Wood,
	PinballEnum.ResType.Food,
	PinballEnum.ResType.Mine
}

function slot0.onClickSelect(slot0, slot1)
	gohelper.setActive(slot0._goitem, false)
	gohelper.setActive(slot0._goitem, true)

	slot0._curIndex = slot1

	for slot5 = 1, 4 do
		gohelper.setActive(slot0._itemSelects[slot5], slot5 == slot1)
	end

	if not PinballConfig.instance:getRandomEpisode(slot1) then
		logError("没有副本配置")

		return
	end

	slot0._txtname.text = slot2.name
	slot0._txtdesc1.text = slot2.longDesc
	slot0._txtdesc2.text = slot2.desc
	slot0._txtdesc3.text = slot2.shortDesc

	if not uv0[slot2.type] then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot0._icontype, lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot3].icon)
end

function slot0._onStartClick(slot0)
	if not slot0._enough then
		GameFacade.showToast(ToastEnum.DiamondBuy, lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballEnum.ResType.Food].name)

		return
	end

	if not PinballConfig.instance:getRandomEpisode(slot0._curIndex, PinballModel.instance.leftEpisodeId) then
		logError("随机关卡失败，index：" .. tostring(slot0._curIndex))

		return
	end

	PinballModel.instance.leftEpisodeId = slot1.id

	Activity178Rpc.instance:sendAct178StartEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.leftEpisodeId, slot0._onReq, slot0)
end

function slot0._onReq(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.PinballGameView, {
		index = slot0._curIndex
	})
	ViewMgr.instance:openView(ViewName.PinballStartLoadingView)
	slot0:closeThis()
end

return slot0
