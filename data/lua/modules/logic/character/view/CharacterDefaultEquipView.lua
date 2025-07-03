module("modules.logic.character.view.CharacterDefaultEquipView", package.seeall)

local var_0_0 = class("CharacterDefaultEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goequipcontainer = gohelper.findChild(arg_1_0.viewGO, "anim/layout/auxiliary/#go_equipcontainer")
	arg_1_0.goclickarea = gohelper.findChild(arg_1_0.viewGO, "anim/layout/auxiliary/#go_equipcontainer/#go_clickarea")
	arg_1_0.txtlv = gohelper.findChildText(arg_1_0.viewGO, "anim/layout/auxiliary/#go_equipcontainer/#txt_lv")
	arg_1_0._godestiny = gohelper.findChild(arg_1_0.viewGO, "anim/layout/auxiliary/#go_destiny")
	arg_1_0._gostone = gohelper.findChild(arg_1_0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone")
	arg_1_0._txtdestiny = gohelper.findChildText(arg_1_0.viewGO, "anim/layout/auxiliary/#go_destiny/#txt_destiny")
	arg_1_0._imagestone = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#image_stone")
	arg_1_0._btndestiny = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/layout/auxiliary/#go_destiny/#btn_destiny")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndestiny:AddClickListener(arg_2_0._btndestinyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndestiny:RemoveClickListener()
end

function var_0_0._btndestinyOnClick(arg_4_0)
	if not arg_4_0:_isOwnHero() then
		return
	end

	if arg_4_0.heroMo:isCanOpenDestinySystem(true) then
		CharacterDestinyController.instance:openCharacterDestinySlotView(arg_4_0.heroMo)

		if arg_4_0:_isShowDestinyReddot() then
			HeroRpc.instance:setHeroRedDotReadRequest(arg_4_0.heroMo.heroId, 2)
		end
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.goaddicon = gohelper.findChild(arg_5_0.goequipcontainer, "lang_txt/#go_addIcon")
	arg_5_0.simageequipicon = gohelper.findChildSingleImage(arg_5_0.goequipcontainer, "lang_txt/#simage_equipicon")
	arg_5_0.equipClick = gohelper.getClickWithAudio(arg_5_0.goclickarea, AudioEnum.UI.play_ui_admission_open)

	arg_5_0.equipClick:AddClickListener(arg_5_0.onClickEquip, arg_5_0)

	arg_5_0._gostonelock = gohelper.findChild(arg_5_0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#go_lock")
	arg_5_0._gostoneunlock = gohelper.findChild(arg_5_0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#level")
	arg_5_0._txtstonelevel = gohelper.findChildText(arg_5_0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#txt_level")
	arg_5_0._gostoneLevelmax = gohelper.findChild(arg_5_0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_stone/#level/#max")
	arg_5_0._godestinyreddot = gohelper.findChild(arg_5_0.viewGO, "anim/layout/auxiliary/#go_destiny/#go_destinyreddot")

	gohelper.setActive(arg_5_0._gostone, true)

	arg_5_0._animDestiny = arg_5_0._godestiny:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onClickEquip(arg_6_0)
	if arg_6_0.heroMo:isOwnHero() then
		EquipController.instance:openEquipInfoTeamView({
			heroMo = arg_6_0.heroMo,
			fromView = EquipEnum.FromViewEnum.FromCharacterView
		})

		return
	end

	local var_6_0 = arg_6_0.heroMo:isOtherPlayerHero()
	local var_6_1 = arg_6_0.heroMo and arg_6_0.heroMo:getTrialEquipMo()

	if var_6_0 or not var_6_1 then
		GameFacade.showToast(ToastEnum.TrialCantUseEquip)
	else
		EquipController.instance:openEquipInfoTeamView({
			heroMo = arg_6_0.heroMo,
			equipMo = var_6_1,
			fromView = EquipEnum.FromViewEnum.FromCharacterView
		})
	end
end

function var_0_0._isOwnHero(arg_7_0)
	if not arg_7_0.viewContainer:isOwnHero() then
		return
	end

	if arg_7_0.heroMo:isOtherPlayerHero() then
		return
	end

	return true
end

function var_0_0.playOpenAnim(arg_8_0)
	if arg_8_0.heroMo:isOtherPlayerHero() then
		return
	end

	arg_8_0:_playDestinyAnim("open")

	if not arg_8_0.isUnlockEquip then
		return
	end

	arg_8_0._equipAnimator.enabled = false
	arg_8_0._equipAnimator.enabled = true

	arg_8_0._equipAnimator:Play("open", 0, 0)
end

function var_0_0._showEquipPreferenceOpen(arg_9_0)
	local var_9_0 = arg_9_0.heroMo:isOtherPlayerHero()

	if not arg_9_0.isUnlockEquip or var_9_0 then
		return
	end

	arg_9_0._equipAnimator = gohelper.onceAddComponent(arg_9_0.goequipcontainer, typeof(UnityEngine.Animator))

	local var_9_1 = PlayerEnum.SimpleProperty.EquipPreferenceOpen
	local var_9_2 = PlayerModel.instance:getSimpleProperty(var_9_1)
	local var_9_3 = "1"

	if var_9_2 == var_9_3 then
		arg_9_0._equipAnimator:Play("open", 0, 0)

		return
	end

	arg_9_0._equipAnimator:Play("onece", 0, 0)

	local var_9_4 = var_9_3

	PlayerModel.instance:forceSetSimpleProperty(var_9_1, var_9_4)
	PlayerRpc.instance:sendSetSimplePropertyRequest(var_9_1, var_9_4)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.heroMo = arg_10_0.viewParam

	local var_10_0 = arg_10_0.viewParam:isTrial()
	local var_10_1 = arg_10_0.viewParam:isOtherPlayerHero()

	arg_10_0:_onRefreshDestinySystem()

	if var_10_0 then
		arg_10_0.isUnlockEquip = true
	else
		arg_10_0.isUnlockEquip = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Equip)
	end

	gohelper.setActive(arg_10_0.goequipcontainer, arg_10_0.isUnlockEquip and not var_10_1)

	if not arg_10_0.isUnlockEquip then
		return
	end

	arg_10_0:_showEquipPreferenceOpen()

	arg_10_0.equipMo = nil

	if not var_10_1 and arg_10_0.heroMo:hasDefaultEquip() then
		local var_10_2 = arg_10_0.heroMo and arg_10_0.heroMo:getTrialEquipMo()

		var_10_2 = var_10_2 or EquipModel.instance:getEquip(arg_10_0.heroMo.defaultEquipUid)
		arg_10_0.equipMo = var_10_2
	end

	arg_10_0:refreshUI()
	arg_10_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_10_0.onHeroUpdatePush, arg_10_0)
	arg_10_0:addEventCb(CharacterController.instance, CharacterEvent.RefreshDefaultEquip, arg_10_0._onRefreshDefaultEquip, arg_10_0)
	arg_10_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_10_0.refreshUI, arg_10_0)
	arg_10_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_10_0._onRefreshDestinySystem, arg_10_0)
	arg_10_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_10_0._onRefreshDestinySystem, arg_10_0)
end

function var_0_0.refreshUI(arg_11_0)
	gohelper.setActive(arg_11_0.simageequipicon.gameObject, arg_11_0.equipMo ~= nil)
	gohelper.setActive(arg_11_0.txtlv.gameObject, arg_11_0.equipMo ~= nil)
	gohelper.setActive(arg_11_0.goaddicon, arg_11_0.equipMo == nil)

	if arg_11_0.equipMo then
		arg_11_0.simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(arg_11_0.equipMo.config.icon))

		arg_11_0.txtlv.text = arg_11_0.equipMo.level
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:onOpen()
end

