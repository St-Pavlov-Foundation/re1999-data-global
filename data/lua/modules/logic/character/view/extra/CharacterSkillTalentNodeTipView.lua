module("modules.logic.character.view.extra.CharacterSkillTalentNodeTipView", package.seeall)

local var_0_0 = class("CharacterSkillTalentNodeTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_tipclose")
	arg_1_0._imageTag = gohelper.findChildImage(arg_1_0.viewGO, "#go_tip/#image_Tag")
	arg_1_0._golichang = gohelper.findChild(arg_1_0.viewGO, "#go_tip/Scroll View/Viewport/Content/#go_lichang")
	arg_1_0._goWarning = gohelper.findChild(arg_1_0.viewGO, "#go_tip/Scroll View/Viewport/Content/#go_lichang/#go_Warning")
	arg_1_0._txtWarning = gohelper.findChildText(arg_1_0.viewGO, "#go_tip/Scroll View/Viewport/Content/#go_lichang/#go_Warning/txt_Warning")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tip/#btn_yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tip/#btn_no")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tip/#btn_Locked")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#go_tip/#btn_Locked/txt_Tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onClickTalentTreeNode, arg_2_0._onClickTalentTreeNode, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, arg_2_0._closeTip, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, arg_2_0._closeTip, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onClickTalentTreeNode, arg_3_0._onClickTalentTreeNode, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, arg_3_0._closeTip, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, arg_3_0._closeTip, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:_closeTip()
end

function var_0_0._btnyesOnClick(arg_5_0)
	if not arg_5_0.heroMo:isOwnHero() then
		return
	end

	if not arg_5_0.skillTalentMo then
		return
	end

	if arg_5_0.skillTalentMo:isNullTalentPonit(arg_5_0.heroMo) then
		return
	end

	if arg_5_0._nodeMo:isLight() then
		return
	end

	HeroRpc.instance:setChoiceHero3124TalentTreeRequest(arg_5_0.heroMo.heroId, arg_5_0._sub, arg_5_0._level)
end

function var_0_0._btnnoOnClick(arg_6_0)
	if not arg_6_0.heroMo:isOwnHero() then
		return
	end

	if not arg_6_0.skillTalentMo then
		return
	end

	if not arg_6_0._nodeMo:isLight() then
		return
	end

	HeroRpc.instance:setCancelHero3124TalentTreeRequest(arg_6_0.heroMo.heroId, arg_6_0._sub, arg_6_0._level)
end

