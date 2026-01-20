-- chunkname: @modules/logic/store/view/PackageStoreGoodsItem.lua

module("modules.logic.store.view.PackageStoreGoodsItem", package.seeall)

local PackageStoreGoodsItem = class("PackageStoreGoodsItem", ListScrollCellExtend)

function PackageStoreGoodsItem:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._iconImage = self._simageicon:GetComponent(gohelper.Type_Image)
	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "cost/txt_materialNum")
	self._imagematerial = gohelper.findChildImage(self.viewGO, "cost/simage_material")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txteng = gohelper.findChildText(self.viewGO, "#txt_name/#txt_eng")
	self._txtremain = gohelper.findChildText(self.viewGO, "txt_remain")
	self._gosoldout = gohelper.findChild(self.viewGO, "#go_soldout")
	self._gohas = gohelper.findChild(self.viewGO, "go_has")
	self._goitemreddot = gohelper.findChild(self.viewGO, "go_itemreddot")
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._imagediscount = gohelper.findChild(self.viewGO, "#go_tag/#image_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "#go_tag/#txt_discount")
	self._gowenhao = gohelper.findChild(self.viewGO, "#go_wenhao")
	self._gosoldoutbg = gohelper.findChild(self._gosoldout, "bg")
	self._gosoldouttagbg = gohelper.findChild(self._gosoldout, "bg_tag")
	self._gooptionalgift = gohelper.findChild(self.viewGO, "#go_optionalgift")
	self._gooptionalvx = gohelper.findChild(self.viewGO, "#packs_vx")
	self._gosummonSimulationPickFX = gohelper.findChild(self.viewGO, "#go_summonSimulationPickFX")
	self._txtpickdesc = gohelper.findChildText(self.viewGO, "#txt_pickdesc")
	self._goSkinTips = gohelper.findChild(self.viewGO, "#go_SkinTips")
	self._imgProp = gohelper.findChildImage(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PackageStoreGoodsItem:addEvents()
	self:addEventCb(PayController.instance, PayEvent.UpdateProductDetails, self._onUpdateProductDetails, self)
end

function PackageStoreGoodsItem:removeEvents()
	self:removeEventCb(PayController.instance, PayEvent.UpdateProductDetails, self._onUpdateProductDetails, self)
end

function PackageStoreGoodsItem:_editableInitView()
	self._btnGO = gohelper.findChild(self.viewGO, "clickArea")
	self._btn = gohelper.getClickWithAudio(self._btnGO, AudioEnum.UI.play_ui_common_pause)

	self._btn:AddClickListener(self._onClick, self)

	self._gocost = gohelper.findChild(self.viewGO, "cost")
	self._btnCost = gohelper.getClick(self._gocost)

	self._btnCost:AddClickListener(self._onClickCost, self)

	self._golevelLock = gohelper.findChild(self.viewGO, "#go_levelLock")
	self._txtneedLevel = gohelper.findChildText(self.viewGO, "#go_levelLock/levellock/#txt_needLevel")
	self._golevelLockbg = gohelper.findChild(self.viewGO, "#go_levelLock/bg")
	self._golevelLockbgtag = gohelper.findChild(self.viewGO, "#go_levelLock/bg_tag")
	self._soldout = false
	self._hascloth = false
	self._lastStartPayTime = 0
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goremaintime = gohelper.findChild(self.viewGO, "go_remaintime")
	self._txtremiantime = gohelper.findChildText(self.viewGO, "go_remaintime/bg/#txt_remiantime")
	self._gonewtag = gohelper.findChild(self.viewGO, "go_newtag")
	self._nationalgifttag = gohelper.findChild(self.viewGO, "go_nationalgift")
	self._gomooncardup = gohelper.findChild(self.viewGO, "#go_mooncardup")
	self._gomaterialup = gohelper.findChild(self.viewGO, "#go_materialup")
	self._gocobranded = gohelper.findChild(self.viewGO, "#go_cobranded")
	self._golinkgift = gohelper.findChild(self.viewGO, "#go_linkgift")
	self._gologoTab = gohelper.findChild(self.viewGO, "#simage_logo")
	self._gotxtv2a8_09 = gohelper.findChild(self.viewGO, "txt_v2a8_09")
	self._gojinfanglun = gohelper.findChild(self.viewGO, "#go_jinfanglun")
end

function PackageStoreGoodsItem:_onClick()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj, self._mo)
	end

	StoreController.instance:forceReadTab(self._mo.belongStoreId)

	local goodsIds = {
		self._mo.goodsId
	}

	ChargeRpc.instance:sendReadChargeNewRequest(goodsIds, self._onRefreshNew, self)

	if not self:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if self._cfgType == StoreEnum.StoreChargeType.LinkGiftGoods then
		if self._mo.buyCount > 0 and StoreCharageConditionalHelper.isHasCanFinishGoodsTask(self._mo.goodsId) then
			TaskRpc.instance:sendFinishTaskRequest(self._mo.config.taskid)
			StoreGoodsTaskController.instance:requestGoodsTaskList()
		else
			StoreController.instance:openPackageStoreGoodsView(self._mo)
		end
	elseif self._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif self._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	else
		StoreController.instance:openPackageStoreGoodsView(self._mo)
	end
end

function PackageStoreGoodsItem:_onRefreshNew(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	gohelper.setActive(self._gonewtag, false)
end

function PackageStoreGoodsItem:_onClickCost()
	if self.isLevelOpen == false then
		return
	end

	if not self:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if self._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif self._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif self._mo.isChargeGoods then
		if Time.time - self._lastStartPayTime > 0.3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
			PayController.instance:startPay(self._mo.goodsId)

			self._lastStartPayTime = Time.time
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
		StoreController.instance:openPackageStoreGoodsView(self._mo)
	end
end

function PackageStoreGoodsItem:_isStoreItemUnlock()
	local episodeId = self._mo.config.needEpisodeId

	if not episodeId or episodeId == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function PackageStoreGoodsItem:_onUpdateProductDetails(mo)
	if self.mo then
		self:onUpdateMO(self.mo)
	end
end

function PackageStoreGoodsItem:onUpdateMO(mo)
	self._mo = mo
	self._cfgType = mo and mo.config and mo.config.type

	gohelper.setActive(self._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(mo.goodsId))
	gohelper.setActive(self._golevellimit, not self:_isStoreItemUnlock())
	gohelper.setActive(self._gomooncardup, false)
	gohelper.setActive(self._nationalgifttag, mo.config.offTag == "1")

	if not self:_isStoreItemUnlock() then
		local episodeId = self._mo.config.needEpisodeId
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if chapterConfig and chapterConfig.type == DungeonEnum.ChapterType.Hard then
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
		end

		local chapterIndex, episodeIndex, episodeType

		if episodeConfig and chapterConfig then
			chapterIndex = chapterConfig.chapterIndex
			episodeIndex, episodeType = DungeonConfig.instance:getChapterEpisodeIndexWithSP(chapterConfig.id, episodeConfig.id)

			if type == DungeonEnum.EpisodeType.Sp then
				chapterIndex = "SP"
			end
		end

		self._txtlvlimit.text = string.format(luaLang("level_limit_unlock"), string.format("%s-%s", chapterIndex, episodeIndex))
	end

	self._txtname.text = self._mo.config.name
	self._txteng.text = self._mo.config.nameEn

	self._simageicon:LoadImage(ResUrl.getStorePackageIcon(self._mo.config.bigImg))

	local cost = self._mo.cost

	if string.nilorempty(cost) or cost == 0 then
		self._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(self._imagematerial.gameObject, false)
	elseif self._mo.isChargeGoods then
		self._txtmaterialNum.text = PayModel.instance:getProductPrice(self._mo.id)

		gohelper.setActive(self._imagematerial.gameObject, false)

		self._costQuantity = cost
	else
		local costs = string.split(cost, "|")
		local costParam = costs[mo.buyCount + 1] or costs[#costs]
		local costInfo = string.splitToNumber(costParam, "#")

		self._costType = costInfo[1]
		self._costId = costInfo[2]
		self._costQuantity = costInfo[3]

		local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)

		self._txtmaterialNum.text = self._costQuantity

		gohelper.setActive(self._imagematerial.gameObject, true)

		local id = 0

		if string.len(self._costId) == 1 then
			id = self._costType .. "0" .. self._costId
		else
			id = self._costType .. self._costId
		end

		local str = string.format("%s_1", id)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerial, str)
	end

	local maxBuyCount = mo.maxBuyCount
	local remain = maxBuyCount - mo.buyCount

	self._soldout = mo:isSoldOut()

	local content

	if self._mo.isChargeGoods then
		content = StoreConfig.instance:getChargeRemainText(maxBuyCount, mo.refreshTime, remain, mo.offlineTime)
	else
		content = StoreConfig.instance:getRemainText(maxBuyCount, mo.refreshTime, remain, mo.offlineTime)
	end

	if string.nilorempty(content) then
		gohelper.setActive(self._txtremain.gameObject, false)
	else
		gohelper.setActive(self._txtremain.gameObject, true)

		self._txtremain.text = content
	end

	local offEndTime = mo.offlineTime - ServerTime.now()

	gohelper.setActive(self._goremaintime, mo.offlineTime > 0)

	if offEndTime > 3600 then
		local time, str = TimeUtil.secondToRoughTime(offEndTime)

		self._txtremiantime.text = formatLuaLang("remain", time .. str)
	else
		self._txtremiantime.text = luaLang("not_enough_one_hour")
	end

	local offTag = tonumber(mo:getDiscount())

	if offTag and offTag > 0 then
		self.hasTag = true

		gohelper.setActive(self._gotag, true)

		self._txtdiscount.text = string.format("-%d%%", offTag)
	else
		self.hasTag = false

		gohelper.setActive(self._gotag, false)
	end

	gohelper.setActive(self._gonewtag, mo:needShowNew())

	self._hascloth = self._mo:alreadyHas()

	gohelper.setActive(self._gohas, false)
	gohelper.setActive(self._gosoldout, false)
	ZProj.UGUIHelper.SetColorAlpha(self._iconImage, 1)

	if self._hascloth then
		gohelper.setActive(self._gohas, true)
	elseif self._soldout then
		gohelper.setActive(self._gosoldout, not StoreCharageConditionalHelper.isCharageTaskNotFinish(mo.goodsId))
		gohelper.setActive(self._gosoldoutbg, not self.hasTag)
		gohelper.setActive(self._gosoldouttagbg, self.hasTag)
		ZProj.UGUIHelper.SetColorAlpha(self._iconImage, 0.8)
	end

	gohelper.setActive(self._gowenhao, false)

	if self._mo.goodsId == StoreEnum.MonthCardGoodsId then
		gohelper.setActive(self._gowenhao, true)

		self._wenhaoClick = gohelper.getClick(self._gowenhao)

		self._wenhaoClick:AddClickListener(self.showMonthCardTips, self)

		local showtag = StoreHelper.checkMonthCardLevelUpTagOpen()

		gohelper.setActive(self._gomooncardup, showtag)
	elseif self._mo.goodsId == StoreEnum.SeasonCardGoodsId then
		gohelper.setActive(self._gowenhao, true)

		self._wenhaoClick = gohelper.getClick(self._gowenhao)

		self._wenhaoClick:AddClickListener(self._showSeasonCardTips, self)
	else
		GameUtil.onDestroyViewMember_ClickListener(self, "_wenhaoClick")
	end

	self.isLevelOpen = mo:isLevelOpen()

	gohelper.setActive(self._golevelLock, self.isLevelOpen == false)
	gohelper.setActive(self._golevelLockbg, not self.hasTag)
	gohelper.setActive(self._golevelLockbgtag, self.hasTag)

	self._txtneedLevel.text = formatLuaLang("packagestoregoodsitem_level", mo.buyLevel)

	if mo.isChargeGoods then
		self.isPreGoodsSoldOut = mo:checkPreGoodsSoldOut()

		gohelper.setActive(self._golevelLock, self.isLevelOpen == false or self.isPreGoodsSoldOut == false)

		if self.isLevelOpen and self.isPreGoodsSoldOut == false then
			local preGoodsCfg = StoreConfig.instance:getChargeGoodsConfig(mo.config.preGoodsId)

			self._txtneedLevel.text = formatLuaLang("packagestoregoods_pregoods_tips", preGoodsCfg.name)
		end
	end

	local isOptional = mo.isChargeGoods and mo.config.type == StoreEnum.StoreChargeType.Optional or mo.goodsId == StoreEnum.NewbiePackId

	gohelper.setActive(self._gooptionalgift, isOptional)
	gohelper.setActive(self._gooptionalvx, isOptional and not mo.goodsId == StoreEnum.NewbiePackId)
	gohelper.setActive(self._txtpickdesc.gameObject, mo.goodsId == StoreEnum.NewbiePackId)
	self:_onUpdateMO_newMatUpTag(mo)
	self:_onUpdateMO_coBrandedTag(mo)
	self:_onUpdateMO_gosummonSimulationPickFX(mo)
	self:_onUpdateMO_linkPackage(mo)
	self:_onUpdateMO_gosummonSimulationPickTag(mo)
	self:refreshSkinTips(mo)
	gohelper.setActive(self._gotxtv2a8_09, PackageStoreEnum.AnimHeadDict[mo.goodsId])
end

function PackageStoreGoodsItem:showMonthCardTips()
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc))
end

