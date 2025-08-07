module("modules.logic.character.view.extra.CharacterSkillTalentTreeNode", package.seeall)

local var_0_0 = class("CharacterSkillTalentTreeNode", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._godark = gohelper.findChild(arg_1_0.viewGO, "#go_dark")
	arg_1_0._imagedarkIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_dark/#image_darkIcon")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._gocanlvup = gohelper.findChild(arg_1_0.viewGO, "#go_canlvup")
	arg_1_0._gomaxEffect = gohelper.findChild(arg_1_0.viewGO, "#go_canlvup/#go_maxEffect")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_canlvup/#image_icon")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	CharacterController.instance:dispatchEvent(CharacterEvent.onClickTalentTreeNode, arg_4_0._sub, arg_4_0._level)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:showSelect(false)

	arg_5_0._goprelit = gohelper.findChild(arg_5_0.viewGO, "#pre_lit")
	arg_5_0._canlvupanim = arg_5_0._gocanlvup:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._lockanim = arg_5_0._golock:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	local var_6_0 = arg_6_0._mo.co

	arg_6_0._sub = var_6_0.sub
	arg_6_0._level = var_6_0.level

	local var_6_1 = arg_6_1:getIconPath()

	if not string.nilorempty(var_6_1) then
		UISpriteSetMgr.instance:setSp01TalentIconSprite(arg_6_0._imageicon, var_6_1, true)
		UISpriteSetMgr.instance:setSp01TalentIconSprite(arg_6_0._imagedarkIcon, var_6_1, true)
	end

	arg_6_0._light = arg_6_0._mo:isLight()
end

function var_0_0.setLineGo(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0._line = arg_7_0:getUserDataTb_()
		arg_7_0._line.anim = arg_7_1:GetComponent(typeof(UnityEngine.Animator))
		arg_7_0._line.light = gohelper.findChild(arg_7_1, "go_linelight")
	end
end

function var_0_0.refreshStatus(arg_8_0)
	gohelper.setActive(arg_8_0._gocanlvup, arg_8_0._mo:isLight())
	gohelper.setActive(arg_8_0._golock, arg_8_0._mo:isLock())

	if arg_8_0._mo:isLight() then
		if arg_8_0._line then
			gohelper.setActive(arg_8_0._line.light, true)
		end

		if not arg_8_0._light then
			arg_8_0._canlvupanim:Play(CharacterExtraEnum.SkillTreeAnimName.Click, 0, 0)

			if arg_8_0._line and arg_8_0._line.anim then
				arg_8_0._line.anim:Play(CharacterExtraEnum.SkillTreeAnimName.Click, 0, 0)
			end

			AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_kashan_jihuo)
		end
	else
		if arg_8_0._line then
			gohelper.setActive(arg_8_0._line.light, false)
		end

		if arg_8_0._mo:isLock() and not arg_8_0._lock then
			arg_8_0._lockanim:Play(CharacterExtraEnum.SkillTreeAnimName.Lock, 0, 0)
		end
	end

	arg_8_0._light = arg_8_0._mo:isLight()
	arg_8_0._lock = arg_8_0._mo:isLock()
end

function var_0_0.showSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselect, arg_9_1)
end

function var_0_0.showSelectEffect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goprelit, arg_10_1)
end

function var_0_0.getAnchoredPosition(arg_11_0)
	return arg_11_0.viewGO.transform.anchoredPosition
end

return var_0_0
