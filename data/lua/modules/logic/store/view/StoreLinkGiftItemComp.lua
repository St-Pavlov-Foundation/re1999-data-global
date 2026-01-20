-- chunkname: @modules/logic/store/view/StoreLinkGiftItemComp.lua

module("modules.logic.store.view.StoreLinkGiftItemComp", package.seeall)

local StoreLinkGiftItemComp = class("StoreLinkGiftItemComp", LuaCompBase)

function StoreLinkGiftItemComp:init(go)
	self._go = go
	self.viewGO = go
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txteng = gohelper.findChildText(self.viewGO, "#txt_name/#txt_eng")
	self._txtremain = gohelper.findChildText(self.viewGO, "txt_remain")
	self._txttotal = gohelper.findChildText(self.viewGO, "total/txt_total")
	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "cost/txt_materialNum")
	self._imagematerial = gohelper.findChildImage(self.viewGO, "cost/simage_material")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "reward/simage_icon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "reward/simage_icon")
	self._goimagedesc = gohelper.findChild(self.viewGO, "reward/image_dec")
	self._gototal = gohelper.findChild(self.viewGO, "total")
	self._rewartTb = self:_createRewardTb(gohelper.findChild(self.viewGO, "reward/reward1"), 1)
	self._rewart2Tb = self:_createRewardTb(gohelper.findChild(self.viewGO, "reward/reward2"), 2)
	self._golock = gohelper.findChild(self.viewGO, "go_lock")
	self._gocanget = gohelper.findChild(self.viewGO, "go_canget")
	self._goreward3 = gohelper.findChild(self.viewGO, "reward/reward3")
	self._txtrewardnum3 = gohelper.findChildText(self.viewGO, "reward/reward3/normal/num3/txt_num")

	self:addEventListeners()
end

function StoreLinkGiftItemComp:addEventListeners()
	if not self._isRunAddEventListeners then
		self._isRunAddEventListeners = true

		TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	end
end

function StoreLinkGiftItemComp:removeEventListeners()
	if self._isRunAddEventListeners then
		self._isRunAddEventListeners = false

		TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	end
end

function StoreLinkGiftItemComp:onStart()
	return
end

function StoreLinkGiftItemComp:onDestroy()
	if self._rewartTb then
		self:_disposeRewardTb(self._rewartTb)

		self._rewartTb = nil
	end

	if self._rewart2Tb then
		self:_disposeRewardTb(self._rewart2Tb)

		self._rewart2Tb = nil
	end

	if self._simageicon then
		self._simageicon:UnLoadImage()
	end

	self:removeEventListeners()
	self:__onDispose()
end

function StoreLinkGiftItemComp:_onFinishTask(taskId)
	if self._mo and self._mo.config and self._mo.config.taskid == taskId then
		self:onUpdateMO(self._mo)
	end
end

function StoreLinkGiftItemComp:onUpdateMO(mo)
	self._mo = mo

	if self._mo then
		self._txtname.text = self._mo.config.name
		self._txteng.text = self._mo.config.nameEn

		self:_refreshPrice()
		self:_refreshReward()
	end
end

function StoreLinkGiftItemComp:_refreshPrice()
	local mo = self._mo
	local maxBuyCount = mo.maxBuyCount
	local remain = maxBuyCount - mo.buyCount
	local content

	if mo.isChargeGoods then
		content = StoreConfig.instance:getChargeRemainText(maxBuyCount, mo.refreshTime, remain, mo.offlineTime)
	else
		content = StoreConfig.instance:getRemainText(maxBuyCount, mo.refreshTime, remain, mo.offlineTime)
	end

	if string.nilorempty(content) then
		gohelper.setActive(self._txtremain, false)
	else
		gohelper.setActive(self._txtremain, true)

		self._txtremain.text = content
	end

	local cost = mo.cost

	if string.nilorempty(cost) or cost == 0 then
		self._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(self._imagematerial, false)
	elseif mo.isChargeGoods then
		self._txtmaterialNum.text = StoreModel.instance:getCostPriceFull(mo.id)

		gohelper.setActive(self._imagematerial, false)

		self._costQuantity = cost
	else
		local costs = GameUtil.splitString2(cost, true)
		local costInfo = costs[mo.buyCount + 1] or costs[#costs]

		self._costType = costInfo[1]
		self._costId = costInfo[2]
		self._costQuantity = costInfo[3]

		local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)

		self._txtmaterialNum.text = self._costQuantity

		gohelper.setActive(self._imagematerial, true)

		local id = 0

		if string.len(self._costId) == 1 then
			id = self._costType .. "0" .. self._costId
		else
			id = self._costType .. self._costId
		end

		local str = string.format("%s_1", id)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerial, str)
	end
