module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameHeroHeadItem", package.seeall)

local var_0_0 = class("AssassinStealthGameHeroHeadItem", LuaCompBase)
local var_0_1 = 1
local var_0_2 = 0.8

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._goselected = gohelper.findChild(arg_2_0.go, "#go_selected")
	arg_2_0._goitemlayout = gohelper.findChild(arg_2_0.go, "#go_selected/#go_itemlayout")
	arg_2_0._goitem = gohelper.findChild(arg_2_0.go, "#go_selected/#go_itemlayout/#go_item")
	arg_2_0._gonormal = gohelper.findChild(arg_2_0.go, "#go_normal")
	arg_2_0._imagehead1 = gohelper.findChildImage(arg_2_0.go, "#go_normal/#simage_head")
	arg_2_0._imagehp1 = gohelper.findChildImage(arg_2_0.go, "#go_normal/#image_hp")
	arg_2_0._goapLayout = gohelper.findChild(arg_2_0.go, "#go_normal/#go_apLayout")
	arg_2_0._goselectedarrow = gohelper.findChild(arg_2_0.go, "#go_selected_arrow")
	arg_2_0._godead = gohelper.findChild(arg_2_0.go, "#go_dead")
	arg_2_0._imagehead2 = gohelper.findChildImage(arg_2_0.go, "#go_dead/#simage_head")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_2_0._animator = arg_2_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._gohl = gohelper.findChild(arg_2_0.go, "#go_normal/image_light")
	arg_2_0._apComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._goapLayout, AssassinStealthGameAPComp)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._skillPropItemList) do
		iter_4_1.btnclick:RemoveClickListener()
	end
end

function var_0_0._btnclickOnClick(arg_5_0)
	AssassinStealthGameController.instance:clickHeroEntity(arg_5_0.uid, true)
end

function var_0_0._btnClickSkillProp(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._skillPropItemList[arg_6_1]

	if not var_6_0 then
		return
	end

	AssassinStealthGameController.instance:clickSkillProp(var_6_0.id, var_6_0.isSkill)
end

function var_0_0.onSkillPropChange(arg_7_0, arg_7_1)
	arg_7_0:setSkillPropList(arg_7_1)
	arg_7_0:refreshSkillProp()
end

function var_0_0.setData(arg_8_0, arg_8_1)
	arg_8_0.uid = arg_8_1.heroUid
	arg_8_0.isLastHeroHead = arg_8_1.isLastHeroHead

	arg_8_0._apComp:setHeroUid(arg_8_0.uid)

	local var_8_0 = AssassinStealthGameModel.instance:getHeroMo(arg_8_0.uid, true)
	local var_8_1 = var_8_0 and var_8_0:getHeroId()
	local var_8_2 = AssassinConfig.instance:getAssassinHeroEntityIcon(var_8_1)

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_8_0._imagehead1, var_8_2)
	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_8_0._imagehead2, var_8_2)
	arg_8_0:setSkillPropList()

	local var_8_3 = arg_8_1.checkSelectedAnim
	local var_8_4 = arg_8_1.oldSelectedHeroUid

	arg_8_0:refresh(var_8_3, var_8_4)
end

function var_0_0.setSkillPropList(arg_9_0, arg_9_1)
	if arg_9_0._skillPropItemList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._skillPropItemList) do
			iter_9_1.btnclick:RemoveClickListener()
		end
	end

	arg_9_0._skillPropItemList = {}

	local var_9_0 = AssassinStealthGameModel.instance:getHeroSkillPropList(arg_9_0.uid)

	if arg_9_1 then
		for iter_9_2, iter_9_3 in ipairs(var_9_0) do
			if not iter_9_3.isSkill then
				iter_9_3.isNew = arg_9_1[iter_9_3.id]
			end
		end
	end

	gohelper.CreateObjList(arg_9_0, arg_9_0._onCreateSkillPropItem, var_9_0, arg_9_0._goitemlayout, arg_9_0._goitem)
end

function var_0_0._onCreateSkillPropItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:getUserDataTb_()

	var_10_0.go = arg_10_1
	var_10_0.id = arg_10_2.id
	var_10_0.isSkill = arg_10_2.isSkill and true or false
	var_10_0.animator = var_10_0.go:GetComponent(typeof(UnityEngine.Animator))
	var_10_0.gonormal = gohelper.findChild(var_10_0.go, "#go_normal")
	var_10_0.goselected = gohelper.findChild(var_10_0.go, "#go_normal/#go_selected")
	var_10_0.txtnum = gohelper.findChildText(var_10_0.go, "#go_normal/#txt_num")
	var_10_0.goapLayout = gohelper.findChild(var_10_0.go, "#go_normal/#go_apLayout")
	var_10_0.imageicon1 = gohelper.findChildImage(var_10_0.go, "#go_normal/#simage_icon")
	var_10_0.godisable = gohelper.findChild(var_10_0.go, "#go_disable")
	var_10_0.imageicon2 = gohelper.findChildImage(var_10_0.go, "#go_disable/#simage_icon")
	var_10_0.btnclick = gohelper.findChildClickWithAudio(var_10_0.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	var_10_0.btnclick:AddClickListener(arg_10_0._btnClickSkillProp, arg_10_0, arg_10_3)

	local var_10_1 = 0

	var_10_0.apComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_0.goapLayout, AssassinStealthGameAPComp)

	if var_10_0.isSkill then
		local var_10_2, var_10_3 = AssassinConfig.instance:getAssassinSkillCost(var_10_0.id)

		if var_10_2 == AssassinEnum.SkillCostType.AP then
			var_10_1 = var_10_3
		else
			logError(string.format("AssassinStealthGameHeroHeadItem:_onCreateSkillPropItem error, not support cost type:%s, skillId:%s", var_10_2, var_10_0.id))
		end

		AssassinHelper.setAssassinSkillIcon(var_10_0.id, var_10_0.imageicon1)
		AssassinHelper.setAssassinSkillIcon(var_10_0.id, var_10_0.imageicon2)
	else
		var_10_1 = AssassinConfig.instance:getAssassinItemCostPoint(var_10_0.id)

		AssassinHelper.setAssassinItemIcon(var_10_0.id, var_10_0.imageicon1)
		AssassinHelper.setAssassinItemIcon(var_10_0.id, var_10_0.imageicon2)
	end

	var_10_0.apComp:setAPCount(var_10_1)

	if arg_10_2.isNew then
		var_10_0.animator:Play("open", 0, 0)
	end

	arg_10_0._skillPropItemList[arg_10_3] = var_10_0
