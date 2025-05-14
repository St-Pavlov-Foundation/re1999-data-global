module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEquipInfoTeamShowView", package.seeall)

local var_0_0 = class("V1a6_CachotEquipInfoTeamShowView", BaseView)

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
	arg_1_0._goseatlevel = gohelper.findChild(arg_1_0.viewGO, "#go_equipcontainer/#go_level")
	arg_1_0._seatIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_equipcontainer/#go_level/bg/#txt_title/icon")
	arg_1_0._seatEffect = gohelper.findChild(arg_1_0.viewGO, "#go_equipcontainer/#go_level/bg/#txt_title/quality_effect")

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
	arg_8_0.handleFuncDict[arg_8_0.viewParam.fromView](arg_8_0)
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

function var_0_0._onClickConfirmBtnFromCachotHeroGroupView(arg_10_0)
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
	arg_10_0:closeThis()
end

function var_0_0._onClickConfirmBtnFromHeroGroupFightView(arg_11_0)
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

	HeroGroupModel.instance:replaceEquips(var_11_4, var_11_3)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, arg_11_0.posIndex)
	HeroGroupModel.instance:saveCurGroupData(arg_11_0.closeThis, arg_11_0, var_11_3)
end

function var_0_0._onClickConfirmBtnFromCharacterView(arg_12_0)
	HeroRpc.instance:setHeroDefaultEquipRequest(arg_12_0.heroMo.heroId, arg_12_0.selectedEquipMo and arg_12_0.selectedEquipMo.uid or "0")
end

function var_0_0._btnjumpOnClick(arg_13_0)
	if arg_13_0.selectedEquipMo then
		arg_13_0._anim:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(function()
			ViewMgr.instance:openView(ViewName.EquipView, {
				equipMO = arg_13_0.selectedEquipMo,
				defaultTabIds = {
					[2] = 2
				}
			})
		end, nil, 0.07)
	end
end

function var_0_0._btnequiplvOnClick(arg_15_0)
	arg_15_0.listModel:changeSortByLevel()
	arg_15_0:refreshBtnStatus()
end

function var_0_0._btnequiprareOnClick(arg_16_0)
	arg_16_0.listModel:changeSortByRare()
	arg_16_0:refreshBtnStatus()
end

