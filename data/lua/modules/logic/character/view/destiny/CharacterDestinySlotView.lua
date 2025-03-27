module("modules.logic.character.view.destiny.CharacterDestinySlotView", package.seeall)

slot0 = class("CharacterDestinySlotView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gomain = gohelper.findChild(slot0.viewGO, "#go_main")
	slot0._scrollattr = gohelper.findChildScrollRect(slot0.viewGO, "#go_main/left/#scroll_attr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_main/left/#scroll_attr/Viewport/Content/#go_attritem")
	slot0._goslot = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot")
	slot0._goslotItem = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/#go_slotItem")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/#go_lock")
	slot0._gopreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/middle/#go_slot/#go_lock/#btn_preview")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_empty")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_empty/#btn_add")
	slot0._gostone = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone")
	slot0._txtstonename = gohelper.findChildText(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#txt_stonename")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#image_icon")
	slot0._simagestone = gohelper.findChildSingleImage(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_stone")
	slot0._gostonebtnicon = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/icon")
	slot0._simagestonedec = gohelper.findChildSingleImage(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_stonedec")
	slot0._btnstone = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#btn_stone")
	slot0._goconsumeitem = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_consumeitem")
	slot0._gocurrency = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_currency")
	slot0._txtcurrency = gohelper.findChildText(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_currency/#txt_currency")
	slot0._imagecurrency = gohelper.findChildImage(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_currency/#txt_currency/#image_currency")
	slot0._gounlockbtn = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_unlockbtn")
	slot0._btnunlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_unlockbtn/#btn_unlock", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	slot0._gouplv = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv")
	slot0._btnuplv = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv/#btn_uplv", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv/#btn_uplv/#txt_lv")
	slot0._gouprank = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_uprank")
	slot0._btnuprank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_uprank/#btn_uprank", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	slot0._gomax = gohelper.findChild(slot0.viewGO, "#go_main/middle/#go_slot/btn/#go_max")
	slot0._scrolleffect = gohelper.findChildScrollRect(slot0.viewGO, "#go_main/right/#scroll_effect")
	slot0._gostoneeffectitem = gohelper.findChild(slot0.viewGO, "#go_main/right/#scroll_effect/Viewport/Content/#go_stoneeffectitem")
	slot0._gostoneempty = gohelper.findChild(slot0.viewGO, "#go_main/right/#go_stoneempty")
	slot0._gostonelock = gohelper.findChild(slot0.viewGO, "#go_main/right/#go_stonelock")
	slot0._gounlockanim = gohelper.findChild(slot0.viewGO, "#go_unlockanim")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnstone:AddClickListener(slot0._btnstoneOnClick, slot0)
	slot0._btnunlock:AddClickListener(slot0._btnunlockOnClick, slot0)
	slot0._btnuplv:AddClickListener(slot0._btnuplvOnClick, slot0)
	slot0._btnuprank:AddClickListener(slot0._btnuprankOnClick, slot0)
	slot0._gopreview:AddClickListener(slot0._btnpreviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadd:RemoveClickListener()
	slot0._btnstone:RemoveClickListener()
	slot0._btnunlock:RemoveClickListener()
	slot0._btnuplv:RemoveClickListener()
	slot0._btnuprank:RemoveClickListener()
	slot0._gopreview:RemoveClickListener()
end

function slot0._btnaddOnClick(slot0)
end

function slot0._btnuplvOnClick(slot0)
end

function slot0._btnpreviewOnClick(slot0)
	slot0:_openCharacterDestinyStoneView()
end

slot0.UI_CLICK_BLOCK_KEY = "CharacterDestinySlotView_Click"

function slot0._btnuprankOnClick(slot0)
	if slot0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	if not slot0:isHasEnoughCurrenctLevelUp(true) then
		return
	end

	slot0._isPlayingRankUpAnim = true

	slot0._anim:Play(CharacterDestinyEnum.SlotViewAnim.LevelUp, 0, 0)
	CharacterDestinyController.instance:onRankUp(slot0._heroMO.heroId)

	if slot0._slotmats[slot0._heroMO.destinyStoneMo.rank + 1] then
		gohelper.setActive(slot1.golevelup, true)
	end

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_leimi_smalluncharted_refresh)
	gohelper.setActive(slot0._goempty, false)
	UIBlockMgr.instance:startBlock(uv0.UI_CLICK_BLOCK_KEY)
end

function slot0._btnstoneOnClick(slot0)
	slot0:_openCharacterDestinyStoneView()
end

function slot0._btnunlockOnClick(slot0)
	if not slot0:isHasEnoughCurrenctLevelUp(true) then
		return
	end

	slot0._isPlayingUnlockAnim = true

	slot0._anim:Play(CharacterDestinyEnum.SlotViewAnim.Unlock, 0, 0)
	CharacterDestinyController.instance:onRankUp(slot0._heroMO.heroId)
	gohelper.setActive(slot0._gotopleft, false)
	gohelper.setActive(slot0._goempty, false)
	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_unlock)
	UIBlockMgr.instance:startBlock(uv0.UI_CLICK_BLOCK_KEY)
end

slot1 = 0.5
slot2 = 0.1

function slot0._editableInitView(slot0)
	slot0._btnUpLvlongPress = SLFramework.UGUI.UILongPressListener.Get(slot0._btnuplv.gameObject)

	slot0._btnUpLvlongPress:SetLongPressTime({
		uv0,
		uv1
	})
	slot0._btnUpLvlongPress:AddLongPressListener(slot0._upLvLongPress, slot0)

	slot0._btnuplevel = SLFramework.UGUI.UIClickListener.Get(slot0._btnuplv.gameObject)

	slot0._btnuplevel:AddClickUpListener(slot0._onClickLevelUpBtnUp, slot0)
	slot0._btnuplevel:AddClickDownListener(slot0._onClickLevelUpBtnDown, slot0)

	slot0._consumeCurrencyItems = slot0:getUserDataTb_()
	slot0._consumeCurrencyItems[1] = {
		go = slot0._txtcurrency.gameObject,
		txt = slot0._txtcurrency,
		icon = slot0._imagecurrency
	}
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_main/middle/#go_slot/title/txt_title")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot4 = ZProj.AnimationEventWrap
	slot0._animEvent = slot0.viewGO:GetComponent(typeof(slot4))
	slot0._slotmats = slot0:getUserDataTb_()

	for slot4 = 1, CharacterDestinyEnum.EffectItemCount do
		slot5 = gohelper.findChild(slot0._goslot, "mesh0" .. slot4)

		table.insert(slot0._slotmats, {
			mpc = slot5:GetComponent(typeof(ZProj.MaterialPropsCtrl)),
			ms = gohelper.findChild(slot5, "ms"):GetComponent(typeof(UIMesh)),
			golevelup = gohelper.findChild(slot5, "#leveup")
		})
	end

	slot0._gyroOffsetID = UnityEngine.Shader.PropertyToID("_GyroOffset")
	slot0._gyroOffset = Vector4.New(0, 0, 0)

	TaskDispatcher.runRepeat(slot0._tick, slot0, 0)
end

function slot0._tick(slot0)
	slot1, slot2, slot3 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)
	slot0._gyroOffset.y = (slot0._gyroOffset.y + slot2) * 0.5
	slot0._gyroOffset.x = (slot0._gyroOffset.x + slot1) * 0.5

	UnityEngine.Shader.SetGlobalVector(slot0._gyroOffsetID, slot0._gyroOffset)
end

function slot0._upLvLongPress(slot0)
	if not slot0._canLongPress then
		return
	end

	if slot0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		slot0:_onClickLevelUpBtnUp()

		return
	end

	slot2 = slot1.level

	if slot0._addLevel then
		if not slot0:isHasEnoughCurrenctLevelUp(true, slot1.rank, slot1.level + slot0._addLevel - 1) then
			slot0._addLevel = slot0._addLevel - 1

			slot0:_onClickLevelUpBtnUp()

			return
		end

		if slot2 < slot0._maxRankLevel then
			slot0._addLevel = slot0._addLevel + 1

			slot0:_refreshLevelUpConsume(slot2)
		else
			slot0:_onClickLevelUpBtnUp()
		end
	else
		slot2 = slot1.level + 2
		slot0._addLevel = 2
	end

	slot0:_refreshLevelUp(slot1.rank, slot2)
end

function slot0._onClickLevelUpBtnDown(slot0)
	if slot0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	if not slot0:isHasEnoughCurrenctLevelUp(true) then
		return
	end

	slot0._addLevel = 1
	slot0._canLongPress = true
end

function slot0._onClickLevelUpBtnUp(slot0)
	if not slot0._canLongPress then
		return
	end

	slot0._canLongPress = nil

	if slot0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	if slot0._addLevel then
		slot2 = math.min(slot1.level + slot0._addLevel, slot0._maxRankLevel)

		if slot1.level + slot0._addLevel <= slot0._maxRankLevel then
			CharacterDestinyController.instance:onLevelUp(slot0._heroMO.heroId, slot2)
			slot0:_refreshLevelUp(slot1.rank, slot2)
		else
			slot0:_refreshBtn(slot2)
		end
	end

	slot0._addLevel = nil
end

function slot0._refreshLevelUp(slot0, slot1, slot2)
	slot0:_playAttrItemLevelUp(slot1, slot2 - 1)
	TaskDispatcher.runDelay(function ()
		uv0:_refreshAttrPanel(uv1, uv2)
	end, slot0, 0.5)
	slot0:_refreshBtnLevel(slot2)

	if slot2 < slot0._heroMO.destinyStoneMo.maxLevel[slot1] then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_charged)
	else
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_full)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, slot0._OnRankUpReply, slot0)
	slot0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnLevelUpReply, slot0._onLevelUpReply, slot0)
	slot0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, slot0._onUseStoneReply, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshCurrency, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.RefreshView, slot0._refreshDataCB, slot0)
	slot0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.UnlockEnd, slot0._unlockEndCB, slot0)
	slot0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.LevelUpEnd, slot0._rankUpEndCB, slot0)
	slot0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.UnlockAttrAnim, slot0._unlockAttrAnim, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, slot0._OnRankUpReply, slot0)
	slot0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnLevelUpReply, slot0._onLevelUpReply, slot0)
	slot0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, slot0._onUseStoneReply, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshCurrency, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	if slot0._btnUpLvlongPress then
		slot0._btnUpLvlongPress:RemoveLongPressListener()
	end

	if slot0._btnuplevel then
		slot0._btnuplevel:RemoveClickUpListener()
		slot0._btnuplevel:RemoveClickDownListener()
	end

	slot0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.RefreshView)
	slot0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.UnlockEnd)
	slot0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.LevelUpEnd)
	slot0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.UnlockAttrAnim)
