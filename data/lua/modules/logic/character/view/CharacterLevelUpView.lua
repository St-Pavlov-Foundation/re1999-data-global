module("modules.logic.character.view.CharacterLevelUpView", package.seeall)

slot0 = class("CharacterLevelUpView", BaseView)
slot1 = 2
slot2 = 0.3
slot3 = 0.5
slot4 = 0.05
slot5 = 0.01

function slot0.onInitView(slot0)
	slot0._animGO = gohelper.findChild(slot0.viewGO, "anim")
	slot0._anim = slot0._animGO and slot0._animGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._waveAnimation = slot0.viewGO:GetComponent(typeof(UnityEngine.Animation))
	slot0._lvCtrl = slot0.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	slot0._goprevieweff = gohelper.findChild(slot0.viewGO, "anim/lv/#lvimge_ffect")
	slot0._previewlvCtrl = slot0._goprevieweff:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	slot0._golv = gohelper.findChild(slot0.viewGO, "anim/lv/#go_Lv")
	slot0._scrolllv = gohelper.findChildScrollRect(slot0.viewGO, "anim/lv/#go_Lv/#scroll_Num")
	slot0._scrollrectlv = slot0._scrolllv:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0._translvcontent = gohelper.findChild(slot0.viewGO, "anim/lv/#go_Lv/#scroll_Num/Viewport/Content").transform
	slot0._gomax = gohelper.findChild(slot0.viewGO, "anim/lv/#go_Lv/Max")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/lv/#go_Lv/Max")
	slot0._txtmax = gohelper.findChildText(slot0.viewGO, "anim/lv/#go_Lv/Max/#txt_Num")
	slot0._gomaxlarrow = gohelper.findChild(slot0.viewGO, "anim/lv/#go_Lv/Max/image_lArrow")
	slot0._gomaxrarrow = gohelper.findChild(slot0.viewGO, "anim/lv/#go_Lv/Max/image_rArrow")
	slot0._scrolldrag = SLFramework.UGUI.UIDragListener.Get(slot0._scrolllv.gameObject)
	slot0._golvfull = gohelper.findChild(slot0.viewGO, "anim/lv/#go_LvFull")
	slot0._txtfulllvnum = gohelper.findChildText(slot0.viewGO, "anim/lv/#go_LvFull/#txt_LvNum")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "anim/#go_tips")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "anim/#go_righttop")
	slot0._btninsight = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/#btn_insight")
	slot0._goupgrade = gohelper.findChild(slot0.viewGO, "anim/#go_upgrade")
	slot0._goupgradetexten = gohelper.findChild(slot0.viewGO, "anim/#go_upgrade/txten")
	slot0._btnuplevel = SLFramework.UGUI.UIClickListener.Get(slot0._goupgrade)
	slot0._btnuplevellongpress = SLFramework.UGUI.UILongPressListener.Get(slot0._goupgrade)
	slot0._golevelupbeffect = gohelper.findChild(slot0.viewGO, "anim/#go_levelupbeffect")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocharacterbg = gohelper.findChild(slot0.viewGO, "anim/bg/#go_characterbg")
	slot0._goherogroupbg = gohelper.findChild(slot0.viewGO, "anim/bg/#go_herogroupbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._scrolldrag:AddDragBeginListener(slot0._onLevelScrollDragBegin, slot0)
	slot0._scrolldrag:AddDragEndListener(slot0._onLevelScrollDragEnd, slot0)
	slot0._scrolllv:AddOnValueChanged(slot0._onLevelScrollChange, slot0)

	slot5 = slot0

	slot0._btnmax:AddClickListener(slot0._onMaxLevelClick, slot5)

	slot1 = {
		0.5
	}

	for slot5 = 2, 100 do
		table.insert(slot1, math.max(0.9 * slot1[slot5 - 1], 0.2))
	end

	slot0._btnuplevellongpress:SetLongPressTime(slot1)
	slot0._btnuplevellongpress:AddLongPressListener(slot0._onUpLevelLongPress, slot0)
	slot0._btnuplevel:AddClickListener(slot0._onUpLevelClick, slot0)
	slot0._btnuplevel:AddClickUpListener(slot0._onClickUp, slot0)
	slot0._btninsight:AddClickListener(slot0._btninsightOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onItemChanged, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, slot0._onClickHeroEditItem, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpClickLevel, slot0._onClickLevel, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpViewClick, slot0._localLevelUpConfirmSend, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scrolldrag:RemoveDragBeginListener()
	slot0._scrolldrag:RemoveDragEndListener()
	slot0._scrolllv:RemoveOnValueChanged()
	slot0._btnmax:RemoveClickListener()
	slot0._btnuplevellongpress:RemoveLongPressListener()
	slot0._btnuplevel:RemoveClickListener()
	slot0._btnuplevel:RemoveClickUpListener()
	slot0._btninsight:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onItemChanged, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, slot0._onClickHeroEditItem, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpClickLevel, slot0._onClickLevel, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpViewClick, slot0._localLevelUpConfirmSend, slot0)
end

function slot0._onLevelScrollDragBegin(slot0)
	slot0:killTween()

	slot0._isDrag = true
end

function slot0._onLevelScrollDragEnd(slot0)
	slot0._isDrag = false

	if slot0._scrollrectlv and slot0:checkScrollMove(true) then
		slot0:_selectToNearLevel(true)
	end
end

function slot0._onLevelScrollChange(slot0, slot1)
	slot0:dispatchLevelScrollChange()

	if not slot0._isDrag and not slot0._tweenId and (slot0:checkScrollMove() or slot1 <= 0 or slot1 >= 1) then
		slot0:_selectToNearLevel(true)
	end

	slot2 = slot0:calScrollLevel()

	if slot0.previewLevel and slot0.previewLevel == slot2 then
		return
	end

	slot0.previewLevel = slot2
	slot4 = slot0.previewLevel == slot0:getHeroLevel()

	gohelper.setActive(slot0._goupgrade, not slot4)
	gohelper.setActive(slot0._tips[3], slot4)
	slot0:_refreshConsume(slot0.previewLevel)
	slot0:_refreshMaxBtnStatus(slot0.previewLevel)
	slot0:_refreshPreviewLevelHorizontal(slot0.previewLevel)

	if not slot0._skipScrollAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_role_upgrade_lv_item_scroll)
	end

	slot0._skipScrollAudio = nil

	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpChangePreviewLevel, slot0.previewLevel)