function var_0_0._onClickTalentTreeNode(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:_openNodeTip(arg_7_1, arg_7_2)
end

function var_0_0._closeTip(arg_8_0)
	arg_8_0:_activeTip(false)
	CharacterController.instance:dispatchEvent(CharacterEvent.onCloseSkillTalentTipView, arg_8_0._sub, arg_8_0._level)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._txtname = gohelper.findChildText(arg_9_0.viewGO, "#go_tip/txt_name")
	arg_9_0._txtdesc = gohelper.findChildText(arg_9_0.viewGO, "#go_tip/Scroll View/Viewport/Content/txt_desc")
	arg_9_0._txtyesnum = gohelper.findChildText(arg_9_0.viewGO, "#go_tip/#btn_yes/txt_num")
	arg_9_0._txtnonum = gohelper.findChildText(arg_9_0.viewGO, "#go_tip/#btn_no/txt_num")
	arg_9_0._txtlocknum = gohelper.findChildText(arg_9_0.viewGO, "#go_tip/#btn_Locked/txt_num")
	arg_9_0._txtlock = gohelper.findChildText(arg_9_0.viewGO, "#go_tip/#btn_Locked/no")
	arg_9_0._txtfield = gohelper.findChildText(arg_9_0._golichang, "txt_desc")
	arg_9_0._gofieldbg = gohelper.findChild(arg_9_0._golichang, "image_LightBG")
	arg_9_0._animPlayer = SLFramework.AnimatorPlayer.Get(arg_9_0._gotip.gameObject)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.heroMo = arg_10_0.viewParam
	arg_10_0.skillTalentMo = arg_10_0.heroMo.extraMo:getSkillTalentMo()
	arg_10_0._isShowTip = false

	gohelper.setActive(arg_10_0._gotip, false)
	gohelper.setActive(arg_10_0._btnclose.gameObject, false)
end

local var_0_1 = "+"
local var_0_2 = "-"

function var_0_0._openNodeTip(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.heroMo.exSkillLevel

	recthelper.setAnchorX(arg_11_0._gotip.transform, arg_11_1 == 2 and 500 or 0)

	local var_11_1 = arg_11_0.skillTalentMo:getTreeNodeMoBySubLevel(arg_11_1, arg_11_2)

	arg_11_0._sub = arg_11_1
	arg_11_0._level = arg_11_2
	arg_11_0._txtname.text = var_11_1.co.name

	local var_11_2 = var_11_1:getDesc(var_11_0)
	local var_11_3 = var_11_1:getFieldActivateDesc(var_11_0)

	arg_11_0._skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._txtdesc.gameObject, SkillDescComp)

	arg_11_0._skillDesc:updateInfo(arg_11_0._txtdesc, var_11_2, arg_11_0.heroMo.heroId)
	UISpriteSetMgr.instance:setUiCharacterSprite(arg_11_0._imageTag, arg_11_0.skillTalentMo:getSmallSubIconPath(arg_11_1))

	arg_11_0._treeMo = arg_11_0.skillTalentMo:getTreeMosBySub(arg_11_1)
	arg_11_0._nodeMo = arg_11_0.skillTalentMo:getTreeNodeMoBySubLevel(arg_11_1, arg_11_2)

	local var_11_4 = #arg_11_0.skillTalentMo:getLightOrCancelNodes(arg_11_1, arg_11_2)
	local var_11_5 = var_11_4 > arg_11_0.skillTalentMo:getTalentpoint()

	arg_11_0._fieldDesc = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._txtfield.gameObject, SkillDescComp)

	arg_11_0._fieldDesc:updateInfo(arg_11_0._txtfield, var_11_3, arg_11_0.heroMo.heroId)

	local var_11_6 = arg_11_0._treeMo:isAllLight()
	local var_11_7 = arg_11_0._nodeMo:isLock()
	local var_11_8 = arg_11_0._nodeMo:isLight()
	local var_11_9 = arg_11_0._nodeMo:isNormal()
	local var_11_10 = arg_11_0.skillTalentMo:getExtraCount()
	local var_11_11 = ""
	local var_11_12 = ""

	if var_11_5 then
		var_11_11 = luaLang("characterskilltalent_warning_3")
	end

	local var_11_13 = arg_11_0.skillTalentMo:getMainFieldMo()

	if var_11_13 then
		local var_11_14 = var_11_13.co and var_11_13.co.sub

		if var_11_14 and var_11_14 ~= arg_11_1 then
			if not var_11_5 then
				var_11_11 = luaLang("characterskilltalent_warning_2")
			end

			local var_11_15 = luaLang("characterskilltalent_warning_1")
			local var_11_16 = luaLang("characterskilltalent_sub_" .. var_11_14)
			local var_11_17 = luaLang("characterskilltalent_sub_" .. arg_11_1)

			var_11_12 = GameUtil.getSubPlaceholderLuaLangTwoParam(var_11_15, var_11_16, var_11_17)
		end
	end

	local var_11_18 = var_11_6 and var_11_10 > 1
	local var_11_19 = var_11_7 and not string.nilorempty(var_11_11)
	local var_11_20 = not string.nilorempty(var_11_12)
	local var_11_21 = not string.nilorempty(var_11_3)
	local var_11_22 = arg_11_0.heroMo:isOwnHero()

	gohelper.setActive(arg_11_0._gofieldbg.gameObject, var_11_22 and (var_11_20 or var_11_21))
	gohelper.setActive(arg_11_0._golichang.gameObject, var_11_22 and var_11_21)
	gohelper.setActive(arg_11_0._txtTips.gameObject, var_11_22 and var_11_19)
	gohelper.setActive(arg_11_0._txtWarning.gameObject, var_11_22 and var_11_20)
	gohelper.setActive(arg_11_0._btnyes.gameObject, var_11_22 and not var_11_18 and var_11_9)
	gohelper.setActive(arg_11_0._btnno.gameObject, var_11_22 and not var_11_18 and var_11_8)
	gohelper.setActive(arg_11_0._btnLocked.gameObject, var_11_22 and (var_11_18 or var_11_19))
	gohelper.setActive(arg_11_0._goWarning.gameObject, var_11_22 and not var_11_6 and var_11_20)
	arg_11_0:_activeTip(true)

	if arg_11_0._nodeMo:isLight() then
		arg_11_0._txtnonum.text = var_0_1 .. var_11_4
		arg_11_0._txtlocknum.text = var_0_1 .. var_11_4
		arg_11_0._txtlock.text = luaLang("characterskilltalent_cancel_light")
	elseif arg_11_0._nodeMo:isLock() then
		arg_11_0._txtlocknum.text = var_0_2 .. var_11_4
		arg_11_0._txtlock.text = luaLang("characterskilltalent_sure_light")
	else
		arg_11_0._txtyesnum.text = var_0_2 .. var_11_4
	end

	arg_11_0._txtWarning.text = var_11_12
	arg_11_0._txtTips.text = var_11_11
end

function var_0_0._activeTip(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0._isShowTip = true

		gohelper.setActive(arg_12_0._gotip, true)
		gohelper.setActive(arg_12_0._btnclose.gameObject, true)
		arg_12_0._animPlayer:Play(CharacterExtraEnum.SkillTreeAnimName.OpenTip, arg_12_0._playAnimCallback, arg_12_0)
		AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_kashan_zhuangbei)
	elseif arg_12_0._isShowTip then
		arg_12_0._isShowTip = false

		arg_12_0._animPlayer:Play(CharacterExtraEnum.SkillTreeAnimName.CloseTip, arg_12_0._playAnimCallback, arg_12_0)
	end
end

function var_0_0._playAnimCallback(arg_13_0)
	if not arg_13_0._isShowTip then
		gohelper.setActive(arg_13_0._gotip, false)
		gohelper.setActive(arg_13_0._btnclose.gameObject, false)
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
