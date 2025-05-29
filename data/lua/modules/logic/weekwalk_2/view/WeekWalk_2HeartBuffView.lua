module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffView", package.seeall)

local var_0_0 = class("WeekWalk_2HeartBuffView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnMask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Mask")
	arg_1_0._simageTipsBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_TipsBG")
	arg_1_0._txtBuffName = gohelper.findChildText(arg_1_0.viewGO, "Root/Right/#txt_BuffName")
	arg_1_0._imageBuffIcon = gohelper.findChildImage(arg_1_0.viewGO, "Root/Right/#image_BuffIcon")
	arg_1_0._txtEffectDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/Right/Scroll View/Viewport/#txt_EffectDesc")
	arg_1_0._btnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_Equip")
	arg_1_0._btnUnLoad = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_UnLoad")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnMask:AddClickListener(arg_2_0._btnMaskOnClick, arg_2_0)
	arg_2_0._btnEquip:AddClickListener(arg_2_0._btnEquipOnClick, arg_2_0)
	arg_2_0._btnUnLoad:AddClickListener(arg_2_0._btnUnLoadOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnMask:RemoveClickListener()
	arg_3_0._btnEquip:RemoveClickListener()
	arg_3_0._btnUnLoad:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnUnLoadOnClick(arg_4_0)
	arg_4_0._selectedSkillId = nil

	arg_4_0:_updateBuffStatus()
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetup)

	if HeroGroupModel.instance.curGroupSelectIndex then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChooseSkillRequest(HeroGroupModel.instance.curGroupSelectIndex)
	end
end

function var_0_0._btnMaskOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnEquipOnClick(arg_6_0)
	if arg_6_0._isPrevBattleSkill then
		GameFacade.showToast(ToastEnum.WeekWalk_2BuffCannotSetup)

		return
	end

	arg_6_0._selectedSkillId = arg_6_0._buffConfig.id

	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetup, arg_6_0._buffConfig)

	if HeroGroupModel.instance.curGroupSelectIndex then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChooseSkillRequest(HeroGroupModel.instance.curGroupSelectIndex, {
			arg_6_0._selectedSkillId
		}, arg_6_0._onBuffSetupReply, arg_6_0)
	end
end

function var_0_0._btnCloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._txtBuffName.text = ""
	arg_8_0._txtEffectDesc.text = ""

	gohelper.setActive(arg_8_0._btnEquip, false)
	gohelper.setActive(arg_8_0._btnUnLoad, false)
	gohelper.addUIClickAudio(arg_8_0._btnEquip.gameObject, AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_equip)
	gohelper.addUIClickAudio(arg_8_0._btnUnLoad.gameObject, AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_unequip)
end

function var_0_0._onBuffSelectedChange(arg_9_0, arg_9_1)
	arg_9_0._buffConfig = arg_9_1

	arg_9_0:_updateBuffStatus()
end

function var_0_0._updateBuffStatus(arg_10_0)
	arg_10_0._txtBuffName.text = arg_10_0._buffConfig.name
	arg_10_0._txtEffectDesc.text = arg_10_0._buffConfig.desc
	arg_10_0._isPrevBattleSkill = WeekWalk_2BuffListModel.instance.prevBattleSkillId == arg_10_0._buffConfig.id

	local var_10_0 = arg_10_0._isBattle and arg_10_0._selectedSkillId ~= arg_10_0._buffConfig.id

	gohelper.setActive(arg_10_0._btnEquip, var_10_0)
	gohelper.setActive(arg_10_0._btnUnLoad, arg_10_0._isBattle and arg_10_0._selectedSkillId == arg_10_0._buffConfig.id and not arg_10_0._isPrevBattleSkill)

	if var_10_0 then
		ZProj.UGUIHelper.SetGrayscale(arg_10_0._btnEquip.gameObject, arg_10_0._isPrevBattleSkill)
	end

	UISpriteSetMgr.instance:setWeekWalkSprite(arg_10_0._imageBuffIcon, arg_10_0._buffConfig.icon)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._isBattle = arg_12_0.viewParam and arg_12_0.viewParam.isBattle

	if arg_12_0._isBattle then
		local var_12_0 = WeekWalk_2Model.instance:getCurMapInfo()

		arg_12_0._battleId = HeroGroupModel.instance.battleId
		arg_12_0._layerId = var_12_0.id
		arg_12_0._selectedSkillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()
	end

	arg_12_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSelectedChange, arg_12_0._onBuffSelectedChange, arg_12_0)
end

function var_0_0._onBuffSetupReply(arg_13_0)
	arg_13_0:closeThis()
	GameFacade.showToast(ToastEnum.WeekWalk_2BuffSetup)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
