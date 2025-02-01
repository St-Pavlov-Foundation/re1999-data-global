module("modules.logic.character.view.CharacterDefaultEquipView", package.seeall)

slot0 = class("CharacterDefaultEquipView", BaseView)

function slot0.onInitView(slot0)
	slot0.goequipcontainer = gohelper.findChild(slot0.viewGO, "anim/layout/#go_equipcontainer")
	slot0.goclickarea = gohelper.findChild(slot0.viewGO, "anim/layout/#go_equipcontainer/lang_txt/#go_clickarea")
	slot0.txtlv = gohelper.findChildText(slot0.viewGO, "anim/layout/#go_equipcontainer/lang_txt/#txt_lv")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.goaddicon = gohelper.findChild(slot0.goequipcontainer, "lang_txt/#go_addIcon")
	slot0.simageequipicon = gohelper.findChildSingleImage(slot0.goequipcontainer, "lang_txt/#simage_equipicon")
	slot0.equipClick = gohelper.getClickWithAudio(slot0.goclickarea, AudioEnum.UI.play_ui_admission_open)

	slot0.equipClick:AddClickListener(slot0.onClickEquip, slot0)
end

function slot0.onClickEquip(slot0)
	if slot0.heroMo:isOwnHero() then
		EquipController.instance:openEquipInfoTeamView({
			heroMo = slot0.heroMo,
			fromView = EquipEnum.FromViewEnum.FromCharacterView
		})

		return
	end

	if slot0.heroMo:isOtherPlayerHero() or not (slot0.heroMo and slot0.heroMo:getTrialEquipMo()) then
		GameFacade.showToast(ToastEnum.TrialCantUseEquip)
	else
		EquipController.instance:openEquipInfoTeamView({
			heroMo = slot0.heroMo,
			equipMo = slot3,
			fromView = EquipEnum.FromViewEnum.FromCharacterView
		})
	end
end

function slot0.playOpenAnim(slot0)
	if not slot0.isUnlockEquip or slot0.heroMo:isOtherPlayerHero() then
		return
	end

	slot0._equipAnimator.enabled = false
	slot0._equipAnimator.enabled = true

	slot0._equipAnimator:Play("open", 0, 0)
end

function slot0._showEquipPreferenceOpen(slot0)
	if not slot0.isUnlockEquip or slot0.heroMo:isOtherPlayerHero() then
		return
	end

	slot0._equipAnimator = gohelper.onceAddComponent(slot0.goequipcontainer, typeof(UnityEngine.Animator))

	if PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.EquipPreferenceOpen) == "1" then
		slot0._equipAnimator:Play("open", 0, 0)

		return
	end

	slot0._equipAnimator:Play("onece", 0, 0)

	slot5 = slot4

	PlayerModel.instance:forceSetSimpleProperty(slot2, slot5)
	PlayerRpc.instance:sendSetSimplePropertyRequest(slot2, slot5)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
end

function slot0.onOpen(slot0)
	slot0.heroMo = slot0.viewParam
	slot2 = slot0.viewParam:isOtherPlayerHero()

	if slot0.viewParam:isTrial() then
		slot0.isUnlockEquip = true
	else
		slot0.isUnlockEquip = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Equip)
	end

	gohelper.setActive(slot0.goequipcontainer, slot0.isUnlockEquip and not slot2)

	if not slot0.isUnlockEquip then
		return
	end

	slot0:_showEquipPreferenceOpen()

	slot0.equipMo = nil

	if not slot2 and slot0.heroMo:hasDefaultEquip() then
		slot0.equipMo = slot0.heroMo and slot0.heroMo:getTrialEquipMo() or EquipModel.instance:getEquip(slot0.heroMo.defaultEquipUid)
	end

	slot0:refreshUI()
	slot0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0.onHeroUpdatePush, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.RefreshDefaultEquip, slot0._onRefreshDefaultEquip, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.refreshUI, slot0)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0.simageequipicon.gameObject, slot0.equipMo ~= nil)
	gohelper.setActive(slot0.txtlv.gameObject, slot0.equipMo ~= nil)
	gohelper.setActive(slot0.goaddicon, slot0.equipMo == nil)

	if slot0.equipMo then
		slot0.simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot0.equipMo.config.icon))

		slot0.txtlv.text = slot0.equipMo.level
	end
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onHeroUpdatePush(slot0)
	if not slot0.heroMo:isOtherPlayerHero() and slot0.heroMo:hasDefaultEquip() then
		slot0.equipMo = EquipModel.instance:getEquip(slot0.heroMo.defaultEquipUid)
	else
		slot0.equipMo = nil
	end

	slot0:refreshUI()
end

function slot0.onClose(slot0)
	slot0.equipClick:RemoveClickListener()

	if slot0.isUnlockEquip then
		slot0.simageequipicon:UnLoadImage()
		slot0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0.onHeroUpdatePush, slot0)
		slot0:removeEventCb(CharacterController.instance, CharacterEvent.RefreshDefaultEquip, slot0._onRefreshDefaultEquip, slot0)
		slot0:removeEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.refreshUI, slot0)
	end
end

function slot0._onRefreshDefaultEquip(slot0, slot1)
	slot0.viewParam = slot1

	slot0:onOpen()
end

function slot0.onDestroyView(slot0)
end

return slot0