function var_0_0.onHeroUpdatePush(arg_13_0)
	if not arg_13_0.heroMo:isOtherPlayerHero() and arg_13_0.heroMo:hasDefaultEquip() then
		arg_13_0.equipMo = EquipModel.instance:getEquip(arg_13_0.heroMo.defaultEquipUid)
	else
		arg_13_0.equipMo = nil
	end

	arg_13_0:refreshUI()
	arg_13_0:_onRefreshDestinySystem()
end

function var_0_0.onClose(arg_14_0)
	arg_14_0.equipClick:RemoveClickListener()

	if arg_14_0.isUnlockEquip then
		arg_14_0.simageequipicon:UnLoadImage()
		arg_14_0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_14_0.onHeroUpdatePush, arg_14_0)
		arg_14_0:removeEventCb(CharacterController.instance, CharacterEvent.RefreshDefaultEquip, arg_14_0._onRefreshDefaultEquip, arg_14_0)
		arg_14_0:removeEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_14_0.refreshUI, arg_14_0)
	end

	arg_14_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_14_0._onRefreshDestinySystem, arg_14_0)
	arg_14_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_14_0._onRefreshDestinySystem, arg_14_0)
end

function var_0_0._onRefreshDefaultEquip(arg_15_0, arg_15_1)
	arg_15_0.viewParam = arg_15_1

	arg_15_0:onOpen()