end

function slot0.checkScrollMove(slot0, slot1)
	slot2 = false

	if slot1 then
		slot5 = slot0._scrollrectlv and slot0._scrollrectlv.horizontalNormalizedPosition or 0
		slot2 = math.abs(slot0._scrollrectlv and slot0._scrollrectlv.velocity.x or 0) <= 10 or slot5 <= 0.01 or slot5 >= 0.99
	else
		slot2 = slot3 <= 50
	end

	return slot2
end

function slot0._selectToNearLevel(slot0, slot1)
	slot0:killTween()
	slot0._scrollrectlv:StopMovement()

	slot0._targetLevel = slot0:calScrollLevel()

	slot0:dispatchLevelScrollChange()

	if slot1 then
		slot3 = true

		if slot0._heroMO then
			slot3 = math.abs(slot0:calScrollPos(slot0._targetLevel) - slot0._scrolllv.horizontalNormalizedPosition) > 1 / (CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1] - slot0:getHeroLevel()) / 100
		end

		if slot3 then
			slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot4, slot2, uv0, slot0.tweenFrame, slot0.tweenFinish, slot0)
		end
	else
		slot0._scrolllv.horizontalNormalizedPosition = slot2
	end
end

function slot0._onMaxLevelClick(slot0)
	slot0:_onClickLevel(slot0._maxCanUpLevel)
end