function var_0_0.onEquipTypeHasChange(arg_17_0, arg_17_1)
	if arg_17_1 ~= arg_17_0.viewName then
		return
	end

	arg_17_0._scrollequip.verticalNormalizedPosition = 1

	local var_17_0 = arg_17_0.heroMo and arg_17_0.heroMo.trialEquipMo

	if var_17_0 then
		if arg_17_0.filterMo:checkIsIncludeTag(var_17_0.config) then
			arg_17_0.listModel.equipMoList = {
				var_17_0
			}
		else
			arg_17_0.listModel.equipMoList = {}
		end
	else
		arg_17_0.listModel:initEquipList(arg_17_0.filterMo)
	end

	arg_17_0.listModel:refreshEquipList()
	arg_17_0:refreshFilterBtnStatus()
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0.goNotFilter = gohelper.findChild(arg_18_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_notfilter")
	arg_18_0.goFilter = gohelper.findChild(arg_18_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_filter")
	arg_18_0.goRareBtnNoSelect = gohelper.findChild(arg_18_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn1")
	arg_18_0.goRareBtnSelect = gohelper.findChild(arg_18_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2")
	arg_18_0.goLvBtnNoSelect = gohelper.findChild(arg_18_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn1")
	arg_18_0.goLvBtnSelect = gohelper.findChild(arg_18_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2")
	arg_18_0.goRareBtnSelectArrow = gohelper.findChild(arg_18_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2/txt/arrow")
	arg_18_0.goLvBtnSelectArrow = gohelper.findChild(arg_18_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2/txt/arrow")
	arg_18_0.goBaseSkillCanvasGroup = arg_18_0._gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_18_0.imageBreakIcon = gohelper.findChildImage(arg_18_0._gobreakeffect, "image_icon")
	arg_18_0.txtBreakAttrName = gohelper.findChildText(arg_18_0._gobreakeffect, "txt_name")
	arg_18_0.txtBreakValue = gohelper.findChildText(arg_18_0._gobreakeffect, "txt_value")

	gohelper.setActive(arg_18_0._goleftempty, true)
	gohelper.setActive(arg_18_0._gocontainer1, false)
	gohelper.setActive(arg_18_0._gostrengthenattr, false)
	gohelper.setActive(arg_18_0._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(arg_18_0._btnjump.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	gohelper.addUIClickAudio(arg_18_0._btncompare.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)
	gohelper.addUIClickAudio(arg_18_0._btnfold.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)

	arg_18_0.strengthenAttrItems = arg_18_0:getUserDataTb_()
	arg_18_0.skillAttributeItems = arg_18_0:getUserDataTb_()
	arg_18_0.skillDescItems = arg_18_0:getUserDataTb_()
	arg_18_0.container1_strengthenAttrItems = arg_18_0:getUserDataTb_()
	arg_18_0.container1_skillAttributeItems = arg_18_0:getUserDataTb_()
	arg_18_0.container1_skillDescItems = arg_18_0:getUserDataTb_()

	arg_18_0:addEventCb(EquipController.instance, EquipEvent.ChangeSelectedEquip, arg_18_0.onSelectEquipChange, arg_18_0)
	arg_18_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_18_0.onEquipChange, arg_18_0)
	arg_18_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_18_0.onEquipChange, arg_18_0)
	arg_18_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_18_0.onEquipChange, arg_18_0)
	arg_18_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_18_0.onEquipChange, arg_18_0)
	arg_18_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_18_0.onDeleteEquip, arg_18_0)
	arg_18_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_18_0._onCloseFullView, arg_18_0, LuaEventSystem.Low)
	arg_18_0:addEventCb(CharacterController.instance, CharacterEvent.successSetDefaultEquip, arg_18_0.onSuccessSetDefaultEquip, arg_18_0)
	arg_18_0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, arg_18_0.onEquipTypeHasChange, arg_18_0)

	arg_18_0.txtConfirm = gohelper.findChildText(arg_18_0._btnconfirm.gameObject, "txt")
	arg_18_0.comparing = false
	arg_18_0.handleFuncDict = {
		[EquipEnum.FromViewEnum.FromHeroGroupFightView] = arg_18_0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupFightView] = arg_18_0._onClickConfirmBtnFromCachotHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupView] = arg_18_0._onClickConfirmBtnFromCachotHeroGroupView,
		[EquipEnum.FromViewEnum.FromCharacterView] = arg_18_0._onClickConfirmBtnFromCharacterView,
		[EquipEnum.FromViewEnum.FromSeasonFightView] = arg_18_0._onClickConfirmBtnFromHeroGroupFightView
	}
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpenFinish(arg_20_0)
	arg_20_0._anim.enabled = true

	if arg_20_0.viewParam and arg_20_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.EquipInfo)
	end
end

function var_0_0._onCloseFullView(arg_21_0)
	if arg_21_0._anim then
		arg_21_0._anim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.onOpen(arg_22_0)
	local var_22_0 = arg_22_0.viewParam.seatLevel

	arg_22_0._seatLevel = var_22_0

	gohelper.setActive(arg_22_0._goseatlevel, var_22_0)

	if var_22_0 then
		UISpriteSetMgr.instance:setV1a6CachotSprite(arg_22_0._seatIcon, "v1a6_cachot_quality_0" .. var_22_0)

		if not arg_22_0._qualityEffectList then
			arg_22_0._qualityEffectList = arg_22_0:getUserDataTb_()

			local var_22_1 = arg_22_0._seatEffect.transform
			local var_22_2 = var_22_1.childCount

			for iter_22_0 = 1, var_22_2 do
				local var_22_3 = var_22_1:GetChild(iter_22_0 - 1)

				arg_22_0._qualityEffectList[var_22_3.name] = var_22_3
			end
		end

		local var_22_4 = "effect_0" .. var_22_0

		for iter_22_1, iter_22_2 in pairs(arg_22_0._qualityEffectList) do
			gohelper.setActive(iter_22_2, iter_22_1 == var_22_4)
		end
	end

	arg_22_0.filterMo = EquipFilterModel.instance:generateFilterMo(arg_22_0.viewName)
	arg_22_0.heroMo = arg_22_0.viewParam.heroMo
	arg_22_0.posIndex = arg_22_0.viewParam.posIndex

	arg_22_0:initOriginEquipMo()

	arg_22_0.listModel = arg_22_0.viewContainer:getListModel()

	arg_22_0.listModel:onOpen(arg_22_0.viewParam, arg_22_0.filterMo)

	arg_22_0.selectedEquipMo = arg_22_0.listModel:getCurrentSelectEquipMo()

	arg_22_0._simagebg:LoadImage(ResUrl.getEquipBg("bg_beijingjianbian.png"))
	arg_22_0._simagecompare:LoadImage(ResUrl.getEquipBg("full/bg_black_mask.png"))
	arg_22_0:refreshCompareContainerUI()
	arg_22_0:refreshUI()

	arg_22_0.txtConfirm.text = luaLang("confirm_text")
