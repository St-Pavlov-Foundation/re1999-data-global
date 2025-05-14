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

	if not arg_7_0:isHasEnoughCurrenctLevelUp(true) then
		return
	end

	arg_7_0._isPlayingRankUpAnim = true

	arg_7_0._anim:Play(CharacterDestinyEnum.SlotViewAnim.LevelUp, 0, 0)
	CharacterDestinyController.instance:onRankUp(arg_7_0._heroMO.heroId)

	local var_7_0 = arg_7_0._slotmats[arg_7_0._heroMO.destinyStoneMo.rank + 1]

	if var_7_0 then
		gohelper.setActive(var_7_0.golevelup, true)
	end

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_leimi_smalluncharted_refresh)
	gohelper.setActive(arg_7_0._goempty, false)
	UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._btnstoneOnClick(arg_8_0)
	arg_8_0:_openCharacterDestinyStoneView()
end

function var_0_0._btnunlockOnClick(arg_9_0)
	if not arg_9_0:isHasEnoughCurrenctLevelUp(true) then
		return
	end

	arg_9_0._isPlayingUnlockAnim = true

	arg_9_0._anim:Play(CharacterDestinyEnum.SlotViewAnim.Unlock, 0, 0)
	CharacterDestinyController.instance:onRankUp(arg_9_0._heroMO.heroId)
	gohelper.setActive(arg_9_0._gotopleft, false)
	gohelper.setActive(arg_9_0._goempty, false)
	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_unlock)
	UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

local var_0_1 = 0.5
local var_0_2 = 0.1

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._btnUpLvlongPress = SLFramework.UGUI.UILongPressListener.Get(arg_10_0._btnuplv.gameObject)

	arg_10_0._btnUpLvlongPress:SetLongPressTime({
		var_0_1,
		var_0_2
	})
	arg_10_0._btnUpLvlongPress:AddLongPressListener(arg_10_0._upLvLongPress, arg_10_0)

	arg_10_0._btnuplevel = SLFramework.UGUI.UIClickListener.Get(arg_10_0._btnuplv.gameObject)

	arg_10_0._btnuplevel:AddClickUpListener(arg_10_0._onClickLevelUpBtnUp, arg_10_0)
	arg_10_0._btnuplevel:AddClickDownListener(arg_10_0._onClickLevelUpBtnDown, arg_10_0)

	arg_10_0._consumeCurrencyItems = arg_10_0:getUserDataTb_()
	arg_10_0._consumeCurrencyItems[1] = {
		go = arg_10_0._txtcurrency.gameObject,
		txt = arg_10_0._txtcurrency,
		icon = arg_10_0._imagecurrency
	}
	arg_10_0._txttitle = gohelper.findChildText(arg_10_0.viewGO, "#go_main/middle/#go_slot/title/txt_title")
	arg_10_0._anim = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._animEvent = arg_10_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_10_0._slotmats = arg_10_0:getUserDataTb_()

	for iter_10_0 = 1, CharacterDestinyEnum.EffectItemCount do
		local var_10_0 = gohelper.findChild(arg_10_0._goslot, "mesh0" .. iter_10_0)
		local var_10_1 = gohelper.findChild(var_10_0, "ms"):GetComponent(typeof(UIMesh))
		local var_10_2 = gohelper.findChild(var_10_0, "#leveup")
		local var_10_3 = var_10_0:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		local var_10_4 = {
			mpc = var_10_3,
			ms = var_10_1,
			golevelup = var_10_2
		}

		table.insert(arg_10_0._slotmats, var_10_4)
	end

	arg_10_0._gyroOffsetID = UnityEngine.Shader.PropertyToID("_GyroOffset")
	arg_10_0._gyroOffset = Vector4.New(0, 0, 0)

	TaskDispatcher.runRepeat(arg_10_0._tick, arg_10_0, 0)
end