function slot0._onUpLevelLongPress(slot0)
	if slot0._targetLevel - slot0:getHeroLevel() == 1 then
		slot0.longPress = true

		slot0:_onUpLevelClick()
	end
end

function slot0._onClickUp(slot0)
	if not slot0._heroMO or not slot0.longPress then
		return
	end

	slot0.longPress = false

	slot0:_localLevelUpConfirmSend()
end

function slot0._onUpLevelClick(slot0)
	if UIBlockMgr.instance:isBlock() or not slot0._heroMO or slot0._isDrag or slot0._tweenId or not slot0:checkScrollMove(true) then
		return
	end

	if slot0:getHeroLevel() < slot0._targetLevel and not CharacterModel.instance:isHeroLevelReachCeil(slot0._heroMO.heroId, slot3) then
		slot0:_localLevelUp(slot0._targetLevel)

		if GuideController.instance:isGuiding() and GuideModel.instance:getDoingGuideId() == CharacterEnum.LevelUpGuideId then
			slot0:_localLevelUpConfirmSend()
		end
	else
		slot0._btnuplevellongpress:RemoveLongPressListener()
		slot0._btnuplevel:RemoveClickListener()
		slot0._btnuplevel:RemoveClickUpListener()
		slot0:_refreshView()

		if not slot0.longPress then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		end
	end
end

function slot0._localLevelUp(slot0, slot1)
	if not slot0._heroMO then
		return
	end

	slot3 = slot0:getHeroLevel(true)

	if CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1] < (slot1 or slot0:getHeroLevel() + 1) or slot5 <= slot4 then
		return
	end

	if HeroConfig.instance:getLevelUpItems(slot2, slot3, slot5) then
		slot9, slot10, slot11 = ItemModel.instance:hasEnoughItems(slot8)

		if not slot10 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot11, slot9)
			slot0:_localLevelUpConfirmSend()

			return
		end
	end

	slot0._lastHeroLevel = slot4

	slot0:playLevelUpEff(slot5)
	slot0.viewContainer:setLocalUpLevel(slot5)
	TaskDispatcher.cancelTask(slot0._delayRefreshView, slot0)
	TaskDispatcher.runDelay(slot0._delayRefreshView, slot0, uv0)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem, slot8)

	if CharacterModel.instance:isHeroLevelReachCeil(slot2, slot5) then
		slot0._btnuplevellongpress:RemoveLongPressListener()
		slot0._btnuplevel:RemoveClickListener()
		slot0._btnuplevel:RemoveClickUpListener()
		slot0:_localLevelUpConfirmSend(true)
	end
end

function slot0._delayRefreshView(slot0)
	slot0:_refreshView()

	slot1 = slot0._heroMO.heroId
	slot2 = slot0:getHeroLevel()
	slot3 = true

	if not slot0.longPress then
		slot3 = false

		if slot0._lastHeroLevel and slot2 - slot0._lastHeroLevel == 1 and not CharacterModel.instance:isHeroLevelReachCeil(slot1, slot2) and HeroConfig.instance:getLevelUpItems(slot1, slot0:getHeroLevel(true), slot2 + 1) then
			slot8, slot3, slot10 = ItemModel.instance:hasEnoughItems(slot7)
		end
	end

	slot0._lastHeroLevel = nil

	slot0:_resetLevelScrollPos(slot3)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute, slot2, slot1)
end

function slot0._localLevelUpConfirmSend(slot0, slot1)
	if slot0:getHeroLevel(true) < slot0:getHeroLevel() and not CharacterModel.instance:isHeroLevelReachCeil(slot0._heroMO.heroId) then
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem, {}, true)
		HeroRpc.instance:sendHeroLevelUpRequest(slot2, slot3, slot0._localLevelUpConfirmSendCallback, slot0)
		slot0.viewContainer:setWaitHeroLevelUpRefresh(true)
	elseif slot1 then
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem)
		slot0:_refreshView()
	end
end

