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

function var_0_0._onClickConfirmBtnFromCachotHeroGroupFightView(arg_9_0)
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

	V1a6_CachotHeroGroupModel.instance:replaceEquips(var_9_4, var_9_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_9_0.posIndex)
	V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup(arg_9_0.closeThis, arg_9_0)
end

function var_0_0._onClickConfirmBtnFromRougeHeroGroupFightView(arg_10_0)
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

	RougeHeroGroupModel.instance:replaceEquips(var_10_4, var_10_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_10_0.posIndex)
	RougeHeroGroupModel.instance:rougeSaveCurGroup(arg_10_0.closeThis, arg_10_0, var_10_3)
end

function var_0_0._onClickConfirmBtnFromCachotHeroGroupView(arg_11_0)
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

	V1a6_CachotHeroGroupModel.instance:replaceEquips(var_11_4, var_11_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_11_0.posIndex)
	arg_11_0:closeThis()
end

function var_0_0._onClickConfirmBtnFromHeroGroupFightView(arg_12_0)
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

	HeroGroupModel.instance:replaceEquips(var_12_4, var_12_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_12_0.posIndex)
	HeroGroupModel.instance:saveCurGroupData(arg_12_0.closeThis, arg_12_0, var_12_3)
end

function var_0_0._onClickConfirmBtnFromSeason166HeroGroupFightView(arg_13_0)
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

	Season166HeroGroupModel.instance:replaceEquips(var_13_4, var_13_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_13_0.posIndex)
	Season166HeroGroupModel.instance:saveCurGroupData(arg_13_0.closeThis, arg_13_0, var_13_3)
end

function var_0_0._onClickConfirmBtnFromCharacterView(arg_14_0)
	HeroRpc.instance:setHeroDefaultEquipRequest(arg_14_0.heroMo.heroId, arg_14_0.selectedEquipMo and arg_14_0.selectedEquipMo.uid or "0")
end

function var_0_0._btnjumpOnClick(arg_15_0)
	if arg_15_0.selectedEquipMo then
		arg_15_0._anim:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(function()
			ViewMgr.instance:openView(ViewName.EquipView, {
				equipMO = arg_15_0.selectedEquipMo,
				defaultTabIds = {
					[2] = 2
				}
			})
		end, nil, 0.07)
	end
end

function var_0_0._btnequiplvOnClick(arg_17_0)
	arg_17_0.listModel:changeSortByLevel()
	arg_17_0:refreshBtnStatus()
end

function var_0_0._btnequiprareOnClick(arg_18_0)
	arg_18_0.listModel:changeSortByRare()
	arg_18_0:refreshBtnStatus()
end

function var_0_0.onEquipTypeHasChange(arg_19_0, arg_19_1)
	if arg_19_1 ~= arg_19_0.viewName then
		return
	end

	arg_19_0._scrollequip.verticalNormalizedPosition = 1

	local var_19_0 = arg_19_0.heroMo and arg_19_0.heroMo:getTrialEquipMo()

	if var_19_0 then
		if arg_19_0.filterMo:checkIsIncludeTag(var_19_0.config) then
			arg_19_0.listModel.equipMoList = {
				var_19_0
			}
		else
			arg_19_0.listModel.equipMoList = {}
		end
	else
		arg_19_0.listModel:initEquipList(arg_19_0.filterMo)
	end

	arg_19_0.listModel:refreshEquipList()
	arg_19_0:refreshFilterBtnStatus()
end