end

function StoreLinkGiftItemComp:_refreshReward()
	local bonusList = GameUtil.splitString2(self._mo.config.product, true)
	local bounsCount = self:_getRewardCount(bonusList)
	local condCfg = StoreConfig.instance:getChargeConditionalConfig(self._mo.config.taskid)
	local condBonusList = condCfg and GameUtil.splitString2(condCfg.bonus, true)
	local condBonusCount = self:_getRewardCount(condBonusList)
	local goodsId = self._mo.goodsId
	local isBuy = self._mo.buyCount and self._mo.buyCount > 0
	local isCond = StoreCharageConditionalHelper.isCharageCondition(goodsId)
	local isTaskNoFinish = StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsId)
	local iconName = condCfg.bigImg2
	local showCondIcon = true

	if not isBuy and isCond then
		showCondIcon = false
		iconName = self._mo.config.bigImg
	elseif isBuy then
		iconName = condCfg.bigImg3
	end

	self._simageicon:LoadImage(ResUrl.getStorePackageIcon(iconName), self._onIconLoadFinish, self)
	gohelper.setActive(self._rewartTb.go, showCondIcon)
	gohelper.setActive(self._rewart2Tb.go, showCondIcon)
	gohelper.setActive(self._goimagedesc, showCondIcon)
	gohelper.setActive(self._gototal, showCondIcon)
	gohelper.setActive(self._goreward3, not showCondIcon)
	gohelper.setActive(self._golock, isBuy and not isCond)
	gohelper.setActive(self._gocanget, isBuy and isCond and isTaskNoFinish)

	if showCondIcon then
		self._txttotal.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("store_linkgift_totalcount_txt"), bounsCount + condBonusCount)

		self:_setRewardTbNum(self._rewartTb, bounsCount)
		self:_setRewardTbNum(self._rewart2Tb, condBonusCount)
		self:_setRewardTbHasget(self._rewartTb, isBuy)
		self:_setRewardTbHasget(self._rewart2Tb, isBuy and StoreCharageConditionalHelper.isCharageTaskFinish(goodsId))
	else
		self._txtrewardnum3.text = self:_getRewardNumStr(bounsCount + condBonusCount)
	end
end

function StoreLinkGiftItemComp:_onIconLoadFinish()
	self._imageicon:SetNativeSize()
end

function StoreLinkGiftItemComp:_createRewardTb(go, iconIndx)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.gonormal = gohelper.findChild(go, "normal")
	tb.gohasget = gohelper.findChild(go, "hasget")
	tb.txtnum = gohelper.findChildText(go, string.format("normal/num%s/txt_num", iconIndx))
	tb.txtnum2 = gohelper.findChildText(go, string.format("hasget/num%s/txt_num", iconIndx))

	return tb
end

function StoreLinkGiftItemComp:_getRewardNumStr(num)
	return string.format("×<size=32>%s", num)
end

function StoreLinkGiftItemComp:_setRewardTbNum(rewardTb, num)
	if rewardTb then
		local str = self:_getRewardNumStr(num)

		rewardTb.txtnum.text = str
		rewardTb.txtnum2.text = str
	end
end

function StoreLinkGiftItemComp:_setRewardTbHasget(rewardTb, isHasget)
	if rewardTb then
		gohelper.setActive(rewardTb.gonormal, not isHasget)
		gohelper.setActive(rewardTb.gohasget, isHasget)
	end
end

function StoreLinkGiftItemComp:_disposeRewardTb(rewardTb)
	return
end

function StoreLinkGiftItemComp:_getRewardCount(bonusList)
	local count = 0

	if bonusList and #bonusList > 0 then
		for i, bonus in ipairs(bonusList) do
			if bonus and #bonus >= 2 then
				count = count + bonus[3]
			end
		end
	end

	return count
end

return StoreLinkGiftItemComp
