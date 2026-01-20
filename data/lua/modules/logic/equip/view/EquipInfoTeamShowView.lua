-- chunkname: @modules/logic/equip/view/EquipInfoTeamShowView.lua

module("modules.logic.equip.view.EquipInfoTeamShowView", package.seeall)

local EquipInfoTeamShowView = class("EquipInfoTeamShowView", BaseView)

function EquipInfoTeamShowView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagecompare = gohelper.findChildSingleImage(self.viewGO, "#simage_compare")
	self._goleftempty = gohelper.findChild(self.viewGO, "#go_leftempty")
	self._goheroempty = gohelper.findChild(self.viewGO, "#go_leftempty/#go_heroempty")
	self._goequipinfoempty = gohelper.findChild(self.viewGO, "#go_leftempty/#go_equipinfoempty")
	self._goequipempty = gohelper.findChild(self.viewGO, "#go_equipempty")
	self._gocontainer = gohelper.findChild(self.viewGO, "container/#go_container")
	self._gocontainer1 = gohelper.findChild(self.viewGO, "container/#go_container1")
	self._goherocontainer = gohelper.findChild(self.viewGO, "container/#go_container/#go_herocontainer")
	self._txtheroname = gohelper.findChildText(self.viewGO, "container/#go_container/#go_herocontainer/#txt_heroname")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "container/#go_container/#go_herocontainer/mask/#simage_heroicon")
	self._imageherocareer = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_herocontainer/#image_herocareer")
	self._goequipinfo = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo")
	self._txtname = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#txt_name")
	self._txtlevel = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/#txt_level")
	self._image1 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_1")
	self._image2 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_2")
	self._image3 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_3")
	self._image4 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_4")
	self._image5 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_5")
	self._image6 = gohelper.findChildImage(self.viewGO, "container/#go_container/#go_equipinfo/go_insigt/#image_6")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	self._gobreakeffect = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
	self._gosuitattribute = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute")
	self._txtattributelv = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	self._scrolldesccontainer = gohelper.findChildScrollRect(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer")
	self._gosuiteffect = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect")
	self._gobaseskill = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
	self._txteffect = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/title/#txt_effect")
	self._txtsuiteffect2 = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr/#btn_jump")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_center")
	self._simageequip = gohelper.findChildSingleImage(self.viewGO, "#go_center/#simage_equip")
	self._goequipcontainer = gohelper.findChild(self.viewGO, "#go_equipcontainer")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "#go_equipcontainer/#scroll_equip")
	self._goequipsort = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort")
	self._btnequiplv = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv")
	self._btnequiprare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter")
	self._gobuttom = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_buttom")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_buttom/#btn_cancel")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_buttom/#btn_confirm")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gobalance = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_isBalance")
	self._btncompare = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_compare")
	self._btninteam = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_inteam")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#go_state/#btn_fold")
	self._gointeam = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_inteam")
	self._gointeamheroicon = gohelper.findChildSingleImage(self.viewGO, "container/#go_container/#go_equipinfo/#go_inteam/#simage_inteamHeroIcon")
	self._gointeamheroname = gohelper.findChildText(self.viewGO, "container/#go_container/#go_equipinfo/#go_inteam/#txt_inteamName")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._gotrialtip = gohelper.findChild(self.viewGO, "#go_trialtip")
	self.layoutElement = self._scrolldesccontainer:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	self._goAttr = gohelper.findChild(self.viewGO, "container/#go_container/#go_equipinfo/#go_attr")
	self._goEquipEmpty = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_buttom/#go_empty")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipcontainer/#go_buttom/#btn_goto")
	self._btnmaxlevel = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_container/#go_equipinfo/#btn_maxlevel")
	self._gomaxlevelselect = gohelper.findChild(self._btnmaxlevel.gameObject, "selected")
	self._gomaxlevelunselect = gohelper.findChild(self._btnmaxlevel.gameObject, "unselect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipInfoTeamShowView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnequiplv:AddClickListener(self._btnequiplvOnClick, self)
	self._btnequiprare:AddClickListener(self._btnequiprareOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncompare:AddClickListener(self._btncompareOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnmaxlevel:AddClickListener(self._onClickMaxLevelBtn, self)
	self._btngoto:AddClickListener(self._onClickGotoBtn, self)
end

function EquipInfoTeamShowView:removeEvents()
	self._btnjump:RemoveClickListener()
	self._btnequiplv:RemoveClickListener()
	self._btnequiprare:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btncompare:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btnmaxlevel:RemoveClickListener()
	self._btngoto:RemoveClickListener()
end

function EquipInfoTeamShowView:_onClickGotoBtn()
	local str = string.format("%s#%s", JumpEnum.JumpView.StoreView, StoreEnum.StoreId.SummonEquipExchange)

	JumpController.instance:jumpTo(str)
end

function EquipInfoTeamShowView:_onClickMaxLevelBtn()
	self._showMax = not self._showMax

	if self._showMax then
		self.selectedEquipMo = self._maxEquipMo
	else
		self.selectedEquipMo = self._normalEquipMO
	end

	self:refreshMaxLevelImage(0)
	self:refreshLeftUI()
end

function EquipInfoTeamShowView:_btnfilterOnClick()
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = self.viewName
	})
end

function EquipInfoTeamShowView:_btncompareOnClick()
	if not self.originEquipMo then
		return
	end

	if self.comparing then
		return
	end

	self.comparing = true

	gohelper.setActive(self._gocontainer1, true)
	gohelper.setActive(self._simagecompare.gameObject, true)
	self:refreshSelectStatus()
end

function EquipInfoTeamShowView:_btnfoldOnClick()
	if not self.comparing then
		return
	end

	self.comparing = false

	gohelper.setActive(self._gocontainer1, false)
	gohelper.setActive(self._simagecompare.gameObject, false)
	self:refreshSelectStatus()
end

function EquipInfoTeamShowView:_btncancelOnClick()
	self:closeThis()
end

function EquipInfoTeamShowView:_btnconfirmOnClick()
	local confirmType = self.viewParam.confirmViewType or self.viewParam.fromView
	local handleFunc = self.handleFuncDict[confirmType]

	handleFunc(self)
end

function EquipInfoTeamShowView:_onClickConfirmBtnFromPresetPreviewView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = false

	if equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)) then
		isReplace = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex
	equipTable.equipUid = {
		self.selectedEquipMo and self.selectedEquipMo.uid or "0"
	}

	curGroupMO:updatePosEquips(equipTable)
	HeroGroupPresetController.instance:dispatchEvent(HeroGroupPresetEvent.ChangeEquip, self.viewParam.presetGroupId, self.viewParam.presetSubId)
	HeroGroupPresetModel.instance:externalSaveCurGroupData(self.closeThis, self, curGroupMO, self.viewParam.presetGroupId, self.viewParam.presetSubId)