function var_0_0._editableInitView(arg_20_0)
	arg_20_0.goNotFilter = gohelper.findChild(arg_20_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_notfilter")
	arg_20_0.goFilter = gohelper.findChild(arg_20_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_filter")
	arg_20_0.goRareBtnNoSelect = gohelper.findChild(arg_20_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn1")
	arg_20_0.goRareBtnSelect = gohelper.findChild(arg_20_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2")
	arg_20_0.goLvBtnNoSelect = gohelper.findChild(arg_20_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn1")
	arg_20_0.goLvBtnSelect = gohelper.findChild(arg_20_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2")
	arg_20_0.goRareBtnSelectArrow = gohelper.findChild(arg_20_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2/txt/arrow")
	arg_20_0.goLvBtnSelectArrow = gohelper.findChild(arg_20_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2/txt/arrow")
	arg_20_0.goBaseSkillCanvasGroup = arg_20_0._gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_20_0.imageBreakIcon = gohelper.findChildImage(arg_20_0._gobreakeffect, "image_icon")
	arg_20_0.txtBreakAttrName = gohelper.findChildText(arg_20_0._gobreakeffect, "txt_name")
	arg_20_0.txtBreakValue = gohelper.findChildText(arg_20_0._gobreakeffect, "txt_value")

	gohelper.setActive(arg_20_0._goleftempty, true)
	gohelper.setActive(arg_20_0._gocontainer1, false)
	gohelper.setActive(arg_20_0._gostrengthenattr, false)
	gohelper.setActive(arg_20_0._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(arg_20_0._btnjump.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	gohelper.addUIClickAudio(arg_20_0._btncompare.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)
	gohelper.addUIClickAudio(arg_20_0._btnfold.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)

	arg_20_0.strengthenAttrItems = arg_20_0:getUserDataTb_()
	arg_20_0.skillAttributeItems = arg_20_0:getUserDataTb_()
	arg_20_0.skillDescItems = arg_20_0:getUserDataTb_()
	arg_20_0.container1_strengthenAttrItems = arg_20_0:getUserDataTb_()
	arg_20_0.container1_skillAttributeItems = arg_20_0:getUserDataTb_()
	arg_20_0.container1_skillDescItems = arg_20_0:getUserDataTb_()

	arg_20_0:addEventCb(EquipController.instance, EquipEvent.ChangeSelectedEquip, arg_20_0.onSelectEquipChange, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_20_0.onEquipChange, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_20_0.onEquipChange, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_20_0.onEquipChange, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_20_0.onEquipChange, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_20_0.onDeleteEquip, arg_20_0)
	arg_20_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_20_0._onCloseFullView, arg_20_0, LuaEventSystem.Low)
	arg_20_0:addEventCb(CharacterController.instance, CharacterEvent.successSetDefaultEquip, arg_20_0.onSuccessSetDefaultEquip, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, arg_20_0.onEquipTypeHasChange, arg_20_0)

	arg_20_0.txtConfirm = gohelper.findChildText(arg_20_0._btnconfirm.gameObject, "txt")
	arg_20_0.comparing = false
	arg_20_0.handleFuncDict = {
		[EquipEnum.FromViewEnum.FromHeroGroupFightView] = arg_20_0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupFightView] = arg_20_0._onClickConfirmBtnFromCachotHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupView] = arg_20_0._onClickConfirmBtnFromCachotHeroGroupView,
		[EquipEnum.FromViewEnum.FromRougeHeroGroupFightView] = arg_20_0._onClickConfirmBtnFromRougeHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCharacterView] = arg_20_0._onClickConfirmBtnFromCharacterView,
		[EquipEnum.FromViewEnum.FromSeasonFightView] = arg_20_0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView] = arg_20_0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView] = arg_20_0._onClickConfirmBtnFromSeason166HeroGroupFightView,
		[EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView] = arg_20_0._onClickConfirmBtnFromHeroGroupFightView
	}
end

function var_0_0.onUpdateParam(arg_21_0)
	return
end

function var_0_0.onOpenFinish(arg_22_0)
	arg_22_0._anim.enabled = true

	if arg_22_0.viewParam and arg_22_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.EquipInfo)
	end
end

function var_0_0._onCloseFullView(arg_23_0)
	if arg_23_0._anim then
		arg_23_0._anim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.onOpen(arg_24_0)
	arg_24_0.filterMo = EquipFilterModel.instance:generateFilterMo(arg_24_0.viewName)
	arg_24_0.heroMo = arg_24_0.viewParam.heroMo
	arg_24_0.posIndex = arg_24_0.viewParam.posIndex
	arg_24_0._isBalance = arg_24_0.viewParam.isBalance

	arg_24_0:initOriginEquipMo()

	arg_24_0.listModel = arg_24_0.viewContainer:getListModel()

	arg_24_0.listModel:onOpen(arg_24_0.viewParam, arg_24_0.filterMo)

	arg_24_0.selectedEquipMo = arg_24_0.listModel:getCurrentSelectEquipMo()

	arg_24_0._simagebg:LoadImage(ResUrl.getEquipBg("bg_beijingjianbian.png"))
	arg_24_0._simagecompare:LoadImage(ResUrl.getEquipBg("full/bg_black_mask.png"))
	arg_24_0:refreshCompareContainerUI()
	arg_24_0:refreshUI()

	arg_24_0.txtConfirm.text = luaLang("confirm_text")
end

function var_0_0.initOriginEquipMo(arg_25_0)
	arg_25_0.originEquipMo = nil

	if arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView then
		arg_25_0.originEquipMo = arg_25_0.viewParam.equipMo
	elseif arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		arg_25_0.originEquipMo = EquipModel.instance:getEquip(arg_25_0.viewParam.heroMo.defaultEquipUid)
	elseif arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView then
		arg_25_0.originEquipMo = arg_25_0.viewParam.equipMo
	elseif arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
		arg_25_0.originEquipMo = arg_25_0.viewParam.equipMo
	elseif arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		arg_25_0.originEquipMo = arg_25_0.viewParam.equipMo
	elseif arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView or arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView then
		arg_25_0.originEquipMo = arg_25_0.viewParam.equipMo
	elseif arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView then
		arg_25_0.originEquipMo = arg_25_0.viewParam.equipMo
	elseif arg_25_0.viewParam.fromView == EquipEnum.FromViewEnum.FromAssassinHeroView then
		arg_25_0.originEquipMo = arg_25_0.viewParam.equipMo
	else
		logError("not found from view ...")

		arg_25_0.originEquipMo = arg_25_0.viewParam.equipMo
	end
end

function var_0_0.refreshCompareContainerUI(arg_26_0)
	local var_26_0 = arg_26_0.originEquipMo

	if not var_26_0 then
		gohelper.setActive(arg_26_0._gocontainer1, false)
		gohelper.setActive(arg_26_0._simagecompare.gameObject, false)

		return
	end

	local var_26_1 = tonumber(var_26_0.uid) > 0 and arg_26_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	var_26_1 = var_26_1 or arg_26_0._isBalance

	if var_26_1 then
		local var_26_2 = arg_26_0.viewContainer:getBalanceEquipLv()

		if var_26_2 > var_26_0.level then
			local var_26_3 = EquipMO.New()

			var_26_3:initByConfig(nil, var_26_0.equipId, var_26_2, var_26_0.refineLv)

			var_26_0 = var_26_3
		else
			var_26_1 = nil
		end
	end

	if not arg_26_0.container1_txtname then
		arg_26_0.container1_txtname = gohelper.findChildText(arg_26_0._gocontainer1, "#go_equipinfo/#txt_name")
	end

	arg_26_0.container1_txtname.text = var_26_0.config.name

	if not arg_26_0.container1_txtlevel then
		arg_26_0.container1_txtlevel = gohelper.findChildText(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr/#txt_level")
	end

	if not arg_26_0.container1_gobalance then
		arg_26_0.container1_gobalance = gohelper.findChild(arg_26_0._gocontainer1, "#go_equipinfo/#go_isBalance")
	end

	gohelper.setActive(arg_26_0.container1_gobalance, var_26_1)

	if not arg_26_0.container1_goattr then
		arg_26_0.container1_goattr = gohelper.findChild(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr").transform
	end

	local var_26_4, var_26_5 = transformhelper.getLocalPos(arg_26_0.container1_goattr)

	transformhelper.setLocalPosXY(arg_26_0.container1_goattr, var_26_4, var_26_1 and -28 or 17.3)

	local var_26_6 = var_26_0.level
	local var_26_7 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(var_26_0)

	if var_26_1 then
		arg_26_0.container1_txtlevel.text = string.format("Lv.<color=#8fb1cc>%d</color>/<color=#8fb1cc>%d</color>", var_26_6, var_26_7)
	else
		arg_26_0.container1_txtlevel.text = string.format("Lv.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", var_26_6, var_26_7)
	end

	if not arg_26_0.container1_goStarList then
		arg_26_0.container1_goStarList = arg_26_0:getUserDataTb_()

		for iter_26_0 = 1, 6 do
			table.insert(arg_26_0.container1_goStarList, gohelper.findChild(arg_26_0._gocontainer1, "#go_equipinfo/go_insigt/#image_" .. iter_26_0))
		end
	end

	local var_26_8 = var_26_0.config.rare

	for iter_26_1 = 1, 6 do
		gohelper.setActive(arg_26_0.container1_goStarList[iter_26_1], iter_26_1 <= var_26_8 + 1)
	end

	if not arg_26_0.container1_gostrengthenattr then
		arg_26_0.container1_gostrengthenattr = gohelper.findChild(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	end

	gohelper.setActive(arg_26_0.container1_gostrengthenattr, false)

	local var_26_9, var_26_10 = EquipConfig.instance:getEquipNormalAttr(var_26_0.config.id, var_26_0.level, HeroConfig.sortAttrForEquipView)
	local var_26_11
	local var_26_12

	for iter_26_2, iter_26_3 in ipairs(var_26_10) do
		local var_26_13 = arg_26_0.container1_strengthenAttrItems[iter_26_2]

		if not var_26_13 then
			var_26_13 = arg_26_0:getUserDataTb_()
			var_26_13.go = gohelper.cloneInPlace(arg_26_0.container1_gostrengthenattr, "item" .. iter_26_2)
			var_26_13.icon = gohelper.findChildImage(var_26_13.go, "image_icon")
			var_26_13.name = gohelper.findChildText(var_26_13.go, "txt_name")
			var_26_13.attr_value = gohelper.findChildText(var_26_13.go, "txt_value")
			var_26_13.bg = gohelper.findChild(var_26_13.go, "bg")

			table.insert(arg_26_0.container1_strengthenAttrItems, var_26_13)
		end

		local var_26_14 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_26_3.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_26_13.icon, "icon_att_" .. var_26_14.id)

		var_26_13.name.text = var_26_14.name
		var_26_13.attr_value.text = iter_26_3.value

		gohelper.setActive(var_26_13.bg, iter_26_2 % 2 == 0)
		gohelper.setActive(var_26_13.go, true)
	end

	for iter_26_4 = #var_26_10 + 1, #arg_26_0.container1_strengthenAttrItems do
		gohelper.setActive(arg_26_0.container1_strengthenAttrItems[iter_26_4].go, false)
	end

	if not arg_26_0.container1_gobreakeffect then
		arg_26_0.container1_gobreakeffect = gohelper.findChild(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
		arg_26_0.container1_imageBreakIcon = gohelper.findChildImage(arg_26_0.container1_gobreakeffect, "image_icon")
		arg_26_0.container1_txtBreakAttrName = gohelper.findChildText(arg_26_0.container1_gobreakeffect, "txt_name")
		arg_26_0.container1_txtBreakValue = gohelper.findChildText(arg_26_0.container1_gobreakeffect, "txt_value")
	end

	local var_26_15, var_26_16 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_26_0.config, var_26_0.breakLv)

	if var_26_15 then
		gohelper.setActive(arg_26_0.container1_gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0.container1_imageBreakIcon, "icon_att_" .. var_26_15)

		arg_26_0.container1_txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_26_15)
		arg_26_0.container1_txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_26_16)

		gohelper.setAsLastSibling(arg_26_0.container1_gobreakeffect)
	else
		gohelper.setActive(arg_26_0.container1_gobreakeffect, false)
	end

	if not arg_26_0.container1_gosuitattribute then
		arg_26_0.container1_gosuitattribute = gohelper.findChild(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute")
	end

	if var_26_0.config.rare <= EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(arg_26_0.container1_gosuitattribute, false)

		return
	end

	gohelper.setActive(arg_26_0.container1_gosuitattribute, true)

	if not arg_26_0.container1_txtattributelv then
		arg_26_0.container1_txtattributelv = gohelper.findChildText(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	end

	if not arg_26_0.container1_goadvanceskill then
		arg_26_0.container1_goadvanceskill = gohelper.findChild(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")
	end

	if not arg_26_0.container1_gobaseskill then
		arg_26_0.container1_gobaseskill = gohelper.findChild(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
		arg_26_0.container1_goBaseSkillCanvasGroup = arg_26_0.container1_gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	if not arg_26_0.container1_txtsuiteffect2 then
		arg_26_0.container1_txtsuiteffect2 = gohelper.findChildText(arg_26_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	end

	gohelper.setActive(arg_26_0.container1_txtsuiteffect2.gameObject, false)

	local var_26_17 = EquipHelper.getEquipSkillBaseDes(var_26_0.config.id, var_26_0.refineLv, "#D9A06F")

	if #var_26_17 == 0 then
		gohelper.setActive(arg_26_0.container1_gobaseskill, false)
	else
		arg_26_0.container1_txtattributelv.text = var_26_0.refineLv

		gohelper.setActive(arg_26_0.container1_gobaseskill, true)

		local var_26_18

		for iter_26_5, iter_26_6 in ipairs(var_26_17) do
			local var_26_19 = arg_26_0.container1_skillDescItems[iter_26_5]

			if not var_26_19 then
				var_26_19 = arg_26_0:getUserDataTb_()
				var_26_19.itemGo = gohelper.cloneInPlace(arg_26_0.container1_txtsuiteffect2.gameObject, "item_" .. iter_26_5)
				var_26_19.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_26_19.itemGo, FixTmpBreakLine)
				var_26_19.imagepoint = gohelper.findChildImage(var_26_19.itemGo, "#image_point")
				var_26_19.txt = var_26_19.itemGo:GetComponent(gohelper.Type_TextMesh)

				SkillHelper.addHyperLinkClick(var_26_19.txt)
				table.insert(arg_26_0.container1_skillDescItems, var_26_19)
			end

			var_26_19.txt.text = EquipHelper.getEquipSkillDesc(iter_26_6)

			var_26_19.fixTmpBreakLine:refreshTmpContent(var_26_19.txt)
			gohelper.setActive(var_26_19.itemGo, true)
		end

		arg_26_0.container1_goBaseSkillCanvasGroup.alpha = var_26_0 and arg_26_0.heroMo and EquipHelper.detectEquipSkillSuited(arg_26_0.heroMo.heroId, var_26_0.config.id, var_26_0.refineLv) and 1 or 0.4

		for iter_26_7 = #var_26_17 + 1, #arg_26_0.container1_skillDescItems do
			gohelper.setActive(arg_26_0.container1_skillDescItems[iter_26_7].itemGo, false)
		end
	end
end

function var_0_0.refreshUI(arg_27_0)
	arg_27_0:refreshBtnStatus()
	arg_27_0:refreshHeroInfo()
	arg_27_0:refreshLeftUI()
	arg_27_0:refreshCenterUI()
	arg_27_0:refreshRightUI()
end

function var_0_0.refreshBtnStatus(arg_28_0)
	gohelper.setActive(arg_28_0.goRareBtnNoSelect, not arg_28_0.listModel:isSortByRare())
	gohelper.setActive(arg_28_0.goRareBtnSelect, arg_28_0.listModel:isSortByRare())
	gohelper.setActive(arg_28_0.goLvBtnNoSelect, not arg_28_0.listModel:isSortByLevel())
	gohelper.setActive(arg_28_0.goLvBtnSelect, arg_28_0.listModel:isSortByLevel())

	local var_28_0, var_28_1 = arg_28_0.listModel:getSortState()

	transformhelper.setLocalScale(arg_28_0.goRareBtnSelectArrow.transform, 1, var_28_1, 1)
	transformhelper.setLocalScale(arg_28_0.goLvBtnSelectArrow.transform, 1, var_28_0, 1)
	arg_28_0:refreshFilterBtnStatus()
end

function var_0_0.refreshFilterBtnStatus(arg_29_0)
	local var_29_0 = arg_29_0.filterMo:isFiltering()

	gohelper.setActive(arg_29_0.goNotFilter, not var_29_0)
	gohelper.setActive(arg_29_0.goFilter, var_29_0)
end

function var_0_0.refreshHeroInfo(arg_30_0)
	gohelper.setActive(arg_30_0._goherocontainer, arg_30_0.heroMo)
	gohelper.setActive(arg_30_0._goheroempty, not arg_30_0.heroMo)

	if not arg_30_0.heroMo then
		return
	end

	arg_30_0._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(arg_30_0.heroMo.config.skinId))

	arg_30_0._txtheroname.text = arg_30_0.heroMo:getHeroName()

	UISpriteSetMgr.instance:setHandBookCareerSprite(arg_30_0._imageherocareer, "sx_icon_" .. tostring(arg_30_0.heroMo.config.career))
end

function var_0_0.refreshLeftUI(arg_31_0)
	local var_31_0 = arg_31_0.heroMo and arg_31_0.heroMo.trialEquipMo and true or false
	local var_31_1 = arg_31_0.selectedEquipMo and not var_31_0 and tonumber(arg_31_0.selectedEquipMo.uid) > 0 and arg_31_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	var_31_1 = var_31_1 or arg_31_0._isBalance
	arg_31_0._balanceEquipMo = nil

	if var_31_1 and arg_31_0.selectedEquipMo then
		local var_31_2 = arg_31_0.viewContainer:getBalanceEquipLv()

		if var_31_2 <= arg_31_0.selectedEquipMo.level then
			var_31_1 = nil
		else
			local var_31_3 = EquipMO.New()

			var_31_3:initByConfig(nil, arg_31_0.selectedEquipMo.equipId, var_31_2, arg_31_0.selectedEquipMo.refineLv)

			arg_31_0._balanceEquipMo = var_31_3
		end
	end

	gohelper.setActive(arg_31_0._gotrialtip, var_31_0)
	gohelper.setActive(arg_31_0._goequipinfo, arg_31_0.selectedEquipMo)
	gohelper.setActive(arg_31_0._goequipinfoempty, not arg_31_0.selectedEquipMo)
	gohelper.setActive(arg_31_0._gobalance, var_31_1)

	local var_31_4, var_31_5 = transformhelper.getLocalPos(arg_31_0._goAttr.transform)

	transformhelper.setLocalPosXY(arg_31_0._goAttr.transform, var_31_4, var_31_1 and -172.2 or -127)

	arg_31_0.layoutElement.minHeight = var_31_1 and 142 or 187

	if arg_31_0.selectedEquipMo then
		arg_31_0._txtname.text = arg_31_0.selectedEquipMo.config.name

		arg_31_0:refreshEquipStar()
		arg_31_0:refreshSelectStatus()
		arg_31_0:refreshEquipLevel()
		arg_31_0:refreshEquipNormalAttr()

		if arg_31_0.selectedEquipMo.config.rare > EquipConfig.instance:getNotShowRefineRare() then
			arg_31_0:refreshEquipSkillDesc()
			gohelper.setActive(arg_31_0._gosuitattribute, true)
		else
			gohelper.setActive(arg_31_0._gosuitattribute, false)
		end

		arg_31_0:refreshInTeam()
	end

	local var_31_6 = arg_31_0.selectedEquipMo ~= nil and tonumber(arg_31_0.selectedEquipMo.uid) > 0

	gohelper.setActive(arg_31_0._btnjump.gameObject, var_31_6)
	gohelper.setActive(arg_31_0._gobuttom, not var_31_0)
end

function var_0_0.refreshCenterUI(arg_32_0)
	if arg_32_0.selectedEquipMo then
		arg_32_0._simageequip:LoadImage(ResUrl.getEquipSuit(arg_32_0.selectedEquipMo.config.icon))
		gohelper.setActive(arg_32_0._gocenter, true)
	else
		gohelper.setActive(arg_32_0._gocenter, false)
	end
end

function var_0_0.refreshRightUI(arg_33_0)
	local var_33_0 = arg_33_0.listModel:isEmpty()

	gohelper.setActive(arg_33_0._scrollequip.gameObject, not var_33_0)
	gohelper.setActive(arg_33_0._goequipempty, var_33_0)

	if not var_33_0 then
		arg_33_0.listModel:refreshEquipList()
	end
end

function var_0_0.refreshEquipStar(arg_34_0)
	local var_34_0 = arg_34_0.selectedEquipMo.config.rare

	for iter_34_0 = 1, 6 do
		gohelper.setActive(arg_34_0["_image" .. iter_34_0].gameObject, iter_34_0 <= var_34_0 + 1)
	end
end

function var_0_0.refreshSelectStatus(arg_35_0)
	if not arg_35_0.originEquipMo then
		gohelper.setActive(arg_35_0._btncompare.gameObject, false)
		gohelper.setActive(arg_35_0._btninteam.gameObject, false)
		gohelper.setActive(arg_35_0._btnfold.gameObject, false)

		return
	end

	if arg_35_0.comparing then
		gohelper.setActive(arg_35_0._btncompare.gameObject, false)
		gohelper.setActive(arg_35_0._btninteam.gameObject, false)
		gohelper.setActive(arg_35_0._btnfold.gameObject, true)

		return
	end

	if arg_35_0.originEquipMo.uid == arg_35_0.selectedEquipMo.uid then
		gohelper.setActive(arg_35_0._btncompare.gameObject, false)
		gohelper.setActive(arg_35_0._btninteam.gameObject, true)
		gohelper.setActive(arg_35_0._btnfold.gameObject, false)

		return
	end

	gohelper.setActive(arg_35_0._btncompare.gameObject, true)
	gohelper.setActive(arg_35_0._btninteam.gameObject, false)
	gohelper.setActive(arg_35_0._btnfold.gameObject, false)
end

function var_0_0.refreshEquipLevel(arg_36_0)
	if arg_36_0._balanceEquipMo then
		local var_36_0 = arg_36_0._balanceEquipMo.level
		local var_36_1 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_36_0._balanceEquipMo)

		arg_36_0._txtlevel.text = string.format("Lv.<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>/<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>", var_36_0, var_36_1)
	else
		local var_36_2 = arg_36_0.selectedEquipMo.level
		local var_36_3 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_36_0.selectedEquipMo)

		arg_36_0._txtlevel.text = string.format("Lv.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", var_36_2, var_36_3)
	end
end

function var_0_0.refreshEquipNormalAttr(arg_37_0)
	local var_37_0 = arg_37_0._balanceEquipMo or arg_37_0.selectedEquipMo
	local var_37_1, var_37_2 = EquipConfig.instance:getEquipNormalAttr(var_37_0.config.id, var_37_0.level, HeroConfig.sortAttrForEquipView)
	local var_37_3
	local var_37_4

	for iter_37_0, iter_37_1 in ipairs(var_37_2) do
		local var_37_5 = arg_37_0.strengthenAttrItems[iter_37_0]

		if not var_37_5 then
			var_37_5 = {
				go = gohelper.cloneInPlace(arg_37_0._gostrengthenattr, "item" .. iter_37_0)
			}
			var_37_5.icon = gohelper.findChildImage(var_37_5.go, "image_icon")
			var_37_5.name = gohelper.findChildText(var_37_5.go, "txt_name")
			var_37_5.attr_value = gohelper.findChildText(var_37_5.go, "txt_value")
			var_37_5.bg = gohelper.findChild(var_37_5.go, "bg")

			table.insert(arg_37_0.strengthenAttrItems, var_37_5)
		end

		local var_37_6 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_37_1.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_37_5.icon, "icon_att_" .. var_37_6.id)

		var_37_5.name.text = var_37_6.name
		var_37_5.attr_value.text = iter_37_1.value

		gohelper.setActive(var_37_5.bg, iter_37_0 % 2 == 0)
		gohelper.setActive(var_37_5.go, true)
	end

	for iter_37_2 = #var_37_2 + 1, #arg_37_0.strengthenAttrItems do
		gohelper.setActive(arg_37_0.strengthenAttrItems[iter_37_2].go, false)
	end

	local var_37_7, var_37_8 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_37_0.config, var_37_0.breakLv)

	if var_37_7 then
		gohelper.setActive(arg_37_0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_37_0.imageBreakIcon, "icon_att_" .. var_37_7)

		arg_37_0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_37_7)
		arg_37_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_37_8)

		gohelper.setAsLastSibling(arg_37_0._gobreakeffect)
	else
		gohelper.setActive(arg_37_0._gobreakeffect, false)
	end