end

function slot0._onLevelUpReply(slot0, slot1, slot2)
	slot0:_refreshView()

	if slot0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_molu_sky_open)
	end
end

function slot0._playItemLevelUp(slot0, slot1)
	if slot0:_getAttrItemByAtttrId(slot1) then
		slot2:playLevelUpAnim()
	end
end

function slot0._playAttrItemLevelUp(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = CharacterDestinyModel.instance:getCurSlotAttrInfos(slot0._heroMO.heroId, slot1, slot2)
	slot7 = 0

	if slot4 then
		for slot11, slot12 in ipairs(slot4) do
			if slot12.nextNum then
				slot0:_playItemLevelUp(slot12.attrId)

				slot7 = slot7 + 1
			end
		end
	end

	if slot5 then
		for slot11, slot12 in ipairs(slot5) do
			if slot12.nextNum then
				slot0:_playItemLevelUp(slot12.attrId)

				slot7 = slot7 + 1
			end
		end
	end

	if slot3 and slot6[1] or slot6[slot1] then
		for slot12, slot13 in ipairs(slot8) do
			slot0:_playItemLevelUp(slot13.attrId)

			slot7 = slot7 + 1
		end
	end

	if slot7 > 0 then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_inking_preference_open)
	end
end

function slot0._onUseStoneReply(slot0, slot1, slot2)
	slot0:_refreshView()
	slot0:_refreshEmpty()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CharacterDestinyStoneView then
		slot0:_playerOpenAnim()
	end
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._heroMO = slot0.viewParam.heroMo
	slot0._isPlayingUnlockAnim = false
	slot0._maxRankLevel = slot0._heroMO.destinyStoneMo:getRankLevelCount()

	if not slot0._itemConsumeList then
		slot0._itemConsumeList = {}
	end

	slot0._txttitle.text = luaLang(CharacterDestinyEnum.SlotTitle[slot0._heroMO.config.heroType] or CharacterDestinyEnum.SlotTitle[1])

	if slot0.viewParam.isBack then
		slot0._anim:Play(slot0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock, 0, 1)
	else
		slot0:_playerOpenAnim()
	end

	slot0:_refreshView(true)
	slot0:_refreshAttrPanel()
	slot0:_refreshEmpty()
	slot0.viewContainer:setCurDestinySlot(slot1)
	slot0:_refreshTrial()