function slot0._localLevelUpConfirmSendCallback(slot0, slot1, slot2, slot3)
	slot0.viewContainer:setWaitHeroLevelUpRefresh(false)
	slot0.viewContainer:setLocalUpLevel()
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem)
end

function slot0._btninsightOnClick(slot0)
	CharacterController.instance:dispatchEvent(CharacterEvent.showCharacterRankUpView, function ()
		CharacterController.instance:openCharacterRankUpView(uv0._heroMO)
	end)
	slot0:closeThis()
end

function slot0._btnitemOnClick(slot0, slot1)
	slot2 = tonumber(slot1.type)
	slot3 = tonumber(slot1.id)

	MaterialTipController.instance:showMaterialInfo(slot2, slot3, false, nil, , {
		type = slot2,
		id = slot3,
		quantity = tonumber(slot1.quantity),
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
	slot0:_localLevelUpConfirmSend()
end

function slot0._onItemChanged(slot0)
	if slot0.viewContainer:getWaitHeroLevelUpRefresh() then
		return
	end

	slot0:_refreshConsume()
	slot0:_refreshMaxCanUpLevel()
end

function slot0._onClickHeroEditItem(slot0, slot1)
	if not slot1 or slot1.heroId ~= slot0._heroMO.heroId then
		slot0:closeThis()
	end
end

function slot0._onClickLevel(slot0, slot1)
	if not slot1 or not slot0._heroMO then
		return
	end

	if CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1] < slot1 or slot1 < slot0:getHeroLevel() then
		return
	end

	slot0._targetLevel = slot1

	slot0:killTween()

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._scrolllv.horizontalNormalizedPosition, slot0:calScrollPos(slot0._targetLevel), uv0, slot0.tweenFrame, slot0.tweenFinish, slot0)
end

function slot0.tweenFrame(slot0, slot1)
	if not slot0._scrolllv then
		return
	end

	slot0._scrolllv.horizontalNormalizedPosition = slot1
end

function slot0.tweenFinish(slot0)
	slot0._tweenId = nil

	slot0:_selectToNearLevel()
end

function slot0.calScrollLevel(slot0)
	slot1 = nil

	if slot0._scrolllv and slot0._heroMO then
		slot2 = slot0:getHeroLevel()
		slot4 = CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1] - slot2
		slot1 = slot2

		for slot10 = 1, slot4 do
			if slot0._scrolllv.horizontalNormalizedPosition < (slot10 - 0.5) * 1 / slot4 then
				break
			end

			slot1 = slot2 + slot10
		end

		slot1 = Mathf.Clamp(slot1, slot2, slot3)
	end

	return slot1
end

function slot0.calScrollPos(slot0, slot1)
	slot2 = 0

	if slot1 and slot0._heroMO then
		slot3 = slot0:getHeroLevel()
		slot2 = Mathf.Clamp((slot1 - slot3) / (CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1] - slot3), 0, 1)
	end

	return slot2
end

function slot0._editableInitView(slot0)
	slot0._tips = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0._tips[slot4] = gohelper.findChild(slot0._gotips, "tips" .. tostring(slot4))
	end

	slot4 = "full"
	slot0._txtfulllevel = gohelper.findChild(slot0._tips[1], slot4)
	slot0._tipitems = {}

	for slot4 = 1, uv0 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._tips[2], "item" .. tostring(slot4))
		slot5.icon = gohelper.findChildSingleImage(slot5.go, "icon")
		slot5.value = gohelper.findChildText(slot5.go, "value")
		slot5.btn = gohelper.findChildButtonWithAudio(slot5.go, "bg")
		slot5.type = nil
		slot5.id = nil
		slot0._tipitems[slot4] = slot5
	end
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0:clearVar()

	slot0._heroMO = slot0.viewParam.heroMO
	slot0._enterViewName = slot0.viewParam.enterViewName

	slot0:_setView()
	slot0:_refreshView()
	slot0:_resetLevelScrollPos(true, true)
