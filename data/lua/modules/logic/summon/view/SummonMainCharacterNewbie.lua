-- chunkname: @modules/logic/summon/view/SummonMainCharacterNewbie.lua

module("modules.logic.summon.view.SummonMainCharacterNewbie", package.seeall)

local SummonMainCharacterNewbie = class("SummonMainCharacterNewbie", BaseView)

function SummonMainCharacterNewbie:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._simagesignature1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/right/#go_characteritem1/#simage_signature1")
	self._gocharacteritem2 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem2")
	self._simagesignature2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/right/#go_characteritem2/#simage_signature2")
	self._gocharacteritem3 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem3")
	self._simagesignature3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/right/#go_characteritem3/#simage_signature3")
	self._txtsummonnum = gohelper.findChildText(self.viewGO, "#go_ui/count/#txt_summonnum")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#simage_line")
	self._simagetips1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/tips/#simage_tips1")
	self._simagetips2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/tips/#simage_tips2")
	self._simagetips3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/tips/#simage_tips3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainCharacterNewbie:addEvents()
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function SummonMainCharacterNewbie:removeEvents()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

SummonMainCharacterNewbie.showHeroNum = 3
SummonMainCharacterNewbie.heroId = {
	"3025",
	"3051",
	"3004"
}
SummonMainCharacterNewbie.preloadList = {
	ResUrl.getSummonHeroIcon("full/bg000")
}

if SummonMainCharacterNewbie.heroId ~= nil then
	for i = 1, #SummonMainCharacterNewbie.heroId do
		local heroId = SummonMainCharacterNewbie.heroId[i]

		table.insert(SummonMainCharacterNewbie.preloadList, ResUrl.getSummonHeroIcon(heroId))
	end
end

function SummonMainCharacterNewbie:onUpdateParam()
	self:_refreshView()
end

function SummonMainCharacterNewbie:onOpen()
	self:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self:addEventCb(SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshView, self)
	self:playEnterAnim()
	self:_refreshView()
end

function SummonMainCharacterNewbie:playEnterAnim()
	logNormal("playEnterAnim")

	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function SummonMainCharacterNewbie:playerEnterAnimFromScene()
	logNormal("playerEnterAnimFromScene")
	self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function SummonMainCharacterNewbie:onClose()
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshView, self)
end

function SummonMainCharacterNewbie:_btnsummon1OnClick()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(curPool.cost1)
	local param = {}

	param.type = cost_type
	param.id = cost_id
	param.quantity = cost_num
	param.callback = self._summon1Confirm
	param.callbackObj = self
	param.notEnough = false

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local itemEnough = cost_num <= num
	local everyCostCount = SummonMainModel.instance.everyCostCount
	local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not itemEnough and currencyNum < everyCostCount then
		param.notEnough = true
	end

	if itemEnough then
		param.needTransform = false

		self:_summon1Confirm()

		return
	else
		param.needTransform = true
		param.cost_type = SummonMainModel.instance.costCurrencyType
		param.cost_id = SummonMainModel.instance.costCurrencyId
		param.cost_quantity = everyCostCount
		param.miss_quantity = 1
	end

	SummonMainController.instance:openSummonConfirmView(param)
end

function SummonMainCharacterNewbie:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonMainCharacterNewbie:_btnsummon10OnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local cost_type, cost_id, cost_num, ownNum = SummonMainModel.getCostByConfig(curPool.cost10)
	local maxGachaTimes = 10
	local param = {}

	param.type = cost_type
	param.id = cost_id
	param.quantity = cost_num
	param.callback = self._summon10Confirm
	param.callbackObj = self
	param.notEnough = false
	ownNum = ownNum or ItemModel.instance:getItemQuantity(cost_type, cost_id)

	local itemEnough = cost_num <= ownNum
	local everyCostCount = SummonMainModel.instance.everyCostCount
	local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()
	local remainCount = maxGachaTimes - ownNum
	local costRemain = everyCostCount * remainCount

	param.gachaTimes = maxGachaTimes

	if not itemEnough and currencyNum < costRemain then
		param.notEnough = true
	end

	if itemEnough then
		param.needTransform = false

		self:_summon10Confirm(param)

		return
	else
		param.needTransform = true
		param.cost_type = SummonMainModel.instance.costCurrencyType
		param.cost_id = SummonMainModel.instance.costCurrencyId
		param.cost_quantity = costRemain
		param.miss_quantity = remainCount
	end

	SummonMainController.instance:openSummonConfirmView(param)
end