function var_0_0._tick(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	arg_11_0._gyroOffset.x, arg_11_0._gyroOffset.y = (arg_11_0._gyroOffset.x + var_11_0) * 0.5, (arg_11_0._gyroOffset.y + var_11_1) * 0.5

	UnityEngine.Shader.SetGlobalVector(arg_11_0._gyroOffsetID, arg_11_0._gyroOffset)
end

function var_0_0._upLvLongPress(arg_12_0)
	if not arg_12_0._canLongPress then
		return
	end

	local var_12_0 = arg_12_0._heroMO.destinyStoneMo

	if var_12_0:isSlotMaxLevel() then
		arg_12_0:_onClickLevelUpBtnUp()

		return
	end

	local var_12_1 = var_12_0.level

	if arg_12_0._addLevel then
		var_12_1 = var_12_0.level + arg_12_0._addLevel

		if not arg_12_0:isHasEnoughCurrenctLevelUp(true, var_12_0.rank, var_12_1 - 1) then
			arg_12_0._addLevel = arg_12_0._addLevel - 1

			arg_12_0:_onClickLevelUpBtnUp()

			return
		end

		if var_12_1 < arg_12_0._maxRankLevel then
			arg_12_0._addLevel = arg_12_0._addLevel + 1

			arg_12_0:_refreshLevelUpConsume(var_12_1)
		else
			arg_12_0:_onClickLevelUpBtnUp()
		end
	else
		var_12_1 = var_12_0.level + 2
		arg_12_0._addLevel = 2
	end

	arg_12_0:_refreshLevelUp(var_12_0.rank, var_12_1)
end

function var_0_0._onClickLevelUpBtnDown(arg_13_0)
	if arg_13_0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	if not arg_13_0:isHasEnoughCurrenctLevelUp(true) then
		return
	end

	arg_13_0._addLevel = 1
	arg_13_0._canLongPress = true
end

function var_0_0._onClickLevelUpBtnUp(arg_14_0)
	if not arg_14_0._canLongPress then
		return
	end

	arg_14_0._canLongPress = nil

	local var_14_0 = arg_14_0._heroMO.destinyStoneMo

	if var_14_0:isSlotMaxLevel() then
		return
	end

	if arg_14_0._addLevel then
		local var_14_1 = math.min(var_14_0.level + arg_14_0._addLevel, arg_14_0._maxRankLevel)

		if var_14_0.level + arg_14_0._addLevel <= arg_14_0._maxRankLevel then
			CharacterDestinyController.instance:onLevelUp(arg_14_0._heroMO.heroId, var_14_1)
			arg_14_0:_refreshLevelUp(var_14_0.rank, var_14_1)
		else
			arg_14_0:_refreshBtn(var_14_1)
		end
	end

	arg_14_0._addLevel = nil
end

function var_0_0._refreshLevelUp(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:_playAttrItemLevelUp(arg_15_1, arg_15_2 - 1)
	TaskDispatcher.runDelay(function()
		arg_15_0:_refreshAttrPanel(arg_15_1, arg_15_2)
	end, arg_15_0, 0.5)
	arg_15_0:_refreshBtnLevel(arg_15_2)

	if arg_15_2 < arg_15_0._heroMO.destinyStoneMo.maxLevel[arg_15_1] then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_charged)
	else
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_full)
	end
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0._addEvents(arg_18_0)
	arg_18_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, arg_18_0._OnRankUpReply, arg_18_0)
	arg_18_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnLevelUpReply, arg_18_0._onLevelUpReply, arg_18_0)
	arg_18_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_18_0._onUseStoneReply, arg_18_0)
	arg_18_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_18_0._refreshCurrency, arg_18_0)
	arg_18_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_18_0._refreshCurrency, arg_18_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_18_0._onCloseViewFinish, arg_18_0)
	arg_18_0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.RefreshView, arg_18_0._refreshDataCB, arg_18_0)
	arg_18_0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.UnlockEnd, arg_18_0._unlockEndCB, arg_18_0)
	arg_18_0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.LevelUpEnd, arg_18_0._rankUpEndCB, arg_18_0)
	arg_18_0._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.UnlockAttrAnim, arg_18_0._unlockAttrAnim, arg_18_0)
end

