module("modules.logic.character.view.CharacterDefaultEquipView", package.seeall)

slot0 = class("CharacterDefaultEquipView", BaseView)

function slot0.onInitView(slot0)
	slot0.goequipcontainer = gohelper.findChild(slot0.viewGO, "anim/layout/auxiliary/#go_equipcontainer")
	slot0.goclickarea = gohelper.findChild(slot0.viewGO, "anim/layout/auxiliary/#go_equipcontainer/#go_clickarea")
	slot0.txtlv = gohelper.findChildText(slot0.viewGO, "anim/layout/auxiliary/#go_equipcontainer/#txt_lv")
	slot0._godestiny = gohelper.findChild(slot0.viewGO, "anim/layout/auxiliary/#go_destiny")
	slot0._gostone = gohelper.findChild(slot0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone")
	slot0._imagestone = gohelper.findChildSingleImage(slot0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#image_stone")
	slot0._btndestiny = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/layout/auxiliary/#go_destiny/#btn_destiny")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndestiny:AddClickListener(slot0._btndestinyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndestiny:RemoveClickListener()
end

function slot0._btndestinyOnClick(slot0)
	if not slot0:_isOwnHero() then
		return
	end

	if slot0.heroMo:isCanOpenDestinySystem(true) then
		CharacterDestinyController.instance:openCharacterDestinySlotView(slot0.heroMo)

		if slot0:_isShowDestinyReddot() then
			HeroRpc.instance:setHeroRedDotReadRequest(slot0.heroMo.heroId, 2)
		end
	end
end

function slot0._editableInitView(slot0)
	slot0.goaddicon = gohelper.findChild(slot0.goequipcontainer, "lang_txt/#go_addIcon")
	slot0.simageequipicon = gohelper.findChildSingleImage(slot0.goequipcontainer, "lang_txt/#simage_equipicon")
	slot0.equipClick = gohelper.getClickWithAudio(slot0.goclickarea, AudioEnum.UI.play_ui_admission_open)

	slot0.equipClick:AddClickListener(slot0.onClickEquip, slot0)

	slot0._gostonelock = gohelper.findChild(slot0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#go_lock")
	slot0._gostoneunlock = gohelper.findChild(slot0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#level")
	slot0._txtstonelevel = gohelper.findChildText(slot0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#txt_level")
	slot0._gostoneLevelmax = gohelper.findChild(slot0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#level/#max")
	slot0._godestinyreddot = gohelper.findChild(slot0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_destinyreddot")

	gohelper.setActive(slot0._gostone, true)

	slot0._animDestiny = slot0._godestiny:GetComponent(typeof(UnityEngine.Animator))
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

function slot0._isOwnHero(slot0)
	if not slot0.viewContainer:isOwnHero() then
		return
	end

	if slot0.heroMo:isOtherPlayerHero() or slot0.heroMo:isTrial() then
		return
	end

	return true
end

function slot0.playOpenAnim(slot0)
	if slot0.heroMo:isOtherPlayerHero() then
		return
	end

	slot0:_playDestinyAnim("open")

	if not slot0.isUnlockEquip then
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

	slot0:_onRefreshDestinySystem()

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
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._onRefreshDestinySystem, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._onRefreshDestinySystem, slot0)
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
	slot0:_onRefreshDestinySystem()
end

function slot0.onClose(slot0)
	slot0.equipClick:RemoveClickListener()

	if slot0.isUnlockEquip then
		slot0.simageequipicon:UnLoadImage()
		slot0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0.onHeroUpdatePush, slot0)
		slot0:removeEventCb(CharacterController.instance, CharacterEvent.RefreshDefaultEquip, slot0._onRefreshDefaultEquip, slot0)
		slot0:removeEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.refreshUI, slot0)
	end

	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._onRefreshDestinySystem, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._onRefreshDestinySystem, slot0)
end

function slot0._onRefreshDefaultEquip(slot0, slot1)
	slot0.viewParam = slot1

	slot0:onOpen()
end

function slot0._onRefreshDestinySystem(slot0)
	slot1 = slot0.heroMo:isHasDestinySystem()
	slot3 = slot0.heroMo.destinyStoneMo

	if slot0.heroMo:isCanOpenDestinySystem() then
		if not slot0._stoneLevel then
			slot0._stoneLevel = slot0:getUserDataTb_()

			for slot7 = 1, 4 do
				slot9 = slot0:getUserDataTb_()
				slot9.canvasgroup = gohelper.findChild(slot0._gostone, "#level/level" .. slot7):GetComponent(typeof(UnityEngine.CanvasGroup))

				table.insert(slot0._stoneLevel, slot9)
			end
		end

		if slot3 then
			slot4 = slot3.rank or 0
			slot5 = slot4 == slot3.maxRank
			slot0._txtstonelevel.text = CharacterDestinyEnum.RomanNum[slot4]

			for slot9, slot10 in ipairs(slot0._stoneLevel) do
				slot10.canvasgroup.alpha = slot9 <= slot4 and 1 or 0.3
			end

			gohelper.setActive(slot0._gostoneLevelmax.gameObject, slot5)
		end

		if slot3.curUseStoneId ~= 0 then
			slot4, slot5 = slot3:getCurStoneNameAndIcon()

			slot0._imagestone:LoadImage(slot5)
		end
	end

	gohelper.setActive(slot0._godestiny, slot1)
	gohelper.setActive(slot0._gostoneunlock, slot2)
	gohelper.setActive(slot0._gostonelock, not slot2)
	gohelper.setActive(slot0._imagestone.gameObject, slot2 and slot3:isUnlockSlot() and slot3.curUseStoneId ~= 0)
	gohelper.setActive(slot0._txtstonelevel.gameObject, slot2)
	gohelper.setActive(slot0._godestinyreddot, slot0:_isShowDestinyReddot())
end

function slot0._isShowDestinyReddot(slot0)
	if not slot0:_isOwnHero() then
		return
	end

	if slot0.heroMo and slot0.heroMo.destinyStoneMo then
		return slot0.heroMo:isCanOpenDestinySystem() and slot0.heroMo.destinyStoneMo:getRedDot() < 3
	end
end

function slot0._playDestinyAnim(slot0, slot1)
	if slot0._animDestiny then
		slot0._animDestiny:Play(slot1, 0, 0)
	end
end

function slot0.onDestroyView(slot0)
	slot0._imagestone:UnLoadImage()
end

return slot0