function PackageStoreGoodsItem:getAnimator()
	return self._animator
end

function PackageStoreGoodsItem:refreshSkinTips(goodsMO)
	local isSkinStoreGoods, skinId = SkinConfig.instance:isSkinStoreGoods(goodsMO.goodsId)

	if not isSkinStoreGoods then
		gohelper.setActive(self._goSkinTips, false)

		return
	end

	if StoreModel.instance:isSkinGoodsCanRepeatBuy(goodsMO, skinId) then
		gohelper.setActive(self._goSkinTips, true)

		local skinConfig = SkinConfig.instance:getSkinCo(skinId)
		local compensate = string.splitToNumber(skinConfig.compensate, "#")
		local currencyId = compensate[2]
		local currencyNum = compensate[3]
		local currencyCo = CurrencyConfig.instance:getCurrencyCo(currencyId)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imgProp, string.format("%s_1", currencyCo.icon))

		self._txtPropNum.text = tostring(currencyNum)
	else
		gohelper.setActive(self._goSkinTips, false)
	end
end

function PackageStoreGoodsItem:onDestroy()
	self._btn:RemoveClickListener()
	self._btnCost:RemoveClickListener()
	GameUtil.onDestroyViewMember_ClickListener(self, "_wenhaoClick")

	if self._linkGiftItemComp then
		self._linkGiftItemComp:onDestroy()

		self._linkGiftItemComp = nil
	end
