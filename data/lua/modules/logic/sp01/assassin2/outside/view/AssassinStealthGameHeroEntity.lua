module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameHeroEntity", package.seeall)

local var_0_0 = class("AssassinStealthGameHeroEntity", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_0.go.transform
	arg_2_0.transParent = arg_2_0.trans.parent
	arg_2_0._imagehead1 = gohelper.findChildImage(arg_2_0.go, "#simage_head")
	arg_2_0._gonormal = gohelper.findChild(arg_2_0.go, "#go_normal")
	arg_2_0._imagehp1 = gohelper.findChildImage(arg_2_0.go, "#go_normal/#image_hp")
	arg_2_0._gohl = gohelper.findChild(arg_2_0.go, "#go_normal/image_light")
	arg_2_0._goapLayout = gohelper.findChild(arg_2_0.go, "#go_apLayout")
	arg_2_0._goexpose = gohelper.findChild(arg_2_0.go, "#go_expose")
	arg_2_0._imagehp2 = gohelper.findChildImage(arg_2_0.go, "#go_expose/#image_hp")
	arg_2_0._gohide = gohelper.findChild(arg_2_0.go, "#go_hide")
	arg_2_0._godead = gohelper.findChild(arg_2_0.go, "#go_dead")
	arg_2_0._imagehead2 = gohelper.findChildImage(arg_2_0.go, "#go_dead/#simage_head")
	arg_2_0._goselected = gohelper.findChild(arg_2_0.go, "#go_selected")
	arg_2_0._btnclick = gohelper.findChildClickWithAudio(arg_2_0.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_2_0._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.go, AssassinStealthGameEffectComp)
	arg_2_0._apComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._goapLayout, AssassinStealthGameAPComp)

	arg_2_0._apComp:setHeroUid(arg_2_0.uid)

	local var_2_0 = AssassinStealthGameModel.instance:getHeroMo(arg_2_0.uid, true):getHeroId()

	arg_2_0.go.name = string.format("%s", var_2_0)

	local var_2_1 = AssassinConfig.instance:getAssassinHeroEntityIcon(var_2_0)

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_2_0._imagehead1, var_2_1)
	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_2_0._imagehead2, var_2_1)

	arg_2_0._showStatus = nil
	arg_2_0._animator = arg_2_0.go:GetComponent(typeof(UnityEngine.Animator))

	arg_2_0:refresh()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_5_0)
	AssassinStealthGameController.instance:clickHeroEntity(arg_5_0.uid)
end

function var_0_0.changeParent(arg_6_0, arg_6_1)
	if gohelper.isNil(arg_6_1) then
		return
	end

	arg_6_0.trans:SetParent(arg_6_1)

	arg_6_0.transParent = arg_6_1

	arg_6_0:refreshPos()
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0:refreshStatus()
	arg_7_0:refreshHp()
	arg_7_0:refreshPos()
	arg_7_0:refreshSelected()
	arg_7_0:refreshHighlight()
	arg_7_0:playEffect(arg_7_1)
end

function var_0_0.refreshStatus(arg_8_0)
	local var_8_0 = AssassinStealthGameModel.instance:getHeroMo(arg_8_0.uid, true):getStatus()

	if arg_8_0._showStatus and arg_8_0._showStatus == var_8_0 then
		return
	end

	local var_8_1 = var_8_0 == AssassinEnum.HeroStatus.Hide
	local var_8_2 = var_8_0 == AssassinEnum.HeroStatus.Expose
	local var_8_3 = var_8_0 == AssassinEnum.HeroStatus.Stealth

	if arg_8_0._showStatus == AssassinEnum.HeroStatus.Expose and var_8_3 then
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_inhidden)
	end

	gohelper.setActive(arg_8_0._goexpose, var_8_2)
	gohelper.setActive(arg_8_0._gohide, var_8_1)
	gohelper.setActive(arg_8_0._gonormal, var_8_3)
	gohelper.setActive(arg_8_0._godead, var_8_0 == AssassinEnum.HeroStatus.Dead)

	if var_8_2 then
		arg_8_0._animator:Play("expose", 0, 0)
	elseif var_8_1 then
		arg_8_0._animator:Play("hide", 0, 0)
	else
		arg_8_0._animator:Play("empty", 0, 0)
	end

	arg_8_0._showStatus = var_8_0
end

function var_0_0.refreshHp(arg_9_0)
	local var_9_0 = AssassinStealthGameModel.instance:getHeroMo(arg_9_0.uid, true):getHp() / AssassinEnum.StealthConst.HpRatePoint

	arg_9_0._imagehp1.fillAmount = var_9_0
	arg_9_0._imagehp2.fillAmount = var_9_0
end

function var_0_0.refreshPos(arg_10_0)
	local var_10_0, var_10_1 = AssassinStealthGameModel.instance:getHeroMo(arg_10_0.uid, true):getPos()
	local var_10_2 = AssassinStealthGameEntityMgr.instance:getGridPointGoPosInEntityLayer(var_10_0, var_10_1, arg_10_0.transParent)

	transformhelper.setLocalPosXY(arg_10_0.trans, var_10_2.x, var_10_2.y)
end

function var_0_0.refreshSelected(arg_11_0)
	local var_11_0 = false

	if AssassinStealthGameHelper.isCanSelectHero(arg_11_0.uid) then
		var_11_0 = AssassinStealthGameModel.instance:isSelectedHero(arg_11_0.uid)
	end

	gohelper.setActive(arg_11_0._goselected, var_11_0)
end

function var_0_0.refreshHighlight(arg_12_0)
	local var_12_0 = AssassinStealthGameModel.instance:getIsShowHeroHighlight()

	gohelper.setActive(arg_12_0._gohl, var_12_0)
end

function var_0_0.playEffect(arg_13_0, arg_13_1)
	if arg_13_0._effectComp then
		arg_13_0._effectComp:playEffect(arg_13_1)
	end
end

function var_0_0.destroy(arg_14_0)
	arg_14_0.go:DestroyImmediate()
end

function var_0_0.onDestroy(arg_15_0)
	arg_15_0.uid = nil
	arg_15_0._showStatus = nil
end

return var_0_0
