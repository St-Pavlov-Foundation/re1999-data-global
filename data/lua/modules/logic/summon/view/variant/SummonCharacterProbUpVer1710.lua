-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer1710.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer1710", package.seeall)

local SummonCharacterProbUpVer1710 = class("SummonCharacterProbUpVer1710", SummonMainCharacterProbUp)

SummonCharacterProbUpVer1710.preloadList = {
	"singlebg/summon/heroversion_1_7/lake/full/v1a7_lake_fullbg.png",
	"singlebg/summon/heroversion_1_7/lake/v1a7_lake_role2.png",
	"singlebg/summon/heroversion_1_7/lake/v1a7_lake_role1.png"
}

function SummonCharacterProbUpVer1710:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad2")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad1")
	self._simagead3dec = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad3dec")
	self._gobefore30 = gohelper.findChild(self.viewGO, "#go_ui/summonbtns/summon10/currency/#go_before30")
	self._txtcurrency_current = gohelper.findChildText(self._gobefore30, "#txt_currency_current")
	self._txtcurrency_before = gohelper.findChildText(self._gobefore30, "#txt_currency_before")
	self._gotag = gohelper.findChild(self._gobefore30, "#go_tag")
	self._txtnum = gohelper.findChildText(self._gotag, "#txt_num")
	self._textEN = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/textEN")
	self._charaterItemCount = 2
	self._txtcurrency102.text = ""
	self._txtcurrency101.text = ""

	SummonCharacterProbUpVer1710.super._editableInitView(self)
end

function SummonCharacterProbUpVer1710:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer1710:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead2:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagead3dec:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

function SummonCharacterProbUpVer1710._parseCost(cost)
	if string.nilorempty(cost) then
		return -1, 0, 0
	end

	return SummonMainModel.instance.getCostByConfig(cost)
end

function SummonCharacterProbUpVer1710._checkIsEnough(itemType, itemId, need)
	local has = ItemModel.instance:getItemQuantity(itemType, itemId)

	return need <= has
end

function SummonCharacterProbUpVer1710:_refreshView(...)
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	local poolId = pool.id

	self._currentCostInfo = SummonCharacterProbUpVer1710._getCostInfo(poolId)

	SummonCharacterProbUpVer1710.super._refreshView(self, ...)
end

function SummonCharacterProbUpVer1710._getCostInfo(poolId)
	local res = {
		cost_num = 0,
		cost_num_before = 0,
		discountPercent01 = 0,
		cost_id = 0,
		cost_type = -1
	}

	if not poolId then
		return res
	end

	local co = SummonConfig.instance:getSummonPool(poolId)

	if not co then
		return res
	end

	local cost_type, cost_id, cost_num = SummonCharacterProbUpVer1710._parseCost(co.cost10)

	if cost_type < 0 then
		return res
	end

	res.cost_type = cost_type
	res.cost_id = cost_id
	res.cost_num = cost_num
	res.cost_num_before = cost_num

	if string.nilorempty(co.discountCost10) then
		return res
	end

	local strList = string.split(co.discountCost10, "|")

	for _, costStr in ipairs(strList) do
		local cost = string.splitToNumber(costStr, "#")
		local cost_type2, cost_id2, cost_num2 = cost[1], cost[2], cost[3]

		if cost_type2 == res.cost_type and res.cost_id == cost_id2 then
			if SummonMainModel.instance:getDiscountTime10Server(poolId) > 0 then
				res.discountPercent01 = (res.cost_num - cost_num2) / res.cost_num
				res.cost_num = cost_num2
			end

			break
		end
	end

	return res
end

function SummonCharacterProbUpVer1710:_btnsummon10OnClick()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local info = self._currentCostInfo
	local cost_type = info.cost_type
	local cost_id = info.cost_id
	local cost_num = info.cost_num
	local param = {}

	param.type = cost_type
	param.id = cost_id
	param.quantity = cost_num
	param.callback = self._summon10Confirm
	param.callbackObj = self
	param.notEnough = false

	local ownNum = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local itemEnough = cost_num <= ownNum
	local everyCostCount = SummonMainModel.instance.everyCostCount
	local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()
	local remainCount = cost_num - ownNum
	local costRemain = everyCostCount * remainCount

	if not itemEnough and currencyNum < costRemain then
		param.notEnough = true
	end

	if itemEnough then
		param.needTransform = false

		self:_summon10Confirm()

		return
	else
		param.needTransform = true
		param.cost_type = SummonMainModel.instance.costCurrencyType
		param.cost_id = SummonMainModel.instance.costCurrencyId
		param.cost_quantity = costRemain
		param.miss_quantity = remainCount
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, param)
end

function SummonCharacterProbUpVer1710:_refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")
		self:_refreshCost10()
	end
end

function SummonCharacterProbUpVer1710:_refreshCost10()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		self._txtcurrency101.text = ""
		self._txtcurrency102.text = ""
		self._textEN.text = ""

		gohelper.setActive(self._gobefore30, false)

		return
	end

	local info = self._currentCostInfo
	local cost_num = info.cost_num
	local cost_id = info.cost_id
	local cost_type = info.cost_type
	local discountPercent01 = info.discountPercent01
	local cost_num_before = info.cost_num_before
	local isShowDiscount = discountPercent01 > 0

	gohelper.setActive(self._gotag, isShowDiscount)
	gohelper.setActive(self._gobefore30, isShowDiscount)

	self._textEN.text = "SUMMON*" .. cost_num

	if discountPercent01 <= 0 then
		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
	else
		local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

		self._simagecurrency10:LoadImage(cost_icon)

		self._txtcurrency102.text = ""
		self._txtcurrency101.text = ""
		self._txtnum.text = "-" .. discountPercent01 * 100 .. "%"
		self._txtcurrency_before.text = cost_num_before
		self._txtcurrency_current.text = luaLang("multiple") .. cost_num
	end
end

return SummonCharacterProbUpVer1710