end

function slot0.clearVar(slot0)
	slot0:killTween()

	slot0._targetLevel = nil
	slot0.previewLevel = nil
	slot0._isDrag = false
	slot0.longPress = false
	slot0._lastHeroLevel = nil
	slot0._skipScrollAudio = nil
	slot0._maxCanUpLevel = nil
end

function slot0.killTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._setView(slot0)
	if slot0._enterViewName == ViewName.HeroGroupEditView then
		slot0._animGO.transform.anchorMin = Vector2(0, 0.5)
		slot0._animGO.transform.anchorMax = Vector2(0, 0.5)
		slot0._gorighttop.transform.anchorMin = Vector2(0, 1)
		slot0._gorighttop.transform.anchorMax = Vector2(0, 1)

		recthelper.setAnchor(slot0._animGO.transform, 677.22, -50.4)
		recthelper.setAnchor(slot0._gorighttop.transform, 683, 1)
	else
		slot0._animGO.transform.anchorMin = Vector2(1, 0.5)
		slot0._animGO.transform.anchorMax = Vector2(1, 0.5)
		slot0._gorighttop.transform.anchorMin = Vector2(1, 1)
		slot0._gorighttop.transform.anchorMax = Vector2(1, 1)

		recthelper.setAnchor(slot0._animGO.transform, 0, 0)
		recthelper.setAnchor(slot0._gorighttop.transform, -50, -50)
	end

	gohelper.setActive(slot0._btnclose.gameObject, not slot1)
	gohelper.setActive(slot0._goherogroupbg, slot1)
	gohelper.setActive(slot0._gocharacterbg, not slot1)
end

function slot0._refreshView(slot0)
	slot0:_refreshLevelHorizontal()
	slot0:_refreshLevelScroll()
	slot0:_refreshMaxCanUpLevel()
end

function slot0._refreshLevelScroll(slot0)
	if CharacterModel.instance:isHeroLevelReachCeil(slot0._heroMO.heroId, slot0:getHeroLevel()) then
		slot0._txtfulllvnum.text = HeroConfig.instance:getShowLevel(slot2)

		gohelper.setActive(slot0._tips[2], false)
		gohelper.setActive(slot0._tips[3], false)
		gohelper.setActive(slot0._goupgrade, false)
		gohelper.setActive(slot0._golevelupbeffect, false)
		gohelper.setActive(slot0._btninsight.gameObject, not CharacterModel.instance:isHeroRankReachCeil(slot1))
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpChangePreviewLevel, slot2)
	else
		gohelper.setActive(slot0._btninsight.gameObject, false)
		CharacterLevelListModel.instance:setCharacterLevelList(slot0._heroMO, slot2)
		TaskDispatcher.cancelTask(slot0.dispatchLevelScrollChange, slot0)
		TaskDispatcher.runDelay(slot0.dispatchLevelScrollChange, slot0, uv0)
	end

	gohelper.setActive(slot0._tips[1], slot3)
	gohelper.setActive(slot0._golv, not slot3)
	gohelper.setActive(slot0._golvfull, slot3)
end

function slot0.getContentOffset(slot0)
	return transformhelper.getLocalPos(slot0._translvcontent)
end

function slot0.dispatchLevelScrollChange(slot0)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelScrollChange, slot0:getContentOffset())
end