end

function var_0_0.refreshEquipSkillDesc(arg_38_0)
	local var_38_0 = EquipHelper.getEquipSkillBaseDes(arg_38_0.selectedEquipMo.config.id, arg_38_0.selectedEquipMo.refineLv, "#D9A06F")

	if #var_38_0 == 0 then
		gohelper.setActive(arg_38_0._gobaseskill.gameObject, false)
	else
		arg_38_0._txtattributelv.text = arg_38_0.selectedEquipMo.refineLv

		gohelper.setActive(arg_38_0._gobaseskill.gameObject, true)

		local var_38_1
		local var_38_2
		local var_38_3

		for iter_38_0, iter_38_1 in ipairs(var_38_0) do
			local var_38_4 = arg_38_0.skillDescItems[iter_38_0]

			if not var_38_4 then
				local var_38_5 = arg_38_0:getUserDataTb_()
				local var_38_6 = gohelper.cloneInPlace(arg_38_0._txtsuiteffect2.gameObject, "item_" .. iter_38_0)

				var_38_5.itemGo = var_38_6
				var_38_5.imagepoint = gohelper.findChildImage(var_38_6, "#image_point")
				var_38_5.txt = var_38_6:GetComponent(gohelper.Type_TextMesh)

				SkillHelper.addHyperLinkClick(var_38_5.txt)

				var_38_4 = var_38_5

				table.insert(arg_38_0.skillDescItems, var_38_4)
			end

			var_38_4.txt.text = EquipHelper.getEquipSkillDesc(iter_38_1)

			gohelper.setActive(var_38_4.itemGo, true)
		end

		for iter_38_2 = #var_38_0 + 1, #arg_38_0.skillDescItems do
			gohelper.setActive(arg_38_0.skillDescItems[iter_38_2].itemGo, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end
end

function var_0_0.refreshInTeam(arg_39_0)
	if arg_39_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromHeroGroupFightView and arg_39_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromSeasonFightView and arg_39_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupView and arg_39_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupFightView and arg_39_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView then
		gohelper.setActive(arg_39_0._gointeam, false)

		return
	end

	local var_39_0 = arg_39_0.viewContainer.listModel:getHeroMoByEquipUid(arg_39_0.selectedEquipMo.uid)

	if arg_39_0.heroMo and var_39_0 and arg_39_0.selectedEquipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		var_39_0 = arg_39_0.heroMo
	end

	if var_39_0 then
		gohelper.setActive(arg_39_0._gointeam, true)

		local var_39_1 = lua_skin.configDict[var_39_0.skin]

		arg_39_0._gointeamheroicon:LoadImage(ResUrl.getHeadIconSmall(var_39_1.headIcon))

		arg_39_0._gointeamheroname.text = string.format(luaLang("hero_inteam"), var_39_0.config.name)
	else
		gohelper.setActive(arg_39_0._gointeam, false)
	end
end

function var_0_0.onSelectEquipChange(arg_40_0)
	arg_40_0.selectedEquipMo = arg_40_0.listModel:getCurrentSelectEquipMo()

	arg_40_0:refreshLeftUI()
	arg_40_0:refreshCenterUI()
end

function var_0_0.onEquipChange(arg_41_0)
	arg_41_0.listModel:initEquipList(arg_41_0.filterMo)
	arg_41_0:refreshLeftUI()
	arg_41_0:refreshRightUI()
	arg_41_0:refreshCompareContainerUI()
end

function var_0_0.onDeleteEquip(arg_42_0, arg_42_1)
	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		if arg_42_0.selectedEquipMo.uid == iter_42_1 then
			arg_42_0.listModel:setCurrentSelectEquipMo(nil)
			arg_42_0:onSelectEquipChange()

			break
		end
	end
end

function var_0_0.onSuccessSetDefaultEquip(arg_43_0, arg_43_1)
	arg_43_0:closeThis()
end

function var_0_0.onClose(arg_44_0)
	arg_44_0._simageheroicon:UnLoadImage()
	arg_44_0._simageequip:UnLoadImage()
	arg_44_0._simagebg:UnLoadImage()
	arg_44_0._simagecompare:UnLoadImage()
	arg_44_0.listModel:clearRecommend()
	arg_44_0.listModel:clear()
	EquipFilterModel.instance:clear(arg_44_0.viewName)
end

function var_0_0.onDestroyView(arg_45_0)
	return
end

return var_0_0