end

function PackageStoreGoodsItem:_onUpdateMO_newMatUpTag(mo)
	local goodsId = mo.goodsId
	local isActive = StoreHelper.checkNewMatUpTagOpen(goodsId)

	gohelper.setActive(self._gomaterialup, isActive)
end

function PackageStoreGoodsItem:_onUpdateMO_coBrandedTag(mo)
	local isActive = mo.config.showLinkageTag or false

	gohelper.setActive(self._gocobranded, isActive)
	gohelper.setActive(self._gologoTab, mo.config.showLogoTag)
end

function PackageStoreGoodsItem:_showSeasonCardTips()
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.SeasonCardTipsDesc))
end

local kActiveSummonSimulationPickFXGoodsId = {
	811466,
	StoreEnum.SeasonCardGoodsId
}

function PackageStoreGoodsItem:_onUpdateMO_gosummonSimulationPickFX(mo)
	local isActive = mo.config.bigImg == StoreEnum.SummonSimulationPick

	if not isActive then
		for _, goodsId in ipairs(kActiveSummonSimulationPickFXGoodsId) do
			if mo.goodsId == goodsId then
				isActive = true

				break
			end
		end
	end

	gohelper.setActive(self._gosummonSimulationPickFX, isActive)
end

function PackageStoreGoodsItem:_onUpdateMO_linkPackage(mo)
	local isLinkGift = self._cfgType == StoreEnum.StoreChargeType.LinkGiftGoods

	gohelper.setActive(self._golinkgift, isLinkGift)
	gohelper.setActive(self._txtname, not isLinkGift)
	gohelper.setActive(self._txteng, not isLinkGift)

	if isLinkGift then
		if self._linkGiftItemComp == nil then
			self._linkGiftItemComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._golinkgift, StoreLinkGiftItemComp, self)
		end

		self._linkGiftItemComp:onUpdateMO(mo)
	end
end

function PackageStoreGoodsItem:_onUpdateMO_gosummonSimulationPickTag(mo)
	local isActive = mo.config.bigImg == StoreEnum.SummonSimulationPick2

	gohelper.setActive(self._gojinfanglun, isActive)
end

function PackageStoreGoodsItem:setClickCallback(callback, callbackObj)
	self._clickCallback = callback
	self._clickCallbackObj = callbackObj
end

return PackageStoreGoodsItem