function slot0._refreshConsume(slot0, slot1)
	if CharacterModel.instance:isHeroLevelReachCeil(slot0._heroMO.heroId, slot0:getHeroLevel()) then
		return
	end

	slot6 = (slot1 or slot0._targetLevel) == slot3

	gohelper.setActive(slot0._tips[2], not slot6)

	if slot6 then
		gohelper.setActive(slot0._golevelupbeffect, false)

		return
	end

	slot7 = true
	slot13 = slot5
	slot9 = slot0:getLocalCost()

	for slot13, slot14 in ipairs(HeroConfig.instance:getLevelUpItems(slot2, slot3, slot13)) do
		if slot0._tipitems[slot13] then
			if slot15.type ~= tonumber(slot14.type) or not (slot15.id == tonumber(slot14.id)) then
				slot20, slot21 = ItemModel.instance:getItemConfigAndIcon(slot16, slot17)

				slot15.icon:LoadImage(slot21)
				slot15.btn:RemoveClickListener()
				slot15.btn:AddClickListener(slot0._btnitemOnClick, slot0, slot14)

				slot15.type = slot16
				slot15.id = slot17
			end

			if slot9 and slot9[slot16] and slot9[slot16][slot17] then
				slot20 = ItemModel.instance:getItemQuantity(slot16, slot17) - slot9[slot16][slot17]
			end

			if slot20 < tonumber(slot14.quantity) then
				slot15.value.text = "<color=#cc492f>" .. tostring(GameUtil.numberDisplay(slot21)) .. "</color>"
				slot7 = false
			else
				slot15.value.text = tostring(GameUtil.numberDisplay(slot21))
			end

			gohelper.setActive(slot15.go, true)
		end
	end

	if #slot8 < uv0 then
		for slot14 = slot10 + 1, uv0 do
			gohelper.setActive(slot0._tipitems[slot14] and slot15.go, false)
		end
	end

	gohelper.setActive(slot0._golevelupbeffect, slot7)
	ZProj.UGUIHelper.SetGrayscale(slot0._goupgrade, not slot7)
	ZProj.UGUIHelper.SetGrayscale(slot0._goupgradetexten, not slot7)
end

function slot0._refreshLevelHorizontal(slot0)
	if not slot0._heroMO then
		return
	end

	slot2 = 0

	if CharacterModel.instance:isHeroLevelReachCeil(slot0._heroMO.heroId, slot0:getHeroLevel()) then
		slot2 = 1
	else
		slot5 = slot0._heroMO.rank
		slot6 = CharacterModel.instance:getrankEffects(slot1, slot5 - 1)[1]
		slot2 = (slot3 - slot6) / (CharacterModel.instance:getrankEffects(slot1, slot5)[1] - slot6)
	end

	if slot0._lvCtrl then
		slot0._lvCtrl.float_01 = slot2

		slot0._lvCtrl:SetProps()
	end
end

function slot0._refreshPreviewLevelHorizontal(slot0, slot1)
	if not slot0._heroMO then
		return
	end

	slot2 = slot1 or slot0._targetLevel
	slot3 = 0
	slot5 = slot0:getHeroLevel()

	if CharacterModel.instance:isHeroLevelReachCeil(slot0._heroMO.heroId, slot5) or slot1 == slot5 then
		gohelper.setActive(slot0._goprevieweff, false)

		return
	end

	slot8 = slot0._heroMO.rank
	slot9 = CharacterModel.instance:getrankEffects(slot4, slot8 - 1)[1]

	if slot0._previewlvCtrl then
		slot0._previewlvCtrl.float_01 = (slot2 - slot9) / (CharacterModel.instance:getrankEffects(slot4, slot8)[1] - slot9)

		slot0._previewlvCtrl:SetProps()
	end

	gohelper.setActive(slot0._goprevieweff, true)
end

function slot0._refreshMaxCanUpLevel(slot0)
	slot0._maxCanUpLevel = nil

	if slot0._heroMO then
		slot2 = slot0:getLocalCost()
		slot8 = slot0._heroMO.rank

		for slot8 = slot0:getHeroLevel() + 1, CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot8)[1] do
			slot9 = true
			slot14 = slot3
			slot15 = slot8

			for slot14, slot15 in ipairs(HeroConfig.instance:getLevelUpItems(slot1, slot14, slot15)) do
				slot18 = tonumber(slot15.quantity)

				if slot2 and slot2[slot16] and slot2[slot16][slot17] then
					slot19 = ItemModel.instance:getItemQuantity(tonumber(slot15.type), tonumber(slot15.id)) - slot2[slot16][slot17]
				end

				if slot18 > slot19 then
					slot9 = false

					break
				end
			end

			if not slot9 then
				break
			end

			slot0._maxCanUpLevel = slot8
		end
	end

	slot0._txtmax.text = formatLuaLang("v1a5_aizila_level", slot0._maxCanUpLevel and HeroConfig.instance:getShowLevel(slot0._maxCanUpLevel) or "")

	slot0:_refreshMaxBtnStatus()
