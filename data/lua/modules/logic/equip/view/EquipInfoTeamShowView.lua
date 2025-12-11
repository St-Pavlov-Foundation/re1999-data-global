module("modules.logic.equip.view.EquipInfoTeamShowView", package.seeall)

local var_0_0 = class("EquipInfoTeamShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagecompare = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_compare")
	arg_1_0._goleftempty = gohelper.findChild(arg_1_0.viewGO, "#go_leftempty")
	arg_1_0._goheroempty = gohelper.findChild(arg_1_0.viewGO, "#go_leftempty/#go_heroempty")
	arg_1_0._goequipinfoempty = gohelper.findChild(arg_1_0.viewGO, "#go_leftempty/#go_equipinfoempty")
	arg_1_0._goequipempty = gohelper.findChild(arg_1_0.viewGO, "#go_equipempty")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "container/#go_container")
	arg_1_0._gocontainer1 = gohelper.findChild(arg_1_0.viewGO, "container/#go_container1")
	arg_1_0._goherocontainer = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_herocontainer")
	arg_1_0._txtheroname = gohelper.findChildText(arg_1_0.viewGO, "container/#go_container/#go_herocontainer/#txt_heroname")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/#go_container/#go_herocontainer/mask/#simage_heroicon")
	arg_1_0._imageherocareer = gohelper.findChildImage(arg_1_0.viewGO, "container/#go_container/#go_herocontainer/#image_herocareer")
	arg_1_0._goequipinfo = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#txt_name")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/#txt_level")
	arg_1_0._image1 = gohelper.findChildImage(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_1")
	arg_1_0._image2 = gohelper.findChildImage(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_2")
	arg_1_0._image3 = gohelper.findChildImage(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_3")
	arg_1_0._image4 = gohelper.findChildImage(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_4")
	arg_1_0._image5 = gohelper.findChildImage(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_5")
	arg_1_0._image6 = gohelper.findChildImage(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_6")
	arg_1_0._gostrengthenattr = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	arg_1_0._gobreakeffect = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
	arg_1_0._gosuitattribute = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute")
	arg_1_0._txtattributelv = gohelper.findChildText(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	arg_1_0._scrolldesccontainer = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer")
	arg_1_0._gosuiteffect = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect")
	arg_1_0._gobaseskill = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
	arg_1_0._txteffect = gohelper.findChildText(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/title/#txt_effect")
	arg_1_0._txtsuiteffect2 = gohelper.findChildText(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/#btn_jump")
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "#go_center")
	arg_1_0._simageequip = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_center/#simage_equip")
	arg_1_0._goequipcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_equipcontainer")
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_equipcontainer/#scroll_equip")
	arg_1_0._goequipsort = gohelper.findChild(arg_1_0.viewGO, "#go_equipcontainer/#go_equipsort")
	arg_1_0._btnequiplv = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv")
	arg_1_0._btnequiprare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter")
	arg_1_0._gobuttom = gohelper.findChild(arg_1_0.viewGO, "#go_equipcontainer/#go_buttom")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipcontainer/#go_buttom/#btn_cancel")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipcontainer/#go_buttom/#btn_confirm")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gobalance = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_isBalance")
	arg_1_0._btncompare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_compare")
	arg_1_0._btninteam = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_inteam")
	arg_1_0._btnfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_fold")
	arg_1_0._gointeam = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_inteam")
	arg_1_0._gointeamheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_inteam/#simage_inteamHeroIcon")
	arg_1_0._gointeamheroname = gohelper.findChildText(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_inteam/#txt_inteamName")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gotrialtip = gohelper.findChild(arg_1_0.viewGO, "#go_trialtip")
	arg_1_0.layoutElement = arg_1_0._scrolldesccontainer:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	arg_1_0._goAttr = gohelper.findChild(arg_1_0.viewGO, "container/#go_container/#go_equipinfo/#go_attr")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btnequiplv:AddClickListener(arg_2_0._btnequiplvOnClick, arg_2_0)
	arg_2_0._btnequiprare:AddClickListener(arg_2_0._btnequiprareOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncompare:AddClickListener(arg_2_0._btncompareOnClick, arg_2_0)
	arg_2_0._btnfold:AddClickListener(arg_2_0._btnfoldOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btnequiplv:RemoveClickListener()
	arg_3_0._btnequiprare:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncompare:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
end

function var_0_0._btnfilterOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = arg_4_0.viewName
	})
end

function var_0_0._btncompareOnClick(arg_5_0)
	if not arg_5_0.originEquipMo then
		return
	end

	if arg_5_0.comparing then
		return
	end

	arg_5_0.comparing = true

	gohelper.setActive(arg_5_0._gocontainer1, true)
	gohelper.setActive(arg_5_0._simagecompare.gameObject, true)
	arg_5_0:refreshSelectStatus()
end

function var_0_0._btnfoldOnClick(arg_6_0)
	if not arg_6_0.comparing then
		return
	end

	arg_6_0.comparing = false

	gohelper.setActive(arg_6_0._gocontainer1, false)
	gohelper.setActive(arg_6_0._simagecompare.gameObject, false)
	arg_6_0:refreshSelectStatus()
end

function var_0_0._btncancelOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnconfirmOnClick(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.confirmViewType or arg_8_0.viewParam.fromView

	arg_8_0.handleFuncDict[var_8_0](arg_8_0)
end

function var_0_0._onClickConfirmBtnFromPresetPreviewView(arg_9_0)
	local var_9_0 = arg_9_0.viewContainer.listModel:getGroupCurrentPosEquip()[1]
	local var_9_1 = false

	if var_9_0 and (EquipModel.instance:getEquip(var_9_0) or HeroGroupTrialModel.instance:getEquipMo(var_9_0)) then
		local var_9_2 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local var_9_3 = arg_9_0.viewContainer.listModel.curGroupMO
	local var_9_4 = {
		index = arg_9_0.posIndex,
		equipUid = {
			arg_9_0.selectedEquipMo and arg_9_0.selectedEquipMo.uid or "0"
		}
	}

	var_9_3:updatePosEquips(var_9_4)
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.ChangeEquip, arg_9_0.viewParam.presetGroupId, arg_9_0.viewParam.presetSubId)
	HeroGroupPresetModel.instance:externalSaveCurGroupData(arg_9_0.closeThis, arg_9_0, var_9_3, arg_9_0.viewParam.presetGroupId, arg_9_0.viewParam.presetSubId)
end

function var_0_0._onClickConfirmBtnFromCachotHeroGroupFightView(arg_10_0)
	local var_10_0 = arg_10_0.viewContainer.listModel:getGroupCurrentPosEquip()[1]
	local var_10_1 = false

	if var_10_0 and (EquipModel.instance:getEquip(var_10_0) or HeroGroupTrialModel.instance:getEquipMo(var_10_0)) then
		local var_10_2 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local var_10_3 = arg_10_0.viewContainer.listModel.curGroupMO
	local var_10_4 = {
		index = arg_10_0.posIndex,
		equipUid = {
			arg_10_0.selectedEquipMo and arg_10_0.selectedEquipMo.uid or "0"
		}
	}

	V1a6_CachotHeroGroupModel.instance:replaceEquips(var_10_4, var_10_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_10_0.posIndex)
	V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup(arg_10_0.closeThis, arg_10_0)
end

function var_0_0._onClickConfirmBtnFromRougeHeroGroupFightView(arg_11_0)
	local var_11_0 = arg_11_0.viewContainer.listModel:getGroupCurrentPosEquip()[1]
	local var_11_1 = false

	if var_11_0 and (EquipModel.instance:getEquip(var_11_0) or HeroGroupTrialModel.instance:getEquipMo(var_11_0)) then
		local var_11_2 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local var_11_3 = arg_11_0.viewContainer.listModel.curGroupMO
	local var_11_4 = {
		index = arg_11_0.posIndex,
		equipUid = {
			arg_11_0.selectedEquipMo and arg_11_0.selectedEquipMo.uid or "0"
		}
	}

	RougeHeroGroupModel.instance:replaceEquips(var_11_4, var_11_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_11_0.posIndex)
	RougeHeroGroupModel.instance:rougeSaveCurGroup(arg_11_0.closeThis, arg_11_0, var_11_3)
end

function var_0_0._onClickConfirmBtnFromCachotHeroGroupView(arg_12_0)
	local var_12_0 = arg_12_0.viewContainer.listModel:getGroupCurrentPosEquip()[1]
	local var_12_1 = false

	if var_12_0 and (EquipModel.instance:getEquip(var_12_0) or HeroGroupTrialModel.instance:getEquipMo(var_12_0)) then
		local var_12_2 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local var_12_3 = arg_12_0.viewContainer.listModel.curGroupMO
	local var_12_4 = {
		index = arg_12_0.posIndex,
		equipUid = {
			arg_12_0.selectedEquipMo and arg_12_0.selectedEquipMo.uid or "0"
		}
	}

	V1a6_CachotHeroGroupModel.instance:replaceEquips(var_12_4, var_12_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_12_0.posIndex)
	arg_12_0:closeThis()
end

function var_0_0._onClickConfirmBtnFromHeroGroupFightView(arg_13_0)
	local var_13_0 = arg_13_0.viewContainer.listModel:getGroupCurrentPosEquip()[1]
	local var_13_1 = false

	if var_13_0 and (EquipModel.instance:getEquip(var_13_0) or HeroGroupTrialModel.instance:getEquipMo(var_13_0)) then
		local var_13_2 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local var_13_3 = arg_13_0.viewContainer.listModel.curGroupMO
	local var_13_4 = {
		index = arg_13_0.posIndex,
		equipUid = {
			arg_13_0.selectedEquipMo and arg_13_0.selectedEquipMo.uid or "0"
		}
	}

	HeroGroupModel.instance:replaceEquips(var_13_4, var_13_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_13_0.posIndex)
	HeroGroupModel.instance:saveCurGroupData(arg_13_0.closeThis, arg_13_0, var_13_3)
end

function var_0_0._onClickConfirmBtnFromSeason166HeroGroupFightView(arg_14_0)
	local var_14_0 = arg_14_0.viewContainer.listModel:getGroupCurrentPosEquip()[1]
	local var_14_1 = false

	if var_14_0 and (EquipModel.instance:getEquip(var_14_0) or HeroGroupTrialModel.instance:getEquipMo(var_14_0)) then
		local var_14_2 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local var_14_3 = arg_14_0.viewContainer.listModel.curGroupMO
	local var_14_4 = {
		index = arg_14_0.posIndex,
		equipUid = {
			arg_14_0.selectedEquipMo and arg_14_0.selectedEquipMo.uid or "0"
		}
	}

	Season166HeroGroupModel.instance:replaceEquips(var_14_4, var_14_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_14_0.posIndex)
	Season166HeroGroupModel.instance:saveCurGroupData(arg_14_0.closeThis, arg_14_0, var_14_3)
end

function var_0_0._onClickConfirmBtnFromCharacterView(arg_15_0)
	HeroRpc.instance:setHeroDefaultEquipRequest(arg_15_0.heroMo.heroId, arg_15_0.selectedEquipMo and arg_15_0.selectedEquipMo.uid or "0")
end

function var_0_0._btnjumpOnClick(arg_16_0)
	if arg_16_0.selectedEquipMo then
		arg_16_0._anim:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(function()
			ViewMgr.instance:openView(ViewName.EquipView, {
				equipMO = arg_16_0.selectedEquipMo,
				defaultTabIds = {
					[2] = 2
				}
			})
		end, nil, 0.07)
	end
end

function var_0_0._btnequiplvOnClick(arg_18_0)
	arg_18_0.listModel:changeSortByLevel()
	arg_18_0:refreshBtnStatus()
end

function var_0_0._btnequiprareOnClick(arg_19_0)
	arg_19_0.listModel:changeSortByRare()
	arg_19_0:refreshBtnStatus()
end

function var_0_0.onEquipTypeHasChange(arg_20_0, arg_20_1)
	if arg_20_1 ~= arg_20_0.viewName then
		return
	end

	arg_20_0._scrollequip.verticalNormalizedPosition = 1

	local var_20_0 = arg_20_0.heroMo and arg_20_0.heroMo:getTrialEquipMo()

	if var_20_0 then
		if arg_20_0.filterMo:checkIsIncludeTag(var_20_0.config) then
			arg_20_0.listModel.equipMoList = {
				var_20_0
			}
		else
			arg_20_0.listModel.equipMoList = {}
		end
	else
		arg_20_0.listModel:initEquipList(arg_20_0.filterMo)
	end

	arg_20_0.listModel:refreshEquipList()
	arg_20_0:refreshFilterBtnStatus()
end

function var_0_0._editableInitView(arg_21_0)
	arg_21_0.goNotFilter = gohelper.findChild(arg_21_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_notfilter")
	arg_21_0.goFilter = gohelper.findChild(arg_21_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_filter")
	arg_21_0.goRareBtnNoSelect = gohelper.findChild(arg_21_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn1")
	arg_21_0.goRareBtnSelect = gohelper.findChild(arg_21_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2")
	arg_21_0.goLvBtnNoSelect = gohelper.findChild(arg_21_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn1")
	arg_21_0.goLvBtnSelect = gohelper.findChild(arg_21_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2")
	arg_21_0.goRareBtnSelectArrow = gohelper.findChild(arg_21_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2/txt/arrow")
	arg_21_0.goLvBtnSelectArrow = gohelper.findChild(arg_21_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2/txt/arrow")
	arg_21_0.goBaseSkillCanvasGroup = arg_21_0._gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_21_0.imageBreakIcon = gohelper.findChildImage(arg_21_0._gobreakeffect, "image_icon")
	arg_21_0.txtBreakAttrName = gohelper.findChildText(arg_21_0._gobreakeffect, "txt_name")
	arg_21_0.txtBreakValue = gohelper.findChildText(arg_21_0._gobreakeffect, "txt_value")

	gohelper.setActive(arg_21_0._goleftempty, true)
	gohelper.setActive(arg_21_0._gocontainer1, false)
	gohelper.setActive(arg_21_0._gostrengthenattr, false)
	gohelper.setActive(arg_21_0._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(arg_21_0._btnjump.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	gohelper.addUIClickAudio(arg_21_0._btncompare.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)
	gohelper.addUIClickAudio(arg_21_0._btnfold.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)

	arg_21_0.strengthenAttrItems = arg_21_0:getUserDataTb_()
	arg_21_0.skillAttributeItems = arg_21_0:getUserDataTb_()
	arg_21_0.skillDescItems = arg_21_0:getUserDataTb_()
	arg_21_0.container1_strengthenAttrItems = arg_21_0:getUserDataTb_()
	arg_21_0.container1_skillAttributeItems = arg_21_0:getUserDataTb_()
	arg_21_0.container1_skillDescItems = arg_21_0:getUserDataTb_()

	arg_21_0:addEventCb(EquipController.instance, EquipEvent.ChangeSelectedEquip, arg_21_0.onSelectEquipChange, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_21_0.onEquipChange, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_21_0.onEquipChange, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_21_0.onEquipChange, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_21_0.onEquipChange, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_21_0.onDeleteEquip, arg_21_0)
	arg_21_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_21_0._onCloseFullView, arg_21_0, LuaEventSystem.Low)
	arg_21_0:addEventCb(CharacterController.instance, CharacterEvent.successSetDefaultEquip, arg_21_0.onSuccessSetDefaultEquip, arg_21_0)
	arg_21_0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, arg_21_0.onEquipTypeHasChange, arg_21_0)

	arg_21_0.txtConfirm = gohelper.findChildText(arg_21_0._btnconfirm.gameObject, "txt")
	arg_21_0.comparing = false
	arg_21_0.handleFuncDict = {
		[EquipEnum.FromViewEnum.FromHeroGroupFightView] = arg_21_0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupFightView] = arg_21_0._onClickConfirmBtnFromCachotHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupView] = arg_21_0._onClickConfirmBtnFromCachotHeroGroupView,
		[EquipEnum.FromViewEnum.FromRougeHeroGroupFightView] = arg_21_0._onClickConfirmBtnFromRougeHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCharacterView] = arg_21_0._onClickConfirmBtnFromCharacterView,
		[EquipEnum.FromViewEnum.FromSeasonFightView] = arg_21_0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView] = arg_21_0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView] = arg_21_0._onClickConfirmBtnFromSeason166HeroGroupFightView,
		[EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView] = arg_21_0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromPresetPreviewView] = arg_21_0._onClickConfirmBtnFromPresetPreviewView
	}
end

function var_0_0.onUpdateParam(arg_22_0)
	return
end

function var_0_0.onOpenFinish(arg_23_0)
	arg_23_0._anim.enabled = true

	if arg_23_0.viewParam and arg_23_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.EquipInfo)
	end
end

function var_0_0._onCloseFullView(arg_24_0)
	if arg_24_0._anim then
		arg_24_0._anim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.onOpen(arg_25_0)
	arg_25_0.filterMo = EquipFilterModel.instance:generateFilterMo(arg_25_0.viewName)
	arg_25_0.heroMo = arg_25_0.viewParam.heroMo
	arg_25_0.posIndex = arg_25_0.viewParam.posIndex
	arg_25_0._isBalance = arg_25_0.viewParam.isBalance

	arg_25_0:initOriginEquipMo()

	arg_25_0.listModel = arg_25_0.viewContainer:getListModel()

	arg_25_0.listModel:onOpen(arg_25_0.viewParam, arg_25_0.filterMo)

	arg_25_0.selectedEquipMo = arg_25_0.listModel:getCurrentSelectEquipMo()

	arg_25_0._simagebg:LoadImage(ResUrl.getEquipBg("bg_beijingjianbian.png"))
	arg_25_0._simagecompare:LoadImage(ResUrl.getEquipBg("full/bg_black_mask.png"))
	arg_25_0:refreshCompareContainerUI()
	arg_25_0:refreshUI()

	arg_25_0.txtConfirm.text = luaLang("confirm_text")
end

function var_0_0.initOriginEquipMo(arg_26_0)
	arg_26_0.originEquipMo = nil

	if arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView then
		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	elseif arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		arg_26_0.originEquipMo = EquipModel.instance:getEquip(arg_26_0.viewParam.heroMo.defaultEquipUid)
	elseif arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView then
		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	elseif arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	elseif arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromPresetPreviewView then
		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	elseif arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	elseif arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView or arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView then
		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	elseif arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView then
		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	elseif arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromAssassinHeroView then
		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	else
		logError("not found from view ...")

		arg_26_0.originEquipMo = arg_26_0.viewParam.equipMo
	end
end

function var_0_0.refreshCompareContainerUI(arg_27_0)
	local var_27_0 = arg_27_0.originEquipMo

	if not var_27_0 then
		gohelper.setActive(arg_27_0._gocontainer1, false)
		gohelper.setActive(arg_27_0._simagecompare.gameObject, false)

		return
	end

	local var_27_1 = tonumber(var_27_0.uid) > 0 and arg_27_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	var_27_1 = var_27_1 or arg_27_0._isBalance

	if var_27_1 then
		local var_27_2 = arg_27_0.viewContainer:getBalanceEquipLv()

		if var_27_2 > var_27_0.level then
			local var_27_3 = EquipMO.New()

			var_27_3:initByConfig(nil, var_27_0.equipId, var_27_2, var_27_0.refineLv)

			var_27_0 = var_27_3
		else
			var_27_1 = nil
		end
	end

	if not arg_27_0.container1_txtname then
		arg_27_0.container1_txtname = gohelper.findChildText(arg_27_0._gocontainer1, "#go_equipinfo/#txt_name")
	end

	arg_27_0.container1_txtname.text = var_27_0.config.name

	if not arg_27_0.container1_txtlevel then
		arg_27_0.container1_txtlevel = gohelper.findChildText(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr/#txt_level")
	end

	if not arg_27_0.container1_gobalance then
		arg_27_0.container1_gobalance = gohelper.findChild(arg_27_0._gocontainer1, "#go_equipinfo/#go_isBalance")
	end

	gohelper.setActive(arg_27_0.container1_gobalance, var_27_1)

	if not arg_27_0.container1_goattr then
		arg_27_0.container1_goattr = gohelper.findChild(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr").transform
	end

	local var_27_4, var_27_5 = transformhelper.getLocalPos(arg_27_0.container1_goattr)

	transformhelper.setLocalPosXY(arg_27_0.container1_goattr, var_27_4, var_27_1 and -28 or 17.3)

	local var_27_6 = var_27_0.level
	local var_27_7 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(var_27_0)

	if var_27_1 then
		arg_27_0.container1_txtlevel.text = string.format("Lv.<color=#8fb1cc>%d</color>/<color=#8fb1cc>%d</color>", var_27_6, var_27_7)
	else
		arg_27_0.container1_txtlevel.text = string.format("Lv.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", var_27_6, var_27_7)
	end

	if not arg_27_0.container1_goStarList then
		arg_27_0.container1_goStarList = arg_27_0:getUserDataTb_()

		for iter_27_0 = 1, 6 do
			table.insert(arg_27_0.container1_goStarList, gohelper.findChild(arg_27_0._gocontainer1, "#go_equipinfo/go_insigt/#image_" .. iter_27_0))
		end
	end

	local var_27_8 = var_27_0.config.rare

	for iter_27_1 = 1, 6 do
		gohelper.setActive(arg_27_0.container1_goStarList[iter_27_1], iter_27_1 <= var_27_8 + 1)
	end

	if not arg_27_0.container1_gostrengthenattr then
		arg_27_0.container1_gostrengthenattr = gohelper.findChild(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	end

	gohelper.setActive(arg_27_0.container1_gostrengthenattr, false)

	local var_27_9, var_27_10 = EquipConfig.instance:getEquipNormalAttr(var_27_0.config.id, var_27_0.level, HeroConfig.sortAttrForEquipView)
	local var_27_11
	local var_27_12

	for iter_27_2, iter_27_3 in ipairs(var_27_10) do
		local var_27_13 = arg_27_0.container1_strengthenAttrItems[iter_27_2]

		if not var_27_13 then
			var_27_13 = arg_27_0:getUserDataTb_()
			var_27_13.go = gohelper.cloneInPlace(arg_27_0.container1_gostrengthenattr, "item" .. iter_27_2)
			var_27_13.icon = gohelper.findChildImage(var_27_13.go, "image_icon")
			var_27_13.name = gohelper.findChildText(var_27_13.go, "txt_name")
			var_27_13.attr_value = gohelper.findChildText(var_27_13.go, "txt_value")
			var_27_13.bg = gohelper.findChild(var_27_13.go, "bg")

			table.insert(arg_27_0.container1_strengthenAttrItems, var_27_13)
		end

		local var_27_14 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_27_3.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_27_13.icon, "icon_att_" .. var_27_14.id)

		var_27_13.name.text = var_27_14.name
		var_27_13.attr_value.text = iter_27_3.value

		gohelper.setActive(var_27_13.bg, iter_27_2 % 2 == 0)
		gohelper.setActive(var_27_13.go, true)
	end

	for iter_27_4 = #var_27_10 + 1, #arg_27_0.container1_strengthenAttrItems do
		gohelper.setActive(arg_27_0.container1_strengthenAttrItems[iter_27_4].go, false)
	end

	if not arg_27_0.container1_gobreakeffect then
		arg_27_0.container1_gobreakeffect = gohelper.findChild(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
		arg_27_0.container1_imageBreakIcon = gohelper.findChildImage(arg_27_0.container1_gobreakeffect, "image_icon")
		arg_27_0.container1_txtBreakAttrName = gohelper.findChildText(arg_27_0.container1_gobreakeffect, "txt_name")
		arg_27_0.container1_txtBreakValue = gohelper.findChildText(arg_27_0.container1_gobreakeffect, "txt_value")
	end

	local var_27_15, var_27_16 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_27_0.config, var_27_0.breakLv)

	if var_27_15 then
		gohelper.setActive(arg_27_0.container1_gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_27_0.container1_imageBreakIcon, "icon_att_" .. var_27_15)

		arg_27_0.container1_txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_27_15)
		arg_27_0.container1_txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_27_16)

		gohelper.setAsLastSibling(arg_27_0.container1_gobreakeffect)
	else
		gohelper.setActive(arg_27_0.container1_gobreakeffect, false)
	end

	if not arg_27_0.container1_gosuitattribute then
		arg_27_0.container1_gosuitattribute = gohelper.findChild(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute")
	end

	if var_27_0.config.rare <= EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(arg_27_0.container1_gosuitattribute, false)

		return
	end

	gohelper.setActive(arg_27_0.container1_gosuitattribute, true)

	if not arg_27_0.container1_txtattributelv then
		arg_27_0.container1_txtattributelv = gohelper.findChildText(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	end

	if not arg_27_0.container1_goadvanceskill then
		arg_27_0.container1_goadvanceskill = gohelper.findChild(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")
	end

	if not arg_27_0.container1_gobaseskill then
		arg_27_0.container1_gobaseskill = gohelper.findChild(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
		arg_27_0.container1_goBaseSkillCanvasGroup = arg_27_0.container1_gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	if not arg_27_0.container1_txtsuiteffect2 then
		arg_27_0.container1_txtsuiteffect2 = gohelper.findChildText(arg_27_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	end

	gohelper.setActive(arg_27_0.container1_txtsuiteffect2.gameObject, false)

	local var_27_17 = EquipHelper.getEquipSkillBaseDes(var_27_0.config.id, var_27_0.refineLv, "#D9A06F")

	if #var_27_17 == 0 then
		gohelper.setActive(arg_27_0.container1_gobaseskill, false)
	else
		arg_27_0.container1_txtattributelv.text = var_27_0.refineLv

		gohelper.setActive(arg_27_0.container1_gobaseskill, true)

		local var_27_18

		for iter_27_5, iter_27_6 in ipairs(var_27_17) do
			local var_27_19 = arg_27_0.container1_skillDescItems[iter_27_5]

			if not var_27_19 then
				var_27_19 = arg_27_0:getUserDataTb_()
				var_27_19.itemGo = gohelper.cloneInPlace(arg_27_0.container1_txtsuiteffect2.gameObject, "item_" .. iter_27_5)
				var_27_19.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_27_19.itemGo, FixTmpBreakLine)
				var_27_19.imagepoint = gohelper.findChildImage(var_27_19.itemGo, "#image_point")
				var_27_19.txt = var_27_19.itemGo:GetComponent(gohelper.Type_TextMesh)

				SkillHelper.addHyperLinkClick(var_27_19.txt)
				table.insert(arg_27_0.container1_skillDescItems, var_27_19)
			end

			var_27_19.txt.text = EquipHelper.getEquipSkillDesc(iter_27_6)

			var_27_19.fixTmpBreakLine:refreshTmpContent(var_27_19.txt)
			gohelper.setActive(var_27_19.itemGo, true)
		end

		arg_27_0.container1_goBaseSkillCanvasGroup.alpha = var_27_0 and arg_27_0.heroMo and EquipHelper.detectEquipSkillSuited(arg_27_0.heroMo.heroId, var_27_0.config.id, var_27_0.refineLv) and 1 or 0.4

		for iter_27_7 = #var_27_17 + 1, #arg_27_0.container1_skillDescItems do
			gohelper.setActive(arg_27_0.container1_skillDescItems[iter_27_7].itemGo, false)
		end
	end
end

function var_0_0.refreshUI(arg_28_0)
	arg_28_0:refreshBtnStatus()
	arg_28_0:refreshHeroInfo()
	arg_28_0:refreshLeftUI()
	arg_28_0:refreshCenterUI()
	arg_28_0:refreshRightUI()
end

function var_0_0.refreshBtnStatus(arg_29_0)
	gohelper.setActive(arg_29_0.goRareBtnNoSelect, not arg_29_0.listModel:isSortByRare())
	gohelper.setActive(arg_29_0.goRareBtnSelect, arg_29_0.listModel:isSortByRare())
	gohelper.setActive(arg_29_0.goLvBtnNoSelect, not arg_29_0.listModel:isSortByLevel())
	gohelper.setActive(arg_29_0.goLvBtnSelect, arg_29_0.listModel:isSortByLevel())

	local var_29_0, var_29_1 = arg_29_0.listModel:getSortState()

	transformhelper.setLocalScale(arg_29_0.goRareBtnSelectArrow.transform, 1, var_29_1, 1)
	transformhelper.setLocalScale(arg_29_0.goLvBtnSelectArrow.transform, 1, var_29_0, 1)
	arg_29_0:refreshFilterBtnStatus()
end

function var_0_0.refreshFilterBtnStatus(arg_30_0)
	local var_30_0 = arg_30_0.filterMo:isFiltering()

	gohelper.setActive(arg_30_0.goNotFilter, not var_30_0)
	gohelper.setActive(arg_30_0.goFilter, var_30_0)
end

function var_0_0.refreshHeroInfo(arg_31_0)
	gohelper.setActive(arg_31_0._goherocontainer, arg_31_0.heroMo)
	gohelper.setActive(arg_31_0._goheroempty, not arg_31_0.heroMo)

	if not arg_31_0.heroMo then
		return
	end

	arg_31_0._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(arg_31_0.heroMo.config.skinId))

	arg_31_0._txtheroname.text = arg_31_0.heroMo:getHeroName()

	UISpriteSetMgr.instance:setHandBookCareerSprite(arg_31_0._imageherocareer, "sx_icon_" .. tostring(arg_31_0.heroMo.config.career))
end

function var_0_0.refreshLeftUI(arg_32_0)
	local var_32_0 = arg_32_0.heroMo and arg_32_0.heroMo.trialEquipMo and true or false
	local var_32_1 = arg_32_0.selectedEquipMo and not var_32_0 and tonumber(arg_32_0.selectedEquipMo.uid) > 0 and arg_32_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	var_32_1 = var_32_1 or arg_32_0._isBalance
	arg_32_0._balanceEquipMo = nil

	if var_32_1 and arg_32_0.selectedEquipMo then
		local var_32_2 = arg_32_0.viewContainer:getBalanceEquipLv()

		if var_32_2 <= arg_32_0.selectedEquipMo.level then
			var_32_1 = nil
		else
			local var_32_3 = EquipMO.New()

			var_32_3:initByConfig(nil, arg_32_0.selectedEquipMo.equipId, var_32_2, arg_32_0.selectedEquipMo.refineLv)

			arg_32_0._balanceEquipMo = var_32_3
		end
	end

	gohelper.setActive(arg_32_0._gotrialtip, var_32_0)
	gohelper.setActive(arg_32_0._goequipinfo, arg_32_0.selectedEquipMo)
	gohelper.setActive(arg_32_0._goequipinfoempty, not arg_32_0.selectedEquipMo)
	gohelper.setActive(arg_32_0._gobalance, var_32_1)

	local var_32_4, var_32_5 = transformhelper.getLocalPos(arg_32_0._goAttr.transform)

	transformhelper.setLocalPosXY(arg_32_0._goAttr.transform, var_32_4, var_32_1 and -172.2 or -127)

	arg_32_0.layoutElement.minHeight = var_32_1 and 142 or 187

	if arg_32_0.selectedEquipMo then
		arg_32_0._txtname.text = arg_32_0.selectedEquipMo.config.name

		arg_32_0:refreshEquipStar()
		arg_32_0:refreshSelectStatus()
		arg_32_0:refreshEquipLevel()
		arg_32_0:refreshEquipNormalAttr()

		if arg_32_0.selectedEquipMo.config.rare > EquipConfig.instance:getNotShowRefineRare() then
			arg_32_0:refreshEquipSkillDesc()
			gohelper.setActive(arg_32_0._gosuitattribute, true)
		else
			gohelper.setActive(arg_32_0._gosuitattribute, false)
		end

		arg_32_0:refreshInTeam()
	end

	local var_32_6 = arg_32_0.selectedEquipMo ~= nil and tonumber(arg_32_0.selectedEquipMo.uid) > 0

	gohelper.setActive(arg_32_0._btnjump.gameObject, var_32_6)
	gohelper.setActive(arg_32_0._gobuttom, not var_32_0)
end

function var_0_0.refreshCenterUI(arg_33_0)
	if arg_33_0.selectedEquipMo then
		arg_33_0._simageequip:LoadImage(ResUrl.getEquipSuit(arg_33_0.selectedEquipMo.config.icon))
		gohelper.setActive(arg_33_0._gocenter, true)
	else
		gohelper.setActive(arg_33_0._gocenter, false)
	end
end

function var_0_0.refreshRightUI(arg_34_0)
	local var_34_0 = arg_34_0.listModel:isEmpty()

	gohelper.setActive(arg_34_0._scrollequip.gameObject, not var_34_0)
	gohelper.setActive(arg_34_0._goequipempty, var_34_0)

	if not var_34_0 then
		arg_34_0.listModel:refreshEquipList()
	end
end

function var_0_0.refreshEquipStar(arg_35_0)
	local var_35_0 = arg_35_0.selectedEquipMo.config.rare

	for iter_35_0 = 1, 6 do
		gohelper.setActive(arg_35_0["_image" .. iter_35_0].gameObject, iter_35_0 <= var_35_0 + 1)
	end
end

function var_0_0.refreshSelectStatus(arg_36_0)
	if not arg_36_0.originEquipMo then
		gohelper.setActive(arg_36_0._btncompare.gameObject, false)
		gohelper.setActive(arg_36_0._btninteam.gameObject, false)
		gohelper.setActive(arg_36_0._btnfold.gameObject, false)

		return
	end

	if arg_36_0.comparing then
		gohelper.setActive(arg_36_0._btncompare.gameObject, false)
		gohelper.setActive(arg_36_0._btninteam.gameObject, false)
		gohelper.setActive(arg_36_0._btnfold.gameObject, true)

		return
	end

	if arg_36_0.originEquipMo.uid == arg_36_0.selectedEquipMo.uid then
		gohelper.setActive(arg_36_0._btncompare.gameObject, false)
		gohelper.setActive(arg_36_0._btninteam.gameObject, true)
		gohelper.setActive(arg_36_0._btnfold.gameObject, false)

		return
	end

	gohelper.setActive(arg_36_0._btncompare.gameObject, true)
	gohelper.setActive(arg_36_0._btninteam.gameObject, false)
	gohelper.setActive(arg_36_0._btnfold.gameObject, false)
end

function var_0_0.refreshEquipLevel(arg_37_0)
	if arg_37_0._balanceEquipMo then
		local var_37_0 = arg_37_0._balanceEquipMo.level
		local var_37_1 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_37_0._balanceEquipMo)

		arg_37_0._txtlevel.text = string.format("Lv.<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>/<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>", var_37_0, var_37_1)
	else
		local var_37_2 = arg_37_0.selectedEquipMo.level
		local var_37_3 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_37_0.selectedEquipMo)

		arg_37_0._txtlevel.text = string.format("Lv.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", var_37_2, var_37_3)
	end
end

function var_0_0.refreshEquipNormalAttr(arg_38_0)
	local var_38_0 = arg_38_0._balanceEquipMo or arg_38_0.selectedEquipMo
	local var_38_1, var_38_2 = EquipConfig.instance:getEquipNormalAttr(var_38_0.config.id, var_38_0.level, HeroConfig.sortAttrForEquipView)
	local var_38_3
	local var_38_4

	for iter_38_0, iter_38_1 in ipairs(var_38_2) do
		local var_38_5 = arg_38_0.strengthenAttrItems[iter_38_0]

		if not var_38_5 then
			var_38_5 = {
				go = gohelper.cloneInPlace(arg_38_0._gostrengthenattr, "item" .. iter_38_0)
			}
			var_38_5.icon = gohelper.findChildImage(var_38_5.go, "image_icon")
			var_38_5.name = gohelper.findChildText(var_38_5.go, "txt_name")
			var_38_5.attr_value = gohelper.findChildText(var_38_5.go, "txt_value")
			var_38_5.bg = gohelper.findChild(var_38_5.go, "bg")

			table.insert(arg_38_0.strengthenAttrItems, var_38_5)
		end

		local var_38_6 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_38_1.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_38_5.icon, "icon_att_" .. var_38_6.id)

		var_38_5.name.text = var_38_6.name
		var_38_5.attr_value.text = iter_38_1.value

		gohelper.setActive(var_38_5.bg, iter_38_0 % 2 == 0)
		gohelper.setActive(var_38_5.go, true)
	end

	for iter_38_2 = #var_38_2 + 1, #arg_38_0.strengthenAttrItems do
		gohelper.setActive(arg_38_0.strengthenAttrItems[iter_38_2].go, false)
	end

	local var_38_7, var_38_8 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_38_0.config, var_38_0.breakLv)

	if var_38_7 then
		gohelper.setActive(arg_38_0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_38_0.imageBreakIcon, "icon_att_" .. var_38_7)

		arg_38_0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_38_7)
		arg_38_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_38_8)

		gohelper.setAsLastSibling(arg_38_0._gobreakeffect)
	else
		gohelper.setActive(arg_38_0._gobreakeffect, false)
	end
end

function var_0_0.refreshEquipSkillDesc(arg_39_0)
	local var_39_0 = EquipHelper.getEquipSkillBaseDes(arg_39_0.selectedEquipMo.config.id, arg_39_0.selectedEquipMo.refineLv, "#D9A06F")

	if #var_39_0 == 0 then
		gohelper.setActive(arg_39_0._gobaseskill.gameObject, false)
	else
		arg_39_0._txtattributelv.text = arg_39_0.selectedEquipMo.refineLv

		gohelper.setActive(arg_39_0._gobaseskill.gameObject, true)

		local var_39_1
		local var_39_2
		local var_39_3

		for iter_39_0, iter_39_1 in ipairs(var_39_0) do
			local var_39_4 = arg_39_0.skillDescItems[iter_39_0]

			if not var_39_4 then
				local var_39_5 = arg_39_0:getUserDataTb_()
				local var_39_6 = gohelper.cloneInPlace(arg_39_0._txtsuiteffect2.gameObject, "item_" .. iter_39_0)

				var_39_5.itemGo = var_39_6
				var_39_5.imagepoint = gohelper.findChildImage(var_39_6, "#image_point")
				var_39_5.txt = var_39_6:GetComponent(gohelper.Type_TextMesh)

				SkillHelper.addHyperLinkClick(var_39_5.txt)

				var_39_4 = var_39_5

				table.insert(arg_39_0.skillDescItems, var_39_4)
			end

			var_39_4.txt.text = EquipHelper.getEquipSkillDesc(iter_39_1)

			gohelper.setActive(var_39_4.itemGo, true)
		end

		for iter_39_2 = #var_39_0 + 1, #arg_39_0.skillDescItems do
			gohelper.setActive(arg_39_0.skillDescItems[iter_39_2].itemGo, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end
end

function var_0_0.refreshInTeam(arg_40_0)
	if arg_40_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromHeroGroupFightView and arg_40_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromSeasonFightView and arg_40_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupView and arg_40_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupFightView and arg_40_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView then
		gohelper.setActive(arg_40_0._gointeam, false)

		return
	end

	local var_40_0 = arg_40_0.viewContainer.listModel:getHeroMoByEquipUid(arg_40_0.selectedEquipMo.uid)

	if arg_40_0.heroMo and var_40_0 and arg_40_0.selectedEquipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		var_40_0 = arg_40_0.heroMo
	end

	if var_40_0 then
		gohelper.setActive(arg_40_0._gointeam, true)

		local var_40_1 = lua_skin.configDict[var_40_0.skin]

		arg_40_0._gointeamheroicon:LoadImage(ResUrl.getHeadIconSmall(var_40_1.headIcon))

		arg_40_0._gointeamheroname.text = string.format(luaLang("hero_inteam"), var_40_0.config.name)
	else
		gohelper.setActive(arg_40_0._gointeam, false)
	end
end

function var_0_0.onSelectEquipChange(arg_41_0)
	arg_41_0.selectedEquipMo = arg_41_0.listModel:getCurrentSelectEquipMo()

	arg_41_0:refreshLeftUI()
	arg_41_0:refreshCenterUI()
end

function var_0_0.onEquipChange(arg_42_0)
	arg_42_0.listModel:initEquipList(arg_42_0.filterMo)
	arg_42_0:refreshLeftUI()
	arg_42_0:refreshRightUI()
	arg_42_0:refreshCompareContainerUI()
end

function var_0_0.onDeleteEquip(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_1) do
		if arg_43_0.selectedEquipMo.uid == iter_43_1 then
			arg_43_0.listModel:setCurrentSelectEquipMo(nil)
			arg_43_0:onSelectEquipChange()

			break
		end
	end
end

function var_0_0.onSuccessSetDefaultEquip(arg_44_0, arg_44_1)
	arg_44_0:closeThis()
end

function var_0_0.onClose(arg_45_0)
	arg_45_0._simageheroicon:UnLoadImage()
	arg_45_0._simageequip:UnLoadImage()
	arg_45_0._simagebg:UnLoadImage()
	arg_45_0._simagecompare:UnLoadImage()
	arg_45_0.listModel:clearRecommend()
	arg_45_0.listModel:clear()
	EquipFilterModel.instance:clear(arg_45_0.viewName)
end

function var_0_0.onDestroyView(arg_46_0)
	return
end

return var_0_0
