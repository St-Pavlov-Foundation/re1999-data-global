module("modules.logic.character.view.destiny.CharacterDestinySlotView", package.seeall)

local var_0_0 = class("CharacterDestinySlotView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "#go_main")
	arg_1_0._scrollattr = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_main/left/#scroll_attr")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_main/left/#scroll_attr/Viewport/Content/#go_attritem")
	arg_1_0._goslot = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot")
	arg_1_0._goslotItem = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_slotItem")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_lock")
	arg_1_0._gopreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_lock/#btn_preview")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_empty")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_empty/#btn_add")
	arg_1_0._gostone = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone")
	arg_1_0._txtstonename = gohelper.findChildText(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#txt_stonename")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#image_icon")
	arg_1_0._simagestone = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_stone")
	arg_1_0._gostonebtnicon = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/icon")
	arg_1_0._simagestonedec = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_stonedec")
	arg_1_0._btnstone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/middle/#go_slot/#go_unlock/#btn_stone")
	arg_1_0._goconsumeitem = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_consumeitem")
	arg_1_0._gocurrency = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_currency")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_currency/#txt_currency")
	arg_1_0._imagecurrency = gohelper.findChildImage(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_currency/#txt_currency/#image_currency")
	arg_1_0._gounlockbtn = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_unlockbtn")
	arg_1_0._btnunlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_unlockbtn/#btn_unlock", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	arg_1_0._gouplv = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv")
	arg_1_0._btnuplv = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv/#btn_uplv", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv/#btn_uplv/#txt_lv")
	arg_1_0._gouprank = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_uprank")
	arg_1_0._btnuprank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_uprank/#btn_uprank", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/#go_max")
	arg_1_0._gocaneasycombinetip = gohelper.findChild(arg_1_0.viewGO, "#go_main/middle/#go_slot/btn/txt_onceCombine")
	arg_1_0._scrolleffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_main/right/#scroll_effect")
	arg_1_0._gostoneeffectitem = gohelper.findChild(arg_1_0.viewGO, "#go_main/right/#scroll_effect/Viewport/Content/#go_stoneeffectitem")
	arg_1_0._gostoneempty = gohelper.findChild(arg_1_0.viewGO, "#go_main/right/#go_stoneempty")
	arg_1_0._gostonelock = gohelper.findChild(arg_1_0.viewGO, "#go_main/right/#go_stonelock")
	arg_1_0._gounlockanim = gohelper.findChild(arg_1_0.viewGO, "#go_unlockanim")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnstone:AddClickListener(arg_2_0._btnstoneOnClick, arg_2_0)
	arg_2_0._btnunlock:AddClickListener(arg_2_0._btnunlockOnClick, arg_2_0)
	arg_2_0._btnuplv:AddClickListener(arg_2_0._btnuplvOnClick, arg_2_0)
	arg_2_0._btnuprank:AddClickListener(arg_2_0._btnuprankOnClick, arg_2_0)
	arg_2_0._gopreview:AddClickListener(arg_2_0._btnpreviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnstone:RemoveClickListener()
	arg_3_0._btnunlock:RemoveClickListener()
	arg_3_0._btnuplv:RemoveClickListener()
	arg_3_0._btnuprank:RemoveClickListener()
	arg_3_0._gopreview:RemoveClickListener()
end

function var_0_0._btnaddOnClick(arg_4_0)
	return
end

function var_0_0._btnuplvOnClick(arg_5_0)
	return
end

function var_0_0._btnpreviewOnClick(arg_6_0)
	arg_6_0:_openCharacterDestinyStoneView()
end

var_0_0.UI_CLICK_BLOCK_KEY = "CharacterDestinySlotView_Click"

function var_0_0._btnuprankOnClick(arg_7_0)
	if arg_7_0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	local var_7_0, var_7_1, var_7_2 = arg_7_0:isHasEnoughCurrenctLevelUp()

	if not var_7_0 then
		if arg_7_0._canEasyCombine then
			PopupCacheModel.instance:setViewIgnoreGetPropView(arg_7_0.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
			RoomProductionHelper.openRoomFormulaMsgBoxView(arg_7_0._easyCombineTable, arg_7_0._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, arg_7_0._onRankUpEasyCombineFinished, arg_7_0)
		else
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_7_1, var_7_2)
		end

		return
	end

	arg_7_0._isPlayingRankUpAnim = true

	arg_7_0._anim:Play(CharacterDestinyEnum.SlotViewAnim.LevelUp, 0, 0)
	CharacterDestinyController.instance:onRankUp(arg_7_0._heroMO.heroId)

	local var_7_3 = arg_7_0._slotmats[arg_7_0._heroMO.destinyStoneMo.rank + 1]

	if var_7_3 then
		gohelper.setActive(var_7_3.golevelup, true)
	end

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_leimi_smalluncharted_refresh)
	gohelper.setActive(arg_7_0._goempty, false)
	UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._onRankUpEasyCombineFinished(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	PopupCacheModel.instance:setViewIgnoreGetPropView(arg_8_0.viewName, false)

	if arg_8_2 ~= 0 then
		return
	end

	arg_8_0:_btnuprankOnClick()
end

function var_0_0._btnstoneOnClick(arg_9_0)
	arg_9_0:_openCharacterDestinyStoneView()
end

function var_0_0._btnunlockOnClick(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = arg_10_0:isHasEnoughCurrenctLevelUp()

	if not var_10_0 then
		if arg_10_0._canEasyCombine then
			PopupCacheModel.instance:setViewIgnoreGetPropView(arg_10_0.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
			RoomProductionHelper.openRoomFormulaMsgBoxView(arg_10_0._easyCombineTable, arg_10_0._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, arg_10_0._onUnlockEasyCombineFinished, arg_10_0)
		else
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_10_1, var_10_2)
		end

		return
	end

	arg_10_0._isPlayingUnlockAnim = true

	arg_10_0._anim:Play(CharacterDestinyEnum.SlotViewAnim.Unlock, 0, 0)
	CharacterDestinyController.instance:onRankUp(arg_10_0._heroMO.heroId)
	gohelper.setActive(arg_10_0._gotopleft, false)
	gohelper.setActive(arg_10_0._goempty, false)
	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_unlock)
	UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._onUnlockEasyCombineFinished(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	PopupCacheModel.instance:setViewIgnoreGetPropView(arg_11_0.viewName, false)

	if arg_11_2 ~= 0 then
		return
	end

	arg_11_0:_btnunlockOnClick()
end

local var_0_1 = 0.5
local var_0_2 = 0.1

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._btnUpLvlongPress = SLFramework.UGUI.UILongPressListener.Get(arg_12_0._btnuplv.gameObject)

	arg_12_0._btnUpLvlongPress:SetLongPressTime({
		var_0_1,
		var_0_2
	})
	arg_12_0._btnUpLvlongPress:AddLongPressListener(arg_12_0._upLvLongPress, arg_12_0)

	arg_12_0._btnuplevel = SLFramework.UGUI.UIClickListener.Get(arg_12_0._btnuplv.gameObject)

	arg_12_0._btnuplevel:AddClickUpListener(arg_12_0._onClickLevelUpBtnUp, arg_12_0)
	arg_12_0._btnuplevel:AddClickDownListener(arg_12_0._onClickLevelUpBtnDown, arg_12_0)

	arg_12_0._consumeCurrencyItems = arg_12_0:getUserDataTb_()
	arg_12_0._consumeCurrencyItems[1] = {
		go = arg_12_0._txtcurrency.gameObject,
		txt = arg_12_0._txtcurrency,
		icon = arg_12_0._imagecurrency
	}
	arg_12_0._txttitle = gohelper.findChildText(arg_12_0.viewGO, "#go_main/middle/#go_slot/title/txt_title")
	arg_12_0._anim = arg_12_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._animEvent = arg_12_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_12_0._slotmats = arg_12_0:getUserDataTb_()

	for iter_12_0 = 1, CharacterDestinyEnum.EffectItemCount do
		local var_12_0 = gohelper.findChild(arg_12_0._goslot, "mesh0" .. iter_12_0)
		local var_12_1 = gohelper.findChild(var_12_0, "ms"):GetComponent(typeof(UIMesh))
		local var_12_2 = gohelper.findChild(var_12_0, "#leveup")
		local var_12_3 = var_12_0:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		local var_12_4 = {
			mpc = var_12_3,
			ms = var_12_1,
			golevelup = var_12_2
		}

		table.insert(arg_12_0._slotmats, var_12_4)
	end

	arg_12_0._gyroOffsetID = UnityEngine.Shader.PropertyToID("_GyroOffset")
	arg_12_0._gyroOffset = Vector4.New(0, 0, 0)

	TaskDispatcher.runRepeat(arg_12_0._tick, arg_12_0, 0)
end

function var_0_0._tick(arg_13_0)
	local var_13_0, var_13_1, var_13_2 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	arg_13_0._gyroOffset.x, arg_13_0._gyroOffset.y = (arg_13_0._gyroOffset.x + var_13_0) * 0.5, (arg_13_0._gyroOffset.y + var_13_1) * 0.5

	UnityEngine.Shader.SetGlobalVector(arg_13_0._gyroOffsetID, arg_13_0._gyroOffset)
end

function var_0_0._upLvLongPress(arg_14_0)
	if not arg_14_0._canLongPress then
		return
	end

	local var_14_0 = arg_14_0._heroMO.destinyStoneMo

	if var_14_0:isSlotMaxLevel() then
		arg_14_0:_onClickLevelUpBtnUp()

		return
	end

	local var_14_1 = var_14_0.level

	if arg_14_0._addLevel then
		var_14_1 = var_14_0.level + arg_14_0._addLevel

		if not arg_14_0:isHasEnoughCurrenctLevelUp(true, var_14_0.rank, var_14_1 - 1) then
			arg_14_0._addLevel = arg_14_0._addLevel - 1

			arg_14_0:_onClickLevelUpBtnUp()

			return
		end

		if var_14_1 < arg_14_0._maxRankLevel then
			arg_14_0._addLevel = arg_14_0._addLevel + 1

			arg_14_0:_refreshLevelUpConsume(var_14_1)
		else
			arg_14_0:_onClickLevelUpBtnUp()
		end
	else
		var_14_1 = var_14_0.level + 2
		arg_14_0._addLevel = 2
	end

	arg_14_0:_refreshLevelUp(var_14_0.rank, var_14_1)
end

function var_0_0._onClickLevelUpBtnDown(arg_15_0)
	if arg_15_0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	if not arg_15_0:isHasEnoughCurrenctLevelUp(true) then
		return
	end

	arg_15_0._addLevel = 1
	arg_15_0._canLongPress = true
end

function var_0_0._onClickLevelUpBtnUp(arg_16_0)
	if not arg_16_0._canLongPress then
		return
	end

	arg_16_0._canLongPress = nil

	local var_16_0 = arg_16_0._heroMO.destinyStoneMo

	if var_16_0:isSlotMaxLevel() then
		return
	end

	if arg_16_0._addLevel then
		local var_16_1 = math.min(var_16_0.level + arg_16_0._addLevel, arg_16_0._maxRankLevel)

		if var_16_0.level + arg_16_0._addLevel <= arg_16_0._maxRankLevel then
			CharacterDestinyController.instance:onLevelUp(arg_16_0._heroMO.heroId, var_16_1)
			arg_16_0:_refreshLevelUp(var_16_0.rank, var_16_1)
		else
			arg_16_0:_refreshBtn(var_16_1)
		end
	end

	arg_16_0._addLevel = nil
end

function var_0_0._refreshLevelUp(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:_playAttrItemLevelUp(arg_17_1, arg_17_2 - 1)
	TaskDispatcher.runDelay(function()
		arg_17_0:_refreshAttrPanel(arg_17_1, arg_17_2)
	end, arg_17_0, 0.5)
	arg_17_0:_refreshBtnLevel(arg_17_2)

	if arg_17_2 < arg_17_0._heroMO.destinyStoneMo.maxLevel[arg_17_1] then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_charged)
	else
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_full)
	end
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0._addEvents(arg_20_0)
	arg_20_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, arg_20_0._OnRankUpReply, arg_20_0)
	arg_20_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnLevelUpReply, arg_20_0._onLevelUpReply, arg_20_0)
	arg_20_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_20_0._onUseStoneReply, arg_20_0)
	arg_20_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_20_0._refreshCurrency, arg_20_0)
	arg_20_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_20_0._refreshCurrency, arg_20_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_20_0._onCloseViewFinish, arg_20_0)
	arg_20_0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.RefreshView, arg_20_0._refreshDataCB, arg_20_0)
	arg_20_0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.UnlockEnd, arg_20_0._unlockEndCB, arg_20_0)
	arg_20_0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.LevelUpEnd, arg_20_0._rankUpEndCB, arg_20_0)
	arg_20_0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.UnlockAttrAnim, arg_20_0._unlockAttrAnim, arg_20_0)