end

function slot0._refreshTrial(slot0)
	slot1 = slot0._heroMO:isTrial()

	gohelper.setActive(slot0._gostonebtnicon.gameObject, not slot1)
	gohelper.setActive(slot0._btnstone.gameObject, not slot1)
end

function slot0._playerOpenAnim(slot0)
	slot0._anim:Play(slot0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.OpenUnlock or CharacterDestinyEnum.SlotViewAnim.OpenLock, 0, 0)
end

function slot0._refreshView(slot0, slot1)
	slot0:_refreshBtn()
	slot0:_refreshSlot(slot1)
end

function slot0._refreshCurrency(slot0)
	for slot4, slot5 in pairs(slot0._itemConsumeList) do
		for slot9, slot10 in pairs(slot5) do
			slot0._itemConsumeList[slot4][slot9] = ItemModel.instance:getItemQuantity(slot4, slot9)
		end
	end

	slot0:_refreshBtn()
end

function slot0._playIdleAnim(slot0, slot1)
	slot0._anim:Play(slot1 and CharacterDestinyEnum.SlotViewAnim.UnlockIdle or CharacterDestinyEnum.SlotViewAnim.LockIdle, 0, 1)
end

function slot0._OnRankUpReply(slot0)
	slot0._maxRankLevel = slot0._heroMO.destinyStoneMo:getRankLevelCount()