end

function slot0._refreshMaxBtnStatus(slot0, slot1)
	slot2 = slot1 or slot0._targetLevel

	if not slot0._heroMO or not slot2 or not slot0._maxCanUpLevel then
		gohelper.setActive(slot0._gomax, false)

		return
	end

	gohelper.setActive(slot0._gomax, slot2 ~= slot0._maxCanUpLevel)
	gohelper.setActive(slot0._gomaxlarrow, slot0._maxCanUpLevel < slot2)
	gohelper.setActive(slot0._gomaxrarrow, slot2 < slot0._maxCanUpLevel)
end

function slot0._resetLevelScrollPos(slot0, slot1, slot2)
	slot0:killTween()

	slot0.previewLevel = nil

	if not slot0._scrolllv then
		return
	end

	slot0._skipScrollAudio = true

	if slot0._heroMO and slot1 then
		slot0._targetLevel = math.min(slot0:getHeroLevel() + 1, CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1])

		if slot2 then
			TaskDispatcher.cancelTask(slot0.delaySetScrollPos, slot0)
			TaskDispatcher.runDelay(slot0.delaySetScrollPos, slot0, uv0)
		else
			slot0._scrolllv.horizontalNormalizedPosition = slot0:calScrollPos(slot0._targetLevel)
		end
	else
		slot0._scrolllv.horizontalNormalizedPosition = 0
		slot0._targetLevel = slot3 or 0
	end
end

function slot0.delaySetScrollPos(slot0)
	slot0._scrolllv.horizontalNormalizedPosition = slot0:calScrollPos(slot0._targetLevel)
end

function slot0.getHeroLevel(slot0, slot1)
	if not slot0.viewContainer:getLocalUpLevel() or slot1 then
		slot2 = slot0._heroMO and slot0._heroMO.level
	end

	return slot2
end

function slot0.getLocalCost(slot0)
	slot1 = {}

	if slot0._heroMO then
		slot8 = slot0:getHeroLevel(true)

		for slot8 = 1, #HeroConfig.instance:getLevelUpItems(slot0._heroMO.heroId, slot8, slot0:getHeroLevel()) do
			slot9 = slot4[slot8]
			slot1[slot9.type] = slot1[slot9.type] or {}
			slot1[slot9.type][slot9.id] = (slot1[slot9.type][slot9.id] or 0) + slot9.quantity
		end
	end

	return slot1
end

function slot0.playLevelUpEff(slot0, slot1)
	if slot0._anim then
		slot0._anim:Play(UIAnimationName.Click, 0, 0)
	end

	if slot0._waveAnimation then
		slot0._waveAnimation:Stop()
		slot0._waveAnimation:Play()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_role_upgrade_2)
	CharacterController.instance:dispatchEvent(CharacterEvent.characterLevelItemPlayEff, slot1)
end

function slot0.onClose(slot0)
	slot0:removeEvents()
	slot0:clearVar()
	TaskDispatcher.cancelTask(slot0.dispatchLevelScrollChange, slot0)
	TaskDispatcher.cancelTask(slot0.delaySetScrollPos, slot0)
	TaskDispatcher.cancelTask(slot0._delayRefreshView, slot0)
	slot0:_localLevelUpConfirmSend()
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, 2 do
		slot5 = slot0._tipitems[slot4]

		slot5.icon:UnLoadImage()
		slot5.btn:RemoveClickListener()

		slot5.type = nil
		slot5.id = nil
	end
end

return slot0
