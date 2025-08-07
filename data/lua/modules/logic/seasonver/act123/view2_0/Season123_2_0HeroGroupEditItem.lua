module("modules.logic.seasonver.act123.view2_0.Season123_2_0HeroGroupEditItem", package.seeall)

local var_0_0 = class("Season123_2_0HeroGroupEditItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)

	arg_1_0._gohp = gohelper.findChild(arg_1_1, "#go_hp")
	arg_1_0._sliderhp = gohelper.findChildSlider(arg_1_1, "#go_hp/#slider_hp")
	arg_1_0._imagehp = gohelper.findChildImage(arg_1_1, "#go_hp/#slider_hp/Fill Area/Fill")
	arg_1_0._godead = gohelper.findChild(arg_1_1, "#go_dead")

	arg_1_0:_initObj(arg_1_1)
end

function var_0_0._initObj(arg_2_0, arg_2_1)
	arg_2_0._animator = arg_2_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._isSelect = false
	arg_2_0._enableDeselect = true

	transformhelper.setLocalScale(arg_2_1.transform, 0.8, 0.8, 1)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_3_0._onAttributeChanged, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_3_0._onSkinChanged, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0._onSkinChanged(arg_5_0)
	arg_5_0._heroItem:updateHero()
end

function var_0_0._onAttributeChanged(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._heroItem:setLevel(arg_6_1, arg_6_2)
end

function var_0_0.setAdventureBuff(arg_7_0, arg_7_1)
	arg_7_0._heroItem:setAdventureBuff(arg_7_1)
end

function var_0_0.updateLimitStatus(arg_8_0)
	if HeroGroupModel.instance:isRestrict(arg_8_0._mo.uid) then
		arg_8_0._heroItem:setRestrict(true)
	else
		arg_8_0._heroItem:setRestrict(false)
	end
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	arg_9_0._heroItem:onUpdateMO(arg_9_1)
	arg_9_0:updateLimitStatus()

	local var_9_0 = Season123HeroGroupEditModel.instance:isInTeamHero(arg_9_0._mo.uid)

	arg_9_0._heroItem:setNewShow(false)
	arg_9_0._heroItem:setInteam(var_9_0)
	arg_9_0:refreshHp()
	arg_9_0:refreshDead()
end

function var_0_0.refreshHp(arg_10_0)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_10_0 = Season123HeroGroupEditModel.instance.activityId
		local var_10_1 = Season123HeroGroupEditModel.instance.stage
		local var_10_2 = Season123HeroGroupEditModel.instance.layer
		local var_10_3 = Season123Model.instance:getSeasonHeroMO(var_10_0, var_10_1, var_10_2, arg_10_0._mo.uid)

		if var_10_3 ~= nil then
			gohelper.setActive(arg_10_0._gohp, true)
			arg_10_0:setHp(var_10_3.hpRate)
		else
			gohelper.setActive(arg_10_0._gohp, false)
		end
	else
		gohelper.setActive(arg_10_0._gohp, false)
		gohelper.setActive(arg_10_0._godead, false)
	end
end

function var_0_0.refreshDead(arg_11_0)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_11_0 = false
		local var_11_1 = Season123HeroGroupEditModel.instance.activityId
		local var_11_2 = Season123HeroGroupEditModel.instance.stage
		local var_11_3 = Season123HeroGroupEditModel.instance.layer
		local var_11_4 = Season123Model.instance:getSeasonHeroMO(var_11_1, var_11_2, var_11_3, arg_11_0._mo.uid)

		if var_11_4 ~= nil then
			var_11_0 = var_11_4.hpRate <= 0
		end

		arg_11_0._heroItem:setDamage(var_11_0)
		gohelper.setActive(arg_11_0._heroItem._maskgray, var_11_0)
	end
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	arg_12_0._isSelect = arg_12_1

	arg_12_0._heroItem:setSelect(arg_12_1)

	if arg_12_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_12_0._mo)
	end
end

function var_0_0._onItemClick(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_13_0:checkRestrict(arg_13_0._mo.uid) or arg_13_0:checkHpZero(arg_13_0._mo.uid) then
		return
	end

	if arg_13_0._isSelect and arg_13_0._enableDeselect then
		arg_13_0._view:selectCell(arg_13_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_13_0._view:selectCell(arg_13_0._index, true)
	end
end

function var_0_0.checkRestrict(arg_14_0, arg_14_1)
	if HeroGroupModel.instance:isRestrict(arg_14_1) then
		local var_14_0 = HeroGroupModel.instance:getCurrentBattleConfig()
		local var_14_1 = var_14_0 and var_14_0.restrictReason

		if not string.nilorempty(var_14_1) then
			ToastController.instance:showToastWithString(var_14_1)
		end

		return true
	end

	return false
end

function var_0_0.checkHpZero(arg_15_0, arg_15_1)
	local var_15_0 = Season123HeroGroupEditModel.instance.activityId
	local var_15_1 = Season123HeroGroupEditModel.instance.stage
	local var_15_2 = Season123HeroGroupEditModel.instance.layer
	local var_15_3 = Season123Model.instance:getSeasonHeroMO(var_15_0, var_15_1, var_15_2, arg_15_1)

	if var_15_3 == nil then
		return
	end

	if var_15_3.hpRate <= 0 then
		return true
	end

	return false
end

function var_0_0.enableDeselect(arg_16_0, arg_16_1)
	arg_16_0._enableDeselect = arg_16_1
end

function var_0_0.setHp(arg_17_0, arg_17_1)
	local var_17_0 = math.floor(arg_17_1 / 10)
	local var_17_1 = Mathf.Clamp(var_17_0 / 100, 0, 1)

	arg_17_0._sliderhp:SetValue(var_17_1)
	Season123HeroGroupUtils.setHpBar(arg_17_0._imagehp, var_17_1)
	gohelper.setActive(arg_17_0._godead, var_17_1 <= 0)
end

function var_0_0.onDestroy(arg_18_0)
	return
end

function var_0_0.getAnimator(arg_19_0)
	return arg_19_0._animator
end

return var_0_0