end

function slot0._rankUpEndCB(slot0)
	slot0._isPlayingRankUpAnim = false
	slot1 = slot0._heroMO.destinyStoneMo
	slot2 = slot1.rank

	slot0:_playAttrItemLevelUp(slot2 - 1, slot1.maxLevel[slot2 - 1])
	TaskDispatcher.runDelay(slot0._refreshAttrPanel, slot0, 0.5)
	slot0:_refreshBtnLevel(slot1.level)
	gohelper.setActive(slot0._goempty, slot1.curUseStoneId == 0)
	UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)
end

function slot0._unlockEndCB(slot0)
	slot0._isPlayingUnlockAnim = false

	slot0:_playIdleAnim(true)
	gohelper.setActive(slot0._goempty, true)
	gohelper.setActive(slot0._gotopleft, true)
	CharacterDestinyController.instance:dispatchEvent(CharacterDestinyEvent.OnUnlockSlot)
end

function slot0._refreshDataCB(slot0)
	slot0:_refreshView(true)
	slot0:_refreshAttrPanel()
end

function slot0._unlockAttrAnim(slot0)
	slot0:_playAttrItemLevelUp(0, 1, true)
	UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)
end

function slot0._refreshAttrPanel(slot0, slot1, slot2)
	if slot0.isClose then
		return
	end

	slot5, slot6, slot7 = CharacterDestinyModel.instance:getCurSlotAttrInfos(slot0._heroMO.heroId, slot1 or slot0._heroMO.destinyStoneMo.rank, slot2 or slot0._heroMO.destinyStoneMo.level)

	if not slot0._attrItems then
		slot0._attrItems = slot0:getUserDataTb_()
	end

	slot8 = 1

	if slot5 then
		for slot12, slot13 in ipairs(slot5) do
			slot0:_getAttrItem(slot8):onUpdateBaseAttrMO(slot8, slot13)

			slot8 = slot8 + 1
		end
	end

	if slot6 then
		for slot12, slot13 in ipairs(slot6) do
			slot0:_getAttrItem(slot8):onUpdateSpecailAttrMO(slot8, slot13, slot12 == 1, #slot6)

			slot8 = slot8 + 1
		end
	end

	if slot7 then
		for slot12, slot13 in pairs(slot7) do
			slot0:_getAttrItem(slot8):onUpdateLockSpecialAttrMO(slot8, slot12, slot13)

			slot8 = slot8 + 1
		end
	end

	if slot0._attrItems then
		for slot12 = 1, #slot0._attrItems do
			gohelper.setActive(slot0._attrItems[slot12].viewGO, slot12 < slot8)
		end
	end
end

function slot0._getAttrItem(slot0, slot1)
	if not slot0._attrItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot0._attrItems[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goattritem, "attritem_" .. slot1), CharacterDestinySlotAttrItem)
	end

	return slot2
