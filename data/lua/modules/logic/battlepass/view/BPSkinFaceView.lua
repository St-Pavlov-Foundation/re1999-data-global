module("modules.logic.battlepass.view.BPSkinFaceView", package.seeall)

local var_0_0 = class("BPSkinFaceView", BaseView)
local var_0_1 = {
	CloseAnim = 100,
	Idle = 1,
	CardAnimIdle = 3,
	FinalIdle = 5,
	OpenCardAnim = 2,
	TweenAnim = 4
}

var_0_0.OPEN_TYPE = {
	StoreSkin = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/#simage_fullbg/icon/#btn_close")
	arg_1_0._btnCloseBg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/#btn_closeBg")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "main/#btn_start")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "main/desc/#simage_signature")
	arg_1_0._txtskinname = gohelper.findChildTextMesh(arg_1_0.viewGO, "main/desc/#txt_skinname")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "main/desc/#txt_skinname/#txt_name")
	arg_1_0._txtnameEn = gohelper.findChildTextMesh(arg_1_0.viewGO, "main/desc/#txt_skinname/#txt_name/#txt_enname")
	arg_1_0._btnClickCard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullclick")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.onBtnCloseClick, arg_2_0, BpEnum.ButtonName.Close)
	arg_2_0._btnCloseBg:AddClickListener(arg_2_0.onBtnCloseClick, arg_2_0, BpEnum.ButtonName.CloseBg)
	arg_2_0._btnStart:AddClickListener(arg_2_0._openBpView, arg_2_0)
	arg_2_0._btnClickCard:AddClickListener(arg_2_0._onClickCard, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnCloseBg:RemoveClickListener()
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0._btnClickCard:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onViewClose, arg_3_0)
end

function var_0_0._openBpView(arg_4_0)
	if not arg_4_0:canClickClose() then
		return
	end

	arg_4_0:statData(BpEnum.ButtonName.Goto)

	local var_4_0 = StoreClothesGoodsItemListModel.instance:findMOByProduct(MaterialEnum.MaterialType.HeroSkin, arg_4_0._skinId)

	if var_4_0 then
		StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreTabId.Skin, var_4_0.goodsId)
	else
		BpController.instance:openBattlePassView(nil, nil, true)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_4_0._onViewClose, arg_4_0)
end

function var_0_0.onClickModalMask(arg_5_0)
	if not arg_5_0:canClickClose() then
		return
	end

	arg_5_0:onBtnCloseClick(BpEnum.ButtonName.CloseBg)
end

function var_0_0._onClickCard(arg_6_0)
	if arg_6_0._statu == var_0_1.Idle then
		arg_6_0._statu = var_0_1.OpenCardAnim

		TaskDispatcher.runDelay(arg_6_0._delayPlayAudio, arg_6_0, 1.5)
		arg_6_0._anim:Play("tarot_click", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_6.BP.FaceView)
	elseif arg_6_0._statu == var_0_1.CardAnimIdle then
		arg_6_0._statu = var_0_1.TweenAnim

		arg_6_0._anim:Play("tarot_click1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
		TaskDispatcher.runDelay(arg_6_0._delayFinishAnim, arg_6_0, 1)
	elseif arg_6_0._statu == var_0_1.CloseAnim then
		arg_6_0:closeThis()
	end
end

function var_0_0.canClickClose(arg_7_0)
	return arg_7_0._statu == var_0_1.FinalIdle
end

function var_0_0._delayPlayAudio(arg_8_0)
	arg_8_0._statu = var_0_1.CardAnimIdle

	if arg_8_0._openType == var_0_0.OPEN_TYPE.StoreSkin then
		arg_8_0._statu = var_0_1.CloseAnim
	end
end

function var_0_0._delayFinishAnim(arg_9_0)
	arg_9_0._statu = var_0_1.FinalIdle

	gohelper.setActive(arg_9_0._btnClickCard, false)
end

function var_0_0.onBtnCloseClick(arg_10_0, arg_10_1)
	if not arg_10_0:canClickClose() then
		return
	end

	arg_10_0:statData(arg_10_1)
	arg_10_0:closeThis()
end

function var_0_0._onViewClose(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.BpView or arg_11_1 == ViewName.StoreView then
		arg_11_0:closeThis()
	end
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._skinId = arg_12_0.viewParam and arg_12_0.viewParam.skinId
	arg_12_0._openType = arg_12_0.viewParam and arg_12_0.viewParam.openType
	arg_12_0._closeCallback = arg_12_0.viewParam and arg_12_0.viewParam.closeCallback
	arg_12_0._cbObj = arg_12_0.viewParam and arg_12_0.viewParam.cbObj
	arg_12_0._statu = var_0_1.Idle

	local var_12_0 = lua_skin.configDict[arg_12_0._skinId]

	if var_12_0 then
		local var_12_1 = HeroConfig.instance:getHeroCO(var_12_0.characterId)

		arg_12_0._txtskinname.text = var_12_0.name
		arg_12_0._txtname.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("taluo_show_character_name"), var_12_1 and var_12_1.name or var_12_0.name)
		arg_12_0._txtnameEn.text = var_12_0.nameEng

		arg_12_0._simagesignature:LoadImage(ResUrl.getSignature(var_12_1.signature))
		BpController.instance:setSkinFaceViewStr(arg_12_0._skinId)
	end
end

function var_0_0.statData(arg_13_0, arg_13_1)
	return
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayFinishAnim, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayPlayAudio, arg_14_0)

	if arg_14_0._closeCallback then
		if arg_14_0._cbObj then
			arg_14_0._closeCallback(arg_14_0._cbObj)
		else
			arg_14_0._closeCallback()
		end
	end
end

return var_0_0