end

function var_0_0._removeEvents(arg_21_0)
	arg_21_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, arg_21_0._OnRankUpReply, arg_21_0)
	arg_21_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnLevelUpReply, arg_21_0._onLevelUpReply, arg_21_0)
	arg_21_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_21_0._onUseStoneReply, arg_21_0)
	arg_21_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_21_0._refreshCurrency, arg_21_0)
	arg_21_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_21_0._refreshCurrency, arg_21_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_21_0._onCloseViewFinish, arg_21_0)

	if arg_21_0._btnUpLvlongPress then
		arg_21_0._btnUpLvlongPress:RemoveLongPressListener()
	end

	if arg_21_0._btnuplevel then
		arg_21_0._btnuplevel:RemoveClickUpListener()
		arg_21_0._btnuplevel:RemoveClickDownListener()
	end

	arg_21_0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.RefreshView)
	arg_21_0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.UnlockEnd)
	arg_21_0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.LevelUpEnd)
	arg_21_0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.UnlockAttrAnim)
end

function var_0_0._onLevelUpReply(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:_refreshView()

	if arg_22_0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_molu_sky_open)
	end
end

function var_0_0._playItemLevelUp(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:_getAttrItemByAtttrId(arg_23_1)

	if var_23_0 then
		var_23_0:playLevelUpAnim()
	end
end

function var_0_0._playAttrItemLevelUp(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0, var_24_1, var_24_2 = CharacterDestinyModel.instance:getCurSlotAttrInfos(arg_24_0._heroMO.heroId, arg_24_1, arg_24_2)
	local var_24_3 = 0

	if var_24_0 then
		for iter_24_0, iter_24_1 in ipairs(var_24_0) do
			if iter_24_1.nextNum then
				arg_24_0:_playItemLevelUp(iter_24_1.attrId)

				var_24_3 = var_24_3 + 1
			end
		end
	end

	if var_24_1 then
		for iter_24_2, iter_24_3 in ipairs(var_24_1) do
			if iter_24_3.nextNum then
				arg_24_0:_playItemLevelUp(iter_24_3.attrId)

				var_24_3 = var_24_3 + 1
			end
		end
	end

	local var_24_4 = arg_24_3 and var_24_2[1] or var_24_2[arg_24_1]

	if var_24_4 then
		for iter_24_4, iter_24_5 in ipairs(var_24_4) do
			arg_24_0:_playItemLevelUp(iter_24_5.attrId)

			var_24_3 = var_24_3 + 1
		end
	end

	if var_24_3 > 0 then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_inking_preference_open)
	end
end

function var_0_0._onUseStoneReply(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:_refreshView()
	arg_25_0:_refreshEmpty()
end

function var_0_0._onCloseViewFinish(arg_26_0, arg_26_1)
	if arg_26_1 == ViewName.CharacterDestinyStoneView then
		arg_26_0:_playerOpenAnim()
	end
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0:_addEvents()

	arg_27_0._heroMO = arg_27_0.viewParam.heroMo
	arg_27_0._isPlayingUnlockAnim = false

	local var_27_0 = arg_27_0._heroMO.destinyStoneMo

	arg_27_0._maxRankLevel = var_27_0:getRankLevelCount()

	if not arg_27_0._itemConsumeList then
		arg_27_0._itemConsumeList = {}
	end

	local var_27_1 = CharacterDestinyEnum.SlotTitle[arg_27_0._heroMO.config.heroType] or CharacterDestinyEnum.SlotTitle[1]

	arg_27_0._txttitle.text = luaLang(var_27_1)

	if arg_27_0.viewParam.isBack then
		local var_27_2 = arg_27_0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock

		arg_27_0._anim:Play(var_27_2, 0, 1)
	else
		arg_27_0:_playerOpenAnim()
	end

	arg_27_0:_refreshView(true)
	arg_27_0:_refreshAttrPanel()
	arg_27_0:_refreshEmpty()
	arg_27_0.viewContainer:setCurDestinySlot(var_27_0)
	arg_27_0:_refreshTrial()
end

function var_0_0._refreshTrial(arg_28_0)
	local var_28_0 = arg_28_0._heroMO:isTrial()

	gohelper.setActive(arg_28_0._gostonebtnicon.gameObject, not var_28_0)
	gohelper.setActive(arg_28_0._btnstone.gameObject, not var_28_0)
end

function var_0_0._playerOpenAnim(arg_29_0)
	local var_29_0 = arg_29_0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.OpenUnlock or CharacterDestinyEnum.SlotViewAnim.OpenLock

	arg_29_0._anim:Play(var_29_0, 0, 0)
end

function var_0_0._refreshView(arg_30_0, arg_30_1)
	arg_30_0:_refreshBtn()
	arg_30_0:_refreshSlot(arg_30_1)
end

function var_0_0._refreshCurrency(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0._itemConsumeList) do
		for iter_31_2, iter_31_3 in pairs(iter_31_1) do
			arg_31_0._itemConsumeList[iter_31_0][iter_31_2] = ItemModel.instance:getItemQuantity(iter_31_0, iter_31_2)
		end
	end

	arg_31_0:_refreshBtn()
end

function var_0_0._playIdleAnim(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1 and CharacterDestinyEnum.SlotViewAnim.UnlockIdle or CharacterDestinyEnum.SlotViewAnim.LockIdle

	arg_32_0._anim:Play(var_32_0, 0, 1)
end

function var_0_0._OnRankUpReply(arg_33_0)
	arg_33_0._maxRankLevel = arg_33_0._heroMO.destinyStoneMo:getRankLevelCount()
end

function var_0_0._rankUpEndCB(arg_34_0)
	arg_34_0._isPlayingRankUpAnim = false

	local var_34_0 = arg_34_0._heroMO.destinyStoneMo
	local var_34_1 = var_34_0.rank
	local var_34_2 = var_34_0.maxLevel[var_34_1 - 1]

	arg_34_0:_playAttrItemLevelUp(var_34_1 - 1, var_34_2)
	TaskDispatcher.runDelay(arg_34_0._refreshAttrPanel, arg_34_0, 0.5)
	arg_34_0:_refreshBtnLevel(var_34_0.level)
	gohelper.setActive(arg_34_0._goempty, var_34_0.curUseStoneId == 0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._unlockEndCB(arg_35_0)
	arg_35_0._isPlayingUnlockAnim = false

	arg_35_0:_playIdleAnim(true)
	gohelper.setActive(arg_35_0._goempty, true)
	gohelper.setActive(arg_35_0._gotopleft, true)
	CharacterDestinyController.instance:dispatchEvent(CharacterDestinyEvent.OnUnlockSlot)
end

function var_0_0._refreshDataCB(arg_36_0)
	arg_36_0:_refreshView(true)
	arg_36_0:_refreshAttrPanel()
end

function var_0_0._unlockAttrAnim(arg_37_0)
	arg_37_0:_playAttrItemLevelUp(0, 1, true)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._refreshAttrPanel(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.isClose then
		return
	end

	local var_38_0 = arg_38_1 or arg_38_0._heroMO.destinyStoneMo.rank
	local var_38_1 = arg_38_2 or arg_38_0._heroMO.destinyStoneMo.level
	local var_38_2, var_38_3, var_38_4 = CharacterDestinyModel.instance:getCurSlotAttrInfos(arg_38_0._heroMO.heroId, var_38_0, var_38_1)

	if not arg_38_0._attrItems then
		arg_38_0._attrItems = arg_38_0:getUserDataTb_()
	end

	local var_38_5 = 1

	if var_38_2 then
		for iter_38_0, iter_38_1 in ipairs(var_38_2) do
			arg_38_0:_getAttrItem(var_38_5):onUpdateBaseAttrMO(var_38_5, iter_38_1)

			var_38_5 = var_38_5 + 1
		end
	end

	if var_38_3 then
		for iter_38_2, iter_38_3 in ipairs(var_38_3) do
			arg_38_0:_getAttrItem(var_38_5):onUpdateSpecailAttrMO(var_38_5, iter_38_3, iter_38_2 == 1, #var_38_3)

			var_38_5 = var_38_5 + 1
		end
	end

	if var_38_4 then
		for iter_38_4, iter_38_5 in pairs(var_38_4) do
			arg_38_0:_getAttrItem(var_38_5):onUpdateLockSpecialAttrMO(var_38_5, iter_38_4, iter_38_5)

			var_38_5 = var_38_5 + 1
		end
	end

	if arg_38_0._attrItems then
		for iter_38_6 = 1, #arg_38_0._attrItems do
			local var_38_6 = arg_38_0._attrItems[iter_38_6]

			gohelper.setActive(var_38_6.viewGO, iter_38_6 < var_38_5)
		end
	end
end

function var_0_0._getAttrItem(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0._attrItems[arg_39_1]

	if not var_39_0 then
		var_39_0 = arg_39_0:getUserDataTb_()

		local var_39_1 = gohelper.cloneInPlace(arg_39_0._goattritem, "attritem_" .. arg_39_1)

		var_39_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_39_1, CharacterDestinySlotAttrItem)
		arg_39_0._attrItems[arg_39_1] = var_39_0
	end

	return var_39_0
end

function var_0_0._getAttrItemByAtttrId(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0._attrItems) do
		if iter_40_1.attrId == arg_40_1 then
			return iter_40_1
		end
	end
end

function var_0_0._refreshSlot(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0._heroMO.destinyStoneMo
	local var_41_1 = var_41_0:isUnlockSlot()
	local var_41_2 = var_41_0.curUseStoneId ~= 0
	local var_41_3 = Color.white

	if var_41_2 then
		local var_41_4, var_41_5, var_41_6 = var_41_0:getCurStoneNameAndIcon()

		arg_41_0._txtstonename.text = var_41_4

		arg_41_0._simagestone:LoadImage(var_41_5)

		local var_41_7 = CharacterDestinyEnum.SlotTend[var_41_6.tend]
		local var_41_8 = var_41_7.TitleIconName

		UISpriteSetMgr.instance:setUiCharacterSprite(arg_41_0._imageicon, var_41_8)

		arg_41_0._txtstonename.color = GameUtil.parseColor(var_41_7.TitleColor)

		if not arg_41_0._stoneEffectItem then
			arg_41_0._stoneEffectItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_41_0._gostoneeffectitem, CharacterDestinyStoneEffectItem)
		end

		var_41_3 = var_41_7.RuneColor

		arg_41_0._stoneEffectItem:onUpdateMo(var_41_0)
	end

	for iter_41_0, iter_41_1 in ipairs(arg_41_0._slotmats) do
		local var_41_9 = iter_41_1.mpc

		if var_41_9.color_01 ~= var_41_3 then
			var_41_9.color_01 = var_41_3

			var_41_9:SetProps()
		end
	end

	arg_41_0:_setSlotLevel(arg_41_1)
	gohelper.setActive(arg_41_0._txttitle.gameObject, not var_41_2)
	gohelper.setActive(arg_41_0._golock, not var_41_1)
	gohelper.setActive(arg_41_0._gounlock, var_41_1)
	gohelper.setActive(arg_41_0._gostone, var_41_2)
	gohelper.setActive(arg_41_0._scrolleffect.gameObject, var_41_1 and var_41_2)
	gohelper.setActive(arg_41_0._gostoneempty.gameObject, var_41_1 and not var_41_2)
	gohelper.setActive(arg_41_0._gostonelock.gameObject, not var_41_1)
end

function var_0_0._refreshEmpty(arg_42_0)
	local var_42_0 = arg_42_0._heroMO.destinyStoneMo.curUseStoneId ~= 0

	gohelper.setActive(arg_42_0._goempty, not var_42_0)
end

function var_0_0._setSlotLevel(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0._heroMO.destinyStoneMo
	local var_43_1 = var_43_0.rank
	local var_43_2 = var_43_0.level - 1

	for iter_43_0 = 1, var_43_0.maxRank do
		local var_43_3 = 0.65
		local var_43_4 = 1

		if iter_43_0 < var_43_1 then
			var_43_4 = 0
		elseif var_43_1 < iter_43_0 then
			var_43_4 = 1
			var_43_3 = 0.3
		else
			local var_43_5 = var_43_0:getRankLevelCount() - 1

			var_43_4 = var_43_5 ~= 0 and 1 - var_43_2 / var_43_5 or 0
		end

		local var_43_6 = arg_43_0._slotmats[iter_43_0]
		local var_43_7 = var_43_6.ms.color

		var_43_7.a = var_43_3
		var_43_6.ms.color = var_43_7

		local var_43_8 = var_43_6.mpc
		local var_43_9 = var_43_8.vector_01
		local var_43_10 = var_43_8.vector_02

		if var_43_6._tweenId then
			ZProj.TweenHelper.KillById(var_43_6._tweenId, false)

			var_43_6._tweenId = nil
		end

		local var_43_11 = {
			mpc = var_43_8,
			vector1 = var_43_9,
			vector2 = var_43_10
		}

		if not arg_43_1 then
			if var_43_4 < var_43_10.x then
				var_43_6._tweenId = ZProj.TweenHelper.DOTweenFloat(var_43_10.x, var_43_4, 0.5, arg_43_0._progressMat, nil, arg_43_0, var_43_11)
			end
		else
			arg_43_0:_progressMat(var_43_4, var_43_11)
		end
	end
end

function var_0_0._openCharacterDestinyStoneView(arg_44_0)
	if arg_44_0._isPlayingUnlockAnim then
		return
	end

	local var_44_0 = arg_44_0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock

	arg_44_0._anim:Play(var_44_0, 0, 0)
	CharacterDestinyController.instance:openCharacterDestinyStoneView(arg_44_0._heroMO)
end

function var_0_0._progressMat(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_2.mpc

	var_45_0.vector_01 = Vector4.New(arg_45_2.vector1.x, arg_45_2.vector1.y, arg_45_2.vector1.z, -0.5 + arg_45_1)
	var_45_0.vector_02 = Vector4.New(arg_45_1, arg_45_2.vector2.y, arg_45_2.vector2.z, arg_45_2.vector2.w)

	var_45_0:SetProps()
end

function var_0_0.isHasEnoughCurrenctLevelUp(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = arg_46_0._heroMO.destinyStoneMo

	arg_46_2 = arg_46_2 or var_46_0.rank
	arg_46_3 = arg_46_3 or var_46_0.level

	local var_46_1 = CharacterDestinyConfig.instance:getNextDestinySlotCo(var_46_0.heroId, arg_46_2, arg_46_3)

	if not var_46_1 then
		return
	end

	local var_46_2 = GameUtil.splitString2(var_46_1.consume, true)
	local var_46_3
	local var_46_4

	if var_46_2 then
		for iter_46_0, iter_46_1 in ipairs(var_46_2) do
			local var_46_5 = iter_46_1[1]
			local var_46_6 = iter_46_1[2]
			local var_46_7 = iter_46_1[3]
			local var_46_8 = arg_46_0._itemConsumeList[var_46_5]

			if not var_46_8 then
				var_46_8 = {}
				arg_46_0._itemConsumeList[var_46_5] = var_46_8
			end

			if not var_46_8[var_46_6] then
				var_46_8[var_46_6] = ItemModel.instance:getItemQuantity(var_46_5, var_46_6)
			end

			if var_46_7 > arg_46_0._itemConsumeList[var_46_5][var_46_6] then
				var_46_3, var_46_4 = ItemModel.instance:getItemConfigAndIcon(var_46_5, var_46_6)

				break
			end
		end
	end

	if var_46_3 then
		if arg_46_1 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_46_4, var_46_3.name)
		end

		return false, var_46_4, var_46_3.name
	end

	return true
end

function var_0_0._refreshBtn(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0._heroMO.destinyStoneMo
	local var_47_1 = var_47_0:isUnlockSlot()
	local var_47_2 = var_47_1 and var_47_0:isSlotMaxLevel()
	local var_47_3 = var_47_1 and not var_47_2 and var_47_0:isCanUpSlotRank()
	local var_47_4 = var_47_1 and not var_47_2 and not var_47_0:isCanUpSlotRank()
	local var_47_5 = not var_47_1 or var_47_3
	local var_47_6 = arg_47_0._heroMO:isTrial()

	gohelper.setActive(arg_47_0._gounlockbtn, not var_47_6 and not var_47_1)
	gohelper.setActive(arg_47_0._gouplv, not var_47_6 and var_47_4)
	gohelper.setActive(arg_47_0._gouprank, not var_47_6 and var_47_3)
	gohelper.setActive(arg_47_0._gomax, var_47_1 and var_47_2)
	gohelper.setActive(arg_47_0._goconsumeitem, not var_47_6 and var_47_5)
	gohelper.setActive(arg_47_0._gocurrency, not var_47_6 and var_47_4)

	arg_47_1 = arg_47_1 or var_47_0.level
	arg_47_0._canEasyCombine = false

	local var_47_7 = CharacterDestinyConfig.instance:getNextDestinySlotCo(var_47_0.heroId, var_47_0.rank, arg_47_1)

	if var_47_7 then
		local var_47_8 = ItemModel.instance:getItemDataListByConfigStr(var_47_7.consume)

		if var_47_5 then
			arg_47_0._lackedItemDataList = {}
			arg_47_0._occupyItemDic = {}

			IconMgr.instance:getCommonPropItemIconList(arg_47_0, arg_47_0._onConsumeItemCB, var_47_8, arg_47_0._goconsumeitem)

			arg_47_0._canEasyCombine, arg_47_0._easyCombineTable = RoomProductionHelper.canEasyCombineItems(arg_47_0._lackedItemDataList, arg_47_0._occupyItemDic)
			arg_47_0._occupyItemDic = nil
		end

		if var_47_4 then
			arg_47_0:_onRefreshConsumeCurrencyItems(var_47_8)
		end
	end

	gohelper.setActive(arg_47_0._gocaneasycombinetip, arg_47_0._canEasyCombine)
	arg_47_0:_refreshBtnLevel(var_47_0.level)
end

function var_0_0._onConsumeItemCB(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	transformhelper.setLocalScale(arg_48_1.viewGO.transform, 0.6, 0.6, 1)
	arg_48_1:onUpdateMO(arg_48_2)
	arg_48_1:setConsume(true)
	arg_48_1:showStackableNum2()
	arg_48_1:isShowEffect(true)
	arg_48_1:setAutoPlay(true)
	arg_48_1:setCountFontSize(48)

	local var_48_0 = arg_48_1:getItemIcon():getCount()
	local var_48_1 = 170
	local var_48_2 = var_48_0.gameObject:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	var_48_0.enableAutoSizing = true
	var_48_2.enabled = false
	var_48_0.fontSizeMax = 48
	var_48_0.fontSizeMin = 30
	var_48_0.transform.anchorMax = Vector2(0.5, 0.5)
	var_48_0.transform.anchorMin = Vector2(0.5, 0.5)
	var_48_0.transform.pivot = Vector2(0.5, 0.5)
	var_48_0.alignment = TMPro.TextAlignmentOptions.Center

	recthelper.setWidth(var_48_0.transform, var_48_1)
	recthelper.setHeight(var_48_0.transform, 70)
	arg_48_1:SetCountLocalY(-50)

	local var_48_3 = arg_48_2.materilType
	local var_48_4 = arg_48_2.materilId
	local var_48_5 = arg_48_2.quantity
	local var_48_6, var_48_7 = ItemModel.instance:getItemIsEnoughText(arg_48_2)

	if var_48_7 then
		table.insert(arg_48_0._lackedItemDataList, {
			type = var_48_3,
			id = var_48_4,
			quantity = var_48_7
		})
	else
		if not arg_48_0._occupyItemDic[var_48_3] then
			arg_48_0._occupyItemDic[var_48_3] = {}
		end

		arg_48_0._occupyItemDic[var_48_3][var_48_4] = (arg_48_0._occupyItemDic[var_48_3][var_48_4] or 0) + var_48_5
	end

	arg_48_1:setCountText(var_48_6)
	arg_48_1:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_48_0)
	arg_48_1:setRecordFarmItem({
		type = var_48_3,
		id = var_48_4,
		quantity = var_48_5
	})
end

function var_0_0._onRefreshConsumeCurrencyItems(arg_49_0, arg_49_1)
	if arg_49_1 then
		for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
			arg_49_0:_refreshConsumeCurrencyItem(iter_49_0, iter_49_1)
		end
	end

	for iter_49_2 = 1, #arg_49_0._consumeCurrencyItems do
		gohelper.setActive(arg_49_0._consumeCurrencyItems[iter_49_2].go, arg_49_1 and iter_49_2 <= #arg_49_1)
	end
end

function var_0_0._refreshConsumeCurrencyItem(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_0:_getConsumeCurrencyItem(arg_50_1)
	local var_50_1 = ItemModel.instance:getItemConfig(arg_50_2.materilType, arg_50_2.materilId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(var_50_0.icon, var_50_1.icon .. "_1")

	var_50_0.consumeBtn = SLFramework.UGUI.UIClickListener.Get(var_50_0.icon.gameObject)

	var_50_0.consumeBtn:AddClickListener(function()
		MaterialTipController.instance:showMaterialInfo(arg_50_2.materilType, arg_50_2.materilId)
	end, arg_50_0)

	local var_50_2 = arg_50_0._itemConsumeList[arg_50_2.materilType] and arg_50_0._itemConsumeList[arg_50_2.materilType][arg_50_2.materilId] or ItemModel.instance:getItemQuantity(arg_50_2.materilType, arg_50_2.materilId)
	local var_50_3 = var_50_2 >= arg_50_2.quantity and "%s/%s" or "<color=#cd5353>%s</color>/%s"

	var_50_0.txt.text = string.format(var_50_3, GameUtil.numberDisplay(var_50_2), GameUtil.numberDisplay(arg_50_2.quantity))
end

function var_0_0._refreshLevelUpConsume(arg_52_0, arg_52_1)
	local var_52_0 = CharacterDestinyConfig.instance:getNextDestinySlotCo(arg_52_0._heroMO.destinyStoneMo.heroId, arg_52_0._heroMO.destinyStoneMo.rank, arg_52_1 - 1)
	local var_52_1 = CharacterDestinyConfig.instance:getNextDestinySlotCo(arg_52_0._heroMO.destinyStoneMo.heroId, arg_52_0._heroMO.destinyStoneMo.rank, arg_52_1)

	if var_52_0 then
		local var_52_2 = ItemModel.instance:getItemDataListByConfigStr(var_52_0.consume)

		if var_52_2 then
			for iter_52_0, iter_52_1 in ipairs(var_52_2) do
				local var_52_3 = iter_52_1.materilType
				local var_52_4 = iter_52_1.materilId
				local var_52_5 = iter_52_1.quantity

				if not arg_52_0._itemConsumeList[var_52_3] then
					arg_52_0._itemConsumeList[var_52_3] = {}
				end

				local var_52_6 = arg_52_0._itemConsumeList[var_52_3][var_52_4] or ItemModel.instance:getItemQuantity(var_52_3, var_52_4)

				arg_52_0._itemConsumeList[var_52_3][var_52_4] = var_52_6 - var_52_5
			end
		end
	end

	if var_52_1 then
		local var_52_7 = ItemModel.instance:getItemDataListByConfigStr(var_52_1.consume)

		arg_52_0:_onRefreshConsumeCurrencyItems(var_52_7)
	end
end

function var_0_0._getConsumeCurrencyItem(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0._consumeCurrencyItems[arg_53_1]

	if not var_53_0 then
		local var_53_1 = gohelper.cloneInPlace(arg_53_0._txtcurrency.gameObject)

		var_53_0 = arg_53_0:getUserDataTb_()
		var_53_0.go = var_53_1
		var_53_0.txt = var_53_1:GetComponent(gohelper.Type_TextMesh)
		var_53_0.icon = gohelper.findChildImage(var_53_1, "#image_currency")
		arg_53_0._consumeCurrencyItems[arg_53_1] = var_53_0
	end

	return var_53_0
end

function var_0_0._refreshBtnLevel(arg_54_0, arg_54_1)
	local var_54_0 = luaLang("character_destiny_slot_level")

	arg_54_1 = math.min(arg_54_0._maxRankLevel, arg_54_1)
	arg_54_0._txtlv.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_54_0, arg_54_1, arg_54_0._maxRankLevel)
end

function var_0_0.onClose(arg_55_0)
	arg_55_0.isClose = true
end

function var_0_0.onDestroyView(arg_56_0)
	if arg_56_0._consumeCurrencyItems then
		for iter_56_0, iter_56_1 in ipairs(arg_56_0._consumeCurrencyItems) do
			if iter_56_1.consumeBtn then
				iter_56_1.consumeBtn:RemoveClickListener()
			end
		end
	end

	arg_56_0:_removeEvents()
	arg_56_0._simagestone:UnLoadImage()
	TaskDispatcher.cancelTask(arg_56_0._tick, arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0._refreshAttrPanel, arg_56_0)

	if arg_56_0._slotmats then
		for iter_56_2, iter_56_3 in ipairs(arg_56_0._slotmats) do
			if iter_56_3._tweenId then
				ZProj.TweenHelper.KillById(iter_56_3._tweenId, false)

				iter_56_3._tweenId = nil
			end
		end
	end
end

return var_0_0