end

function slot0._getAttrItemByAtttrId(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._attrItems) do
		if slot6.attrId == slot1 then
			return slot6
		end
	end
end

function slot0._refreshSlot(slot0, slot1)
	slot2 = slot0._heroMO.destinyStoneMo
	slot3 = slot2:isUnlockSlot()
	slot6 = Color.white

	if slot2.curUseStoneId ~= 0 then
		slot0._txtstonename.text, slot8, slot9 = slot2:getCurStoneNameAndIcon()

		slot0._simagestone:LoadImage(slot8)

		slot10 = CharacterDestinyEnum.SlotTend[slot9.tend]

		UISpriteSetMgr.instance:setUiCharacterSprite(slot0._imageicon, slot10.TitleIconName)

		slot0._txtstonename.color = GameUtil.parseColor(slot10.TitleColor)

		if not slot0._stoneEffectItem then
			slot0._stoneEffectItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gostoneeffectitem, CharacterDestinyStoneEffectItem)
		end

		slot6 = slot10.RuneColor

		slot0._stoneEffectItem:onUpdateMo(slot2)
	end

	for slot10, slot11 in ipairs(slot0._slotmats) do
		if slot11.mpc.color_01 ~= slot6 then
			slot12.color_01 = slot6

			slot12:SetProps()
		end
	end

	slot0:_setSlotLevel(slot1)
	gohelper.setActive(slot0._txttitle.gameObject, not slot5)
	gohelper.setActive(slot0._golock, not slot3)
	gohelper.setActive(slot0._gounlock, slot3)
	gohelper.setActive(slot0._gostone, slot5)
	gohelper.setActive(slot0._scrolleffect.gameObject, slot3 and slot5)
	gohelper.setActive(slot0._gostoneempty.gameObject, slot3 and not slot5)
	gohelper.setActive(slot0._gostonelock.gameObject, not slot3)
end

function slot0._refreshEmpty(slot0)
	gohelper.setActive(slot0._goempty, not (slot0._heroMO.destinyStoneMo.curUseStoneId ~= 0))
end

function slot0._setSlotLevel(slot0, slot1)
	slot2 = slot0._heroMO.destinyStoneMo
	slot4 = slot2.level - 1

	for slot8 = 1, slot2.maxRank do
		slot9 = 0.65
		slot10 = 1

		if slot8 < slot2.rank then
			slot10 = 0
		elseif slot3 < slot8 then
			slot10 = 1
			slot9 = 0.3
		else
			slot10 = slot2:getRankLevelCount() - 1 ~= 0 and 1 - slot4 / slot11 or 0
		end

		slot11 = slot0._slotmats[slot8]
		slot12 = slot11.ms.color
		slot12.a = slot9
		slot11.ms.color = slot12
		slot13 = slot11.mpc
		slot14 = slot13.vector_01
		slot15 = slot13.vector_02

		if slot11._tweenId then
			ZProj.TweenHelper.KillById(slot11._tweenId, false)

			slot11._tweenId = nil
		end

		if not slot1 then
			if slot10 < slot15.x then
				slot11._tweenId = ZProj.TweenHelper.DOTweenFloat(slot15.x, slot10, 0.5, slot0._progressMat, nil, slot0, {
					mpc = slot13,
					vector1 = slot14,
					vector2 = slot15
				})
			end
		else
			slot0:_progressMat(slot10, slot16)
		end
	end