end

function EquipInfoTeamShowView:_onClickConfirmBtnFromCachotHeroGroupFightView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = false

	if equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)) then
		isReplace = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex
	equipTable.equipUid = {
		self.selectedEquipMo and self.selectedEquipMo.uid or "0"
	}

	V1a6_CachotHeroGroupModel.instance:replaceEquips(equipTable, curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, self.posIndex)
	V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup(self.closeThis, self)
end

function EquipInfoTeamShowView:_onClickConfirmBtnFromRougeHeroGroupFightView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = false

	if equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)) then
		isReplace = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex
	equipTable.equipUid = {
		self.selectedEquipMo and self.selectedEquipMo.uid or "0"
	}

	RougeHeroGroupModel.instance:replaceEquips(equipTable, curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, self.posIndex)
	RougeHeroGroupModel.instance:rougeSaveCurGroup(self.closeThis, self, curGroupMO)
end

function EquipInfoTeamShowView:_onClickConfirmBtnFromCachotHeroGroupView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = false

	if equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)) then
		isReplace = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex
	equipTable.equipUid = {
		self.selectedEquipMo and self.selectedEquipMo.uid or "0"
	}

	V1a6_CachotHeroGroupModel.instance:replaceEquips(equipTable, curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, self.posIndex)
	self:closeThis()
end

function EquipInfoTeamShowView:_onClickConfirmBtnFromHeroGroupFightView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = false

	if equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)) then
		isReplace = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex
	equipTable.equipUid = {
		self.selectedEquipMo and self.selectedEquipMo.uid or "0"
	}

	HeroGroupModel.instance:replaceEquips(equipTable, curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, self.posIndex)
	HeroGroupModel.instance:saveCurGroupData(self.closeThis, self, curGroupMO)
end

function EquipInfoTeamShowView:_onClickConfirmBtnFromSeason166HeroGroupFightView()
	local currentPosEquipList = self.viewContainer.listModel:getGroupCurrentPosEquip()
	local equipUid = currentPosEquipList[1]
	local isReplace = false

	if equipUid and (EquipModel.instance:getEquip(equipUid) or HeroGroupTrialModel.instance:getEquipMo(equipUid)) then
		isReplace = true
	end

	EquipChooseListModel.instance:clearTeamInfo()

	local curGroupMO = self.viewContainer.listModel.curGroupMO
	local equipTable = {}

	equipTable.index = self.posIndex
	equipTable.equipUid = {
		self.selectedEquipMo and self.selectedEquipMo.uid or "0"
	}

	Season166HeroGroupModel.instance:replaceEquips(equipTable, curGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip, self.posIndex)
	Season166HeroGroupModel.instance:saveCurGroupData(self.closeThis, self, curGroupMO)
end

