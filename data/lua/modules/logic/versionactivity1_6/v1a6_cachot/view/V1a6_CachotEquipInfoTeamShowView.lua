module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEquipInfoTeamShowView", package.seeall)

slot0 = class("V1a6_CachotEquipInfoTeamShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagecompare = gohelper.findChildSingleImage(slot0.viewGO, "#simage_compare")
	slot0._goleftempty = gohelper.findChild(slot0.viewGO, "#go_leftempty")
	slot0._goheroempty = gohelper.findChild(slot0.viewGO, "#go_leftempty/#go_heroempty")
	slot0._goequipinfoempty = gohelper.findChild(slot0.viewGO, "#go_leftempty/#go_equipinfoempty")
	slot0._goequipempty = gohelper.findChild(slot0.viewGO, "#go_equipempty")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "container/#go_container")
	slot0._gocontainer1 = gohelper.findChild(slot0.viewGO, "container/#go_container1")
	slot0._goherocontainer = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_herocontainer")
	slot0._txtheroname = gohelper.findChildText(slot0.viewGO, "container/#go_container/#go_herocontainer/#txt_heroname")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot0.viewGO, "container/#go_container/#go_herocontainer/mask/#simage_heroicon")
	slot0._imageherocareer = gohelper.findChildImage(slot0.viewGO, "container/#go_container/#go_herocontainer/#image_herocareer")
	slot0._goequipinfo = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "container/#go_container/#go_equipinfo/#txt_name")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/#txt_level")
	slot0._image1 = gohelper.findChildImage(slot0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_1")
	slot0._image2 = gohelper.findChildImage(slot0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_2")
	slot0._image3 = gohelper.findChildImage(slot0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_3")
	slot0._image4 = gohelper.findChildImage(slot0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_4")
	slot0._image5 = gohelper.findChildImage(slot0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_5")
	slot0._image6 = gohelper.findChildImage(slot0.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_6")
	slot0._gostrengthenattr = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	slot0._gobreakeffect = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
	slot0._gosuitattribute = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute")
	slot0._txtattributelv = gohelper.findChildText(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	slot0._scrolldesccontainer = gohelper.findChildScrollRect(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer")
	slot0._gosuiteffect = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect")
	slot0._gobaseskill = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
	slot0._txteffect = gohelper.findChildText(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/title/#txt_effect")
	slot0._txtsuiteffect2 = gohelper.findChildText(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr/#btn_jump")
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "#go_center")
	slot0._simageequip = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/#simage_equip")
	slot0._goequipcontainer = gohelper.findChild(slot0.viewGO, "#go_equipcontainer")
	slot0._scrollequip = gohelper.findChildScrollRect(slot0.viewGO, "#go_equipcontainer/#scroll_equip")
	slot0._goequipsort = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort")
	slot0._btnequiplv = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv")
	slot0._btnequiprare = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter")
	slot0._gobuttom = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_buttom")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipcontainer/#go_buttom/#btn_cancel")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_equipcontainer/#go_buttom/#btn_confirm")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gobalance = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_isBalance")
	slot0._btncompare = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_compare")
	slot0._btninteam = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_inteam")
	slot0._btnfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_fold")
	slot0._gointeam = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_inteam")
	slot0._gointeamheroicon = gohelper.findChildSingleImage(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_inteam/#simage_inteamHeroIcon")
	slot0._gointeamheroname = gohelper.findChildText(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_inteam/#txt_inteamName")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._gotrialtip = gohelper.findChild(slot0.viewGO, "#go_trialtip")
	slot0.layoutElement = slot0._scrolldesccontainer:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	slot0._goAttr = gohelper.findChild(slot0.viewGO, "container/#go_container/#go_equipinfo/#go_attr")
	slot0._goseatlevel = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_level")
	slot0._seatIcon = gohelper.findChildImage(slot0.viewGO, "#go_equipcontainer/#go_level/bg/#txt_title/icon")
	slot0._seatEffect = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_level/bg/#txt_title/quality_effect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btnequiplv:AddClickListener(slot0._btnequiplvOnClick, slot0)
	slot0._btnequiprare:AddClickListener(slot0._btnequiprareOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncompare:AddClickListener(slot0._btncompareOnClick, slot0)
	slot0._btnfold:AddClickListener(slot0._btnfoldOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
	slot0._btnequiplv:RemoveClickListener()
	slot0._btnequiprare:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncompare:RemoveClickListener()
	slot0._btnfold:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
end

function slot0._btnfilterOnClick(slot0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = slot0.viewName
	})
end

function slot0._btncompareOnClick(slot0)
	if not slot0.originEquipMo then
		return
	end

	if slot0.comparing then
		return
	end

	slot0.comparing = true

	gohelper.setActive(slot0._gocontainer1, true)
	gohelper.setActive(slot0._simagecompare.gameObject, true)
	slot0:refreshSelectStatus()
end

function slot0._btnfoldOnClick(slot0)
	if not slot0.comparing then
		return
	end

	slot0.comparing = false

	gohelper.setActive(slot0._gocontainer1, false)
	gohelper.setActive(slot0._simagecompare.gameObject, false)
	slot0:refreshSelectStatus()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnconfirmOnClick(slot0)
	slot0.handleFuncDict[slot0.viewParam.fromView](slot0)
end

function slot0._onClickConfirmBtnFromCachotHeroGroupFightView(slot0)
	slot3 = false

	if slot0.viewContainer.listModel:getGroupCurrentPosEquip()[1] and (EquipModel.instance:getEquip(slot2) or HeroGroupTrialModel.instance:getEquipMo(slot2)) then
		slot3 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()
	V1a6_CachotHeroGroupModel.instance:replaceEquips({
		index = slot0.posIndex,
		equipUid = {
			slot0.selectedEquipMo and slot0.selectedEquipMo.uid or "0"
		}
	}, slot0.viewContainer.listModel.curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot0.posIndex)
	V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup(slot0.closeThis, slot0)
end

function slot0._onClickConfirmBtnFromCachotHeroGroupView(slot0)
	slot3 = false

	if slot0.viewContainer.listModel:getGroupCurrentPosEquip()[1] and (EquipModel.instance:getEquip(slot2) or HeroGroupTrialModel.instance:getEquipMo(slot2)) then
		slot3 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()
	V1a6_CachotHeroGroupModel.instance:replaceEquips({
		index = slot0.posIndex,
		equipUid = {
			slot0.selectedEquipMo and slot0.selectedEquipMo.uid or "0"
		}
	}, slot0.viewContainer.listModel.curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot0.posIndex)
	slot0:closeThis()
end

function slot0._onClickConfirmBtnFromHeroGroupFightView(slot0)
	slot3 = false

	if slot0.viewContainer.listModel:getGroupCurrentPosEquip()[1] and (EquipModel.instance:getEquip(slot2) or HeroGroupTrialModel.instance:getEquipMo(slot2)) then
		slot3 = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	slot4 = slot0.viewContainer.listModel.curGroupMO

	HeroGroupModel.instance:replaceEquips({
		index = slot0.posIndex,
		equipUid = {
			slot0.selectedEquipMo and slot0.selectedEquipMo.uid or "0"
		}
	}, slot4)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, slot0.posIndex)
	HeroGroupModel.instance:saveCurGroupData(slot0.closeThis, slot0, slot4)
end

function slot0._onClickConfirmBtnFromCharacterView(slot0)
	HeroRpc.instance:setHeroDefaultEquipRequest(slot0.heroMo.heroId, slot0.selectedEquipMo and slot0.selectedEquipMo.uid or "0")
end

function slot0._btnjumpOnClick(slot0)
	if slot0.selectedEquipMo then
		slot0._anim:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(function ()
			ViewMgr.instance:openView(ViewName.EquipView, {
				equipMO = uv0.selectedEquipMo,
				defaultTabIds = {
					[2.0] = 2
				}
			})
		end, nil, 0.07)
	end
end

function slot0._btnequiplvOnClick(slot0)
	slot0.listModel:changeSortByLevel()
	slot0:refreshBtnStatus()
end

function slot0._btnequiprareOnClick(slot0)
	slot0.listModel:changeSortByRare()
	slot0:refreshBtnStatus()
end

function slot0.onEquipTypeHasChange(slot0, slot1)
	if slot1 ~= slot0.viewName then
		return
	end

	slot0._scrollequip.verticalNormalizedPosition = 1

	if slot0.heroMo and slot0.heroMo.trialEquipMo then
		if slot0.filterMo:checkIsIncludeTag(slot2.config) then
			slot0.listModel.equipMoList = {
				slot2
			}
		else
			slot0.listModel.equipMoList = {}
		end
	else
		slot0.listModel:initEquipList(slot0.filterMo)
	end

	slot0.listModel:refreshEquipList()
	slot0:refreshFilterBtnStatus()
end

function slot0._editableInitView(slot0)
	slot0.goNotFilter = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_notfilter")
	slot0.goFilter = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_filter")
	slot0.goRareBtnNoSelect = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn1")
	slot0.goRareBtnSelect = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2")
	slot0.goLvBtnNoSelect = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn1")
	slot0.goLvBtnSelect = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2")
	slot0.goRareBtnSelectArrow = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2/txt/arrow")
	slot0.goLvBtnSelectArrow = gohelper.findChild(slot0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2/txt/arrow")
	slot0.goBaseSkillCanvasGroup = slot0._gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.imageBreakIcon = gohelper.findChildImage(slot0._gobreakeffect, "image_icon")
	slot0.txtBreakAttrName = gohelper.findChildText(slot0._gobreakeffect, "txt_name")
	slot0.txtBreakValue = gohelper.findChildText(slot0._gobreakeffect, "txt_value")

	gohelper.setActive(slot0._goleftempty, true)
	gohelper.setActive(slot0._gocontainer1, false)
	gohelper.setActive(slot0._gostrengthenattr, false)
	gohelper.setActive(slot0._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(slot0._btnjump.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	gohelper.addUIClickAudio(slot0._btncompare.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)
	gohelper.addUIClickAudio(slot0._btnfold.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)

	slot0.strengthenAttrItems = slot0:getUserDataTb_()
	slot0.skillAttributeItems = slot0:getUserDataTb_()
	slot0.skillDescItems = slot0:getUserDataTb_()
	slot0.container1_strengthenAttrItems = slot0:getUserDataTb_()
	slot0.container1_skillAttributeItems = slot0:getUserDataTb_()
	slot0.container1_skillDescItems = slot0:getUserDataTb_()

	slot0:addEventCb(EquipController.instance, EquipEvent.ChangeSelectedEquip, slot0.onSelectEquipChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, slot0.onEquipChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, slot0.onEquipChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, slot0.onEquipChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.onEquipChange, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, slot0.onDeleteEquip, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successSetDefaultEquip, slot0.onSuccessSetDefaultEquip, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, slot0.onEquipTypeHasChange, slot0)

	slot0.txtConfirm = gohelper.findChildText(slot0._btnconfirm.gameObject, "txt")
	slot0.comparing = false
	slot0.handleFuncDict = {
		[EquipEnum.FromViewEnum.FromHeroGroupFightView] = slot0._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupFightView] = slot0._onClickConfirmBtnFromCachotHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupView] = slot0._onClickConfirmBtnFromCachotHeroGroupView,
		[EquipEnum.FromViewEnum.FromCharacterView] = slot0._onClickConfirmBtnFromCharacterView,
		[EquipEnum.FromViewEnum.FromSeasonFightView] = slot0._onClickConfirmBtnFromHeroGroupFightView
	}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpenFinish(slot0)
	slot0._anim.enabled = true

	if slot0.viewParam and slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.EquipInfo)
	end
end

function slot0._onCloseFullView(slot0)
	if slot0._anim then
		slot0._anim:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.seatLevel
	slot0._seatLevel = slot1

	gohelper.setActive(slot0._goseatlevel, slot1)

	if slot1 then
		UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._seatIcon, "v1a6_cachot_quality_0" .. slot1)

		if not slot0._qualityEffectList then
			slot0._qualityEffectList = slot0:getUserDataTb_()

			for slot7 = 1, slot0._seatEffect.transform.childCount do
				slot8 = slot2:GetChild(slot7 - 1)
				slot0._qualityEffectList[slot8.name] = slot8
			end
		end

		for slot6, slot7 in pairs(slot0._qualityEffectList) do
			gohelper.setActive(slot7, slot6 == "effect_0" .. slot1)
		end
	end

	slot0.filterMo = EquipFilterModel.instance:generateFilterMo(slot0.viewName)
	slot0.heroMo = slot0.viewParam.heroMo
	slot0.posIndex = slot0.viewParam.posIndex

	slot0:initOriginEquipMo()

	slot0.listModel = slot0.viewContainer:getListModel()

	slot0.listModel:onOpen(slot0.viewParam, slot0.filterMo)

	slot0.selectedEquipMo = slot0.listModel:getCurrentSelectEquipMo()

	slot0._simagebg:LoadImage(ResUrl.getEquipBg("bg_beijingjianbian.png"))
	slot0._simagecompare:LoadImage(ResUrl.getEquipBg("full/bg_black_mask.png"))
	slot0:refreshCompareContainerUI()
	slot0:refreshUI()

	slot0.txtConfirm.text = luaLang("confirm_text")
end

function slot0.initOriginEquipMo(slot0)
	slot0.originEquipMo = nil

	if slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView then
		slot0.originEquipMo = slot0.viewParam.equipMo
	elseif slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		slot0.originEquipMo = EquipModel.instance:getEquip(slot0.viewParam.heroMo.defaultEquipUid)
	elseif slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView then
		slot0.originEquipMo = slot0.viewParam.equipMo
	elseif slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
		slot0.originEquipMo = slot0.viewParam.equipMo
	elseif slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		slot0.originEquipMo = slot0.viewParam.equipMo
	else
		logError("not found from view ...")

		slot0.originEquipMo = slot0.viewParam.equipMo
	end
end

function slot0.refreshCompareContainerUI(slot0)
	if not slot0.originEquipMo then
		gohelper.setActive(slot0._gocontainer1, false)
		gohelper.setActive(slot0._simagecompare.gameObject, false)

		return
	end

	if tonumber(slot1.uid) > 0 and slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode() then
		slot3, slot4, slot5 = HeroGroupBalanceHelper.getBalanceLv()

		if slot1.level < slot5 then
			slot6 = EquipMO.New()

			slot6:initByConfig(nil, slot1.equipId, slot5, slot1.refineLv)

			slot1 = slot6
		else
			slot2 = nil
		end
	end

	if not slot0.container1_txtname then
		slot0.container1_txtname = gohelper.findChildText(slot0._gocontainer1, "#go_equipinfo/#txt_name")
	end

	slot0.container1_txtname.text = slot1.config.name

	if not slot0.container1_txtlevel then
		slot0.container1_txtlevel = gohelper.findChildText(slot0._gocontainer1, "#go_equipinfo/#go_attr/#txt_level")
	end

	if not slot0.container1_gobalance then
		slot0.container1_gobalance = gohelper.findChild(slot0._gocontainer1, "#go_equipinfo/#go_isBalance")
	end

	gohelper.setActive(slot0.container1_gobalance, slot2)

	if not slot0.container1_goattr then
		slot0.container1_goattr = gohelper.findChild(slot0._gocontainer1, "#go_equipinfo/#go_attr").transform
	end

	slot7, slot4 = transformhelper.getLocalPos(slot0.container1_goattr)

	transformhelper.setLocalPosXY(slot0.container1_goattr, slot7, slot2 and -28 or 17.3)

	if slot2 then
		slot0.container1_txtlevel.text = string.format("LV.<color=#8fb1cc>%d</color>/<color=#8fb1cc>%d</color>", slot1.level, EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot1))
	else
		slot0.container1_txtlevel.text = string.format("LV.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", slot5, slot6)
	end

	if not slot0.container1_goStarList then
		slot0.container1_goStarList = slot0:getUserDataTb_()

		for slot10 = 1, 6 do
			table.insert(slot0.container1_goStarList, gohelper.findChild(slot0._gocontainer1, "#go_equipinfo/go_insigt/#image_" .. slot10))
		end
	end

	for slot11 = 1, 6 do
		gohelper.setActive(slot0.container1_goStarList[slot11], slot11 <= slot1.config.rare + 1)
	end

	if not slot0.container1_gostrengthenattr then
		slot0.container1_gostrengthenattr = gohelper.findChild(slot0._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	end

	gohelper.setActive(slot0.container1_gostrengthenattr, false)

	slot8, slot9 = EquipConfig.instance:getEquipNormalAttr(slot1.config.id, slot1.level, HeroConfig.sortAttrForEquipView)
	slot10, slot11 = nil

	for slot15, slot16 in ipairs(slot9) do
		if not slot0.container1_strengthenAttrItems[slot15] then
			slot11 = slot0:getUserDataTb_()
			slot11.go = gohelper.cloneInPlace(slot0.container1_gostrengthenattr, "item" .. slot15)
			slot11.icon = gohelper.findChildImage(slot11.go, "image_icon")
			slot11.name = gohelper.findChildText(slot11.go, "txt_name")
			slot11.attr_value = gohelper.findChildText(slot11.go, "txt_value")
			slot11.bg = gohelper.findChild(slot11.go, "bg")

			table.insert(slot0.container1_strengthenAttrItems, slot11)
		end

		slot10 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot16.attrType))

		UISpriteSetMgr.instance:setCommonSprite(slot11.icon, "icon_att_" .. slot10.id)

		slot11.name.text = slot10.name
		slot11.attr_value.text = slot16.value

		gohelper.setActive(slot11.bg, slot15 % 2 == 0)
		gohelper.setActive(slot11.go, true)
	end

	for slot15 = #slot9 + 1, #slot0.container1_strengthenAttrItems do
		gohelper.setActive(slot0.container1_strengthenAttrItems[slot15].go, false)
	end

	if not slot0.container1_gobreakeffect then
		slot0.container1_gobreakeffect = gohelper.findChild(slot0._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
		slot0.container1_imageBreakIcon = gohelper.findChildImage(slot0.container1_gobreakeffect, "image_icon")
		slot0.container1_txtBreakAttrName = gohelper.findChildText(slot0.container1_gobreakeffect, "txt_name")
		slot0.container1_txtBreakValue = gohelper.findChildText(slot0.container1_gobreakeffect, "txt_value")
	end

	slot12, slot13 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot1.config, slot1.breakLv)

	if slot12 then
		gohelper.setActive(slot0.container1_gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(slot0.container1_imageBreakIcon, "icon_att_" .. slot12)

		slot0.container1_txtBreakAttrName.text = EquipHelper.getAttrBreakText(slot12)
		slot0.container1_txtBreakValue.text = EquipHelper.getAttrPercentValueStr(slot13)

		gohelper.setAsLastSibling(slot0.container1_gobreakeffect)
	else
		gohelper.setActive(slot0.container1_gobreakeffect, false)
	end

	if not slot0.container1_gosuitattribute then
		slot0.container1_gosuitattribute = gohelper.findChild(slot0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute")
	end

	if slot1.config.rare <= EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(slot0.container1_gosuitattribute, false)

		return
	end

	gohelper.setActive(slot0.container1_gosuitattribute, true)

	if not slot0.container1_txtattributelv then
		slot0.container1_txtattributelv = gohelper.findChildText(slot0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	end

	if not slot0.container1_goadvanceskill then
		slot0.container1_goadvanceskill = gohelper.findChild(slot0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")
	end

	if not slot0.container1_gobaseskill then
		slot0.container1_gobaseskill = gohelper.findChild(slot0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
		slot0.container1_goBaseSkillCanvasGroup = slot0.container1_gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	if not slot0.container1_txtsuiteffect2 then
		slot0.container1_txtsuiteffect2 = gohelper.findChildText(slot0._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	end

	gohelper.setActive(slot0.container1_txtsuiteffect2.gameObject, false)

	if #EquipHelper.getEquipSkillBaseDes(slot1.config.id, slot1.refineLv, "#D9A06F") == 0 then
		gohelper.setActive(slot0.container1_gobaseskill, false)
	else
		slot0.container1_txtattributelv.text = slot1.refineLv

		gohelper.setActive(slot0.container1_gobaseskill, true)

		slot15 = nil

		for slot19, slot20 in ipairs(slot14) do
			if not slot0.container1_skillDescItems[slot19] then
				slot15 = slot0:getUserDataTb_()
				slot15.itemGo = gohelper.cloneInPlace(slot0.container1_txtsuiteffect2.gameObject, "item_" .. slot19)
				slot15.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot15.itemGo, FixTmpBreakLine)
				slot15.imagepoint = gohelper.findChildImage(slot15.itemGo, "#image_point")
				slot15.txt = slot15.itemGo:GetComponent(gohelper.Type_TextMesh)

				table.insert(slot0.container1_skillDescItems, slot15)
			end

			slot15.txt.text = slot20

			slot15.fixTmpBreakLine:refreshTmpContent(slot15.txt)
			gohelper.setActive(slot15.itemGo, true)
		end

		slot0.container1_goBaseSkillCanvasGroup.alpha = slot1 and slot0.heroMo and EquipHelper.detectEquipSkillSuited(slot0.heroMo.heroId, slot1.config.id, slot1.refineLv) and 1 or 0.4

		for slot19 = #slot14 + 1, #slot0.container1_skillDescItems do
			gohelper.setActive(slot0.container1_skillDescItems[slot19].itemGo, false)
		end
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshBtnStatus()
	slot0:refreshHeroInfo()
	slot0:refreshLeftUI()
	slot0:refreshCenterUI()
	slot0:refreshRightUI()
end

function slot0.refreshBtnStatus(slot0)
	gohelper.setActive(slot0.goRareBtnNoSelect, not slot0.listModel:isSortByRare())
	gohelper.setActive(slot0.goRareBtnSelect, slot0.listModel:isSortByRare())
	gohelper.setActive(slot0.goLvBtnNoSelect, not slot0.listModel:isSortByLevel())
	gohelper.setActive(slot0.goLvBtnSelect, slot0.listModel:isSortByLevel())

	slot1, slot2 = slot0.listModel:getSortState()

	transformhelper.setLocalScale(slot0.goRareBtnSelectArrow.transform, 1, slot2, 1)
	transformhelper.setLocalScale(slot0.goLvBtnSelectArrow.transform, 1, slot1, 1)
	slot0:refreshFilterBtnStatus()
end

function slot0.refreshFilterBtnStatus(slot0)
	slot1 = slot0.filterMo:isFiltering()

	gohelper.setActive(slot0.goNotFilter, not slot1)
	gohelper.setActive(slot0.goFilter, slot1)
end

function slot0.refreshHeroInfo(slot0)
	gohelper.setActive(slot0._goherocontainer, slot0.heroMo)
	gohelper.setActive(slot0._goheroempty, not slot0.heroMo)

	if not slot0.heroMo then
		return
	end

	slot0._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(slot0.heroMo.config.skinId))

	slot0._txtheroname.text = slot0.heroMo.config.name

	UISpriteSetMgr.instance:setHandBookCareerSprite(slot0._imageherocareer, "sx_icon_" .. tostring(slot0.heroMo.config.career))
end

function slot0.refreshLeftUI(slot0)
	slot0._balanceEquipMo = nil

	if slot0.selectedEquipMo and not (slot0.heroMo and slot0.heroMo.trialEquipMo and true or false) and tonumber(slot0.selectedEquipMo.uid) > 0 and slot0.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode() then
		slot3, slot4, slot5 = HeroGroupBalanceHelper.getBalanceLv()

		if slot5 <= slot0.selectedEquipMo.level then
			slot2 = nil
		else
			slot6 = EquipMO.New()

			slot6:initByConfig(nil, slot0.selectedEquipMo.equipId, slot5, slot0.selectedEquipMo.refineLv)

			slot0._balanceEquipMo = slot6
		end
	end

	gohelper.setActive(slot0._gotrialtip, slot1)
	gohelper.setActive(slot0._goequipinfo, slot0.selectedEquipMo)
	gohelper.setActive(slot0._goequipinfoempty, not slot0.selectedEquipMo)
	gohelper.setActive(slot0._gobalance, slot2)

	slot7, slot4 = transformhelper.getLocalPos(slot0._goAttr.transform)

	transformhelper.setLocalPosXY(slot0._goAttr.transform, slot7, slot2 and -172.2 or -127)

	slot0.layoutElement.minHeight = slot2 and 149.5 or 192.19

	if slot0.selectedEquipMo then
		slot0._txtname.text = slot0.selectedEquipMo.config.name

		slot0:refreshEquipStar()
		slot0:refreshSelectStatus()
		slot0:refreshEquipLevel()
		slot0:refreshEquipNormalAttr()

		if EquipConfig.instance:getNotShowRefineRare() < slot0.selectedEquipMo.config.rare then
			slot0:refreshEquipSkillDesc()
			gohelper.setActive(slot0._gosuitattribute, true)
		else
			gohelper.setActive(slot0._gosuitattribute, false)
		end

		slot0:refreshInTeam()
	end

	gohelper.setActive(slot0._btnjump.gameObject, false)
	gohelper.setActive(slot0._gobuttom, not slot1)
end

function slot0.refreshCenterUI(slot0)
	if slot0.selectedEquipMo then
		slot0._simageequip:LoadImage(ResUrl.getEquipSuit(slot0.selectedEquipMo.config.icon))
		gohelper.setActive(slot0._gocenter, true)
	else
		gohelper.setActive(slot0._gocenter, false)
	end
end

function slot0.refreshRightUI(slot0)
	slot1 = slot0.listModel:isEmpty()

	gohelper.setActive(slot0._scrollequip.gameObject, not slot1)
	gohelper.setActive(slot0._goequipempty, slot1)

	if not slot1 then
		slot0.listModel:refreshEquipList()
	end
end

function slot0.refreshEquipStar(slot0)
	for slot5 = 1, 6 do
		gohelper.setActive(slot0["_image" .. slot5].gameObject, slot5 <= slot0.selectedEquipMo.config.rare + 1)
	end
end

function slot0.refreshSelectStatus(slot0)
	if not slot0.originEquipMo then
		gohelper.setActive(slot0._btncompare.gameObject, false)
		gohelper.setActive(slot0._btninteam.gameObject, false)
		gohelper.setActive(slot0._btnfold.gameObject, false)

		return
	end

	if slot0.comparing then
		gohelper.setActive(slot0._btncompare.gameObject, false)
		gohelper.setActive(slot0._btninteam.gameObject, false)
		gohelper.setActive(slot0._btnfold.gameObject, true)

		return
	end

	if slot0.originEquipMo.uid == slot0.selectedEquipMo.uid then
		gohelper.setActive(slot0._btncompare.gameObject, false)
		gohelper.setActive(slot0._btninteam.gameObject, true)
		gohelper.setActive(slot0._btnfold.gameObject, false)

		return
	end

	gohelper.setActive(slot0._btncompare.gameObject, true)
	gohelper.setActive(slot0._btninteam.gameObject, false)
	gohelper.setActive(slot0._btnfold.gameObject, false)
	gohelper.setActive(slot0._btncompare.gameObject, false)
end

function slot0.refreshEquipLevel(slot0)
	if slot0._balanceEquipMo then
		slot0._txtlevel.text = string.format("LV.<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>/<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>", slot0._balanceEquipMo.level, EquipConfig.instance:getCurrentBreakLevelMaxLevel(slot0._balanceEquipMo))
	else
		slot1, slot2 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(slot0.selectedEquipMo, slot0._seatLevel)
		slot0._txtlevel.text = string.format("LV.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", slot1, EquipConfig.instance:_getBreakLevelMaxLevel(slot0.selectedEquipMo.config.rare, slot2))
	end
end

function slot0.refreshEquipNormalAttr(slot0)
	slot1 = slot0._balanceEquipMo or slot0.selectedEquipMo
	slot3, slot4 = EquipConfig.instance:getEquipNormalAttr(slot1.config.id, V1a6_CachotTeamModel.instance:getEquipMaxLevel(slot1, slot0._seatLevel), HeroConfig.sortAttrForEquipView)
	slot5, slot6 = nil

	for slot10, slot11 in ipairs(slot4) do
		if not slot0.strengthenAttrItems[slot10] then
			slot5 = {
				go = gohelper.cloneInPlace(slot0._gostrengthenattr, "item" .. slot10)
			}
			slot5.icon = gohelper.findChildImage(slot5.go, "image_icon")
			slot5.name = gohelper.findChildText(slot5.go, "txt_name")
			slot5.attr_value = gohelper.findChildText(slot5.go, "txt_value")
			slot5.bg = gohelper.findChild(slot5.go, "bg")

			table.insert(slot0.strengthenAttrItems, slot5)
		end

		slot6 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot11.attrType))

		UISpriteSetMgr.instance:setCommonSprite(slot5.icon, "icon_att_" .. slot6.id)

		slot5.name.text = slot6.name
		slot5.attr_value.text = slot11.value

		gohelper.setActive(slot5.bg, slot10 % 2 == 0)
		gohelper.setActive(slot5.go, true)
	end

	for slot10 = #slot4 + 1, #slot0.strengthenAttrItems do
		gohelper.setActive(slot0.strengthenAttrItems[slot10].go, false)
	end

	slot8, slot9 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot1.config, slot1:getBreakLvByLevel(slot2))

	if slot8 then
		gohelper.setActive(slot0._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageBreakIcon, "icon_att_" .. slot8)

		slot0.txtBreakAttrName.text = EquipHelper.getAttrBreakText(slot8)
		slot0.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(slot9)

		gohelper.setAsLastSibling(slot0._gobreakeffect)
	else
		gohelper.setActive(slot0._gobreakeffect, false)
	end
end

function slot0.refreshEquipSkillDesc(slot0)
	if #EquipHelper.getEquipSkillBaseDes(slot0.selectedEquipMo.config.id, slot0.selectedEquipMo.refineLv, "#D9A06F") == 0 then
		gohelper.setActive(slot0._gobaseskill.gameObject, false)
	else
		slot0._txtattributelv.text = slot0.selectedEquipMo.refineLv

		gohelper.setActive(slot0._gobaseskill.gameObject, true)

		slot2, slot3, slot4 = nil

		for slot8, slot9 in ipairs(slot1) do
			if not slot0.skillDescItems[slot8] then
				slot4 = slot0:getUserDataTb_()
				slot3 = gohelper.cloneInPlace(slot0._txtsuiteffect2.gameObject, "item_" .. slot8)
				slot4.itemGo = slot3
				slot4.imagepoint = gohelper.findChildImage(slot3, "#image_point")
				slot4.txt = slot3:GetComponent(gohelper.Type_TextMesh)

				table.insert(slot0.skillDescItems, slot4)
			end

			slot2.txt.text = slot9

			gohelper.setActive(slot2.itemGo, true)
		end

		for slot8 = #slot1 + 1, #slot0.skillDescItems do
			gohelper.setActive(slot0.skillDescItems[slot8].itemGo, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end
end

function slot0.refreshInTeam(slot0)
	if slot0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromHeroGroupFightView and slot0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromSeasonFightView and slot0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupView and slot0.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		gohelper.setActive(slot0._gointeam, false)

		return
	end

	if slot0.heroMo and slot0.viewContainer.listModel:getHeroMoByEquipUid(slot0.selectedEquipMo.uid) and slot0.selectedEquipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		slot1 = slot0.heroMo
	end

	if slot1 then
		gohelper.setActive(slot0._gointeam, true)
		slot0._gointeamheroicon:LoadImage(ResUrl.getHeadIconSmall(lua_skin.configDict[slot1.skin].headIcon))

		slot0._gointeamheroname.text = string.format(luaLang("hero_inteam"), slot1.config.name)
	else
		gohelper.setActive(slot0._gointeam, false)
	end
end

function slot0.onSelectEquipChange(slot0)
	slot0.selectedEquipMo = slot0.listModel:getCurrentSelectEquipMo()

	slot0:refreshLeftUI()
	slot0:refreshCenterUI()
end

function slot0.onEquipChange(slot0)
	slot0.listModel:initEquipList(slot0.filterMo)
	slot0:refreshLeftUI()
	slot0:refreshRightUI()
	slot0:refreshCompareContainerUI()
end

function slot0.onDeleteEquip(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.selectedEquipMo.uid == slot6 then
			slot0.listModel:setCurrentSelectEquipMo(nil)
			slot0:onSelectEquipChange()

			break
		end
	end
end

function slot0.onSuccessSetDefaultEquip(slot0, slot1)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	slot0._simageheroicon:UnLoadImage()
	slot0._simageequip:UnLoadImage()
	slot0._simagebg:UnLoadImage()
	slot0._simagecompare:UnLoadImage()
	slot0.listModel:clear()
	EquipFilterModel.instance:clear(slot0.viewName)
end

function slot0.onDestroyView(slot0)
end

return slot0