end

function slot0._openCharacterDestinyStoneView(slot0)
	if slot0._isPlayingUnlockAnim then
		return
	end

	slot0._anim:Play(slot0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock, 0, 0)
	CharacterDestinyController.instance:openCharacterDestinyStoneView(slot0._heroMO)
end

function slot0._progressMat(slot0, slot1, slot2)
	slot3 = slot2.mpc
	slot3.vector_01 = Vector4.New(slot2.vector1.x, slot2.vector1.y, slot2.vector1.z, -0.5 + slot1)
	slot3.vector_02 = Vector4.New(slot1, slot2.vector2.y, slot2.vector2.z, slot2.vector2.w)

	slot3:SetProps()
end

function slot0.isHasEnoughCurrenctLevelUp(slot0, slot1, slot2, slot3)
	slot4 = slot0._heroMO.destinyStoneMo

	if not CharacterDestinyConfig.instance:getNextDestinySlotCo(slot4.heroId, slot2 or slot4.rank, slot3 or slot4.level) then
		return
	end

	slot7, slot8 = nil

	if GameUtil.splitString2(slot5.consume, true) then
		for slot12, slot13 in ipairs(slot6) do
			slot15 = slot13[2]
			slot16 = slot13[3]

			if not slot0._itemConsumeList[slot13[1]] then
				slot0._itemConsumeList[slot14] = {}
			end

			if not slot17[slot15] then
				slot17[slot15] = ItemModel.instance:getItemQuantity(slot14, slot15)
			end

			if slot0._itemConsumeList[slot14][slot15] < slot16 then
				slot7, slot8 = ItemModel.instance:getItemConfigAndIcon(slot14, slot15)

				break
			end
		end
	end

	if slot7 then
		if slot1 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot8, slot7.name)
		end

		return false
	end

	return true
end

function slot0._refreshBtn(slot0, slot1)
	slot4 = slot0._heroMO.destinyStoneMo:isUnlockSlot() and slot2:isSlotMaxLevel()
	slot5 = slot3 and not slot4 and slot2:isCanUpSlotRank()
	slot6 = slot3 and not slot4 and not slot2:isCanUpSlotRank()

	gohelper.setActive(slot0._gounlockbtn, not slot0._heroMO:isTrial() and not slot3)
	gohelper.setActive(slot0._gouplv, not slot8 and slot6)
	gohelper.setActive(slot0._gouprank, not slot8 and slot5)
	gohelper.setActive(slot0._gomax, slot3 and slot4)
	gohelper.setActive(slot0._goconsumeitem, not slot8 and (not slot3 or slot5))
	gohelper.setActive(slot0._gocurrency, not slot8 and slot6)

	if CharacterDestinyConfig.instance:getNextDestinySlotCo(slot2.heroId, slot2.rank, slot1 or slot2.level) then
		if slot7 then
			IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onConsumeItemCB, ItemModel.instance:getItemDataListByConfigStr(slot9.consume), slot0._goconsumeitem)
		end

		if slot6 then
			slot0:_onRefreshConsumeCurrencyItems(slot10)
		end
	end

	slot0:_refreshBtnLevel(slot2.level)
end

function slot0._onConsumeItemCB(slot0, slot1, slot2, slot3)
	transformhelper.setLocalScale(slot1.viewGO.transform, 0.6, 0.6, 1)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)

	slot4 = slot1:getItemIcon():getCount()
	slot4.enableAutoSizing = true
	slot4.gameObject:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = false
	slot4.fontSizeMax = 48
	slot4.fontSizeMin = 30
	slot4.transform.anchorMax = Vector2(0.5, 0.5)
	slot4.transform.anchorMin = Vector2(0.5, 0.5)
	slot4.transform.pivot = Vector2(0.5, 0.5)
	slot4.alignment = TMPro.TextAlignmentOptions.Center

	recthelper.setWidth(slot4.transform, 170)
	recthelper.setHeight(slot4.transform, 70)
	slot1:SetCountLocalY(-50)
	slot1:setCountText(ItemModel.instance:getItemIsEnoughText(slot2))
	slot1:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, slot0)
	slot1:setRecordFarmItem({
		type = slot2.materilType,
		id = slot2.materilId,
		quantity = slot2.quantity
	})