end

function var_0_0.refresh(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:refreshStatus()
	arg_11_0:refreshHp()
	arg_11_0:refreshSelected(arg_11_1, arg_11_2)
	arg_11_0:refreshHighlight()
end

function var_0_0.refreshStatus(arg_12_0)
	local var_12_0 = AssassinStealthGameModel.instance:getHeroMo(arg_12_0.uid, true):getStatus() == AssassinEnum.HeroStatus.Dead

	gohelper.setActive(arg_12_0._gonormal, not var_12_0)
	gohelper.setActive(arg_12_0._godead, var_12_0)
end

function var_0_0.refreshHp(arg_13_0)
	local var_13_0 = AssassinStealthGameModel.instance:getHeroMo(arg_13_0.uid, true):getHp()

	arg_13_0._imagehp1.fillAmount = var_13_0 / AssassinEnum.StealthConst.HpRatePoint
end

function var_0_0.refreshSelected(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = AssassinStealthGameHelper.isCanSelectHero(arg_14_0.uid)
	local var_14_1 = AssassinStealthGameModel.instance:isSelectedHero(arg_14_0.uid)
	local var_14_2 = var_14_1 and var_0_1 or var_0_2

	transformhelper.setLocalScale(arg_14_0.trans, var_14_2, var_14_2, var_14_2)

	local var_14_3
	local var_14_4 = arg_14_0._skillPropItemList and #arg_14_0._skillPropItemList > 0

	if var_14_0 and var_14_1 then
		var_14_3 = var_14_4 and "select_in" or "select_in1"
	else
		var_14_3 = var_14_4 and "select_out" or "select_out1"
	end

	local var_14_5 = false

	if arg_14_1 then
		local var_14_6 = AssassinStealthGameModel.instance:getSelectedHero()

		if not arg_14_2 and var_14_6 or arg_14_2 and not var_14_6 then
			var_14_5 = true
		end
	end

	arg_14_0._animator:Play(var_14_3, 0, arg_14_0.isLastHeroHead and var_14_5 and 0 or 1)
	arg_14_0:refreshSkillProp()
end

function var_0_0.refreshSkillProp(arg_15_0)
	local var_15_0 = false

	if AssassinStealthGameHelper.isCanSelectHero(arg_15_0.uid) then
		var_15_0 = AssassinStealthGameModel.instance:isSelectedHero(arg_15_0.uid)
	end

	if not var_15_0 or not arg_15_0._skillPropItemList then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._skillPropItemList) do
		local var_15_1 = iter_15_1.id
		local var_15_2 = iter_15_1.isSkill
		local var_15_3 = AssassinStealthGameHelper.isCanUseSkillProp(arg_15_0.uid, var_15_1, var_15_2)

		gohelper.setActive(iter_15_1.gonormal, var_15_3)
		gohelper.setActive(iter_15_1.godisable, not var_15_3)

		local var_15_4 = false

		if var_15_3 then
			local var_15_5, var_15_6 = AssassinStealthGameModel.instance:getSelectedSkillProp()

			var_15_4 = var_15_5 == var_15_1 and var_15_6 == var_15_2
		end

		gohelper.setActive(iter_15_1.goselected, var_15_4)

		local var_15_7 = ""

		if not var_15_2 then
			local var_15_8 = AssassinStealthGameModel.instance:getHeroMo(arg_15_0.uid, true)

			if var_15_8 then
				var_15_7 = var_15_8:getItemCount(var_15_1)
			end
		end

		iter_15_1.txtnum.text = var_15_7
	end
end

function var_0_0.refreshHighlight(arg_16_0)
	local var_16_0 = AssassinStealthGameModel.instance:getIsShowHeroHighlight()

	gohelper.setActive(arg_16_0._gohl, var_16_0)
end

function var_0_0.playGetItem(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.uid or arg_17_0.uid ~= arg_17_1 then
		return
	end

	arg_17_0._animator:Play("get", 0, 0)
	arg_17_0:onSkillPropChange(arg_17_2)
end

function var_0_0.onDestroy(arg_18_0)
	arg_18_0.uid = nil
	arg_18_0._skillPropItemList = nil
end

return var_0_0