function EquipInfoTeamShowView:_onClickConfirmBtnFromCharacterView()
	HeroRpc.instance:setHeroDefaultEquipRequest(self.heroMo.heroId, self.selectedEquipMo and self.selectedEquipMo.uid or "0")
end

function EquipInfoTeamShowView:_btnjumpOnClick()
	if self.selectedEquipMo then
		self._anim:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(function()
			ViewMgr.instance:openView(ViewName.EquipView, {
				equipMO = self.selectedEquipMo,
				defaultTabIds = {
					[2] = 2
				}
			})
		end, nil, 0.07)
	end
end

function EquipInfoTeamShowView:_btnequiplvOnClick()
	self.listModel:changeSortByLevel()
	self:refreshBtnStatus()
end

function EquipInfoTeamShowView:_btnequiprareOnClick()
	self.listModel:changeSortByRare()
	self:refreshBtnStatus()
end

function EquipInfoTeamShowView:onEquipTypeHasChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	self._scrollequip.verticalNormalizedPosition = 1

	local trialEquipMo = self.heroMo and self.heroMo:getTrialEquipMo()

	if trialEquipMo then
		if self.filterMo:checkIsIncludeTag(trialEquipMo.config) then
			self.listModel.equipMoList = {
				trialEquipMo
			}
		else
			self.listModel.equipMoList = {}
		end
	else
		self.listModel:initEquipList(self.filterMo)
	end

	self.listModel:refreshEquipList()
	self:refreshFilterBtnStatus()
end

function EquipInfoTeamShowView:_onCloseView(viewName)
	if viewName == ViewName.StoreView then
		self.listModel:selectFirstEquip()
		self.listModel:onModelUpdate()
		self:onSelectEquipChange()
	end
end

function EquipInfoTeamShowView:_editableInitView()
	self.goNotFilter = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_notfilter")
	self.goFilter = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_filter/#go_filter")
	self.goRareBtnNoSelect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn1")
	self.goRareBtnSelect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2")
	self.goLvBtnNoSelect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn1")
	self.goLvBtnSelect = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2")
	self.goRareBtnSelectArrow = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare/btn2/txt/arrow")
	self.goLvBtnSelectArrow = gohelper.findChild(self.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv/btn2/txt/arrow")
	self.goBaseSkillCanvasGroup = self._gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageBreakIcon = gohelper.findChildImage(self._gobreakeffect, "image_icon")
	self.txtBreakAttrName = gohelper.findChildText(self._gobreakeffect, "txt_name")
	self.txtBreakValue = gohelper.findChildText(self._gobreakeffect, "txt_value")

	gohelper.setActive(self._goleftempty, true)
	gohelper.setActive(self._gocontainer1, false)
	gohelper.setActive(self._gostrengthenattr, false)
	gohelper.setActive(self._txtsuiteffect2.gameObject, false)
	gohelper.addUIClickAudio(self._btnjump.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	gohelper.addUIClickAudio(self._btncompare.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)
	gohelper.addUIClickAudio(self._btnfold.gameObject, AudioEnum.HeroGroupUI.Play_UI_General_OK)

	self.strengthenAttrItems = self:getUserDataTb_()
	self.skillAttributeItems = self:getUserDataTb_()
	self.skillDescItems = self:getUserDataTb_()
	self.container1_strengthenAttrItems = self:getUserDataTb_()
	self.container1_skillAttributeItems = self:getUserDataTb_()
	self.container1_skillDescItems = self:getUserDataTb_()

	self:addEventCb(EquipController.instance, EquipEvent.ChangeSelectedEquip, self.onSelectEquipChange, self)
	self:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, self.onEquipChange, self)
	self:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, self.onEquipChange, self)
	self:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, self.onEquipChange, self)
	self:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, self.onEquipChange, self)
	self:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, self.onDeleteEquip, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
	self:addEventCb(CharacterController.instance, CharacterEvent.successSetDefaultEquip, self.onSuccessSetDefaultEquip, self)
	self:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, self.onEquipTypeHasChange, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)

	self.txtConfirm = gohelper.findChildText(self._btnconfirm.gameObject, "txt")
	self.comparing = false
	self.handleFuncDict = {
		[EquipEnum.FromViewEnum.FromHeroGroupFightView] = self._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupFightView] = self._onClickConfirmBtnFromCachotHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCachotHeroGroupView] = self._onClickConfirmBtnFromCachotHeroGroupView,
		[EquipEnum.FromViewEnum.FromRougeHeroGroupFightView] = self._onClickConfirmBtnFromRougeHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromCharacterView] = self._onClickConfirmBtnFromCharacterView,
		[EquipEnum.FromViewEnum.FromSeasonFightView] = self._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView] = self._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView] = self._onClickConfirmBtnFromSeason166HeroGroupFightView,
		[EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView] = self._onClickConfirmBtnFromHeroGroupFightView,
		[EquipEnum.FromViewEnum.FromPresetPreviewView] = self._onClickConfirmBtnFromPresetPreviewView
	}
	self._btnMaxLevelAnim = self._btnmaxlevel.gameObject:GetComponent(typeof(UnityEngine.Animator))