end

function slot0._onRefreshConsumeCurrencyItems(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0:_refreshConsumeCurrencyItem(slot5, slot6)
		end
	end

	for slot5 = 1, #slot0._consumeCurrencyItems do
		gohelper.setActive(slot0._consumeCurrencyItems[slot5].go, slot1 and slot5 <= #slot1)
	end
end

function slot0._refreshConsumeCurrencyItem(slot0, slot1, slot2)
	slot3 = slot0:_getConsumeCurrencyItem(slot1)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot3.icon, ItemModel.instance:getItemConfig(slot2.materilType, slot2.materilId).icon .. "_1")

	slot3.consumeBtn = SLFramework.UGUI.UIClickListener.Get(slot3.icon.gameObject)

	slot3.consumeBtn:AddClickListener(function ()
		MaterialTipController.instance:showMaterialInfo(uv0.materilType, uv0.materilId)
	end, slot0)

	slot6 = slot0._itemConsumeList[slot2.materilType] and slot0._itemConsumeList[slot2.materilType][slot2.materilId] or ItemModel.instance:getItemQuantity(slot2.materilType, slot2.materilId)
	slot3.txt.text = string.format(slot2.quantity <= slot6 and "%s/%s" or "<color=#cd5353>%s</color>/%s", GameUtil.numberDisplay(slot6), GameUtil.numberDisplay(slot2.quantity))
end

function slot0._refreshLevelUpConsume(slot0, slot1)
	slot3 = CharacterDestinyConfig.instance:getNextDestinySlotCo(slot0._heroMO.destinyStoneMo.heroId, slot0._heroMO.destinyStoneMo.rank, slot1)

	if CharacterDestinyConfig.instance:getNextDestinySlotCo(slot0._heroMO.destinyStoneMo.heroId, slot0._heroMO.destinyStoneMo.rank, slot1 - 1) and ItemModel.instance:getItemDataListByConfigStr(slot2.consume) then
		for slot8, slot9 in ipairs(slot4) do
			slot11 = slot9.materilId
			slot12 = slot9.quantity

			if not slot0._itemConsumeList[slot9.materilType] then
				slot0._itemConsumeList[slot10] = {}
			end

			slot0._itemConsumeList[slot10][slot11] = (slot0._itemConsumeList[slot10][slot11] or ItemModel.instance:getItemQuantity(slot10, slot11)) - slot12
		end
	end

	if slot3 then
		slot0:_onRefreshConsumeCurrencyItems(ItemModel.instance:getItemDataListByConfigStr(slot3.consume))
	end
end

function slot0._getConsumeCurrencyItem(slot0, slot1)
	if not slot0._consumeCurrencyItems[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._txtcurrency.gameObject)
		slot2 = slot0:getUserDataTb_()
		slot2.go = slot3
		slot2.txt = slot3:GetComponent(gohelper.Type_TextMesh)
		slot2.icon = gohelper.findChildImage(slot3, "#image_currency")
		slot0._consumeCurrencyItems[slot1] = slot2
	end

	return slot2
end

function slot0._refreshBtnLevel(slot0, slot1)
	slot0._txtlv.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("character_destiny_slot_level"), math.min(slot0._maxRankLevel, slot1), slot0._maxRankLevel)
end

function slot0.onClose(slot0)
	slot0.isClose = true
end

function slot0.onDestroyView(slot0)
	if slot0._consumeCurrencyItems then
		for slot4, slot5 in ipairs(slot0._consumeCurrencyItems) do
			if slot5.consumeBtn then
				slot5.consumeBtn:RemoveClickListener()
			end
		end
	end

	slot0:_removeEvents()
	slot0._simagestone:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._tick, slot0)
	TaskDispatcher.cancelTask(slot0._refreshAttrPanel, slot0)

	if slot0._slotmats then
		for slot4, slot5 in ipairs(slot0._slotmats) do
			if slot5._tweenId then
				ZProj.TweenHelper.KillById(slot5._tweenId, false)

				slot5._tweenId = nil
			end
		end
	end
end

return slot0