end

function var_0_0._onRefreshDestinySystem(arg_16_0)
	local var_16_0 = arg_16_0.heroMo:isHasDestinySystem()
	local var_16_1 = arg_16_0.heroMo:isCanOpenDestinySystem()
	local var_16_2 = arg_16_0.heroMo.destinyStoneMo

	if var_16_1 then
		if not arg_16_0._stoneLevel then
			arg_16_0._stoneLevel = arg_16_0:getUserDataTb_()

			for iter_16_0 = 1, 4 do
				local var_16_3 = gohelper.findChild(arg_16_0._gostone, "#level/level" .. iter_16_0)
				local var_16_4 = arg_16_0:getUserDataTb_()

				var_16_4.canvasgroup = var_16_3:GetComponent(typeof(UnityEngine.CanvasGroup))

				table.insert(arg_16_0._stoneLevel, var_16_4)
			end
		end

		if var_16_2 then
			local var_16_5 = var_16_2.rank or 0
			local var_16_6 = var_16_5 == var_16_2.maxRank

			arg_16_0._txtstonelevel.text = CharacterDestinyEnum.RomanNum[var_16_5]

			for iter_16_1, iter_16_2 in ipairs(arg_16_0._stoneLevel) do
				iter_16_2.canvasgroup.alpha = iter_16_1 <= var_16_5 and 1 or 0.3
			end

			gohelper.setActive(arg_16_0._gostoneLevelmax.gameObject, var_16_6)
		end

		if var_16_2.curUseStoneId ~= 0 then
			local var_16_7, var_16_8 = var_16_2:getCurStoneNameAndIcon()

			arg_16_0._imagestone:LoadImage(var_16_8)
		end
	end

	if var_16_0 then
		local var_16_9 = CharacterDestinyEnum.SlotTitle[arg_16_0.heroMo.config.heroType] or CharacterDestinyEnum.SlotTitle[1]

		arg_16_0._txtdestiny.text = luaLang(var_16_9)
	end

	gohelper.setActive(arg_16_0._godestiny, var_16_0)
	gohelper.setActive(arg_16_0._gostoneunlock, var_16_1)
	gohelper.setActive(arg_16_0._gostonelock, not var_16_1)
	gohelper.setActive(arg_16_0._imagestone.gameObject, var_16_1 and var_16_2:isUnlockSlot() and var_16_2.curUseStoneId ~= 0)
	gohelper.setActive(arg_16_0._txtstonelevel.gameObject, var_16_1)
	gohelper.setActive(arg_16_0._godestinyreddot, arg_16_0:_isShowDestinyReddot())
end

function var_0_0._isShowDestinyReddot(arg_17_0)
	if not arg_17_0:_isOwnHero() or arg_17_0.heroMo:isTrial() then
		return
	end

	if arg_17_0.heroMo and arg_17_0.heroMo.destinyStoneMo then
		return arg_17_0.heroMo:isCanOpenDestinySystem() and arg_17_0.heroMo.destinyStoneMo:getRedDot() < 3
	end
end

function var_0_0._playDestinyAnim(arg_18_0, arg_18_1)
	if arg_18_0._animDestiny then
		arg_18_0._animDestiny:Play(arg_18_1, 0, 0)
	end
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._imagestone:UnLoadImage()
end

return var_0_0