end

function EquipInfoTeamShowView:onUpdateParam()
	return
end

function EquipInfoTeamShowView:onOpenFinish()
	self._anim.enabled = true

	if self.viewParam and self.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.EquipInfo)
	end
end

function EquipInfoTeamShowView:_onCloseFullView()
	if self._anim then
		self._anim:Play(UIAnimationName.Open, 0, 0)
	end
end

function EquipInfoTeamShowView:onOpen()
	self.filterMo = EquipFilterModel.instance:generateFilterMo(self.viewName)
	self.heroMo = self.viewParam.heroMo
	self.posIndex = self.viewParam.posIndex
	self._isBalance = self.viewParam.isBalance

	self:initOriginEquipMo()

	self.listModel = self.viewContainer:getListModel()

	self.listModel:onOpen(self.viewParam, self.filterMo)

	self.selectedEquipMo = self.listModel:getCurrentSelectEquipMo()

	self._simagebg:LoadImage(ResUrl.getEquipBg("bg_beijingjianbian.png"))
	self._simagecompare:LoadImage(ResUrl.getEquipBg("full/bg_black_mask.png"))
	self:refreshCompareContainerUI()
	self:refreshUI()

	self.txtConfirm.text = luaLang("confirm_text")
end

function EquipInfoTeamShowView:refreshMaxLevelImage(offset)
	self._btnMaxLevelAnim:Play(self._showMax and "open" or "close", 0, offset)
	gohelper.setActive(self._gomaxlevelselect, self._showMax)
	gohelper.setActive(self._gomaxlevelunselect, not self._showMax)
end

function EquipInfoTeamShowView:initOriginEquipMo()
	self.originEquipMo = nil

	if self.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCharacterView then
		self.originEquipMo = EquipModel.instance:getEquip(self.viewParam.heroMo.defaultEquipUid)
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromSeasonFightView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromPresetPreviewView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView or self.viewParam.fromView == EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView then
		self.originEquipMo = self.viewParam.equipMo
	elseif self.viewParam.fromView == EquipEnum.FromViewEnum.FromAssassinHeroView then
		self.originEquipMo = self.viewParam.equipMo
	else
		logError("not found from view ...")

		self.originEquipMo = self.viewParam.equipMo
	end
end

