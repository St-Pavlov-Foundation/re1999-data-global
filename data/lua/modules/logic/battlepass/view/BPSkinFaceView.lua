-- chunkname: @modules/logic/battlepass/view/BPSkinFaceView.lua

module("modules.logic.battlepass.view.BPSkinFaceView", package.seeall)

local BPSkinFaceView = class("BPSkinFaceView", BaseView)
local Statu = {
	CloseAnim = 100,
	Idle = 1,
	CardAnimIdle = 3,
	FinalIdle = 5,
	OpenCardAnim = 2,
	TweenAnim = 4
}

BPSkinFaceView.OPEN_TYPE = {
	StoreSkin = 1
}

function BPSkinFaceView:onInitView()
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "main/#simage_fullbg/icon/#btn_close")
	self._btnCloseBg = gohelper.findChildButtonWithAudio(self.viewGO, "main/#btn_closeBg")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "main/#btn_start")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "main/desc/#simage_signature")
	self._txtskinname = gohelper.findChildTextMesh(self.viewGO, "main/desc/#txt_skinname")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "main/desc/#txt_skinname/#txt_name")
	self._txtnameEn = gohelper.findChildTextMesh(self.viewGO, "main/desc/#txt_skinname/#txt_name/#txt_enname")
	self._btnClickCard = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullclick")
end

function BPSkinFaceView:addEvents()
	self._btnClose:AddClickListener(self.onBtnCloseClick, self, BpEnum.ButtonName.Close)
	self._btnCloseBg:AddClickListener(self.onBtnCloseClick, self, BpEnum.ButtonName.CloseBg)
	self._btnStart:AddClickListener(self._openBpView, self)
	self._btnClickCard:AddClickListener(self._onClickCard, self)
end

function BPSkinFaceView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnCloseBg:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnClickCard:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function BPSkinFaceView:_openBpView()
	if not self:canClickClose() then
		return
	end

	self:statData(BpEnum.ButtonName.Goto)

	local goodsMO = StoreClothesGoodsItemListModel.instance:findMOByProduct(MaterialEnum.MaterialType.HeroSkin, self._skinId)

	if goodsMO then
		StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreTabId.Skin, goodsMO.goodsId, true)
	else
		BpController.instance:openBattlePassView(nil, nil, true)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function BPSkinFaceView:onClickModalMask()
	if not self:canClickClose() then
		return
	end

	self:onBtnCloseClick(BpEnum.ButtonName.CloseBg)
end

function BPSkinFaceView:_onClickCard()
	if self._statu == Statu.Idle then
		self._statu = Statu.OpenCardAnim

		TaskDispatcher.runDelay(self._delayPlayAudio, self, 1.5)
		self._anim:Play("tarot_click", 0, 0)

		local bpsvpCo = BpConfig.instance:getBpSkinViewParamCO(self._skinId)

		if bpsvpCo and bpsvpCo.audioId ~= 0 then
			AudioMgr.instance:trigger(bpsvpCo.audioId)
		else
			AudioMgr.instance:trigger(AudioEnum2_6.BP.FaceView)
		end
	elseif self._statu == Statu.CardAnimIdle then
		self._statu = Statu.TweenAnim

		self._anim:Play("tarot_click1", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
		TaskDispatcher.runDelay(self._delayFinishAnim, self, 1)
	elseif self._statu == Statu.CloseAnim then
		self:closeThis()
	end
end

function BPSkinFaceView:canClickClose()
	return self._statu == Statu.FinalIdle
end

function BPSkinFaceView:_delayPlayAudio()
	self._statu = Statu.CardAnimIdle

	if self._openType == BPSkinFaceView.OPEN_TYPE.StoreSkin then
		self._statu = Statu.CloseAnim
	end
end

function BPSkinFaceView:_delayFinishAnim()
	self._statu = Statu.FinalIdle

	gohelper.setActive(self._btnClickCard, false)
end

function BPSkinFaceView:onBtnCloseClick(statParam)
	if not self:canClickClose() then
		return
	end

	self:statData(statParam)
	self:closeThis()
end

function BPSkinFaceView:_onViewClose(viewName)
	if viewName == ViewName.BpView or viewName == ViewName.StoreView then
		self:closeThis()
	end
end

function BPSkinFaceView:onOpen()
	self._skinId = self.viewParam and self.viewParam.skinId
	self._openType = self.viewParam and self.viewParam.openType
	self._closeCallback = self.viewParam and self.viewParam.closeCallback
	self._cbObj = self.viewParam and self.viewParam.cbObj
	self._statu = Statu.Idle

	local skinCfg = lua_skin.configDict[self._skinId]

	if skinCfg then
		local heroCo = HeroConfig.instance:getHeroCO(skinCfg.characterId)

		self._txtskinname.text = skinCfg.name
		self._txtname.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("taluo_show_character_name"), heroCo and heroCo.name or skinCfg.name)
		self._txtnameEn.text = skinCfg.nameEng

		self._simagesignature:LoadImage(ResUrl.getSignature(heroCo.signature))
		BpController.instance:setSkinFaceViewStr(self._skinId)
	end
end

function BPSkinFaceView:statData(param)
	return
end

function BPSkinFaceView:onClose()
	TaskDispatcher.cancelTask(self._delayFinishAnim, self)
	TaskDispatcher.cancelTask(self._delayPlayAudio, self)

	if self._closeCallback then
		if self._cbObj then
			self._closeCallback(self._cbObj)
		else
			self._closeCallback()
		end
	end
end

return BPSkinFaceView
