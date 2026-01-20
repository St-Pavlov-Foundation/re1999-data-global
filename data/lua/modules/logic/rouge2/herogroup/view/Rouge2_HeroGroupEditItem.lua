-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupEditItem.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupEditItem", package.seeall)

local Rouge2_HeroGroupEditItem = class("Rouge2_HeroGroupEditItem", ListScrollCell)

function Rouge2_HeroGroupEditItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self._onItemClick, self)

	self._hptextwhite = gohelper.findChildText(go, "hpbg/hptextwhite")
	self._hptextred = gohelper.findChildText(go, "hpbg/hptextred")
	self._hpimage = gohelper.findChildImage(go, "hpbg/hp")
	self._gohp = gohelper.findChild(go, "hpbg")

	self:_initObj(go)
end

function Rouge2_HeroGroupEditItem:_initObj(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	self._isSelect = false
	self._enableDeselect = true

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)
	self._heroItem:setStyle_HeroGroupEdit()
end

function Rouge2_HeroGroupEditItem:addEventListeners()
	self:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, self._onSkinChanged, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, self.updateTrialRepeat, self)
end

function Rouge2_HeroGroupEditItem:removeEventListeners()
	return
end

function Rouge2_HeroGroupEditItem:_onSkinChanged()
	self._heroItem:updateHero()
end

function Rouge2_HeroGroupEditItem:setAdventureBuff(buffId)
	self._heroItem:setAdventureBuff(buffId)
end

function Rouge2_HeroGroupEditItem:updateLimitStatus()
	gohelper.setActive(self._gohp, false)

	if HeroGroupModel.instance:isRestrict(self._mo.uid) then
		self._heroItem:setRestrict(true)
	else
		self._heroItem:setRestrict(false)
	end
end

function Rouge2_HeroGroupEditItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)

	if not mo:isTrial() then
		local lv = Rouge2_HeroGroupBalanceHelper.getHeroBalanceLv(mo.heroId)

		if lv > mo.level then
			self._heroItem:setBalanceLv(lv)
		end
	end

	self:updateLimitStatus()
	self:updateTrialTag()
	self:updateTrialRepeat()

	local inteam = Rouge2_HeroGroupEditListModel.instance:isInTeamHero(self._mo.uid)

	self._heroItem:setNewShow(false)
	self._heroItem:setInteam(inteam)
end

function Rouge2_HeroGroupEditItem:updateTrialTag()
	local txt

	if self._mo:isTrial() then
		txt = luaLang("herogroup_trial_tag0")
	end

	self._heroItem:setTrialTxt(txt)
end

function Rouge2_HeroGroupEditItem:updateTrialRepeat()
	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if singleGroupMO and not singleGroupMO:isEmpty() and (singleGroupMO.trial and singleGroupMO:getTrialCO().heroId == self._mo.heroId or not singleGroupMO.trial and (not singleGroupMO:getHeroCO() or singleGroupMO:getHeroCO().id == self._mo.heroId)) then
		if not singleGroupMO.trial and not singleGroupMO.aid and not singleGroupMO:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(singleGroupMO.id))
		end

		self._heroItem:setTrialRepeat(false)

		return
	end

	local isRepeat = Rouge2_HeroGroupEditListModel.instance:isRepeatHero(self._mo.heroId, self._mo.uid)

	self._heroItem:setTrialRepeat(isRepeat)
end

function Rouge2_HeroGroupEditItem:onSelect(select)
	self._isSelect = select

	self._heroItem:setSelect(select)

	if select then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, self._mo)
	end
end

function Rouge2_HeroGroupEditItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if self._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._view.viewContainer.viewParam.singleGroupMOId)

	if self._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(self._mo.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and Rouge2_HeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if self._mo.isPosLock or not singleGroupMO:isEmpty() and singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if HeroGroupModel.instance:isRestrict(self._mo.uid) then
		local battleCo = HeroGroupModel.instance:getCurrentBattleConfig()
		local restrictReason = battleCo and battleCo.restrictReason

		if not string.nilorempty(restrictReason) then
			ToastController.instance:showToastWithString(restrictReason)
		end

		return
	end

	if self._isSelect and self._enableDeselect and not self._mo.isPosLock then
		self._view:selectCell(self._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		self._view:selectCell(self._index, true)
	end
end

function Rouge2_HeroGroupEditItem:enableDeselect(enable)
	self._enableDeselect = enable
end

function Rouge2_HeroGroupEditItem:onDestroy()
	return
end

function Rouge2_HeroGroupEditItem:getAnimator()
	return self._animator
end

return Rouge2_HeroGroupEditItem