function SummonMainCharacterNewbie:_summon10Confirm(param)
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonMainCharacterNewbie:_editableInitView()
	self._characteritems = {}
	self._pageitems = {}
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simagebg:LoadImage(ResUrl.getSummonHeroIcon("full/bg000"))
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
	self._simagetips1:LoadImage(ResUrl.getSummonHeroIcon("title_bg_black"))
	self._simagetips2:LoadImage(ResUrl.getSummonHeroIcon("title"))
	self._simagetips3:LoadImage(ResUrl.getSummonHeroIcon("title_bg_orange"))

	self._goSummon1 = gohelper.findChild(self.viewGO, "#go_ui/summonbtns/summon1")
	self._txtGacha10 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/text")

	for i = 1, SummonMainCharacterNewbie.showHeroNum do
		self["_simagead" .. i] = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/simage_ad" .. i)

		local characteritem = self:getUserDataTb_()

		characteritem.go = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem" .. i)
		characteritem.imagecareer = gohelper.findChildImage(characteritem.go, "image_career")
		characteritem.txtnamecn = gohelper.findChildText(characteritem.go, "txt_namecn")
		characteritem.btndetail = gohelper.findChildButtonWithAudio(characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		characteritem.rares = {}

		for j = 1, 6 do
			local rareGO = gohelper.findChild(characteritem.go, "rare/go_rare" .. j)

			table.insert(characteritem.rares, rareGO)
		end

		table.insert(self._characteritems, characteritem)
		characteritem.btndetail:AddClickListener(SummonMainCharacterNewbie._onClickDetailByIndex, self, i)
	end

	local summontxt1 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/text")
	local summontxt10 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/text")

	if GameConfig:GetCurLangType() == LangSettings.en then
		summontxt1.text = string.format(luaLang("p_summon_once"), luaLang("multiple"))
		summontxt10.text = string.format(luaLang("p_summon_tentimes"), luaLang("multiple"))
	else
		summontxt1.text = luaLang("p_summon_once")
		summontxt10.text = luaLang("p_summon_tentimes")
	end
end

function SummonMainCharacterNewbie:_onClickDetailByIndex(index)
	if not self._characteritems then
		return
	end

	local characteritem = self._characteritems[index]

	if characteritem then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			id = characteritem.characterDetailId
		})
	end
end

function SummonMainCharacterNewbie:_refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:_refreshPoolUI()
end

function SummonMainCharacterNewbie:_refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	self:_refreshCost()

	local times = SummonConfig.getSummonSSRTimes(pool) or "-"
	local curTimes = SummonMainModel.instance:getNewbieProgress() or "-"

	self._txtsummonnum.text = string.format("%s/%s", curTimes, times)

	self:showSummonPool(pool)
end

function SummonMainCharacterNewbie:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonMainCharacterNewbie:showSummonPool(poolCo)
	local heroId = SummonMainCharacterNewbie.heroId

	for i = 1, SummonMainCharacterNewbie.showHeroNum do
		self["_simagead" .. i]:LoadImage(ResUrl.getSummonHeroIcon(heroId[i]), self._adLoaded, {
			view = self,
			simage = self["_simagead" .. i]
		})
	end

	self._simagesignature1:LoadImage(ResUrl.getSignature(heroId[1]))
	self._simagesignature2:LoadImage(ResUrl.getSignature(heroId[2]))
	self._simagesignature3:LoadImage(ResUrl.getSignature(heroId[3]))
	self:showCharacter(poolCo)
end

function SummonMainCharacterNewbie._adLoaded(param)
	local view = param.view
	local simage = param.simage

	if gohelper.isNil(simage) then
		return
	end

	local imagead = simage:GetComponent(typeof(UnityEngine.UI.Image))

	imagead:SetNativeSize()
end

function SummonMainCharacterNewbie:showCharacter(poolCo)
	local characterDetails

	if not string.nilorempty(poolCo.characterDetail) then
		characterDetails = string.split(poolCo.characterDetail, "#")
	end

	local indexDict = {}

	if characterDetails then
		for i = 1, #characterDetails do
			local characterDetailId = tonumber(characterDetails[i])
			local characterDetailConfig = SummonConfig.instance:getCharacterDetailConfig(characterDetailId)
			local index = characterDetailConfig.location
			local characteritem = self._characteritems[index]

			if characteritem then
				local heroId = characterDetailConfig.heroId
				local heroConfig = HeroConfig.instance:getHeroCO(heroId)

				UISpriteSetMgr.instance:setCommonSprite(characteritem.imagecareer, "lssx_" .. tostring(heroConfig.career))

				characteritem.txtnamecn.text = heroConfig.name

				for j = 1, 6 do
					gohelper.setActive(characteritem.rares[j], j <= CharacterEnum.Star[heroConfig.rare])
				end

				characteritem.characterDetailId = characterDetailId

				gohelper.setActive(characteritem.go, true)

				indexDict[index] = true
			end
		end
	end

	for i = 1, #self._characteritems do
		gohelper.setActive(self._characteritems[i].go, indexDict[i])
	end
end

function SummonMainCharacterNewbie:_refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
	end
end

function SummonMainCharacterNewbie:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs, true)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local enough = cost_num <= num

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonMainCharacterNewbie:onSummonFailed()
	self.summonSuccess = false

	self:_refreshCost()
end

function SummonMainCharacterNewbie:onSummonReply()
	self.summonSuccess = true
end

function SummonMainCharacterNewbie:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:_refreshCost()
end

function SummonMainCharacterNewbie:onDestroyView()
	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end

	for i = 1, #self._characteritems do
		local characteritem = self._characteritems[i]

		characteritem.btndetail:RemoveClickListener()
	end

	for i = 1, SummonMainCharacterNewbie.showHeroNum do
		self["_simagead" .. i]:UnLoadImage()
	end

	self._simagebg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagetips1:UnLoadImage()
	self._simagetips2:UnLoadImage()
	self._simagetips3:UnLoadImage()
	self._simagesignature1:UnLoadImage()
	self._simagesignature2:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonMainCharacterNewbie
