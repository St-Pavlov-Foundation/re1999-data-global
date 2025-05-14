module("modules.logic.rouge.view.RougeFactionItemSelected_BtnItem", package.seeall)

local var_0_0 = class("RougeFactionItemSelected_BtnItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._lockAnim = gohelper.onceAddComponent(arg_1_0._golock, gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._itemClick then
		arg_3_0._itemClick:RemoveClickListener()

		arg_3_0._itemClick = nil
	end
end

local var_0_1 = SLFramework.UGUI.RectTrHelper

function var_0_0.ctor(arg_4_0, arg_4_1)
	arg_4_0:__onInit()

	arg_4_0._parent = arg_4_1
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1
	arg_5_0._trans = arg_5_1.transform

	arg_5_0:onInitView()
	arg_5_0:addEvents()
end

function var_0_0.transform(arg_6_0)
	return arg_6_0._trans
end

function var_0_0.setIndex(arg_7_0, arg_7_1)
	arg_7_0._index = arg_7_1
end

function var_0_0.index(arg_8_0)
	return arg_8_0._index
end

function var_0_0._getDetailTrans(arg_9_0)
	return arg_9_0._parent._detailTrans
end

function var_0_0._getDetailText(arg_10_0)
	return arg_10_0._parent._txtdec
end

function var_0_0._getDetailIcon(arg_11_0)
	return arg_11_0._parent._detailimageicon
end

function var_0_0._onItemClick(arg_12_0)
	arg_12_0._parent:_btnItemOnSelectIndex(arg_12_0:index(), arg_12_0._isUnlock)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._itemClick = gohelper.getClickWithAudio(arg_13_0.viewGO)
	arg_13_0._normalIcon = gohelper.findChildImage(arg_13_0._gonormal, "icon")
	arg_13_0._selectIcon = gohelper.findChildImage(arg_13_0._goselect, "icon")

	arg_13_0:setData(nil)
	arg_13_0:setSelected(false)
end

function var_0_0._getActiveSkillCO(arg_14_0, arg_14_1, arg_14_2)
	return RougeOutsideModel.instance:config():getSkillCo(arg_14_1, arg_14_2)
end

function var_0_0.setData(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0._skillId = arg_15_2
	arg_15_0._isUnlock = arg_15_3
	arg_15_0._skillType = arg_15_1

	if not arg_15_2 then
		arg_15_0:setActive(false)

		return
	end

	local var_15_0 = arg_15_0:_getActiveSkillCO(arg_15_0._skillType, arg_15_2)
	local var_15_1 = var_15_0 and var_15_0.icon

	if not string.nilorempty(var_15_1) then
		UISpriteSetMgr.instance:setRouge2Sprite(arg_15_0._normalIcon, var_15_1, true)
		UISpriteSetMgr.instance:setRouge2Sprite(arg_15_0._selectIcon, var_15_1, true)
	else
		logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", arg_15_1, arg_15_2))
	end

	gohelper.setActive(arg_15_0._golock, not arg_15_0._isUnlock)

	local var_15_2 = arg_15_0._isUnlock and "idle" or "unlock"

	arg_15_0._lockAnim:Play(var_15_2)
	arg_15_0:setActive(true)
end

function var_0_0.setActive(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0.viewGO, arg_16_1)
end

function var_0_0.onUnlocked(arg_17_0)
	arg_17_0._isUnlock = true

	arg_17_0:setSelected(false)
	SLFramework.AnimatorPlayer.Get(arg_17_0._lockAnim.gameObject):Play("unlock", arg_17_0.endPayAnim, arg_17_0)
end

function var_0_0.endPayAnim(arg_18_0)
	gohelper.setActive(arg_18_0._golock, false)
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0:removeEvents()
	arg_19_0:__onDispose()
end

function var_0_0.setSelected(arg_20_0, arg_20_1)
	if arg_20_0._isSelected == arg_20_1 then
		return
	end

	arg_20_0._isSelected = arg_20_1

	gohelper.setActive(arg_20_0._gonormal, not arg_20_1)
	gohelper.setActive(arg_20_0._goselect, arg_20_1)

	if arg_20_1 then
		arg_20_0:_resetDetailTxt()
		arg_20_0:_refreshDetailIcon()
	end
end

function var_0_0.isSelected(arg_21_0)
	return arg_21_0._isSelected or false
end

function var_0_0._resetDetailTxt(arg_22_0)
	local var_22_0 = arg_22_0:_getDetailText()

	if not arg_22_0._skillId then
		var_22_0.text = ""

		return
	end

	var_22_0.text = arg_22_0:_getActiveSkillCO(arg_22_0._skillType, arg_22_0._skillId).desc
end

function var_0_0._refreshDetailIcon(arg_23_0)
	if not arg_23_0._skillId then
		return
	end

	local var_23_0 = arg_23_0:_getDetailIcon()
	local var_23_1 = arg_23_0:_getActiveSkillCO(arg_23_0._skillType, arg_23_0._skillId)

	UISpriteSetMgr.instance:setRouge2Sprite(var_23_0, var_23_1.icon)
end

return var_0_0
