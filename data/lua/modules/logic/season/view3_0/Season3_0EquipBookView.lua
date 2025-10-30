module("modules.logic.season.view3_0.Season3_0EquipBookView", package.seeall)

local var_0_0 = class("Season3_0EquipBookView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "left/#go_target")
	arg_1_0._gotargetcardpos = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos")
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#go_touch")
	arg_1_0._txtcardname = gohelper.findChildText(arg_1_0.viewGO, "left/#go_target/#txt_cardname")
	arg_1_0._txteffectdesc = gohelper.findChildText(arg_1_0.viewGO, "left/#go_target/Scroll View/Viewport/Content/#txt_effectdesc")
	arg_1_0._scrollcardlist = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/mask/#scroll_cardlist")
	arg_1_0._btnexchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_exchange")
	arg_1_0._goattributeitem = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/Scroll View/Viewport/Content/attrlist/#go_attributeitem")
	arg_1_0._goskilldescitem = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/Scroll View/Viewport/Content/skilldesc/#go_skilldescitem")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos/#go_carditem")
	arg_1_0._gotipPos = gohelper.findChild(arg_1_0.viewGO, "#go_tippos")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnexchange:AddClickListener(arg_2_0._btnexchangeOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity104EquipBookController.instance, Activity104Event.OnBookUpdateNotify, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity104EquipBookController.instance, Activity104Event.OnBookChangeSelectNotify, arg_2_0.onChangeSelectCard, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnexchange:RemoveClickListener()
	arg_3_0:removeEventCb(Activity104EquipBookController.instance, Activity104Event.OnBookUpdateNotify, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity104EquipBookController.instance, Activity104Event.OnBookChangeSelectNotify, arg_3_0.onChangeSelectCard, arg_3_0)
end

function var_0_0._btnexchangeOnClick(arg_4_0)
	local var_4_0 = Activity104Model.instance:getCurSeasonId()

	ViewMgr.instance:openView(ViewName.Season3_0EquipComposeView, {
		actId = var_4_0
	})
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	arg_5_0._goDesc = gohelper.findChild(arg_5_0.viewGO, "left/#go_target/Scroll View")
	arg_5_0._goAttrParent = gohelper.findChild(arg_5_0.viewGO, "left/#go_target/Scroll View/Viewport/Content/attrlist")
	arg_5_0._animatorCard = arg_5_0._gotargetcardpos:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._animCardEventWrap = arg_5_0._animatorCard:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_5_0._animCardEventWrap:AddEventListener("switch", arg_5_0.onSwitchCardAnim, arg_5_0)

	arg_5_0._propItems = {}
	arg_5_0._skillItems = {}
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0._simagebg1:UnLoadImage()

	if arg_6_0._animCardEventWrap then
		arg_6_0._animCardEventWrap:RemoveAllEventListener()

		arg_6_0._animCardEventWrap = nil
	end

	if arg_6_0._icon ~= nil then
		arg_6_0._icon:disposeUI()

		arg_6_0._icon = nil
	end

	Activity104EquipBookController.instance:onCloseView()
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = Activity104Model.instance:getCurSeasonId()

	Activity104EquipBookController.instance:onOpenView(var_7_0)
	arg_7_0:refreshUI()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshDesc()
	arg_9_0:refreshIcon()
end

function var_0_0.refreshDesc(arg_10_0)
	local var_10_0 = Activity104EquipItemBookModel.instance.curSelectItemId

	if not var_10_0 then
		arg_10_0._txtcardname.text = ""

		gohelper.setActive(arg_10_0._goDesc, false)
	else
		local var_10_1 = SeasonConfig.instance:getSeasonEquipCo(var_10_0)

		if not var_10_1 then
			arg_10_0._txtcardname.text = ""

			gohelper.setActive(arg_10_0._goDesc, false)
		else
			gohelper.setActive(arg_10_0._goDesc, true)
		end

		arg_10_0._txtcardname.text = string.format("[%s]", var_10_1.name)

		arg_10_0:refreshProps(var_10_1)
		arg_10_0:refreshSkills(var_10_1)
	end
end

function var_0_0.refreshIcon(arg_11_0)
	arg_11_0:checkCreateIcon()

	local var_11_0 = Activity104EquipItemBookModel.instance.curSelectItemId

	if arg_11_0._icon then
		arg_11_0._icon:updateData(var_11_0)
	end
end

function var_0_0.refreshProps(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = false

	if arg_12_1 and arg_12_1.attrId ~= 0 then
		local var_12_2 = SeasonEquipMetaUtils.getEquipPropsStrList(arg_12_1.attrId)
		local var_12_3 = SeasonEquipMetaUtils.getCareerColorDarkBg(arg_12_1.equipId)

		for iter_12_0, iter_12_1 in ipairs(var_12_2) do
			local var_12_4 = arg_12_0:getOrCreatePropText(iter_12_0)

			gohelper.setActive(var_12_4.go, true)

			var_12_4.txtDesc.text = iter_12_1

			SLFramework.UGUI.GuiHelper.SetColor(var_12_4.txtDesc, var_12_3)

			var_12_0[var_12_4] = true
			var_12_1 = true
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0._propItems) do
		if not var_12_0[iter_12_3] then
			gohelper.setActive(iter_12_3.go, false)
		end
	end

	gohelper.setActive(arg_12_0._goAttrParent, var_12_1)
end

function var_0_0.refreshSkills(arg_13_0, arg_13_1)
	local var_13_0 = SeasonEquipMetaUtils.getSkillEffectStrList(arg_13_1)
	local var_13_1 = SeasonEquipMetaUtils.getCareerColorDarkBg(arg_13_1.equipId)

	for iter_13_0 = 1, math.max(#arg_13_0._skillItems, #var_13_0) do
		local var_13_2 = arg_13_0:getOrCreateSkillText(iter_13_0)

		arg_13_0:updateSkillText(var_13_2, var_13_0[iter_13_0], var_13_1)
	end
end

function var_0_0.getOrCreatePropText(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._propItems[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go = gohelper.cloneInPlace(arg_14_0._goattributeitem, "propname_" .. tostring(arg_14_1))
		var_14_0.txtDesc = gohelper.findChildText(var_14_0.go, "txt_attributedesc")
		arg_14_0._propItems[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.getOrCreateSkillText(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._skillItems[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.go = gohelper.cloneInPlace(arg_15_0._goskilldescitem, "skill_" .. tostring(arg_15_1))
		var_15_0.txtDesc = gohelper.findChildText(var_15_0.go, "txt_skilldesc")
		var_15_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_0.txtDesc.gameObject, FixTmpBreakLine)
		arg_15_0._skillItems[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.updateSkillText(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_2 then
		gohelper.setActive(arg_16_1.go, false)

		return
	end

	gohelper.setActive(arg_16_1.go, true)

	arg_16_2 = HeroSkillModel.instance:skillDesToSpot(arg_16_2)
	arg_16_1.txtDesc.text = SkillHelper.addLink(arg_16_2)

	arg_16_1.fixTmpBreakLine:refreshTmpContent(arg_16_1.txtDesc)
	SLFramework.UGUI.GuiHelper.SetColor(arg_16_1.txtDesc, arg_16_3)
	SkillHelper.addHyperLinkClick(arg_16_1.txtDesc, arg_16_0.setSkillClickCallBack, arg_16_0)
end

function var_0_0.setSkillClickCallBack(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = recthelper.getAnchor(arg_17_0._gotipPos.transform)
	local var_17_2 = Vector2.New(var_17_0, var_17_1)

	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_17_1, var_17_2, CommonBuffTipEnum.Pivot.Left)
end

function var_0_0.checkCreateIcon(arg_18_0)
	if not arg_18_0._icon then
		local var_18_0 = arg_18_0._gocarditem

		arg_18_0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_0, Season3_0CelebrityCardEquip)
	end
end

function var_0_0.onChangeSelectCard(arg_19_0)
	arg_19_0._animatorCard:Play("switch", 0, 0)
end

function var_0_0.onSwitchCardAnim(arg_20_0)
	arg_20_0:refreshUI()
end

return var_0_0