end

function var_0_0.initOriginEquipMo(arg_23_0)
	arg_23_0.originEquipMo = nil

	if arg_23_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView then
		arg_23_0.originEquipMo = arg_23_0.viewParam.equipMo
	elseif arg_23_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		arg_23_0.originEquipMo = EquipModel.instance:getEquip(arg_23_0.viewParam.heroMo.defaultEquipUid)
	elseif arg_23_0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView then
		arg_23_0.originEquipMo = arg_23_0.viewParam.equipMo
	elseif arg_23_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
		arg_23_0.originEquipMo = arg_23_0.viewParam.equipMo
	elseif arg_23_0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		arg_23_0.originEquipMo = arg_23_0.viewParam.equipMo
	else
		logError("not found from view ...")

		arg_23_0.originEquipMo = arg_23_0.viewParam.equipMo
	end
end

function var_0_0.refreshCompareContainerUI(arg_24_0)
	local var_24_0 = arg_24_0.originEquipMo

	if not var_24_0 then
		gohelper.setActive(arg_24_0._gocontainer1, false)
		gohelper.setActive(arg_24_0._simagecompare.gameObject, false)

		return
	end

	local var_24_1 = tonumber(var_24_0.uid) > 0 and arg_24_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	if var_24_1 then
		local var_24_2, var_24_3, var_24_4 = HeroGroupBalanceHelper.getBalanceLv()

		if var_24_4 > var_24_0.level then
			local var_24_5 = EquipMO.New()

			var_24_5:initByConfig(nil, var_24_0.equipId, var_24_4, var_24_0.refineLv)

			var_24_0 = var_24_5
		else
			var_24_1 = nil
		end
	end

	if not arg_24_0.container1_txtname then
		arg_24_0.container1_txtname = gohelper.findChildText(arg_24_0._gocontainer1, "#go_equipinfo/#txt_name")
	end

	arg_24_0.container1_txtname.text = var_24_0.config.name

	if not arg_24_0.container1_txtlevel then
		arg_24_0.container1_txtlevel = gohelper.findChildText(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr/#txt_level")
	end

	if not arg_24_0.container1_gobalance then
		arg_24_0.container1_gobalance = gohelper.findChild(arg_24_0._gocontainer1, "#go_equipinfo/#go_isBalance")
	end

	gohelper.setActive(arg_24_0.container1_gobalance, var_24_1)

	if not arg_24_0.container1_goattr then
		arg_24_0.container1_goattr = gohelper.findChild(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr").transform
	end

	local var_24_6, var_24_7 = transformhelper.getLocalPos(arg_24_0.container1_goattr)

	transformhelper.setLocalPosXY(arg_24_0.container1_goattr, var_24_6, var_24_1 and -28 or 17.3)

	local var_24_8 = var_24_0.level
	local var_24_9 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(var_24_0)

	if var_24_1 then
		arg_24_0.container1_txtlevel.text = string.format("LV.<color=#8fb1cc>%d</color>/<color=#8fb1cc>%d</color>", var_24_8, var_24_9)
	else
		arg_24_0.container1_txtlevel.text = string.format("LV.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", var_24_8, var_24_9)
	end

	if not arg_24_0.container1_goStarList then
		arg_24_0.container1_goStarList = arg_24_0:getUserDataTb_()

		for iter_24_0 = 1, 6 do
			table.insert(arg_24_0.container1_goStarList, gohelper.findChild(arg_24_0._gocontainer1, "#go_equipinfo/go_insigt/#image_" .. iter_24_0))
		end
	end

	local var_24_10 = var_24_0.config.rare

	for iter_24_1 = 1, 6 do
		gohelper.setActive(arg_24_0.container1_goStarList[iter_24_1], iter_24_1 <= var_24_10 + 1)
	end

	if not arg_24_0.container1_gostrengthenattr then
		arg_24_0.container1_gostrengthenattr = gohelper.findChild(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	end

	gohelper.setActive(arg_24_0.container1_gostrengthenattr, false)

	local var_24_11, var_24_12 = EquipConfig.instance:getEquipNormalAttr(var_24_0.config.id, var_24_0.level, HeroConfig.sortAttrForEquipView)
	local var_24_13
	local var_24_14

	for iter_24_2, iter_24_3 in ipairs(var_24_12) do
		local var_24_15 = arg_24_0.container1_strengthenAttrItems[iter_24_2]

		if not var_24_15 then
			var_24_15 = arg_24_0:getUserDataTb_()
			var_24_15.go = gohelper.cloneInPlace(arg_24_0.container1_gostrengthenattr, "item" .. iter_24_2)
			var_24_15.icon = gohelper.findChildImage(var_24_15.go, "image_icon")
			var_24_15.name = gohelper.findChildText(var_24_15.go, "txt_name")
			var_24_15.attr_value = gohelper.findChildText(var_24_15.go, "txt_value")
			var_24_15.bg = gohelper.findChild(var_24_15.go, "bg")

			table.insert(arg_24_0.container1_strengthenAttrItems, var_24_15)
		end

		local var_24_16 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_24_3.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_24_15.icon, "icon_att_" .. var_24_16.id)

		var_24_15.name.text = var_24_16.name
		var_24_15.attr_value.text = iter_24_3.value

		gohelper.setActive(var_24_15.bg, iter_24_2 % 2 == 0)
		gohelper.setActive(var_24_15.go, true)
	end

	for iter_24_4 = #var_24_12 + 1, #arg_24_0.container1_strengthenAttrItems do
		gohelper.setActive(arg_24_0.container1_strengthenAttrItems[iter_24_4].go, false)
	end

	if not arg_24_0.container1_gobreakeffect then
		arg_24_0.container1_gobreakeffect = gohelper.findChild(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
		arg_24_0.container1_imageBreakIcon = gohelper.findChildImage(arg_24_0.container1_gobreakeffect, "image_icon")
		arg_24_0.container1_txtBreakAttrName = gohelper.findChildText(arg_24_0.container1_gobreakeffect, "txt_name")
		arg_24_0.container1_txtBreakValue = gohelper.findChildText(arg_24_0.container1_gobreakeffect, "txt_value")
	end

	local var_24_17, var_24_18 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_24_0.config, var_24_0.breakLv)

	if var_24_17 then
		gohelper.setActive(arg_24_0.container1_gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0.container1_imageBreakIcon, "icon_att_" .. var_24_17)

		arg_24_0.container1_txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_24_17)
		arg_24_0.container1_txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_24_18)

		gohelper.setAsLastSibling(arg_24_0.container1_gobreakeffect)
	else
		gohelper.setActive(arg_24_0.container1_gobreakeffect, false)
	end

	if not arg_24_0.container1_gosuitattribute then
		arg_24_0.container1_gosuitattribute = gohelper.findChild(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute")
	end

	if var_24_0.config.rare <= EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(arg_24_0.container1_gosuitattribute, false)

		return
	end

	gohelper.setActive(arg_24_0.container1_gosuitattribute, true)

	if not arg_24_0.container1_txtattributelv then
		arg_24_0.container1_txtattributelv = gohelper.findChildText(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	end

	if not arg_24_0.container1_goadvanceskill then
		arg_24_0.container1_goadvanceskill = gohelper.findChild(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")
	end

	if not arg_24_0.container1_gobaseskill then
		arg_24_0.container1_gobaseskill = gohelper.findChild(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
		arg_24_0.container1_goBaseSkillCanvasGroup = arg_24_0.container1_gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	if not arg_24_0.container1_txtsuiteffect2 then
		arg_24_0.container1_txtsuiteffect2 = gohelper.findChildText(arg_24_0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	end

	gohelper.setActive(arg_24_0.container1_txtsuiteffect2.gameObject, false)

	local var_24_19 = EquipHelper.getEquipSkillBaseDes(var_24_0.config.id, var_24_0.refineLv, "#D9A06F")

	if #var_24_19 == 0 then
		gohelper.setActive(arg_24_0.container1_gobaseskill, false)
	else
		arg_24_0.container1_txtattributelv.text = var_24_0.refineLv

		gohelper.setActive(arg_24_0.container1_gobaseskill, true)

		local var_24_20

		for iter_24_5, iter_24_6 in ipairs(var_24_19) do
			local var_24_21 = arg_24_0.container1_skillDescItems[iter_24_5]

			if not var_24_21 then
				var_24_21 = arg_24_0:getUserDataTb_()
				var_24_21.itemGo = gohelper.cloneInPlace(arg_24_0.container1_txtsuiteffect2.gameObject, "item_" .. iter_24_5)
				var_24_21.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_21.itemGo, FixTmpBreakLine)
				var_24_21.imagepoint = gohelper.findChildImage(var_24_21.itemGo, "#image_point")
				var_24_21.txt = var_24_21.itemGo:GetComponent(gohelper.Type_TextMesh)

				table.insert(arg_24_0.container1_skillDescItems, var_24_21)
			end

			var_24_21.txt.text = iter_24_6

			var_24_21.fixTmpBreakLine:refreshTmpContent(var_24_21.txt)
			gohelper.setActive(var_24_21.itemGo, true)
		end

		arg_24_0.container1_goBaseSkillCanvasGroup.alpha = var_24_0 and arg_24_0.heroMo and EquipHelper.detectEquipSkillSuited(arg_24_0.heroMo.heroId, var_24_0.config.id, var_24_0.refineLv) and 1 or 0.4

		for iter_24_7 = #var_24_19 + 1, #arg_24_0.container1_skillDescItems do
			gohelper.setActive(arg_24_0.container1_skillDescItems[iter_24_7].itemGo, false)
		end
	end
end

function var_0_0.refreshUI(arg_25_0)
	arg_25_0:refreshBtnStatus()
	arg_25_0:refreshHeroInfo()
	arg_25_0:refreshLeftUI()
	arg_25_0:refreshCenterUI()
	arg_25_0:refreshRightUI()
end

function var_0_0.refreshBtnStatus(arg_26_0)
	gohelper.setActive(arg_26_0.goRareBtnNoSelect, not arg_26_0.listModel:isSortByRare())
	gohelper.setActive(arg_26_0.goRareBtnSelect, arg_26_0.listModel:isSortByRare())
	gohelper.setActive(arg_26_0.goLvBtnNoSelect, not arg_26_0.listModel:isSortByLevel())
	gohelper.setActive(arg_26_0.goLvBtnSelect, arg_26_0.listModel:isSortByLevel())

	local var_26_0, var_26_1 = arg_26_0.listModel:getSortState()

	transformhelper.setLocalScale(arg_26_0.goRareBtnSelectArrow.transform, 1, var_26_1, 1)
	transformhelper.setLocalScale(arg_26_0.goLvBtnSelectArrow.transform, 1, var_26_0, 1)
	arg_26_0:refreshFilterBtnStatus()
end

function var_0_0.refreshFilterBtnStatus(arg_27_0)
	local var_27_0 = arg_27_0.filterMo:isFiltering()

	gohelper.setActive(arg_27_0.goNotFilter, not var_27_0)
	gohelper.setActive(arg_27_0.goFilter, var_27_0)
end

function var_0_0.refreshHeroInfo(arg_28_0)
	gohelper.setActive(arg_28_0._goherocontainer, arg_28_0.heroMo)
	gohelper.setActive(arg_28_0._goheroempty, not arg_28_0.heroMo)

	if not arg_28_0.heroMo then
		return
	end

	arg_28_0._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(arg_28_0.heroMo.config.skinId))

	arg_28_0._txtheroname.text = arg_28_0.heroMo.config.name

	UISpriteSetMgr.instance:setHandBookCareerSprite(arg_28_0._imageherocareer, "sx_icon_" .. tostring(arg_28_0.heroMo.config.career))
end

function var_0_0.refreshLeftUI(arg_29_0)
	local var_29_0 = arg_29_0.heroMo and arg_29_0.heroMo.trialEquipMo and true or false
	local var_29_1 = arg_29_0.selectedEquipMo and not var_29_0 and tonumber(arg_29_0.selectedEquipMo.uid) > 0 and arg_29_0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	arg_29_0._balanceEquipMo = nil

	if var_29_1 then
		local var_29_2, var_29_3, var_29_4 = HeroGroupBalanceHelper.getBalanceLv()

		if var_29_4 <= arg_29_0.selectedEquipMo.level then
			var_29_1 = nil
		else
			local var_29_5 = EquipMO.New()

			var_29_5:initByConfig(nil, arg_29_0.selectedEquipMo.equipId, var_29_4, arg_29_0.selectedEquipMo.refineLv)

			arg_29_0._balanceEquipMo = var_29_5
		end
	end

	gohelper.setActive(arg_29_0._gotrialtip, var_29_0)
	gohelper.setActive(arg_29_0._goequipinfo, arg_29_0.selectedEquipMo)
	gohelper.setActive(arg_29_0._goequipinfoempty, not arg_29_0.selectedEquipMo)
	gohelper.setActive(arg_29_0._gobalance, var_29_1)

	local var_29_6, var_29_7 = transformhelper.getLocalPos(arg_29_0._goAttr.transform)

	transformhelper.setLocalPosXY(arg_29_0._goAttr.transform, var_29_6, var_29_1 and -172.2 or -127)

	arg_29_0.layoutElement.minHeight = var_29_1 and 149.5 or 192.19

	if arg_29_0.selectedEquipMo then
		arg_29_0._txtname.text = arg_29_0.selectedEquipMo.config.name

		arg_29_0:refreshEquipStar()
		arg_29_0:refreshSelectStatus()
		arg_29_0:refreshEquipLevel()
		arg_29_0:refreshEquipNormalAttr()

		if arg_29_0.selectedEquipMo.config.rare > EquipConfig.instance:getNotShowRefineRare() then
			arg_29_0:refreshEquipSkillDesc()
			gohelper.setActive(arg_29_0._gosuitattribute, true)
		else
			gohelper.setActive(arg_29_0._gosuitattribute, false)
		end

		arg_29_0:refreshInTeam()
	end

	gohelper.setActive(arg_29_0._btnjump.gameObject, false)
	gohelper.setActive(arg_29_0._gobuttom, not var_29_0)
end

function var_0_0.refreshCenterUI(arg_30_0)
	if arg_30_0.selectedEquipMo then
		arg_30_0._simageequip:LoadImage(ResUrl.getEquipSuit(arg_30_0.selectedEquipMo.config.icon))
		gohelper.setActive(arg_30_0._gocenter, true)
	else
		gohelper.setActive(arg_30_0._gocenter, false)
	end
end

function var_0_0.refreshRightUI(arg_31_0)
	local var_31_0 = arg_31_0.listModel:isEmpty()

	gohelper.setActive(arg_31_0._scrollequip.gameObject, not var_31_0)
	gohelper.setActive(arg_31_0._goequipempty, var_31_0)

	if not var_31_0 then
		arg_31_0.listModel:refreshEquipList()
	end
end

function var_0_0.refreshEquipStar(arg_32_0)
	local var_32_0 = arg_32_0.selectedEquipMo.config.rare

	for iter_32_0 = 1, 6 do
		gohelper.setActive(arg_32_0["_image" .. iter_32_0].gameObject, iter_32_0 <= var_32_0 + 1)
	end
end

function var_0_0.refreshSelectStatus(arg_33_0)
	if not arg_33_0.originEquipMo then
		gohelper.setActive(arg_33_0._btncompare.gameObject, false)
		gohelper.setActive(arg_33_0._btninteam.gameObject, false)
		gohelper.setActive(arg_33_0._btnfold.gameObject, false)

		return
	end

	if arg_33_0.comparing then
		gohelper.setActive(arg_33_0._btncompare.gameObject, false)
		gohelper.setActive(arg_33_0._btninteam.gameObject, false)
		gohelper.setActive(arg_33_0._btnfold.gameObject, true)

		return
	end

	if arg_33_0.originEquipMo.uid == arg_33_0.selectedEquipMo.uid then
		gohelper.setActive(arg_33_0._btncompare.gameObject, false)
		gohelper.setActive(arg_33_0._btninteam.gameObject, true)
		gohelper.setActive(arg_33_0._btnfold.gameObject, false)

		return
	end

	gohelper.setActive(arg_33_0._btncompare.gameObject, true)
	gohelper.setActive(arg_33_0._btninteam.gameObject, false)
	gohelper.setActive(arg_33_0._btnfold.gameObject, false)
	gohelper.setActive(arg_33_0._btncompare.gameObject, false)
end

function var_0_0.refreshEquipLevel(arg_34_0)
	if arg_34_0._balanceEquipMo then
		local var_34_0 = arg_34_0._balanceEquipMo.level
		local var_34_1 = EquipConfig.instance:getCurrentBreakLevelMaxLevel(arg_34_0._balanceEquipMo)

		arg_34_0._txtlevel.text = string.format("LV.<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>/<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>", var_34_0, var_34_1)
	else
		local var_34_2, var_34_3 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(arg_34_0.selectedEquipMo, arg_34_0._seatLevel)
		local var_34_4 = EquipConfig.instance:_getBreakLevelMaxLevel(arg_34_0.selectedEquipMo.config.rare, var_34_3)

		arg_34_0._txtlevel.text = string.format("LV.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", var_34_2, var_34_4)
	end
end

function var_0_0.refreshEquipNormalAttr(arg_35_0)
	local var_35_0 = arg_35_0._balanceEquipMo or arg_35_0.selectedEquipMo
	local var_35_1 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(var_35_0, arg_35_0._seatLevel)
	local var_35_2, var_35_3 = EquipConfig.instance:getEquipNormalAttr(var_35_0.config.id, var_35_1, HeroConfig.sortAttrForEquipView)
	local var_35_4
	local var_35_5

	for iter_35_0, iter_35_1 in ipairs(var_35_3) do
		local var_35_6 = arg_35_0.strengthenAttrItems[iter_35_0]

		if not var_35_6 then
			var_35_6 = {
				go = gohelper.cloneInPlace(arg_35_0._gostrengthenattr, "item" .. iter_35_0)
			}
			var_35_6.icon = gohelper.findChildImage(var_35_6.go, "image_icon")
			var_35_6.name = gohelper.findChildText(var_35_6.go, "txt_name")
			var_35_6.attr_value = gohelper.findChildText(var_35_6.go, "txt_value")
			var_35_6.bg = gohelper.findChild(var_35_6.go, "bg")

			table.insert(arg_35_0.strengthenAttrItems, var_35_6)
		end

		local var_35_7 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_35_1.attrType))

		UISpriteSetMgr.instance:setCommonSprite(var_35_6.icon, "icon_att_" .. var_35_7.id)

		var_35_6.name.text = var_35_7.name
		var_35_6.attr_value.text = iter_35_1.value

		gohelper.setActive(var_35_6.bg, iter_35_0 % 2 == 0)
		gohelper.setActive(var_35_6.go, true)
	end

	for iter_35_2 = #var_35_3 + 1, #arg_35_0.strengthenAttrItems do
		gohelper.setActive(arg_35_0.strengthenAttrItems[iter_35_2].go, false)
	end

	local var_35_8 = var_35_0:getBreakLvByLevel(var_35_1)
	local var_35_9, var_35_10 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(var_35_0.config, var_35_8)

	if var_35_9 then
		gohelper.setActive(arg_35_0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(arg_35_0.imageBreakIcon, "icon_att_" .. var_35_9)

		arg_35_0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(var_35_9)
		arg_35_0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(var_35_10)

		gohelper.setAsLastSibling(arg_35_0._gobreakeffect)
	else
		gohelper.setActive(arg_35_0._gobreakeffect, false)
	end
end

function var_0_0.refreshEquipSkillDesc(arg_36_0)
	local var_36_0 = EquipHelper.getEquipSkillBaseDes(arg_36_0.selectedEquipMo.config.id, arg_36_0.selectedEquipMo.refineLv, "#D9A06F")

	if #var_36_0 == 0 then
		gohelper.setActive(arg_36_0._gobaseskill.gameObject, false)
	else
		arg_36_0._txtattributelv.text = arg_36_0.selectedEquipMo.refineLv

		gohelper.setActive(arg_36_0._gobaseskill.gameObject, true)

		local var_36_1
		local var_36_2
		local var_36_3

		for iter_36_0, iter_36_1 in ipairs(var_36_0) do
			local var_36_4 = arg_36_0.skillDescItems[iter_36_0]

			if not var_36_4 then
				local var_36_5 = arg_36_0:getUserDataTb_()
				local var_36_6 = gohelper.cloneInPlace(arg_36_0._txtsuiteffect2.gameObject, "item_" .. iter_36_0)

				var_36_5.itemGo = var_36_6
				var_36_5.imagepoint = gohelper.findChildImage(var_36_6, "#image_point")
				var_36_5.txt = var_36_6:GetComponent(gohelper.Type_TextMesh)
				var_36_4 = var_36_5

				table.insert(arg_36_0.skillDescItems, var_36_4)
			end

			var_36_4.txt.text = iter_36_1

			gohelper.setActive(var_36_4.itemGo, true)
		end

		for iter_36_2 = #var_36_0 + 1, #arg_36_0.skillDescItems do
			gohelper.setActive(arg_36_0.skillDescItems[iter_36_2].itemGo, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end
end

function var_0_0.refreshInTeam(arg_37_0)
	if arg_37_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromHeroGroupFightView and arg_37_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromSeasonFightView and arg_37_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupView and arg_37_0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		gohelper.setActive(arg_37_0._gointeam, false)

		return
	end

	local var_37_0 = arg_37_0.viewContainer.listModel:getHeroMoByEquipUid(arg_37_0.selectedEquipMo.uid)

	if arg_37_0.heroMo and var_37_0 and arg_37_0.selectedEquipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		var_37_0 = arg_37_0.heroMo
	end

	if var_37_0 then
		gohelper.setActive(arg_37_0._gointeam, true)

		local var_37_1 = lua_skin.configDict[var_37_0.skin]

		arg_37_0._gointeamheroicon:LoadImage(ResUrl.getHeadIconSmall(var_37_1.headIcon))

		arg_37_0._gointeamheroname.text = string.format(luaLang("hero_inteam"), var_37_0.config.name)
	else
		gohelper.setActive(arg_37_0._gointeam, false)
	end
end

function var_0_0.onSelectEquipChange(arg_38_0)
	arg_38_0.selectedEquipMo = arg_38_0.listModel:getCurrentSelectEquipMo()

	arg_38_0:refreshLeftUI()
	arg_38_0:refreshCenterUI()
end

function var_0_0.onEquipChange(arg_39_0)
	arg_39_0.listModel:initEquipList(arg_39_0.filterMo)
	arg_39_0:refreshLeftUI()
	arg_39_0:refreshRightUI()
	arg_39_0:refreshCompareContainerUI()
end

function var_0_0.onDeleteEquip(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(arg_40_1) do
		if arg_40_0.selectedEquipMo.uid == iter_40_1 then
			arg_40_0.listModel:setCurrentSelectEquipMo(nil)
			arg_40_0:onSelectEquipChange()

			break
		end
	end
end

function var_0_0.onSuccessSetDefaultEquip(arg_41_0, arg_41_1)
	arg_41_0:closeThis()
end

function var_0_0.onClose(arg_42_0)
	arg_42_0._simageheroicon:UnLoadImage()
	arg_42_0._simageequip:UnLoadImage()
	arg_42_0._simagebg:UnLoadImage()
	arg_42_0._simagecompare:UnLoadImage()
	arg_42_0.listModel:clear()
	EquipFilterModel.instance:clear(arg_42_0.viewName)
end

function var_0_0.onDestroyView(arg_43_0)
	return
end

return var_0_0
