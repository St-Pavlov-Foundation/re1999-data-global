-- chunkname: @modules/logic/character/view/CharacterDefaultEquipView.lua

module("modules.logic.character.view.CharacterDefaultEquipView", package.seeall)

local CharacterDefaultEquipView = class("CharacterDefaultEquipView", BaseView)

function CharacterDefaultEquipView:onInitView()
	self.goequipcontainer = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_equipcontainer")
	self.goclickarea = gohelper.findChild(self.viewGO, "anim/layout/auxiliary/#go_equipcontainer/#go_clickarea")
	self.txtlv = gohelper.findChildText(self.viewGO, "anim/layout/auxiliary/#go_equipcontainer/#txt_lv")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDefaultEquipView:addEvents()
	return
end

function CharacterDefaultEquipView:removeEvents()
	return
end

function CharacterDefaultEquipView:_editableInitView()
	self.goaddicon = gohelper.findChild(self.goequipcontainer, "lang_txt/#go_addIcon")
	self.simageequipicon = gohelper.findChildSingleImage(self.goequipcontainer, "lang_txt/#simage_equipicon")
	self.equipClick = gohelper.getClickWithAudio(self.goclickarea, AudioEnum.UI.play_ui_admission_open)

	self.equipClick:AddClickListener(self.onClickEquip, self)
end

function CharacterDefaultEquipView:onClickEquip()
	local isOwnHero = self.heroMo:isOwnHero()

	if isOwnHero then
		EquipController.instance:openEquipInfoTeamView({
			heroMo = self.heroMo,
			fromView = EquipEnum.FromViewEnum.FromCharacterView
		})

		return
	end

	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()
	local trialEquipMo = self.heroMo and self.heroMo:getTrialEquipMo()

	if isOtherPlayerHero or not trialEquipMo then
		GameFacade.showToast(ToastEnum.TrialCantUseEquip)
	else
		EquipController.instance:openEquipInfoTeamView({
			heroMo = self.heroMo,
			equipMo = trialEquipMo,
			fromView = EquipEnum.FromViewEnum.FromCharacterView
		})
	end
end

function CharacterDefaultEquipView:playOpenAnim()
	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()

	if not self.isUnlockEquip or isOtherPlayerHero then
		return
	end

	self._equipAnimator.enabled = false
	self._equipAnimator.enabled = true

	self._equipAnimator:Play("open", 0, 0)
end

function CharacterDefaultEquipView:_showEquipPreferenceOpen()
	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()

	if not self.isUnlockEquip or isOtherPlayerHero then
		return
	end

	self._equipAnimator = gohelper.onceAddComponent(self.goequipcontainer, typeof(UnityEngine.Animator))

	local id = PlayerEnum.SimpleProperty.EquipPreferenceOpen
	local value = PlayerModel.instance:getSimpleProperty(id)
	local targetValue = "1"

	if value == targetValue then
		self._equipAnimator:Play("open", 0, 0)

		return
	end

	self._equipAnimator:Play("onece", 0, 0)

	local value = targetValue

	PlayerModel.instance:forceSetSimpleProperty(id, value)
	PlayerRpc.instance:sendSetSimplePropertyRequest(id, value)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
end

function CharacterDefaultEquipView:onOpen()
	self.heroMo = self.viewParam

	local isTrial = self.viewParam:isTrial()
	local isOtherPlayerHero = self.viewParam:isOtherPlayerHero()

	if isTrial then
		self.isUnlockEquip = true
	else
		self.isUnlockEquip = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Equip)
	end

	gohelper.setActive(self.goequipcontainer, self.isUnlockEquip and not isOtherPlayerHero)

	if not self.isUnlockEquip then
		return
	end

	self:_showEquipPreferenceOpen()

	self.equipMo = nil

	if not isOtherPlayerHero and self.heroMo:hasDefaultEquip() then
		local equipMo = self.heroMo and self.heroMo:getTrialEquipMo()

		equipMo = equipMo or EquipModel.instance:getEquip(self.heroMo.defaultEquipUid)
		self.equipMo = equipMo
	end

	self:refreshUI()
	self:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, self.onHeroUpdatePush, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.RefreshDefaultEquip, self._onRefreshDefaultEquip, self)
	self:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, self.refreshUI, self)
end

function CharacterDefaultEquipView:refreshUI()
	gohelper.setActive(self.simageequipicon.gameObject, self.equipMo ~= nil)
	gohelper.setActive(self.txtlv.gameObject, self.equipMo ~= nil)
	gohelper.setActive(self.goaddicon, self.equipMo == nil)

	if self.equipMo then
		self.simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(self.equipMo.config.icon))

		self.txtlv.text = self.equipMo.level
	end
end

function CharacterDefaultEquipView:onUpdateParam()
	self:onOpen()
end

function CharacterDefaultEquipView:onHeroUpdatePush()
	local isOtherPlayerHero = self.heroMo:isOtherPlayerHero()

	if not isOtherPlayerHero and self.heroMo:hasDefaultEquip() then
		self.equipMo = EquipModel.instance:getEquip(self.heroMo.defaultEquipUid)
	else
		self.equipMo = nil
	end

	self:refreshUI()
end

function CharacterDefaultEquipView:onClose()
	self.equipClick:RemoveClickListener()

	if self.isUnlockEquip then
		self.simageequipicon:UnLoadImage()
		self:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, self.onHeroUpdatePush, self)
		self:removeEventCb(CharacterController.instance, CharacterEvent.RefreshDefaultEquip, self._onRefreshDefaultEquip, self)
		self:removeEventCb(EquipController.instance, EquipEvent.onUpdateEquip, self.refreshUI, self)
	end
end

function CharacterDefaultEquipView:_onRefreshDefaultEquip(viewParam)
	self.viewParam = viewParam

	self:onOpen()
end

function CharacterDefaultEquipView:onDestroyView()
	return
end

return CharacterDefaultEquipView