function var_0_0._removeEvents(arg_19_0)
	arg_19_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, arg_19_0._OnRankUpReply, arg_19_0)
	arg_19_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnLevelUpReply, arg_19_0._onLevelUpReply, arg_19_0)
	arg_19_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_19_0._onUseStoneReply, arg_19_0)
	arg_19_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_19_0._refreshCurrency, arg_19_0)
	arg_19_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_19_0._refreshCurrency, arg_19_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_19_0._onCloseViewFinish, arg_19_0)

	if arg_19_0._btnUpLvlongPress then
		arg_19_0._btnUpLvlongPress:RemoveLongPressListener()
	end

	if arg_19_0._btnuplevel then
		arg_19_0._btnuplevel:RemoveClickUpListener()
		arg_19_0._btnuplevel:RemoveClickDownListener()
	end

	arg_19_0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.RefreshView)
	arg_19_0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.UnlockEnd)
	arg_19_0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.LevelUpEnd)
	arg_19_0._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.UnlockAttrAnim)
end

function var_0_0._onLevelUpReply(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:_refreshView()

	if arg_20_0._heroMO.destinyStoneMo:isSlotMaxLevel() then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_molu_sky_open)
	end
end

function var_0_0._playItemLevelUp(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:_getAttrItemByAtttrId(arg_21_1)

	if var_21_0 then
		var_21_0:playLevelUpAnim()
	end
end

function var_0_0._playAttrItemLevelUp(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0, var_22_1, var_22_2 = CharacterDestinyModel.instance:getCurSlotAttrInfos(arg_22_0._heroMO.heroId, arg_22_1, arg_22_2)
	local var_22_3 = 0

	if var_22_0 then
		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			if iter_22_1.nextNum then
				arg_22_0:_playItemLevelUp(iter_22_1.attrId)

				var_22_3 = var_22_3 + 1
			end
		end
	end

	if var_22_1 then
		for iter_22_2, iter_22_3 in ipairs(var_22_1) do
			if iter_22_3.nextNum then
				arg_22_0:_playItemLevelUp(iter_22_3.attrId)

				var_22_3 = var_22_3 + 1
			end
		end
	end

	local var_22_4 = arg_22_3 and var_22_2[1] or var_22_2[arg_22_1]

	if var_22_4 then
		for iter_22_4, iter_22_5 in ipairs(var_22_4) do
			arg_22_0:_playItemLevelUp(iter_22_5.attrId)

			var_22_3 = var_22_3 + 1
		end
	end

	if var_22_3 > 0 then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_inking_preference_open)
	end
end

function var_0_0._onUseStoneReply(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:_refreshView()
	arg_23_0:_refreshEmpty()
end

function var_0_0._onCloseViewFinish(arg_24_0, arg_24_1)
	if arg_24_1 == ViewName.CharacterDestinyStoneView then
		arg_24_0:_playerOpenAnim()
	end
end

function var_0_0.onOpen(arg_25_0)
	arg_25_0:_addEvents()

	arg_25_0._heroMO = arg_25_0.viewParam.heroMo
	arg_25_0._isPlayingUnlockAnim = false

	local var_25_0 = arg_25_0._heroMO.destinyStoneMo

	arg_25_0._maxRankLevel = var_25_0:getRankLevelCount()

	if not arg_25_0._itemConsumeList then
		arg_25_0._itemConsumeList = {}
	end

	local var_25_1 = CharacterDestinyEnum.SlotTitle[arg_25_0._heroMO.config.heroType] or CharacterDestinyEnum.SlotTitle[1]

	arg_25_0._txttitle.text = luaLang(var_25_1)

	if arg_25_0.viewParam.isBack then
		local var_25_2 = arg_25_0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock

		arg_25_0._anim:Play(var_25_2, 0, 1)
	else
		arg_25_0:_playerOpenAnim()
	end

	arg_25_0:_refreshView(true)
	arg_25_0:_refreshAttrPanel()
	arg_25_0:_refreshEmpty()
	arg_25_0.viewContainer:setCurDestinySlot(var_25_0)
	arg_25_0:_refreshTrial()
end

function var_0_0._refreshTrial(arg_26_0)
	local var_26_0 = arg_26_0._heroMO:isTrial()

	gohelper.setActive(arg_26_0._gostonebtnicon.gameObject, not var_26_0)
	gohelper.setActive(arg_26_0._btnstone.gameObject, not var_26_0)
end

function var_0_0._playerOpenAnim(arg_27_0)
	local var_27_0 = arg_27_0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.OpenUnlock or CharacterDestinyEnum.SlotViewAnim.OpenLock

	arg_27_0._anim:Play(var_27_0, 0, 0)
end

function var_0_0._refreshView(arg_28_0, arg_28_1)
	arg_28_0:_refreshBtn()
	arg_28_0:_refreshSlot(arg_28_1)
end

function var_0_0._refreshCurrency(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0._itemConsumeList) do
		for iter_29_2, iter_29_3 in pairs(iter_29_1) do
			arg_29_0._itemConsumeList[iter_29_0][iter_29_2] = ItemModel.instance:getItemQuantity(iter_29_0, iter_29_2)
		end
	end

	arg_29_0:_refreshBtn()
end

function var_0_0._playIdleAnim(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1 and CharacterDestinyEnum.SlotViewAnim.UnlockIdle or CharacterDestinyEnum.SlotViewAnim.LockIdle

	arg_30_0._anim:Play(var_30_0, 0, 1)
end

function var_0_0._OnRankUpReply(arg_31_0)
	arg_31_0._maxRankLevel = arg_31_0._heroMO.destinyStoneMo:getRankLevelCount()
end

function var_0_0._rankUpEndCB(arg_32_0)
	arg_32_0._isPlayingRankUpAnim = false

	local var_32_0 = arg_32_0._heroMO.destinyStoneMo
	local var_32_1 = var_32_0.rank
	local var_32_2 = var_32_0.maxLevel[var_32_1 - 1]

	arg_32_0:_playAttrItemLevelUp(var_32_1 - 1, var_32_2)
	TaskDispatcher.runDelay(arg_32_0._refreshAttrPanel, arg_32_0, 0.5)
	arg_32_0:_refreshBtnLevel(var_32_0.level)
	gohelper.setActive(arg_32_0._goempty, var_32_0.curUseStoneId == 0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._unlockEndCB(arg_33_0)
	arg_33_0._isPlayingUnlockAnim = false

	arg_33_0:_playIdleAnim(true)
	gohelper.setActive(arg_33_0._goempty, true)
	gohelper.setActive(arg_33_0._gotopleft, true)
	CharacterDestinyController.instance:dispatchEvent(CharacterDestinyEvent.OnUnlockSlot)
end

function var_0_0._refreshDataCB(arg_34_0)
	arg_34_0:_refreshView(true)
	arg_34_0:_refreshAttrPanel()
end

function var_0_0._unlockAttrAnim(arg_35_0)
	arg_35_0:_playAttrItemLevelUp(0, 1, true)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._refreshAttrPanel(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0.isClose then
		return
	end

	local var_36_0 = arg_36_1 or arg_36_0._heroMO.destinyStoneMo.rank
	local var_36_1 = arg_36_2 or arg_36_0._heroMO.destinyStoneMo.level
	local var_36_2, var_36_3, var_36_4 = CharacterDestinyModel.instance:getCurSlotAttrInfos(arg_36_0._heroMO.heroId, var_36_0, var_36_1)

	if not arg_36_0._attrItems then
		arg_36_0._attrItems = arg_36_0:getUserDataTb_()
	end

	local var_36_5 = 1

	if var_36_2 then
		for iter_36_0, iter_36_1 in ipairs(var_36_2) do
			arg_36_0:_getAttrItem(var_36_5):onUpdateBaseAttrMO(var_36_5, iter_36_1)

			var_36_5 = var_36_5 + 1
		end
	end

	if var_36_3 then
		for iter_36_2, iter_36_3 in ipairs(var_36_3) do
			arg_36_0:_getAttrItem(var_36_5):onUpdateSpecailAttrMO(var_36_5, iter_36_3, iter_36_2 == 1, #var_36_3)

			var_36_5 = var_36_5 + 1
		end
	end

	if var_36_4 then
		for iter_36_4, iter_36_5 in pairs(var_36_4) do
			arg_36_0:_getAttrItem(var_36_5):onUpdateLockSpecialAttrMO(var_36_5, iter_36_4, iter_36_5)

			var_36_5 = var_36_5 + 1
		end
	end

	if arg_36_0._attrItems then
		for iter_36_6 = 1, #arg_36_0._attrItems do
			local var_36_6 = arg_36_0._attrItems[iter_36_6]

			gohelper.setActive(var_36_6.viewGO, iter_36_6 < var_36_5)
		end
	end
end

function var_0_0._getAttrItem(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0._attrItems[arg_37_1]

	if not var_37_0 then
		var_37_0 = arg_37_0:getUserDataTb_()

		local var_37_1 = gohelper.cloneInPlace(arg_37_0._goattritem, "attritem_" .. arg_37_1)

		var_37_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_37_1, CharacterDestinySlotAttrItem)
		arg_37_0._attrItems[arg_37_1] = var_37_0
	end

	return var_37_0
end

function var_0_0._getAttrItemByAtttrId(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0._attrItems) do
		if iter_38_1.attrId == arg_38_1 then
			return iter_38_1
		end
	end
end

function var_0_0._refreshSlot(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0._heroMO.destinyStoneMo
	local var_39_1 = var_39_0:isUnlockSlot()
	local var_39_2 = var_39_0.curUseStoneId ~= 0
	local var_39_3 = Color.white

	if var_39_2 then
		local var_39_4, var_39_5, var_39_6 = var_39_0:getCurStoneNameAndIcon()

		arg_39_0._txtstonename.text = var_39_4

		arg_39_0._simagestone:LoadImage(var_39_5)

		local var_39_7 = CharacterDestinyEnum.SlotTend[var_39_6.tend]
		local var_39_8 = var_39_7.TitleIconName

		UISpriteSetMgr.instance:setUiCharacterSprite(arg_39_0._imageicon, var_39_8)

		arg_39_0._txtstonename.color = GameUtil.parseColor(var_39_7.TitleColor)

		if not arg_39_0._stoneEffectItem then
			arg_39_0._stoneEffectItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_39_0._gostoneeffectitem, CharacterDestinyStoneEffectItem)
		end

		var_39_3 = var_39_7.RuneColor

		arg_39_0._stoneEffectItem:onUpdateMo(var_39_0)
	end

	for iter_39_0, iter_39_1 in ipairs(arg_39_0._slotmats) do
		local var_39_9 = iter_39_1.mpc

		if var_39_9.color_01 ~= var_39_3 then
			var_39_9.color_01 = var_39_3

			var_39_9:SetProps()
		end
	end

	arg_39_0:_setSlotLevel(arg_39_1)
	gohelper.setActive(arg_39_0._txttitle.gameObject, not var_39_2)
	gohelper.setActive(arg_39_0._golock, not var_39_1)
	gohelper.setActive(arg_39_0._gounlock, var_39_1)
	gohelper.setActive(arg_39_0._gostone, var_39_2)
	gohelper.setActive(arg_39_0._scrolleffect.gameObject, var_39_1 and var_39_2)
	gohelper.setActive(arg_39_0._gostoneempty.gameObject, var_39_1 and not var_39_2)
	gohelper.setActive(arg_39_0._gostonelock.gameObject, not var_39_1)
end

function var_0_0._refreshEmpty(arg_40_0)
	local var_40_0 = arg_40_0._heroMO.destinyStoneMo.curUseStoneId ~= 0

	gohelper.setActive(arg_40_0._goempty, not var_40_0)
end

function var_0_0._setSlotLevel(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0._heroMO.destinyStoneMo
	local var_41_1 = var_41_0.rank
	local var_41_2 = var_41_0.level - 1

	for iter_41_0 = 1, var_41_0.maxRank do
		local var_41_3 = 0.65
		local var_41_4 = 1

		if iter_41_0 < var_41_1 then
			var_41_4 = 0
		elseif var_41_1 < iter_41_0 then
			var_41_4 = 1
			var_41_3 = 0.3
		else
			local var_41_5 = var_41_0:getRankLevelCount() - 1

			var_41_4 = var_41_5 ~= 0 and 1 - var_41_2 / var_41_5 or 0
		end

		local var_41_6 = arg_41_0._slotmats[iter_41_0]
		local var_41_7 = var_41_6.ms.color

		var_41_7.a = var_41_3
		var_41_6.ms.color = var_41_7

		local var_41_8 = var_41_6.mpc
		local var_41_9 = var_41_8.vector_01
		local var_41_10 = var_41_8.vector_02

		if var_41_6._tweenId then
			ZProj.TweenHelper.KillById(var_41_6._tweenId, false)

			var_41_6._tweenId = nil
		end

		local var_41_11 = {
			mpc = var_41_8,
			vector1 = var_41_9,
			vector2 = var_41_10
		}

		if not arg_41_1 then
			if var_41_4 < var_41_10.x then
				var_41_6._tweenId = ZProj.TweenHelper.DOTweenFloat(var_41_10.x, var_41_4, 0.5, arg_41_0._progressMat, nil, arg_41_0, var_41_11)
			end
		else
			arg_41_0:_progressMat(var_41_4, var_41_11)
		end
	end
end

function var_0_0._openCharacterDestinyStoneView(arg_42_0)
	if arg_42_0._isPlayingUnlockAnim then
		return
	end

	local var_42_0 = arg_42_0._heroMO.destinyStoneMo:isUnlockSlot() and CharacterDestinyEnum.SlotViewAnim.CloseUnlock or CharacterDestinyEnum.SlotViewAnim.CloseLock

	arg_42_0._anim:Play(var_42_0, 0, 0)
	CharacterDestinyController.instance:openCharacterDestinyStoneView(arg_42_0._heroMO)
end

function var_0_0._progressMat(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_2.mpc

	var_43_0.vector_01 = Vector4.New(arg_43_2.vector1.x, arg_43_2.vector1.y, arg_43_2.vector1.z, -0.5 + arg_43_1)
	var_43_0.vector_02 = Vector4.New(arg_43_1, arg_43_2.vector2.y, arg_43_2.vector2.z, arg_43_2.vector2.w)

	var_43_0:SetProps()
end

function var_0_0.isHasEnoughCurrenctLevelUp(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = arg_44_0._heroMO.destinyStoneMo

	arg_44_2 = arg_44_2 or var_44_0.rank
	arg_44_3 = arg_44_3 or var_44_0.level

	local var_44_1 = CharacterDestinyConfig.instance:getNextDestinySlotCo(var_44_0.heroId, arg_44_2, arg_44_3)

	if not var_44_1 then
		return
	end

	local var_44_2 = GameUtil.splitString2(var_44_1.consume, true)
	local var_44_3
	local var_44_4

	if var_44_2 then
		for iter_44_0, iter_44_1 in ipairs(var_44_2) do
			local var_44_5 = iter_44_1[1]
			local var_44_6 = iter_44_1[2]
			local var_44_7 = iter_44_1[3]
			local var_44_8 = arg_44_0._itemConsumeList[var_44_5]

			if not var_44_8 then
				var_44_8 = {}
				arg_44_0._itemConsumeList[var_44_5] = var_44_8
			end

			if not var_44_8[var_44_6] then
				var_44_8[var_44_6] = ItemModel.instance:getItemQuantity(var_44_5, var_44_6)
			end

			if var_44_7 > arg_44_0._itemConsumeList[var_44_5][var_44_6] then
				var_44_3, var_44_4 = ItemModel.instance:getItemConfigAndIcon(var_44_5, var_44_6)

				break
			end
		end
	end

	if var_44_3 then
		if arg_44_1 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_44_4, var_44_3.name)
		end

		return false
	end

	return true
end

function var_0_0._refreshBtn(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0._heroMO.destinyStoneMo
	local var_45_1 = var_45_0:isUnlockSlot()
	local var_45_2 = var_45_1 and var_45_0:isSlotMaxLevel()
	local var_45_3 = var_45_1 and not var_45_2 and var_45_0:isCanUpSlotRank()
	local var_45_4 = var_45_1 and not var_45_2 and not var_45_0:isCanUpSlotRank()
	local var_45_5 = not var_45_1 or var_45_3
	local var_45_6 = arg_45_0._heroMO:isTrial()

	gohelper.setActive(arg_45_0._gounlockbtn, not var_45_6 and not var_45_1)
	gohelper.setActive(arg_45_0._gouplv, not var_45_6 and var_45_4)
	gohelper.setActive(arg_45_0._gouprank, not var_45_6 and var_45_3)
	gohelper.setActive(arg_45_0._gomax, var_45_1 and var_45_2)
	gohelper.setActive(arg_45_0._goconsumeitem, not var_45_6 and var_45_5)
	gohelper.setActive(arg_45_0._gocurrency, not var_45_6 and var_45_4)

	arg_45_1 = arg_45_1 or var_45_0.level

	local var_45_7 = CharacterDestinyConfig.instance:getNextDestinySlotCo(var_45_0.heroId, var_45_0.rank, arg_45_1)

	if var_45_7 then
		local var_45_8 = ItemModel.instance:getItemDataListByConfigStr(var_45_7.consume)

		if var_45_5 then
			IconMgr.instance:getCommonPropItemIconList(arg_45_0, arg_45_0._onConsumeItemCB, var_45_8, arg_45_0._goconsumeitem)
		end

		if var_45_4 then
			arg_45_0:_onRefreshConsumeCurrencyItems(var_45_8)
		end
	end

	arg_45_0:_refreshBtnLevel(var_45_0.level)
end

function var_0_0._onConsumeItemCB(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	transformhelper.setLocalScale(arg_46_1.viewGO.transform, 0.6, 0.6, 1)
	arg_46_1:onUpdateMO(arg_46_2)
	arg_46_1:setConsume(true)
	arg_46_1:showStackableNum2()
	arg_46_1:isShowEffect(true)
	arg_46_1:setAutoPlay(true)
	arg_46_1:setCountFontSize(48)

	local var_46_0 = arg_46_1:getItemIcon():getCount()
	local var_46_1 = 170
	local var_46_2 = var_46_0.gameObject:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	var_46_0.enableAutoSizing = true
	var_46_2.enabled = false
	var_46_0.fontSizeMax = 48
	var_46_0.fontSizeMin = 30
	var_46_0.transform.anchorMax = Vector2(0.5, 0.5)
	var_46_0.transform.anchorMin = Vector2(0.5, 0.5)
	var_46_0.transform.pivot = Vector2(0.5, 0.5)
	var_46_0.alignment = TMPro.TextAlignmentOptions.Center

	recthelper.setWidth(var_46_0.transform, var_46_1)
	recthelper.setHeight(var_46_0.transform, 70)
	arg_46_1:SetCountLocalY(-50)
	arg_46_1:setCountText(ItemModel.instance:getItemIsEnoughText(arg_46_2))
	arg_46_1:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_46_0)
	arg_46_1:setRecordFarmItem({
		type = arg_46_2.materilType,
		id = arg_46_2.materilId,
		quantity = arg_46_2.quantity
	})
end

function var_0_0._onRefreshConsumeCurrencyItems(arg_47_0, arg_47_1)
	if arg_47_1 then
		for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
			arg_47_0:_refreshConsumeCurrencyItem(iter_47_0, iter_47_1)
		end
	end

	for iter_47_2 = 1, #arg_47_0._consumeCurrencyItems do
		gohelper.setActive(arg_47_0._consumeCurrencyItems[iter_47_2].go, arg_47_1 and iter_47_2 <= #arg_47_1)
	end
end

function var_0_0._refreshConsumeCurrencyItem(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:_getConsumeCurrencyItem(arg_48_1)
	local var_48_1 = ItemModel.instance:getItemConfig(arg_48_2.materilType, arg_48_2.materilId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(var_48_0.icon, var_48_1.icon .. "_1")

	var_48_0.consumeBtn = SLFramework.UGUI.UIClickListener.Get(var_48_0.icon.gameObject)

	var_48_0.consumeBtn:AddClickListener(function()
		MaterialTipController.instance:showMaterialInfo(arg_48_2.materilType, arg_48_2.materilId)
	end, arg_48_0)

	local var_48_2 = arg_48_0._itemConsumeList[arg_48_2.materilType] and arg_48_0._itemConsumeList[arg_48_2.materilType][arg_48_2.materilId] or ItemModel.instance:getItemQuantity(arg_48_2.materilType, arg_48_2.materilId)
	local var_48_3 = var_48_2 >= arg_48_2.quantity and "%s/%s" or "<color=#cd5353>%s</color>/%s"

	var_48_0.txt.text = string.format(var_48_3, GameUtil.numberDisplay(var_48_2), GameUtil.numberDisplay(arg_48_2.quantity))
end

function var_0_0._refreshLevelUpConsume(arg_50_0, arg_50_1)
	local var_50_0 = CharacterDestinyConfig.instance:getNextDestinySlotCo(arg_50_0._heroMO.destinyStoneMo.heroId, arg_50_0._heroMO.destinyStoneMo.rank, arg_50_1 - 1)
	local var_50_1 = CharacterDestinyConfig.instance:getNextDestinySlotCo(arg_50_0._heroMO.destinyStoneMo.heroId, arg_50_0._heroMO.destinyStoneMo.rank, arg_50_1)

	if var_50_0 then
		local var_50_2 = ItemModel.instance:getItemDataListByConfigStr(var_50_0.consume)

		if var_50_2 then
			for iter_50_0, iter_50_1 in ipairs(var_50_2) do
				local var_50_3 = iter_50_1.materilType
				local var_50_4 = iter_50_1.materilId
				local var_50_5 = iter_50_1.quantity

				if not arg_50_0._itemConsumeList[var_50_3] then
					arg_50_0._itemConsumeList[var_50_3] = {}
				end

				local var_50_6 = arg_50_0._itemConsumeList[var_50_3][var_50_4] or ItemModel.instance:getItemQuantity(var_50_3, var_50_4)

				arg_50_0._itemConsumeList[var_50_3][var_50_4] = var_50_6 - var_50_5
			end
		end
	end

	if var_50_1 then
		local var_50_7 = ItemModel.instance:getItemDataListByConfigStr(var_50_1.consume)

		arg_50_0:_onRefreshConsumeCurrencyItems(var_50_7)
	end
end

function var_0_0._getConsumeCurrencyItem(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0._consumeCurrencyItems[arg_51_1]

	if not var_51_0 then
		local var_51_1 = gohelper.cloneInPlace(arg_51_0._txtcurrency.gameObject)

		var_51_0 = arg_51_0:getUserDataTb_()
		var_51_0.go = var_51_1
		var_51_0.txt = var_51_1:GetComponent(gohelper.Type_TextMesh)
		var_51_0.icon = gohelper.findChildImage(var_51_1, "#image_currency")
		arg_51_0._consumeCurrencyItems[arg_51_1] = var_51_0
	end

	return var_51_0
end

function var_0_0._refreshBtnLevel(arg_52_0, arg_52_1)
	local var_52_0 = luaLang("character_destiny_slot_level")

	arg_52_1 = math.min(arg_52_0._maxRankLevel, arg_52_1)
	arg_52_0._txtlv.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_52_0, arg_52_1, arg_52_0._maxRankLevel)
end

function var_0_0.onClose(arg_53_0)
	arg_53_0.isClose = true
end

function var_0_0.onDestroyView(arg_54_0)
	if arg_54_0._consumeCurrencyItems then
		for iter_54_0, iter_54_1 in ipairs(arg_54_0._consumeCurrencyItems) do
			if iter_54_1.consumeBtn then
				iter_54_1.consumeBtn:RemoveClickListener()
			end
		end
	end

	arg_54_0:_removeEvents()
	arg_54_0._simagestone:UnLoadImage()
	TaskDispatcher.cancelTask(arg_54_0._tick, arg_54_0)
	TaskDispatcher.cancelTask(arg_54_0._refreshAttrPanel, arg_54_0)

	if arg_54_0._slotmats then
		for iter_54_2, iter_54_3 in ipairs(arg_54_0._slotmats) do
			if iter_54_3._tweenId then
				ZProj.TweenHelper.KillById(iter_54_3._tweenId, false)

				iter_54_3._tweenId = nil
			end
		end
	end
end

return var_0_0