function EquipInfoTeamShowView:refreshCompareContainerUI()
	local equipMo = self.originEquipMo

	if not equipMo then
		gohelper.setActive(self._gocontainer1, false)
		gohelper.setActive(self._simagecompare.gameObject, false)

		return
	end

	local isBalance = tonumber(equipMo.uid) > 0 and self.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	isBalance = isBalance or self._isBalance

	if isBalance then
		local equipLv = self.viewContainer:getBalanceEquipLv()

		if equipLv > equipMo.level then
			local newEquipMo = EquipMO.New()

			newEquipMo:initByConfig(nil, equipMo.equipId, equipLv, equipMo.refineLv)

			equipMo = newEquipMo
		else
			isBalance = nil
		end
	end

	if not self.container1_txtname then
		self.container1_txtname = gohelper.findChildText(self._gocontainer1, "#go_equipinfo/#txt_name")
	end

	self.container1_txtname.text = equipMo.config.name

	if not self.container1_txtlevel then
		self.container1_txtlevel = gohelper.findChildText(self._gocontainer1, "#go_equipinfo/#go_attr/#txt_level")
	end

	if not self.container1_gobalance then
		self.container1_gobalance = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_isBalance")
	end

	gohelper.setActive(self.container1_gobalance, isBalance)

	if not self.container1_goattr then
		self.container1_goattr = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr").transform
	end

	local x, y = transformhelper.getLocalPos(self.container1_goattr)

	transformhelper.setLocalPosXY(self.container1_goattr, x, isBalance and -28 or 17.3)

	local equipLevel = equipMo.level
	local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(equipMo)

	if isBalance then
		self.container1_txtlevel.text = string.format("Lv.<color=#8fb1cc>%d</color>/<color=#8fb1cc>%d</color>", equipLevel, currentBreakLvMaxLevel)
	else
		self.container1_txtlevel.text = string.format("Lv.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", equipLevel, currentBreakLvMaxLevel)
	end

	if not self.container1_goStarList then
		self.container1_goStarList = self:getUserDataTb_()

		for i = 1, 6 do
			table.insert(self.container1_goStarList, gohelper.findChild(self._gocontainer1, "#go_equipinfo/go_insigt/#image_" .. i))
		end
	end

	local equipRare = equipMo.config.rare

	for i = 1, 6 do
		gohelper.setActive(self.container1_goStarList[i], i <= equipRare + 1)
	end

	if not self.container1_gostrengthenattr then
		self.container1_gostrengthenattr = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_strengthenattr")
	end

	gohelper.setActive(self.container1_gostrengthenattr, false)

	local _, attrList = EquipConfig.instance:getEquipNormalAttr(equipMo.config.id, equipMo.level, HeroConfig.sortAttrForEquipView)
	local attrConfig, item

	for index, attr in ipairs(attrList) do
		item = self.container1_strengthenAttrItems[index]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.container1_gostrengthenattr, "item" .. index)
			item.icon = gohelper.findChildImage(item.go, "image_icon")
			item.name = gohelper.findChildText(item.go, "txt_name")
			item.attr_value = gohelper.findChildText(item.go, "txt_value")
			item.bg = gohelper.findChild(item.go, "bg")

			table.insert(self.container1_strengthenAttrItems, item)
		end

		attrConfig = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(attr.attrType))

		UISpriteSetMgr.instance:setCommonSprite(item.icon, "icon_att_" .. attrConfig.id)

		item.name.text = attrConfig.name
		item.attr_value.text = attr.value

		gohelper.setActive(item.bg, index % 2 == 0)
		gohelper.setActive(item.go, true)
	end

	for i = #attrList + 1, #self.container1_strengthenAttrItems do
		gohelper.setActive(self.container1_strengthenAttrItems[i].go, false)
	end

	if not self.container1_gobreakeffect then
		self.container1_gobreakeffect = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/attribute/container/#go_breakeffect")
		self.container1_imageBreakIcon = gohelper.findChildImage(self.container1_gobreakeffect, "image_icon")
		self.container1_txtBreakAttrName = gohelper.findChildText(self.container1_gobreakeffect, "txt_name")
		self.container1_txtBreakValue = gohelper.findChildText(self.container1_gobreakeffect, "txt_value")
	end

	local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(equipMo.config, equipMo.breakLv)

	if attrId then
		gohelper.setActive(self.container1_gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(self.container1_imageBreakIcon, "icon_att_" .. attrId)

		self.container1_txtBreakAttrName.text = EquipHelper.getAttrBreakText(attrId)
		self.container1_txtBreakValue.text = EquipHelper.getAttrPercentValueStr(value)

		gohelper.setAsLastSibling(self.container1_gobreakeffect)
	else
		gohelper.setActive(self.container1_gobreakeffect, false)
	end

	if not self.container1_gosuitattribute then
		self.container1_gosuitattribute = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute")
	end

	if equipMo.config.rare <= EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(self.container1_gosuitattribute, false)

		return
	end

	gohelper.setActive(self.container1_gosuitattribute, true)

	if not self.container1_txtattributelv then
		self.container1_txtattributelv = gohelper.findChildText(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/attributename/#txt_attributelv")
	end

	if not self.container1_goadvanceskill then
		self.container1_goadvanceskill = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_advanceskill")
	end

	if not self.container1_gobaseskill then
		self.container1_gobaseskill = gohelper.findChild(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill")
		self.container1_goBaseSkillCanvasGroup = self.container1_gobaseskill:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	if not self.container1_txtsuiteffect2 then
		self.container1_txtsuiteffect2 = gohelper.findChildText(self._gocontainer1, "#go_equipinfo/#go_attr/layout/#go_suitattribute/#scroll_desccontainer/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	end

	gohelper.setActive(self.container1_txtsuiteffect2.gameObject, false)

	local skillDesList = EquipHelper.getEquipSkillBaseDes(equipMo.config.id, equipMo.refineLv, "#D9A06F")

	if #skillDesList == 0 then
		gohelper.setActive(self.container1_gobaseskill, false)
	else
		self.container1_txtattributelv.text = equipMo.refineLv

		gohelper.setActive(self.container1_gobaseskill, true)

		local item

		for index, desc in ipairs(skillDesList) do
			item = self.container1_skillDescItems[index]

			if not item then
				item = self:getUserDataTb_()
				item.itemGo = gohelper.cloneInPlace(self.container1_txtsuiteffect2.gameObject, "item_" .. index)
				item.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(item.itemGo, FixTmpBreakLine)
				item.imagepoint = gohelper.findChildImage(item.itemGo, "#image_point")
				item.txt = item.itemGo:GetComponent(gohelper.Type_TextMesh)

				SkillHelper.addHyperLinkClick(item.txt)
				table.insert(self.container1_skillDescItems, item)
			end

			item.txt.text = EquipHelper.getEquipSkillDesc(desc)

			item.fixTmpBreakLine:refreshTmpContent(item.txt)
			gohelper.setActive(item.itemGo, true)
		end

		self.container1_goBaseSkillCanvasGroup.alpha = equipMo and self.heroMo and EquipHelper.detectEquipSkillSuited(self.heroMo.heroId, equipMo.config.id, equipMo.refineLv) and 1 or 0.4

		for i = #skillDesList + 1, #self.container1_skillDescItems do
			gohelper.setActive(self.container1_skillDescItems[i].itemGo, false)
		end
	end
end

function EquipInfoTeamShowView:refreshUI()
	self:refreshBtnStatus()
	self:refreshHeroInfo()
	self:refreshLeftUI()
	self:refreshCenterUI()
	self:refreshRightUI()
	self:refreshRecommedNotEquip()
end

function EquipInfoTeamShowView:refreshBtnStatus()
	gohelper.setActive(self.goRareBtnNoSelect, not self.listModel:isSortByRare())
	gohelper.setActive(self.goRareBtnSelect, self.listModel:isSortByRare())
	gohelper.setActive(self.goLvBtnNoSelect, not self.listModel:isSortByLevel())
	gohelper.setActive(self.goLvBtnSelect, self.listModel:isSortByLevel())

	local levelState, rareState = self.listModel:getSortState()

	transformhelper.setLocalScale(self.goRareBtnSelectArrow.transform, 1, rareState, 1)
	transformhelper.setLocalScale(self.goLvBtnSelectArrow.transform, 1, levelState, 1)
	self:refreshFilterBtnStatus()
end

function EquipInfoTeamShowView:refreshFilterBtnStatus()
	local isFiltering = self.filterMo:isFiltering()

	gohelper.setActive(self.goNotFilter, not isFiltering)
	gohelper.setActive(self.goFilter, isFiltering)
end

function EquipInfoTeamShowView:refreshHeroInfo()
	gohelper.setActive(self._goherocontainer, self.heroMo)
	gohelper.setActive(self._goheroempty, not self.heroMo)

	if not self.heroMo then
		return
	end

	self._simageheroicon:LoadImage(ResUrl.getHandbookheroIcon(self.heroMo.config.skinId))

	self._txtheroname.text = self.heroMo:getHeroName()

	UISpriteSetMgr.instance:setHandBookCareerSprite(self._imageherocareer, "sx_icon_" .. tostring(self.heroMo.config.career))
end

function EquipInfoTeamShowView:refreshLeftUI()
	local isTrialDefaultEquip = self.heroMo and self.heroMo.trialEquipMo and true or false
	local showBalance = self.selectedEquipMo and not isTrialDefaultEquip and self.selectedEquipMo.uid and tonumber(self.selectedEquipMo.uid) > 0 and self.viewParam.fromView == EquipEnum.FromViewEnum.FromHeroGroupFightView and HeroGroupBalanceHelper.getIsBalanceMode()

	showBalance = showBalance or self._isBalance
	self._balanceEquipMo = nil

	if showBalance and self.selectedEquipMo then
		local equipLv = self.viewContainer:getBalanceEquipLv()

		if equipLv <= self.selectedEquipMo.level then
			showBalance = nil
		else
			local newEquipMo = EquipMO.New()

			newEquipMo:initByConfig(nil, self.selectedEquipMo.equipId, equipLv, self.selectedEquipMo.refineLv)

			self._balanceEquipMo = newEquipMo
		end
	end

	gohelper.setActive(self._gotrialtip, isTrialDefaultEquip)
	gohelper.setActive(self._goequipinfo, self.selectedEquipMo)
	gohelper.setActive(self._goequipinfoempty, not self.selectedEquipMo)
	gohelper.setActive(self._gobalance, showBalance)

	local x, y = transformhelper.getLocalPos(self._goAttr.transform)

	transformhelper.setLocalPosXY(self._goAttr.transform, x, showBalance and -172.2 or -127)

	self.layoutElement.minHeight = showBalance and 142 or 187

	if self.selectedEquipMo then
		self._txtname.text = self.selectedEquipMo.config.name

		self:refreshEquipStar()
		self:refreshSelectStatus()
		self:refreshEquipLevel()
		self:refreshEquipNormalAttr()

		if self.selectedEquipMo.config.rare > EquipConfig.instance:getNotShowRefineRare() then
			self:refreshEquipSkillDesc()
			gohelper.setActive(self._gosuitattribute, true)
		else
			gohelper.setActive(self._gosuitattribute, false)
		end

		self:refreshInTeam()
	end

	local isShowBtnJump = self.selectedEquipMo ~= nil and self.selectedEquipMo.uid and tonumber(self.selectedEquipMo.uid) > 0

	gohelper.setActive(self._btnjump.gameObject, isShowBtnJump)
	gohelper.setActive(self._gobuttom, not isTrialDefaultEquip)
end

function EquipInfoTeamShowView:refreshCenterUI()
	if self.selectedEquipMo then
		self._simageequip:LoadImage(ResUrl.getEquipSuit(self.selectedEquipMo.config.icon))
		gohelper.setActive(self._gocenter, true)
	else
		gohelper.setActive(self._gocenter, false)
	end
end

function EquipInfoTeamShowView:refreshRightUI()
	local isEmpty = self.listModel:isEmpty()

	gohelper.setActive(self._scrollequip.gameObject, not isEmpty)
	gohelper.setActive(self._goequipempty, isEmpty)

	if not isEmpty then
		self.listModel:refreshEquipList()
	end
end

function EquipInfoTeamShowView:refreshRecommedNotEquip()
	if self.selectedEquipMo then
		local isRecommedNot = self.selectedEquipMo.equipType and self.selectedEquipMo.equipType == EquipEnum.ClientEquipType.RecommedNot

		gohelper.setActive(self._btnmaxlevel.gameObject, isRecommedNot)
		gohelper.setActive(self._btncancel.gameObject, not isRecommedNot)
		gohelper.setActive(self._btnconfirm.gameObject, not isRecommedNot)

		local isCanGotoStore = self:_canGotoStore()
		local isShowEmpty = isRecommedNot and not isCanGotoStore
		local isShowGoto = isRecommedNot and isCanGotoStore

		if isRecommedNot then
			self._normalEquipMO = self.selectedEquipMo
			self._maxEquipMo = EquipHelper.createMaxLevelEquipMo(self.selectedEquipMo.equipId, self.selectedEquipMo.id)
			self._showMax = false

			self:refreshMaxLevelImage(1)
		end

		gohelper.setActive(self._goEquipEmpty.gameObject, isShowEmpty)
		gohelper.setActive(self._btngoto.gameObject, isShowGoto)
	end
end

function EquipInfoTeamShowView:_canGotoStore()
	local storeMO = StoreModel.instance:getStoreMO(StoreEnum.StoreId.SummonEquipExchange)

	if storeMO then
		local storeGoodsMOList = storeMO:getGoodsList()

		if storeGoodsMOList then
			for _, mo in ipairs(storeGoodsMOList) do
				local product = mo.config.product
				local productArr = GameUtil.splitString2(product, true)
				local itemType = productArr[1][1]
				local itemId = productArr[1][2]

				if itemType == MaterialEnum.MaterialType.Equip and self.selectedEquipMo.equipId == itemId then
					return true
				end
			end
		end
	end
end

function EquipInfoTeamShowView:refreshEquipStar()
	local equipRare = self.selectedEquipMo.config.rare

	for i = 1, 6 do
		gohelper.setActive(self["_image" .. i].gameObject, i <= equipRare + 1)
	end
end

function EquipInfoTeamShowView:refreshSelectStatus()
	if not self.originEquipMo then
		gohelper.setActive(self._btncompare.gameObject, false)
		gohelper.setActive(self._btninteam.gameObject, false)
		gohelper.setActive(self._btnfold.gameObject, false)

		return
	end

	if self.comparing then
		gohelper.setActive(self._btncompare.gameObject, false)
		gohelper.setActive(self._btninteam.gameObject, false)
		gohelper.setActive(self._btnfold.gameObject, true)

		return
	end

	if self.originEquipMo.uid == self.selectedEquipMo.uid then
		gohelper.setActive(self._btncompare.gameObject, false)
		gohelper.setActive(self._btninteam.gameObject, true)
		gohelper.setActive(self._btnfold.gameObject, false)

		return
	end

	gohelper.setActive(self._btncompare.gameObject, true)
	gohelper.setActive(self._btninteam.gameObject, false)
	gohelper.setActive(self._btnfold.gameObject, false)
end

function EquipInfoTeamShowView:refreshEquipLevel()
	if self._balanceEquipMo then
		local equipLevel = self._balanceEquipMo.level
		local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(self._balanceEquipMo)

		self._txtlevel.text = string.format("Lv.<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>/<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">%d</color>", equipLevel, currentBreakLvMaxLevel)
	else
		local equipLevel = self.selectedEquipMo.level
		local currentBreakLvMaxLevel = EquipConfig.instance:getCurrentBreakLevelMaxLevel(self.selectedEquipMo)

		self._txtlevel.text = string.format("Lv.<color=#d9a06f>%d</color>/<color=#777676>%d</color>", equipLevel, currentBreakLvMaxLevel)
	end
end

function EquipInfoTeamShowView:refreshEquipNormalAttr()
	local equipMo = self._balanceEquipMo or self.selectedEquipMo
	local _, attrList = EquipConfig.instance:getEquipNormalAttr(equipMo.config.id, equipMo.level, HeroConfig.sortAttrForEquipView)
	local item, attrConfig

	for index, attr in ipairs(attrList) do
		item = self.strengthenAttrItems[index]

		if not item then
			item = {
				go = gohelper.cloneInPlace(self._gostrengthenattr, "item" .. index)
			}
			item.icon = gohelper.findChildImage(item.go, "image_icon")
			item.name = gohelper.findChildText(item.go, "txt_name")
			item.attr_value = gohelper.findChildText(item.go, "txt_value")
			item.bg = gohelper.findChild(item.go, "bg")

			table.insert(self.strengthenAttrItems, item)
		end

		attrConfig = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(attr.attrType))

		UISpriteSetMgr.instance:setCommonSprite(item.icon, "icon_att_" .. attrConfig.id)

		item.name.text = attrConfig.name
		item.attr_value.text = attr.value

		gohelper.setActive(item.bg, index % 2 == 0)
		gohelper.setActive(item.go, true)
	end

	for i = #attrList + 1, #self.strengthenAttrItems do
		gohelper.setActive(self.strengthenAttrItems[i].go, false)
	end

	local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(equipMo.config, equipMo.breakLv)

	if attrId then
		gohelper.setActive(self._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(self.imageBreakIcon, "icon_att_" .. attrId)

		self.txtBreakAttrName.text = EquipHelper.getAttrBreakText(attrId)
		self.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(value)

		gohelper.setAsLastSibling(self._gobreakeffect)
	else
		gohelper.setActive(self._gobreakeffect, false)
	end
end

function EquipInfoTeamShowView:refreshEquipSkillDesc()
	local skillDesList = EquipHelper.getEquipSkillBaseDes(self.selectedEquipMo.config.id, self.selectedEquipMo.refineLv, "#D9A06F")

	if #skillDesList == 0 then
		gohelper.setActive(self._gobaseskill.gameObject, false)
	else
		self._txtattributelv.text = self.selectedEquipMo.refineLv

		gohelper.setActive(self._gobaseskill.gameObject, true)

		local cell, itemGo, iteminfo

		for index, desc in ipairs(skillDesList) do
			cell = self.skillDescItems[index]

			if not cell then
				iteminfo = self:getUserDataTb_()
				itemGo = gohelper.cloneInPlace(self._txtsuiteffect2.gameObject, "item_" .. index)
				iteminfo.itemGo = itemGo
				iteminfo.imagepoint = gohelper.findChildImage(itemGo, "#image_point")
				iteminfo.txt = itemGo:GetComponent(gohelper.Type_TextMesh)

				SkillHelper.addHyperLinkClick(iteminfo.txt)

				cell = iteminfo

				table.insert(self.skillDescItems, cell)
			end

			cell.txt.text = EquipHelper.getEquipSkillDesc(desc)

			gohelper.setActive(cell.itemGo, true)
		end

		for i = #skillDesList + 1, #self.skillDescItems do
			gohelper.setActive(self.skillDescItems[i].itemGo, false)
		end

		EquipController.instance:dispatchEvent(EquipEvent.equipHasRefine)
	end
end

function EquipInfoTeamShowView:refreshInTeam()
	if self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromHeroGroupFightView and self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromSeasonFightView and self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupView and self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromCachotHeroGroupFightView and self.viewParam.fromView ~= EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView then
		gohelper.setActive(self._gointeam, false)

		return
	end

	local heroMo = self.viewContainer.listModel:getHeroMoByEquipUid(self.selectedEquipMo.uid)

	if self.heroMo and heroMo and self.selectedEquipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		heroMo = self.heroMo
	end

	if heroMo then
		gohelper.setActive(self._gointeam, true)

		local skinCo = lua_skin.configDict[heroMo.skin]

		self._gointeamheroicon:LoadImage(ResUrl.getHeadIconSmall(skinCo.headIcon))

		self._gointeamheroname.text = string.format(luaLang("hero_inteam"), heroMo.config.name)
	else
		gohelper.setActive(self._gointeam, false)
	end
end

function EquipInfoTeamShowView:onSelectEquipChange()
	self.selectedEquipMo = self.listModel:getCurrentSelectEquipMo()

	self:refreshLeftUI()
	self:refreshCenterUI()
	self:refreshRecommedNotEquip()
end

function EquipInfoTeamShowView:onEquipChange()
	self.listModel:initEquipList(self.filterMo)
	self:refreshLeftUI()
	self:refreshRightUI()
	self:refreshCompareContainerUI()
end

function EquipInfoTeamShowView:onDeleteEquip(equipUidList)
	for _, equipUid in ipairs(equipUidList) do
		if self.selectedEquipMo.uid == equipUid then
			self.listModel:setCurrentSelectEquipMo(nil)
			self:onSelectEquipChange()

			break
		end
	end
end

function EquipInfoTeamShowView:onSuccessSetDefaultEquip(defaultEquipUid)
	self:closeThis()
end

function EquipInfoTeamShowView:onClose()
	self._simageheroicon:UnLoadImage()
	self._simageequip:UnLoadImage()
	self._simagebg:UnLoadImage()
	self._simagecompare:UnLoadImage()
	self.listModel:clear()
	EquipFilterModel.instance:clear(self.viewName)
end

function EquipInfoTeamShowView:onDestroyView()
	return
end

return EquipInfoTeamShowView
